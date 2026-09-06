# 指定引擎发布包检查工具

## [CREATE] 建立开发工具包

为后续离线检查提供明确的导入入口，新增以下完整文件。该包用于仓库开发环境，不安装到 Rhino，也不导入引擎内部模块。

定位：[tools/__init__.py](../../tools/__init__.py)

```python
"""Read-only reconstruction audit tools."""
```

## [CREATE] 新增指定发布包的只读检查

为防止把其他版本当作本次重构基准，新增以下完整文件。先检查用户指定 ZIP 的 SHA-256，再检查 CRC、内层 EXE、三个必要 PE 文件的 x64 标记和 PyInstaller Python 元数据。输入是 ZIP 路径，输出为 `ReleaseAudit`；命令行输出 JSON，身份不符或解析失败直接以异常失败退出。

此工具只接受固定指纹的发布包，不负责安装或任意版本兼容。`execution_verified=False` 表示未执行引擎；静态完整性不能证明新版协议或数值行为。程序不解包、不改写源文件，也不绕过业务模块保护。CRC 接口与容器元数据分别依据 [Python zipfile](https://docs.python.org/3.13/library/zipfile.html) 和 [PyInstaller 读取器](https://raw.githubusercontent.com/pyinstaller/pyinstaller/develop/PyInstaller/archive/readers.py)。

定位：[tools/audit_release.py](../../tools/audit_release.py)

```python
"""Verify the exact RCBldEng release selected for reconstruction."""

import argparse
import hashlib
import io
import json
import struct
import zipfile
from dataclasses import asdict, dataclass
from pathlib import Path
from typing import Final

RELEASE_SHA256: Final = (
    "824b0cf2f84cb26634d3c920dd38aa97ad041984c6bf21dfc55f0e76bcbf0355"
)
ENGINE_SHA256: Final = (
    "944939cbf14bad46f262543291758bb95527b6e70fa5c701c39d26b8560a4f43"
)
ENGINE_MEMBER: Final = "RCBldEng/RCBldEng.exe"


@dataclass(frozen=True)
class ReleaseAudit:
    archive_sha256: str
    engine_sha256: str
    file_count: int
    unpacked_bytes: int
    python_version: str
    python_library: str
    native_machines: dict[str, str]
    crc_verified: bool
    execution_verified: bool


def audit_release(path: Path) -> ReleaseAudit:
    """Check the pinned release without extracting or executing any member.

    Raises:
        OSError: If the source cannot be read.
        ValueError: If the release identity or required metadata differs.
        zipfile.BadZipFile: If the archive fails integrity checking.
    """
    payload = path.read_bytes()
    digest = hashlib.sha256(payload).hexdigest()
    if digest != RELEASE_SHA256:
        raise ValueError(f"Release SHA-256 mismatch: {digest}")
    with zipfile.ZipFile(io.BytesIO(payload)) as archive:
        bad_member = archive.testzip()
        if bad_member is not None:
            raise zipfile.BadZipFile(f"CRC mismatch: {bad_member}")
        files = [entry for entry in archive.infolist() if not entry.is_dir()]
        machines = {}
        engine = archive.read(ENGINE_MEMBER)
        engine_digest = hashlib.sha256(engine).hexdigest()
        if engine_digest != ENGINE_SHA256:
            raise ValueError(f"Engine SHA-256 mismatch: {engine_digest}")
        for name in (
            ENGINE_MEMBER,
            "RCBldEng/python39.dll",
            "RCBldEng/pyarmor_runtime_005387/pyarmor_runtime.pyd",
        ):
            binary = archive.read(name)
            pe_offset = struct.unpack_from("<I", binary, 0x3C)[0]
            if binary[:2] != b"MZ" or binary[pe_offset : pe_offset + 4] != b"PE\0\0":
                raise ValueError(f"Invalid PE header: {name}")
            machine = struct.unpack_from("<H", binary, pe_offset + 4)[0]
            if machine != 0x8664:
                raise ValueError(f"Expected Windows x64: {name}")
            machines[name] = f"0x{machine:04x}"

    cookie_offset = engine.rfind(b"MEI\x0c\x0b\x0a\x0b\x0e")
    if cookie_offset < 0:
        raise ValueError("PyInstaller cookie not found")
    _, _, _, _, python_version, library = struct.unpack_from(
        "!8sIIII64s", engine, cookie_offset
    )
    library_name = library.rstrip(b"\0").decode("ascii")
    if python_version != 309 or library_name != "python39.dll":
        raise ValueError("Unexpected embedded Python metadata")
    return ReleaseAudit(
        archive_sha256=digest,
        engine_sha256=engine_digest,
        file_count=len(files),
        unpacked_bytes=sum(entry.file_size for entry in files),
        python_version="3.9",
        python_library=library_name,
        native_machines=machines,
        crc_verified=True,
        execution_verified=False,
    )


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("archive", type=Path)
    args = parser.parse_args()
    print(json.dumps(asdict(audit_release(args.archive)), indent=2))


if __name__ == "__main__":
    main()
```
