# 项目修订与持久化实现

## [CREATE] 实现独立项目保存与输入快照

新增以下完整文件，依赖 05 的领域及诊断模块。以普通函数管理项目、方案、修订与输入快照；以一个明确版本的 UTF-8 JSON 文件保存整个首阶段项目，不引入数据库、事件框架或后台写入服务。

定位：[src/rcbld/project.py](../../src/rcbld/project.py)

项目目录是调用方指定的新目录，文件名固定为 `project.json`。GH 定义保留原始建模关系；重载项目只恢复规范化数据及参数，不逆向恢复 Brep 或 GH 连线。本轮代码不创建天气副本、引擎输入文件、日志、结果目录或批次状态，这些由总览中的 S5/S6 实现并扩展持久化格式。

| 接口 | 调用契约 |
|---|---|
| `create_project(directory, name)` | 创建不存在的项目目录及第 0 代项目；已有目录一律拒绝，避免覆盖；目录父级可以按明确路径创建 |
| `load_project(directory)` | 读取并验证 `project.json`，不修改源文件；解码、JSON、版本、结构和历史一致性错误直接报告 |
| `add_variant(project, name, model)` | 返回新增方案后的下一代项目，自动分配方案和首修订 ID；保留传入模型 ID；仅修改内存 |
| `revise_variant(project, variant_id, model)` | 返回追加修订后的下一代项目；保持方案及模型身份，修订号连续；未知方案抛出 `KeyError` |
| `capture_input(project, variant_id)` | 诊断最新修订后创建不可变领域输入快照，分配 run_id 并返回下一代项目；有语义错误时拒绝 |
| `save_project(directory, previous, updated)` | 将一个已载入/已保存状态的下一代提交到原项目目录；失败不伪造成功，不自动重试；每次增改或快照操作后保存，再将成功状态作为下一次 previous |
| `model_digest(model)` | 对 schema/单位/顺序均明确的模型 JSON 计算 SHA-256；用于数据一致性和引用，不作为物理等价判断、数字签名或发布包白名单 |

编辑模型时构造经过校验的新 `BuildingModel`；同一方案始终保留它的模型 ID。新增设计方案可以从现有模型派生；方案 ID 才区分比选对象，不能根据名称或模型摘要推断是否为同一方案。S1 不提供删除历史或重写修订的接口。

`InputSnapshot` 绑定确定方案修订并保存其完整领域数据。它表示输入已冻结，不表示后端已就绪、任务已排队或计算成功。天气引用可能为空或对应文件不可用，几何和后端能力仍需后续运行入口检查。S5/S6 的完整运行请求需要额外绑定天气实际内容、系统和太阳输入、实际引擎身份及运行状态；不得把本阶段快照直接发送给引擎。

持久化契约如下：

| 对象/字段 | 结构及约束 |
|---|---|
| 项目根 | `schema_version="rcbld.project/1"`，`id`、`name`、非负 `generation`、`variants` 和 `snapshots`；不接受未知字段 |
| 方案 | UUID、名称、至少一个修订；修订按追加顺序保存，最新修订为末项 |
| 修订 | UUID、从 1 连续递增的序号、带 UTC 偏移的创建时间、完整 `rcbld.model/1`；旧修订不可修改 |
| 输入快照 | 独立 run_id、variant_id、revision_id、创建时间、完整模型与模型摘要；必须引用项目内对应方案修订，内容与该修订一致 |
| 标识 | 项目、方案、修订、运行使用不同 UUID；同一项目这些身份不重复；显示名称不会成为文件路径或引用主键 |
| JSON 编码 | UTF-8，无 BOM；对象键排序，数组保留领域顺序；不允许重复键、NaN/Infinity、未知或缺失 schema；不猜测旧格式 |
| 缺失与草稿 | 类型、单位或版本错误不能加载；通过结构校验但存在领域引用等错误的草稿可以保存，重载后重新诊断；空值仅用于类型声明的合法缺失状态 |
| 保存一致性 | 更新必须为同一项目下一代，已有方案/修订和快照保持前缀不变；磁盘内容必须等于调用方的 previous，否则要求重新载入 |

一个项目目录只允许一个调用方串行写入。磁盘内容比较用于发现过期编辑，**不是并发锁或跨进程比较交换**；GH 的保存命令必须统一由文档所属的项目写入入口排队。本阶段不支持多个进程同时修改、网络共享协作写入或自动合并。

