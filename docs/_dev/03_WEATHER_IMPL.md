# 天气文件检查与基础回归测试

## [CREATE] 新增全年逐时天气的只读检查

为识别典型年记录错位及关键气象量缺测，新增以下完整文件。接收 UTF-8、单时段、全年每小时一条记录的 EPW，检查八条头记录标签、35 列结构、8760/8784 条顺序和 12 个气象字段，保留源年份、分钟值、起始星期及文件指纹。它不支持全部 EPW 变体，也不替代正式加载器；地点、其他头字段和剩余气象列的完整语义不在本工具检查范围内。

字段范围、缺测阈值和辐射记录单位依据 [EnergyPlus EPW 数据字典](https://bigladdersoftware.com/epx/docs/24-2/auxiliary-programs/energyplus-weather-file-epw-data-dictionary.html)。温度和气压采用其 IDD 表的严格上下界；其他已选字段按表中闭区间处理。当前天气观测指示为 9 单独计数，不能据此把整份天气判为不可用。露点高于干球、散射高于总水平辐射是本工具的诊断条件，不作为引擎数值正确性的判据。

结构无法解释时抛出具体异常；可以定位的气象值问题记录在报告中，不替换为零。命令行打印 JSON 后，若所检字段存在缺测、无效值或上述跨字段诊断，则退出码为 1；否则正常退出。文件读取/编码/结构异常直接失败退出。`Line` 和 `*_lines` 是包含八条头记录的 CSV 记录号；字段 `column` 从 1 开始。没有有效值的字段最小/最大值为 `None`。

`calendar_order_verified` 只说明月/日/小时连续，`engine_compatibility_verified` 固定为 false。用于检查顺序的参考年不会写回文件，不决定工作日、模拟年或引擎时间轴。该工具使用仓库 Python 3.13；不要将其未经适配装入 Rhino 的 Python 3.9 环境。

定位：[tools/audit_weather.py](../../tools/audit_weather.py)

```python
"""Inspect a full-year hourly EPW without rewriting its weather or calendar."""

import argparse
import csv
import hashlib
import io
import json
import math
from collections import Counter
from dataclasses import asdict, dataclass
from datetime import date, timedelta
from pathlib import Path
from typing import Final


@dataclass(frozen=True)
class FieldRule:
    column: int
    name: str
    unit: str
    missing_at: float
    minimum: float
    maximum: float | None
    inclusive_bounds: bool = True


FIELD_RULES: Final = (
    FieldRule(7, "dry_bulb", "degC", 99.9, -70, 70, inclusive_bounds=False),
    FieldRule(8, "dew_point", "degC", 99.9, -70, 70, inclusive_bounds=False),
    FieldRule(9, "relative_humidity", "%", 999, 0, 110),
    FieldRule(
        10, "station_pressure", "Pa", 999999, 31000, 120000, inclusive_bounds=False
    ),
    FieldRule(13, "horizontal_infrared", "Wh/m2", 9999, 0, None),
    FieldRule(14, "global_horizontal", "Wh/m2", 9999, 0, None),
    FieldRule(15, "direct_normal", "Wh/m2", 9999, 0, None),
    FieldRule(16, "diffuse_horizontal", "Wh/m2", 9999, 0, None),
    FieldRule(21, "wind_direction", "deg", 999, 0, 360),
    FieldRule(22, "wind_speed", "m/s", 999, 0, 40),
    FieldRule(23, "total_sky_cover", "tenths", 99, 0, 10),
    FieldRule(24, "opaque_sky_cover", "tenths", 99, 0, 10),
)


@dataclass(frozen=True)
class FieldAudit:
    column: int
    name: str
    unit: str
    minimum: float | None
    maximum: float | None
    missing_lines: tuple[int, ...]
    invalid_lines: tuple[int, ...]


@dataclass(frozen=True)
class WeatherAudit:
    sha256: str
    record_count: int
    source_years: tuple[int, ...]
    minute_values: tuple[int, ...]
    rows_per_month: dict[int, int]
    declared_start_weekday: str
    fields: tuple[FieldAudit, ...]
    missing_observation_count: int
    dew_point_above_dry_bulb_lines: tuple[int, ...]
    diffuse_above_global_lines: tuple[int, ...]
    calendar_order_verified: bool
    engine_compatibility_verified: bool


def audit_weather(path: Path) -> WeatherAudit:
    """Inspect the original row order and twelve relevant EPW fields.

    A non-leap or leap calendar is used only to check month/day/hour coverage;
    it does not replace source years, shift timestamps, or choose a run calendar.

    Raises:
        OSError: If the source cannot be read.
        UnicodeError: If the source is not UTF-8.
        ValueError: If the hourly full-year structure cannot be interpreted.
    """
    payload = path.read_bytes()
    records = list(csv.reader(io.StringIO(payload.decode("utf-8-sig"))))
    expected_headers = (
        "LOCATION",
        "DESIGN CONDITIONS",
        "TYPICAL/EXTREME PERIODS",
        "GROUND TEMPERATURES",
        "HOLIDAYS/DAYLIGHT SAVINGS",
        "COMMENTS 1",
        "COMMENTS 2",
        "DATA PERIODS",
    )
    if len(records) < 8:
        raise ValueError("EPW requires eight header records")
    for line_number, (row, expected) in enumerate(
        zip(records[:8], expected_headers, strict=True), start=1
    ):
        if not row or row[0] != expected:
            raise ValueError(f"Line {line_number}: expected {expected}")
    period = records[7]
    if len(period) != 7 or period[1:3] != ["1", "1"]:
        raise ValueError("Expected one data period with one record per hour")
    if period[5].replace(" ", "") != "1/1" or period[6].replace(" ", "") != "12/31":
        raise ValueError("Expected a January 1 to December 31 data period")
    weekdays = {
        "Sunday",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
    }
    if period[4] not in weekdays:
        raise ValueError("Unknown DATA PERIODS start weekday")
    rows = records[8:]
    if len(rows) not in (8760, 8784):
        raise ValueError(f"Expected 8760 or 8784 hourly records, found {len(rows)}")

    reference_year = 2000 if len(rows) == 8784 else 2001
    first_day = date(reference_year, 1, 1)
    years: set[int] = set()
    minutes: set[int] = set()
    months: Counter[int] = Counter()
    for index, row in enumerate(rows):
        line_number = index + 9
        if len(row) != 35:
            raise ValueError(
                f"Line {line_number}: expected 35 columns, found {len(row)}"
            )
        try:
            year, month, day, hour, minute = (int(value) for value in row[:5])
        except ValueError as error:
            raise ValueError(f"Line {line_number}: non-integer time field") from error
        expected_day = first_day + timedelta(days=index // 24)
        if (month, day, hour) != (expected_day.month, expected_day.day, index % 24 + 1):
            raise ValueError(
                f"Line {line_number}: duplicate, missing, or out-of-order hour"
            )
        if not 1 <= year <= 9999 or not 1 <= minute <= 60:
            raise ValueError(f"Line {line_number}: invalid source year or minute")
        if row[26] not in ("0", "9"):
            raise ValueError(
                f"Line {line_number}: invalid weather observation indicator"
            )
        if len(row[27]) != 9 or not row[27].isascii() or not row[27].isdigit():
            raise ValueError(f"Line {line_number}: expected nine weather-code digits")
        years.add(year)
        minutes.add(minute)
        months[month] += 1

    audits = []
    valid_by_column: dict[int, dict[int, float]] = {}
    for rule in FIELD_RULES:
        valid = {}
        missing = []
        invalid = []
        for line_number, row in enumerate(rows, start=9):
            try:
                value = float(row[rule.column - 1])
            except ValueError:
                invalid.append(line_number)
                continue
            if not math.isfinite(value):
                invalid.append(line_number)
            elif value >= rule.missing_at:
                missing.append(line_number)
            elif (
                value < rule.minimum
                or (rule.maximum is not None and value > rule.maximum)
                or (not rule.inclusive_bounds and value in (rule.minimum, rule.maximum))
            ):
                invalid.append(line_number)
            else:
                valid[line_number] = value
        valid_by_column[rule.column] = valid
        audits.append(
            FieldAudit(
                column=rule.column,
                name=rule.name,
                unit=rule.unit,
                minimum=min(valid.values()) if valid else None,
                maximum=max(valid.values()) if valid else None,
                missing_lines=tuple(missing),
                invalid_lines=tuple(invalid),
            )
        )
    dry_bulb = valid_by_column[7]
    dew_point = valid_by_column[8]
    global_horizontal = valid_by_column[14]
    diffuse_horizontal = valid_by_column[16]
    return WeatherAudit(
        sha256=hashlib.sha256(payload).hexdigest(),
        record_count=len(rows),
        source_years=tuple(sorted(years)),
        minute_values=tuple(sorted(minutes)),
        rows_per_month=dict(sorted(months.items())),
        declared_start_weekday=period[4],
        fields=tuple(audits),
        missing_observation_count=sum(row[26] == "9" for row in rows),
        dew_point_above_dry_bulb_lines=tuple(
            line
            for line in sorted(dry_bulb.keys() & dew_point.keys())
            if dew_point[line] > dry_bulb[line]
        ),
        diffuse_above_global_lines=tuple(
            line
            for line in sorted(global_horizontal.keys() & diffuse_horizontal.keys())
            if diffuse_horizontal[line] > global_horizontal[line]
        ),
        calendar_order_verified=True,
        engine_compatibility_verified=False,
    )


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("weather", type=Path)
    args = parser.parse_args()
    report = audit_weather(args.weather)
    print(json.dumps(asdict(report), indent=2))
    if any(field.missing_lines or field.invalid_lines for field in report.fields):
        raise SystemExit(1)
    if report.dew_point_above_dry_bulb_lines or report.diffuse_above_global_lines:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
```

## [CREATE] 新增发布包和天气检查的回归测试

为保护固定版本身份、源文件完整性和典型年时间语义，在完成两个检查工具后新增以下完整文件。测试直接只读访问仓库 `archive` 下的指定 ZIP 和广州 EPW；错误样本仅写入测试独立临时目录，不覆盖原始文件。资产缺失时测试失败，不自动跳过或下载替代品。

测试覆盖固定发布包、拒绝其他包、广州天气元数据、缺测/非有限值、严格边界、重复小时以及来源年份与记录顺序分离。它们不执行 EXE，也不替代 Windows/Rhino、完整 EPW 格式或物理精度验收。

定位：[tests/test_audits.py](../../tests/test_audits.py)

```python
import csv
import io
import unittest
from dataclasses import asdict
from pathlib import Path
from tempfile import TemporaryDirectory

from tools.audit_release import audit_release
from tools.audit_weather import audit_weather

ROOT = Path(__file__).resolve().parents[1]
ARCHIVE = ROOT / "archive" / "RCBldEng-v1.3.0.zip"
WEATHER = ROOT / "archive" / "Guangdong_Guangzhou_GD_592870.epw"


class ReleaseTests(unittest.TestCase):
    def test_selected_release_is_inspected_without_extraction(self):
        before = set(ARCHIVE.parent.iterdir())
        report = audit_release(ARCHIVE)
        self.assertEqual(report.file_count, 739)
        self.assertEqual(report.unpacked_bytes, 84423813)
        self.assertEqual(report.python_version, "3.9")
        self.assertTrue(report.crc_verified)
        self.assertFalse(report.execution_verified)
        self.assertEqual(set(ARCHIVE.parent.iterdir()), before)

    def test_different_release_is_rejected(self):
        with TemporaryDirectory() as directory:
            path = Path(directory) / "unrecognized.zip"
            path.write_bytes(b"different release")
            with self.assertRaisesRegex(ValueError, "SHA-256 mismatch"):
                audit_release(path)


class WeatherTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.source = WEATHER.read_bytes()

    def test_guangzhou_retains_calendar_metadata_and_reports_missing_observations(self):
        report = audit_weather(WEATHER)
        self.assertEqual(report.record_count, 8760)
        self.assertEqual(report.minute_values, (30,))
        self.assertEqual(report.missing_observation_count, 5164)
        self.assertEqual(report.declared_start_weekday, "Sunday")
        self.assertEqual(len(report.source_years), 9)
        self.assertFalse(report.engine_compatibility_verified)
        self.assertTrue(report.calendar_order_verified)
        self.assertEqual(report.dew_point_above_dry_bulb_lines, ())
        self.assertEqual(report.diffuse_above_global_lines, ())
        self.assertTrue(
            all(
                not item.missing_lines and not item.invalid_lines
                for item in report.fields
            )
        )
        self.assertEqual(WEATHER.read_bytes(), self.source)

    def test_missing_and_nonfinite_values_remain_diagnostics(self):
        records = list(csv.reader(io.StringIO(self.source.decode("utf-8"))))
        records[8][6] = "99.9"
        records[9][6] = "nan"
        with TemporaryDirectory() as directory:
            path = Path(directory) / "weather.epw"
            with path.open("w", newline="", encoding="utf-8") as target:
                csv.writer(target).writerows(records)
            report = audit_weather(path)
        self.assertEqual(report.fields[0].missing_lines, (9,))
        self.assertEqual(report.fields[0].invalid_lines, (10,))
        self.assertNotIn(9, report.dew_point_above_dry_bulb_lines)

    def test_strict_temperature_and_pressure_bounds(self):
        records = list(csv.reader(io.StringIO(self.source.decode("utf-8"))))
        for index, (temperature, pressure) in enumerate(
            (("-70", "31000"), ("70", "120000")), start=8
        ):
            records[index][6] = temperature
            records[index][7] = temperature
            records[index][9] = pressure
        with TemporaryDirectory() as directory:
            path = Path(directory) / "weather.epw"
            with path.open("w", newline="", encoding="utf-8") as target:
                csv.writer(target).writerows(records)
            report = audit_weather(path)
        for field in report.fields:
            if field.name in ("dry_bulb", "dew_point", "station_pressure"):
                self.assertEqual(field.invalid_lines, (9, 10))
                self.assertEqual(field.missing_lines, ())

    def test_duplicate_hour_is_rejected_even_with_8760_rows(self):
        records = list(csv.reader(io.StringIO(self.source.decode("utf-8"))))
        records[9] = records[8].copy()
        with TemporaryDirectory() as directory:
            path = Path(directory) / "weather.epw"
            with path.open("w", newline="", encoding="utf-8") as target:
                csv.writer(target).writerows(records)
            with self.assertRaisesRegex(
                ValueError, "Line 10: duplicate, missing, or out-of-order hour"
            ):
                audit_weather(path)

    def test_changed_source_years_do_not_reorder_typical_year(self):
        records = list(csv.reader(io.StringIO(self.source.decode("utf-8"))))
        for record in records[8:]:
            record[0] = "2025"
        baseline = asdict(audit_weather(WEATHER))
        with TemporaryDirectory() as directory:
            path = Path(directory) / "weather.epw"
            with path.open("w", newline="", encoding="utf-8") as target:
                csv.writer(target).writerows(records)
            changed = asdict(audit_weather(path))
        for key in ("sha256", "source_years"):
            baseline.pop(key)
            changed.pop(key)
        self.assertEqual(baseline, changed)


if __name__ == "__main__":
    unittest.main()
```
