"""Extract this release's protected wrappers without executing engine code.

Run with CPython 3.9.11. The output directory must not already exist.
The CArchive layout follows PyInstaller.archive.readers.CArchiveReader.
"""

import argparse
import hashlib
import importlib.util
import io
import json
import marshal
import struct
import sys
import types
import zipfile
import zlib
from pathlib import Path

RELEASE_SHA256 = "824b0cf2f84cb26634d3c920dd38aa97ad041984c6bf21dfc55f0e76bcbf0355"
ENGINE_SHA256 = "944939cbf14bad46f262543291758bb95527b6e70fa5c701c39d26b8560a4f43"
RUNTIME_SHA256 = "20cad40330c4a7102d3bb34e38197f60f38b7195d83d2a393d1ab0728b141551"
MODULES = ("RCBldEng", "lib", "weather", "simulation", "comfort")


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def carchive_members(engine: bytes) -> dict[str, tuple[str, bytes]]:
    cookie = engine.rfind(b"MEI\x0c\x0b\x0a\x0b\x0e")
    if cookie < 0:
        raise ValueError("CArchive cookie missing")
    _, size, offset, toc_size, version, library = struct.unpack_from(
        "!8sIIII64s", engine, cookie
    )
    if version != 309 or library.rstrip(b"\0") != b"python39.dll":
        raise ValueError("Unexpected embedded interpreter")
    start = cookie + 88 - size
    cursor = start + offset
    end = cursor + toc_size
    members = {}
    while cursor < end:
        length, position, compressed, plain, flag, kind = struct.unpack_from(
            "!iIIIBc", engine, cursor
        )
        if length < 18 or cursor + length > end:
            raise ValueError("Invalid CArchive entry")
        name = engine[cursor + 18 : cursor + length].rstrip(b"\0").decode()
        payload = engine[start + position : start + position + compressed]
        if flag:
            payload = zlib.decompress(payload)
        if len(payload) != plain:
            raise ValueError("Decompressed size mismatch: " + name)
        if name in members:
            raise ValueError("Duplicate CArchive member: " + name)
        members[name] = (kind.decode(), payload)
        cursor += length
    return members


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("release", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    if sys.version_info[:3] != (3, 9, 11):
        raise RuntimeError("Use CPython 3.9.11 for the release's marshal format")
    release_bytes = args.release.read_bytes()
    if sha256(release_bytes) != RELEASE_SHA256:
        raise ValueError("Release SHA-256 mismatch; this extractor is release-specific")
    with zipfile.ZipFile(io.BytesIO(release_bytes)) as archive:
        corrupt = archive.testzip()
        if corrupt is not None:
            raise ValueError("ZIP CRC failure: " + corrupt)
        engine = archive.read("RCBldEng/RCBldEng.exe")
        runtime = archive.read("RCBldEng/pyarmor_runtime_005387/pyarmor_runtime.pyd")
    if sha256(engine) != ENGINE_SHA256 or sha256(runtime) != RUNTIME_SHA256:
        raise ValueError("Unexpected engine or runtime fingerprint")
    members = carchive_members(engine)
    pyz_candidates = [data for kind, data in members.values() if kind == "z"]
    if len(pyz_candidates) != 1:
        raise ValueError("Expected one PYZ archive")
    pyz = pyz_candidates[0]
    if pyz[:8] != b"PYZ\0" + importlib.util.MAGIC_NUMBER:
        raise ValueError("Unexpected PYZ magic")
    toc_offset = struct.unpack_from("!i", pyz, 8)[0]
    toc = dict(marshal.loads(pyz[toc_offset:]))
    wrappers = {}
    for name in MODULES:
        if name == "RCBldEng":
            kind, data = members[name]
            if kind != "s":
                raise ValueError("Unexpected entry-point type")
        else:
            module_kind, position, length = toc[name]
            if module_kind != 0:
                raise ValueError("Unexpected PYZ module type: " + name)
            data = zlib.decompress(pyz[position : position + length])
        code = marshal.loads(data)
        if not isinstance(code, types.CodeType) or "__pyarmor__" not in code.co_names:
            raise ValueError("Expected protected code wrapper: " + name)
        wrappers[name + ".pyc"] = importlib.util.MAGIC_NUMBER + bytes(12) + data

    args.output.mkdir(parents=True, exist_ok=False)
    inputs = args.output / "input"
    inputs.mkdir()
    for name, data in wrappers.items():
        (inputs / name).write_bytes(data)
    (args.output / "RCBldEng.exe").write_bytes(engine)
    (args.output / "pyarmor_runtime.pyd").write_bytes(runtime)
    record = {
        "release_sha256": RELEASE_SHA256,
        "engine_sha256": ENGINE_SHA256,
        "runtime_sha256": RUNTIME_SHA256,
        "python": sys.version,
        "carchive_entries": len(members),
        "pyz_entries": len(toc),
        "inputs": {
            name: {"size": len(data), "sha256": sha256(data)}
            for name, data in wrappers.items()
        },
        "engine_executed": False,
    }
    (args.output / "extraction.json").write_text(
        json.dumps(record, indent=2) + "\n", encoding="utf-8"
    )
    print(json.dumps(record, indent=2))


if __name__ == "__main__":
    main()