保存先完成验证和编码，再在项目同目录写临时文件、刷新并关闭，最后用 `os.replace` 提交；提交前失败时旧文件保持不变。新项目创建失败会清理本次不完整文件，已创建的空目录可留存。`finally` 只清理本次生成的临时文件，不扫描或删除其他产物。正式加载不读取残留 `.tmp` 文件。[Python 3.9 文件替换契约](https://docs.python.org/3.9/library/os.html#os.replace)。

保证范围是本地单写入者的完整文件替换。提交成功后的系统掉电恢复、网络文件系统一致性和 Windows 杀进程时的实际文件行为仍需目标环境验证；不把原子替换等同于备份。所有修订和快照在一个文件内，读写成本随历史数据增长；后续确有规模瓶颈时再设计分文件存储及显式迁移，不预建缓存或数据库。

运行数据由用户在产品中创建时归属于用户项目；这段实现不创建仓库内常驻样例资产，也不自动改写仓库的 DATA.md。后续开发若把真实项目保存到仓库用于持续验收，应按实际路径、来源、schema 和质量同步登记，不能把未生成数据提前登记为已存在。

```python
"""Single-writer project persistence and append-only model input history."""

from __future__ import annotations

import hashlib
import json
import os
import tempfile
from datetime import datetime, timezone
from pathlib import Path
from typing import Annotated, Literal
from uuid import UUID, uuid4

from pydantic import Field, model_validator

from rcbld.model import BuildingModel, Digest, Record, Text
from rcbld.validation import diagnose_model


def canonical_bytes(record: Record) -> bytes:
    return json.dumps(
        record.model_dump(mode="json"),
        ensure_ascii=False,
        allow_nan=False,
        sort_keys=True,
        separators=(",", ":"),
    ).encode("utf-8")


def model_digest(model: BuildingModel) -> str:
    return hashlib.sha256(canonical_bytes(model)).hexdigest()


class Revision(Record):
    id: UUID
    number: Annotated[int, Field(strict=True, ge=1)]
    created_at: datetime
    model: BuildingModel

    @model_validator(mode="after")
    def aware_timestamp(self) -> Revision:
        if self.created_at.utcoffset() is None:
            raise ValueError("revision timestamp requires a UTC offset")
        return self


class Variant(Record):
    id: UUID
    name: Text
    revisions: Annotated[tuple[Revision, ...], Field(min_length=1)]

    @model_validator(mode="after")
    def sequential_history(self) -> Variant:
        if tuple(item.number for item in self.revisions) != tuple(
            range(1, len(self.revisions) + 1)
        ):
            raise ValueError("revision numbers must start at one and be consecutive")
        model_id = self.revisions[0].model.id
        if any(item.model.id != model_id for item in self.revisions):
            raise ValueError("model identity cannot change within a variant")
        return self


class InputSnapshot(Record):
    run_id: UUID
    variant_id: UUID
    revision_id: UUID
    created_at: datetime
    model: BuildingModel
    model_sha256: Digest

    @model_validator(mode="after")
    def verify_content(self) -> InputSnapshot:
        if self.created_at.utcoffset() is None:
            raise ValueError("snapshot timestamp requires a UTC offset")
        if model_digest(self.model) != self.model_sha256:
            raise ValueError("snapshot model digest mismatch")
        return self


class Project(Record):
    schema_version: Literal["rcbld.project/1"]
    id: UUID
    name: Text
    generation: Annotated[int, Field(strict=True, ge=0)]
    variants: tuple[Variant, ...]
    snapshots: tuple[InputSnapshot, ...]

    @model_validator(mode="after")
    def consistent_history(self) -> Project:
        ids = [self.id]
        revisions: dict[UUID, tuple[UUID, Revision]] = {}
        for variant in self.variants:
            ids.append(variant.id)
            for revision in variant.revisions:
                ids.append(revision.id)
                revisions[revision.id] = (variant.id, revision)
        for snapshot in self.snapshots:
            ids.append(snapshot.run_id)
            entry = revisions.get(snapshot.revision_id)
            if entry is None or entry[0] != snapshot.variant_id:
                raise ValueError("snapshot references an unknown variant revision")
            if canonical_bytes(entry[1].model) != canonical_bytes(snapshot.model):
                raise ValueError("snapshot model differs from its revision")
        if len(ids) != len(set(ids)):
            raise ValueError("project, variant, revision and run IDs must be distinct")
        return self


def add_variant(project: Project, name: str, model: BuildingModel) -> Project:
    revision = Revision(
        id=uuid4(), number=1, created_at=datetime.now(timezone.utc), model=model
    )
    variant = Variant(id=uuid4(), name=name, revisions=(revision,))
    return Project(
        schema_version="rcbld.project/1",
        id=project.id,
        name=project.name,
        generation=project.generation + 1,
        variants=(*project.variants, variant),
        snapshots=project.snapshots,
    )


def revise_variant(project: Project, variant_id: UUID, model: BuildingModel) -> Project:
    variants = list(project.variants)
    for index, variant in enumerate(variants):
        if variant.id == variant_id:
            revision = Revision(
                id=uuid4(),
                number=len(variant.revisions) + 1,
                created_at=datetime.now(timezone.utc),
                model=model,
            )
            variants[index] = Variant(
                id=variant.id,
                name=variant.name,
                revisions=(*variant.revisions, revision),
            )
            return Project(
                schema_version="rcbld.project/1",
                id=project.id,
                name=project.name,
                generation=project.generation + 1,
                variants=tuple(variants),
                snapshots=project.snapshots,
            )
    raise KeyError(f"unknown variant: {variant_id}")


def capture_input(project: Project, variant_id: UUID) -> Project:
    for variant in project.variants:
        if variant.id == variant_id:
            revision = variant.revisions[-1]
            diagnostics = diagnose_model(revision.model)
            if diagnostics:
                details = "; ".join(
                    f"{d.code}:{d.object_id}:{d.field}" for d in diagnostics
                )
                raise ValueError(f"model has semantic errors: {details}")
            snapshot = InputSnapshot(
                run_id=uuid4(),
                variant_id=variant.id,
                revision_id=revision.id,
                created_at=datetime.now(timezone.utc),
                model=revision.model,
                model_sha256=model_digest(revision.model),
            )
            return Project(
                schema_version="rcbld.project/1",
                id=project.id,
                name=project.name,
                generation=project.generation + 1,
                variants=project.variants,
                snapshots=(*project.snapshots, snapshot),
            )
    raise KeyError(f"unknown variant: {variant_id}")


def _unique_object(pairs: list[tuple[str, object]]) -> dict[str, object]:
    result: dict[str, object] = {}
    for key, value in pairs:
        if key in result:
            raise ValueError(f"duplicate JSON key: {key}")
        result[key] = value
    return result


def _reject_constant(value: str) -> object:
    raise ValueError(f"non-finite JSON number: {value}")


def load_project(directory: Path) -> Project:
    raw = (directory / "project.json").read_bytes()
    data = json.loads(
        raw.decode("utf-8"),
        object_pairs_hook=_unique_object,
        parse_constant=_reject_constant,
    )
    if not isinstance(data, dict) or data.get("schema_version") != "rcbld.project/1":
        raise ValueError("unsupported or missing project schema_version")
    return Project.model_validate(data)


def create_project(directory: Path, name: str) -> Project:
    project = Project(
        schema_version="rcbld.project/1",
        id=uuid4(),
        name=name,
        generation=0,
        variants=(),
        snapshots=(),
    )
    payload = canonical_bytes(project) + b"\n"
    directory.mkdir(parents=True, exist_ok=False)
    path = directory / "project.json"
    try:
        with path.open("xb") as stream:
            stream.write(payload)
            stream.flush()
            os.fsync(stream.fileno())
    except OSError:
        path.unlink(missing_ok=True)
        raise
    return project


def _check_history(previous: Project, updated: Project) -> None:
    if updated.id != previous.id or updated.generation != previous.generation + 1:
        raise ValueError("save requires the same project and the next generation")
    if len(updated.variants) < len(previous.variants):
        raise ValueError("saved variants cannot be removed")
    for old, new in zip(previous.variants, updated.variants):
        if old.id != new.id or new.revisions[: len(old.revisions)] != old.revisions:
            raise ValueError("saved revision history cannot be changed")
    if updated.snapshots[: len(previous.snapshots)] != previous.snapshots:
        raise ValueError("saved input snapshots cannot be changed")


def save_project(directory: Path, previous: Project, updated: Project) -> None:
    """Commit one generation; callers must serialize all writes to this directory."""
    updated = Project.model_validate(updated)
    _check_history(previous, updated)
    current = load_project(directory)
    if canonical_bytes(current) != canonical_bytes(previous):
        raise ValueError("project changed on disk; reload before saving")
    payload = canonical_bytes(updated) + b"\n"
    temporary_path = None
    try:
        with tempfile.NamedTemporaryFile(
            mode="wb", dir=directory, prefix=".project-", suffix=".tmp", delete=False
        ) as stream:
            temporary_path = Path(stream.name)
            stream.write(payload)
            stream.flush()
            os.fsync(stream.fileno())
        os.replace(temporary_path, directory / "project.json")
    finally:
        if temporary_path is not None:
            temporary_path.unlink(missing_ok=True)
```
