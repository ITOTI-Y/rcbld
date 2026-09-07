# 独立领域模型实现

## [UPDATE] 配置独立包与 Python 3.9 依赖

用以下完整内容替换项目配置。新增 `src/rcbld` 包，以 Pydantic 校验嵌套结构和 JSON 边界，避免另写一套序列化框架。运行依赖只直接声明 Pydantic；Hatchling 只负责包构建。保留 Python 3.9.11 开发基线及已有代码规范。

定位：[pyproject.toml:1](../../pyproject.toml#L1)

Pydantic 2.13.5 声明 Python ≥3.9，采用 MIT 许可证；其原生核心存在 CPython 3.9 / Windows x64 轮子。Hatchling 1.27.0 支持该 Python 基线，较新的构建版本可能要求更高 Python。这些是包依赖版本，不是引擎发布包限制。Rhino 内的导入与打包仍须在目标环境验收。[Pydantic 版本资料](https://pypi.org/project/pydantic/2.13.5/)、[原生核心轮子](https://pypi.org/project/pydantic-core/2.46.5/#files)、[Hatchling 版本资料](https://pypi.org/project/hatchling/1.27.0/)。

`keep-runtime-typing` 保留运行时需要解析的 `Optional`/`Union` 类型写法，避免在 Python 3.9 中被改为不兼容的表达式。没有引入旧 API 兼容层或另一套运行时实现。

```toml
[project]
name = "rcbld"
version = "0.1.0"
description = "Building design models and project snapshots for RCBld"
readme = "README.md"
requires-python = ">=3.9.11,<3.10"
dependencies = ["pydantic==2.13.5"]

[build-system]
requires = ["hatchling==1.27.0"]
build-backend = "hatchling.build"

[tool.hatch.build.targets.wheel]
packages = ["src/rcbld"]

[tool.ruff]
target-version = "py39"
line-length = 88

[tool.ruff.lint]
select = ["E", "W", "F", "I", "B", "C4", "UP", "SIM", "RUF", "N"]
ignore = ["E501", "N805", "N806"]

[tool.ruff.lint.pyupgrade]
keep-runtime-typing = true

[tool.ruff.format]
quote-style = "double"
indent-style = "space"
docstring-code-format = true
```

## [CREATE] 创建独立包入口

新增完整文件，仅声明包职责。业务对象从各自模块导入，不在包入口建立全量重导出或触发运行副作用。

定位：[src/rcbld/__init__.py](../../src/rcbld/__init__.py)

```python
"""Building design data independent of Rhino, Grasshopper and engine protocols."""
```

## [CREATE] 定义版本化领域数据

新增以下完整文件。所有对象冻结，集合使用元组；编辑时用有效字段构造新对象，再形成方案修订。输入通过构造器或 `model_validate` 验证，不使用会跳过校验的 `model_construct` 或 `model_copy(update=...)`。公共边界使用明确对象、单位及枚举，不传任意字典作为业务扩展槽。

定位：[src/rcbld/model.py](../../src/rcbld/model.py)

本文件实现 `rcbld.model/1` 的领域基础，结构版本字段必填；它不接收旧归档对象，也不接收引擎协议数据。物理数值必须有限，不将字符串或布尔值自动当作物理量。UUID 与展示名称分离；名称允许中文，协议名称转换留在引擎适配器。

| 数据 | 契约 |
|---|---|
| 坐标与北向 | 右手项目坐标系，Z 向上，所有坐标单位为 m；`north_angle_deg` 是从项目 +Y 顺时针转到真北的角度，范围 [0, 360)，不旋转或量化原始面法线 |
| 面多边形 | `outer` 与 `holes` 使用同一坐标系；环不重复首点；`area_m2` 是扣除几何洞、但尚未扣除单独窗对象的围护总面积；窗洞不在 `holes` 重复扣除 |
| 几何有效性 | 面积、体积由几何适配器量测；S1 只检查数值、环顶点及单位法线，不重算面积、验证平面/闭合、洞包含或窗重叠；单位法线的 1e-9 是数值归一化容差，不是 Brep 几何容差 |
| 邻接与容差 | 相接面分属不同热区并互相引用；部分接触先拆分；`distance_m` 与 `area_m2` 容差来自明确的几何处理规则，调用方必填，不设置无依据默认值 |
| 有效热工参数 | U 值为 W/(m²·K)，等效面热容量为 J/(m²·K)，吸收率及 SHGC 为 0–1；不从 U 值反推热容量；接触面的双方引用同一份有效不透明热工参数 |
| 窗 | `ratio` 使用围护总面积；显式窗以开口总面积计，框架影响已包含在有效窗参数中；`explicit_windows=None` 表示没有显式覆盖，`ExplicitWindows(windows=())` 表示明确无窗 |
| 空窗与备用设置 | 显式窗覆盖面积计算，但保留参数化配置供编辑；所有保存的引用，包括备用参数化配置，均可被诊断；两种设置都为空表示当前无窗，不猜测默认 WWR |
| 工况 | 人员密度为人/m²；人员显热为 W/人；照明/设备为 W/m²；室外新风为 m³/(s·人)，其日程作用于新风使用比例；渗透输入为恒定 h⁻¹，后续复杂控制另立明确字段 |
| 日程与温控 | `fraction` 为无量纲比例，`degC` 为温度设定；所有序列长度等于同一个时间轴样本数；自由浮动有独立类型，仍必须引用使用工况；受控区可仅供暖或仅制冷，但不能两者都缺失 |
| 时间轴 | `start` 是首区间起点，必须含 UTC 偏移；步长按绝对时间秒计，第 i 个值适用于从 start 起第 i 个等长区间；日历、节假日、夏令时和 EPW 区间换算由后续前处理完成，不继承机器本地时间 |
| 来源 | `Source` 保存名称、版本与定位；`Origin` 关联对象 ID 和该对象的直接字段名，`preset`/`override` 必须引用来源；有效值在对象本身，旧值由项目修订保留；来源内容的适用性不是结构校验结果 |
| 天气引用 | 可为空，表示尚未选择天气；有引用时必须同时提供位置和 SHA-256；本模块不访问路径、不复制文件、不验证天气实际可用性 |

`Record` 仅统一实际复用的校验与冻结策略。模型没有 Rhino/GH 依赖、进程服务、后端注册器或通用插件接口。窗口面积函数仅执行已确认的覆盖规则；参数化窗布局、几何校核与太阳计算属于后续阶段。

```python
"""Versioned, immutable building input data in explicit physical units."""

from __future__ import annotations

from datetime import datetime
from math import hypot, isclose
from typing import Annotated, Literal, Optional, Union
from uuid import UUID

from pydantic import BaseModel, ConfigDict, Field, model_validator

Number = Annotated[float, Field(strict=True, allow_inf_nan=False)]
Positive = Annotated[Number, Field(gt=0)]
Nonnegative = Annotated[Number, Field(ge=0)]
Fraction = Annotated[Number, Field(ge=0, le=1)]
Text = Annotated[str, Field(strict=True, min_length=1, pattern=r"\S")]
Digest = Annotated[str, Field(pattern=r"^[0-9a-f]{64}$", strict=True)]


class Record(BaseModel):
    model_config = ConfigDict(
        extra="forbid", frozen=True, revalidate_instances="always", allow_inf_nan=False
    )


class Point(Record):
    x_m: Number
    y_m: Number
    z_m: Number


class Normal(Record):
    x: Number
    y: Number
    z: Number

    @model_validator(mode="after")
    def unit_length(self) -> Normal:
        if not isclose(hypot(self.x, self.y, self.z), 1.0, abs_tol=1e-9):
            raise ValueError("normal must have unit length")
        return self


class Ring(Record):
    vertices: Annotated[tuple[Point, ...], Field(min_length=3)]

    @model_validator(mode="after")
    def distinct_vertices(self) -> Ring:
        if len(set(self.vertices)) != len(self.vertices):
            raise ValueError("ring vertices must be distinct; do not repeat the first")
        return self


class Polygon(Record):
    outer: Ring
    holes: tuple[Ring, ...]
    area_m2: Positive
    outward_normal: Normal


class GeometryTolerance(Record):
    distance_m: Positive
    area_m2: Positive


class Source(Record):
    id: UUID
    title: Text
    version: Text
    locator: Text


class Origin(Record):
    target_id: UUID
    field: Text
    kind: Literal["user", "preset", "override"]
    source_id: Optional[UUID]
    note: Text

    @model_validator(mode="after")
    def source_for_preset(self) -> Origin:
        if self.kind in ("preset", "override") and self.source_id is None:
            raise ValueError("preset and override origins require a source")
        return self


class TimeAxis(Record):
    start: datetime
    step_seconds: Annotated[int, Field(strict=True, gt=0)]
    count: Annotated[int, Field(strict=True, gt=0)]

    @model_validator(mode="after")
    def explicit_offset(self) -> TimeAxis:
        if self.start.utcoffset() is None:
            raise ValueError("time axis start requires an explicit UTC offset")
        return self


class Schedule(Record):
    id: UUID
    name: Text
    unit: Literal["fraction", "degC"]
    values: tuple[Number, ...]

    @model_validator(mode="after")
    def physical_range(self) -> Schedule:
        if self.unit == "fraction" and any(not 0 <= v <= 1 for v in self.values):
            raise ValueError("fraction schedules require values between zero and one")
        if self.unit == "degC" and any(v < -273.15 for v in self.values):
            raise ValueError("temperature cannot be below absolute zero")
        return self


class OpaqueProperties(Record):
    id: UUID
    name: Text
    u_w_m2k: Positive
    areal_heat_capacity_j_m2k: Nonnegative
    solar_absorptance: Fraction


class GlazingProperties(Record):
    id: UUID
    name: Text
    u_w_m2k: Positive
    solar_heat_gain_coefficient: Fraction


class UseProfile(Record):
    id: UUID
    name: Text
    people_per_m2: Nonnegative
    sensible_heat_w_person: Nonnegative
    lighting_w_m2: Nonnegative
    equipment_w_m2: Nonnegative
    outdoor_air_m3_s_person: Nonnegative
    infiltration_air_changes_h: Nonnegative
    occupancy_schedule_id: UUID
    lighting_schedule_id: UUID
    equipment_schedule_id: UUID
    ventilation_schedule_id: UUID


class FreeFloating(Record):
    kind: Literal["free_floating"]


class Controlled(Record):
    kind: Literal["controlled"]
    heating_schedule_id: Optional[UUID]
    cooling_schedule_id: Optional[UUID]

    @model_validator(mode="after")
    def at_least_one_control(self) -> Controlled:
        if self.heating_schedule_id is None and self.cooling_schedule_id is None:
            raise ValueError("controlled zones require heating or cooling setpoints")
        return self


Conditioning = Annotated[Union[FreeFloating, Controlled], Field(discriminator="kind")]


class Zone(Record):
    id: UUID
    name: Text
    floor_area_m2: Positive
    volume_m3: Positive
    use_profile_id: UUID
    conditioning: Conditioning


class Exterior(Record):
    kind: Literal["exterior"]


class Ground(Record):
    kind: Literal["ground"]


class Adiabatic(Record):
    kind: Literal["adiabatic"]


class Adjacent(Record):
    kind: Literal["adjacent"]
    face_id: UUID


Boundary = Annotated[
    Union[Exterior, Ground, Adiabatic, Adjacent], Field(discriminator="kind")
]


class Window(Record):
    id: UUID
    polygon: Polygon
    glazing_id: UUID


class ParametricWindows(Record):
    ratio: Fraction
    glazing_id: UUID


class ExplicitWindows(Record):
    windows: tuple[Window, ...]


class Face(Record):
    id: UUID
    name: Text
    zone_id: UUID
    polygon: Polygon
    opaque_id: UUID
    boundary: Boundary
    parametric_windows: Optional[ParametricWindows]
    explicit_windows: Optional[ExplicitWindows]


class AssetReference(Record):
    location: Text
    sha256: Digest


class BuildingModel(Record):
    schema_version: Literal["rcbld.model/1"]
    id: UUID
    name: Text
    north_angle_deg: Annotated[Number, Field(ge=0, lt=360)]
    geometry_tolerance: GeometryTolerance
    time_axis: TimeAxis
    weather: Optional[AssetReference]
    sources: tuple[Source, ...]
    origins: tuple[Origin, ...]
    schedules: tuple[Schedule, ...]
    opaque_properties: tuple[OpaqueProperties, ...]
    glazing_properties: tuple[GlazingProperties, ...]
    use_profiles: tuple[UseProfile, ...]
    zones: tuple[Zone, ...]
    faces: tuple[Face, ...]


def window_area_m2(face: Face) -> float:
    """Return gross opening area; explicit emptiness overrides a stored ratio."""
    if face.explicit_windows is not None:
        return sum(window.polygon.area_m2 for window in face.explicit_windows.windows)
    if face.parametric_windows is not None:
        return face.parametric_windows.ratio * face.polygon.area_m2
    return 0.0
```

## [CREATE] 实现对象引用与物理语义诊断

新增完整诊断模块。结构不合法由 Pydantic 在输入边界抛出带字段位置的 `ValidationError`；可解析模型中的跨对象错误由 `diagnose_model` 返回可定位记录，供编辑和后续运行入口处理。

定位：[src/rcbld/validation.py](../../src/rcbld/validation.py)

本阶段所有返回诊断均为阻止创建输入快照的错误，模型草稿仍可保存。`code` 用于稳定分类，`object_id` 和 `field` 定位错误，`related_ids` 定位关联对象；界面文本由后续 i18n 呈现层解释，不把英文异常整句作为稳定键。

| 诊断代码 | 含义 |
|---|---|
| `duplicate_id` | 模型内稳定对象标识重复；先修复歧义，再检查引用 |
| `missing_reference`、`origin_field` | 引用对象不存在，或来源记录指向不存在的直接字段 |
| `schedule_length`、`schedule_unit` | 日程与模型时间轴或引用用途不匹配 |
| `no_zones`、`zone_without_faces` | 草稿尚无热区或热区尚无围护面 |
| `setpoint_order` | 某时间步供暖设定高于制冷设定 |
| `window_area_exceeds_face` | 当前有效显式窗总面积超过围护总面积 |
| `adjacency_same_zone`、`adjacency_not_reciprocal` | 邻接指向自身/同区，或没有对应反向引用 |
| `adjacency_area`、`adjacency_properties` | 接触面积超出明确容差，或双方引用不同热工属性 |

返回空诊断仅表示这些领域语义检查通过，不表示空间几何重合、遮挡计算、天气、系统完整性或引擎能力已验证。相关检查由后续模块在其真实输入边界完成。

```python
"""Object-linked semantic diagnostics; geometric algorithms remain in the adapter."""

from __future__ import annotations

from collections.abc import Container
from typing import Literal, Optional
from uuid import UUID

from rcbld.model import (
    Adjacent,
    BuildingModel,
    Controlled,
    Record,
    Text,
    window_area_m2,
)


class Diagnostic(Record):
    code: Text
    object_id: UUID
    field: Text
    related_ids: tuple[UUID, ...] = ()


def diagnose_model(model: BuildingModel) -> tuple[Diagnostic, ...]:
    issues: list[Diagnostic] = []

    def report(code: str, owner: UUID, field: str, *related: UUID) -> None:
        issues.append(
            Diagnostic(code=code, object_id=owner, field=field, related_ids=related)
        )

    records = [model]
    for group in (
        model.sources,
        model.schedules,
        model.opaque_properties,
        model.glazing_properties,
        model.use_profiles,
        model.zones,
        model.faces,
    ):
        records.extend(group)
    for face in model.faces:
        if face.explicit_windows is not None:
            records.extend(face.explicit_windows.windows)
    by_id: dict[UUID, Record] = {}
    for item in records:
        if item.id in by_id:
            report("duplicate_id", item.id, "id")
        by_id[item.id] = item
    if issues:
        return tuple(issues)

    sources = {source.id for source in model.sources}
    schedules = {schedule.id: schedule for schedule in model.schedules}
    opaque = {properties.id for properties in model.opaque_properties}
    glazing = {properties.id for properties in model.glazing_properties}
    profiles = {profile.id for profile in model.use_profiles}
    zones = {zone.id: zone for zone in model.zones}
    faces = {face.id: face for face in model.faces}

    def reference(
        owner: UUID, field: str, target: UUID, candidates: Container[UUID]
    ) -> None:
        if target not in candidates:
            report("missing_reference", owner, field, target)

    def schedule_reference(
        owner: UUID,
        field: str,
        target: Optional[UUID],
        unit: Literal["fraction", "degC"],
    ) -> None:
        if target is None:
            return
        reference(owner, field, target, schedules)
        if target in schedules and schedules[target].unit != unit:
            report("schedule_unit", owner, field, target)

    for origin in model.origins:
        reference(model.id, "origins.target_id", origin.target_id, by_id)
        target = by_id.get(origin.target_id)
        if target is not None and origin.field not in type(target).model_fields:
            report("origin_field", origin.target_id, origin.field)
        if origin.source_id is not None:
            reference(origin.target_id, "source_id", origin.source_id, sources)
    for schedule in model.schedules:
        if len(schedule.values) != model.time_axis.count:
            report("schedule_length", schedule.id, "values")
    for profile in model.use_profiles:
        for field in (
            "occupancy_schedule_id",
            "lighting_schedule_id",
            "equipment_schedule_id",
            "ventilation_schedule_id",
        ):
            schedule_reference(profile.id, field, getattr(profile, field), "fraction")
    if not model.zones:
        report("no_zones", model.id, "zones")
    for zone in model.zones:
        reference(zone.id, "use_profile_id", zone.use_profile_id, profiles)
        if not any(face.zone_id == zone.id for face in model.faces):
            report("zone_without_faces", zone.id, "faces")
        control = zone.conditioning
        if isinstance(control, Controlled):
            schedule_reference(
                zone.id, "heating_schedule_id", control.heating_schedule_id, "degC"
            )
            schedule_reference(
                zone.id, "cooling_schedule_id", control.cooling_schedule_id, "degC"
            )
            heating = schedules.get(control.heating_schedule_id)
            cooling = schedules.get(control.cooling_schedule_id)
            if (
                heating is not None
                and cooling is not None
                and heating.unit == cooling.unit == "degC"
                and len(heating.values) == len(cooling.values) == model.time_axis.count
                and any(h > c for h, c in zip(heating.values, cooling.values))
            ):
                report("setpoint_order", zone.id, "conditioning")
    for face in model.faces:
        reference(face.id, "zone_id", face.zone_id, zones)
        reference(face.id, "opaque_id", face.opaque_id, opaque)
        if face.parametric_windows is not None:
            reference(
                face.id,
                "parametric_windows.glazing_id",
                face.parametric_windows.glazing_id,
                glazing,
            )
        if face.explicit_windows is not None:
            for window in face.explicit_windows.windows:
                reference(window.id, "glazing_id", window.glazing_id, glazing)
        if window_area_m2(face) > face.polygon.area_m2:
            report("window_area_exceeds_face", face.id, "explicit_windows")
        boundary = face.boundary
        if isinstance(boundary, Adjacent):
            reference(face.id, "boundary.face_id", boundary.face_id, faces)
            other = faces.get(boundary.face_id)
            if other is None:
                continue
            if other.id == face.id or other.zone_id == face.zone_id:
                report("adjacency_same_zone", face.id, "boundary", other.id)
            if (
                not isinstance(other.boundary, Adjacent)
                or other.boundary.face_id != face.id
            ):
                report("adjacency_not_reciprocal", face.id, "boundary", other.id)
            if (
                abs(face.polygon.area_m2 - other.polygon.area_m2)
                > model.geometry_tolerance.area_m2
            ):
                report("adjacency_area", face.id, "polygon.area_m2", other.id)
            if face.opaque_id != other.opaque_id:
                report("adjacency_properties", face.id, "opaque_id", other.id)
    return tuple(issues)
```
