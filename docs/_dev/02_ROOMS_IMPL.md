# 热区接入与检查

## [CREATE] 编写热区组件脚本

新建下面的完整文件。代码分成三个检查函数和末尾的 GH 入口：`model_scale` 读取单位与容差，`prepare_room` 检查一个实体，`check_rooms` 汇总整组结果。末尾代码把结果分配给 GH 输出端口。

定位：[grasshopper/rooms.py](../../grasshopper/rooms.py)

使用 Rhino 8 的 Python 3 Script，保持普通脚本模式。这里检查的是 Rhino 几何，直接调用 RhinoCommon；`dataclass` 只保存检查结果，不负责外部文件或 JSON 的校验。脚本需要 GH 提供输入变量和 `ghenv`，不能直接作为普通命令行脚本运行。

平面检查调用 `BrepFace.IsPlanar(tolerance)`，容差取自当前 GH 定义关联的 Rhino 文档。面积和体积由 `Brep.GetArea()`、`Brep.GetVolume()` 计算，再分别按长度换算系数的平方、立方转换。几何本体仅在副本上换算为米。组件输入、输出和脚本模式的设置依据 [McNeel Python Script 指南](https://developer.rhino3d.com/guides/scripting/scripting-gh-python/)。

```python
"""Grasshopper Python 3: collect and check planar room solids."""

from dataclasses import dataclass, field
from math import isfinite
from typing import Optional

import Rhino
from Grasshopper.Kernel import GH_RuntimeMessageLevel
from Rhino import Geometry


@dataclass
class Room:
    source_index: int
    name: str
    brep_m: Geometry.Brep
    volume_m3: float
    envelope_area_m2: float
    tolerance_m: float


@dataclass
class RoomChecks:
    rooms: list[Room] = field(default_factory=list)
    ready: bool = False
    preview: list[Geometry.Brep] = field(default_factory=list)
    invalid: list[Geometry.GeometryBase] = field(default_factory=list)
    points: list[Geometry.Point3d] = field(default_factory=list)
    labels: list[str] = field(default_factory=list)
    report: list[str] = field(default_factory=list)


def model_scale(document: Rhino.RhinoDoc) -> tuple[float, float]:
    units = document.ModelUnitSystem
    unsupported = (
        getattr(Rhino.UnitSystem, "None"),
        Rhino.UnitSystem.Unset,
        Rhino.UnitSystem.CustomUnits,
    )
    if units in unsupported:
        raise ValueError(
            "Set a standard Rhino model unit, such as meters or millimeters."
        )
    scale = Rhino.RhinoMath.UnitScale(units, Rhino.UnitSystem.Meters)
    tolerance = document.ModelAbsoluteTolerance
    if not isfinite(scale) or scale <= 0:
        raise ValueError("The model unit cannot be converted to meters.")
    if not isfinite(tolerance) or tolerance <= 0:
        raise ValueError("The Rhino absolute tolerance must be positive and finite.")
    return scale, tolerance


def prepare_room(
    item: Geometry.Brep, name: str, source_index: int, scale: float, tolerance: float
) -> Room:
    """Check one room and return a separate geometry copy measured in meters.

    Args:
        item: One Brep in the Rhino document's model units.
        name: Display name already checked by the component boundary.
        source_index: Zero-based position in the flattened input list.
        scale: Document length units converted to meters.
        tolerance: Absolute tolerance in the original document units.

    Returns:
        A checked room for the next Grasshopper component.

    Raises:
        ValueError: If the input is not one closed planar room or cannot be measured.
    """
    if not item.IsValid:
        raise ValueError(
            "Rhino reports invalid geometry. Inspect the source with Check."
        )
    if not item.IsSolid:
        raise ValueError("The room is not a closed solid. Check open edges and joins.")

    # A single connected Brep returns an empty array, not an array of length one.
    pieces = item.GetConnectedComponents()
    try:
        if len(pieces) > 1:
            raise ValueError(
                "One input contains separate solids. Supply one solid per room."
            )
    finally:
        for piece in pieces:
            piece.Dispose()

    curved_faces = [
        str(index + 1)
        for index, face in enumerate(item.Faces)
        if not face.IsPlanar(tolerance)
    ]
    if curved_faces:
        raise ValueError("Non-planar face numbers: " + ", ".join(curved_faces))

    orientation = item.SolidOrientation
    if orientation not in (
        Geometry.BrepSolidOrientation.Outward,
        Geometry.BrepSolidOrientation.Inward,
    ):
        raise ValueError("The solid orientation cannot be determined.")

    volume_m3 = abs(item.GetVolume()) * scale**3
    area_m2 = item.GetArea() * scale**2
    if not isfinite(volume_m3) or volume_m3 <= 0:
        raise ValueError(
            "The room volume could not be measured as a positive finite value."
        )
    if not isfinite(area_m2) or area_m2 <= 0:
        raise ValueError(
            "The envelope area could not be measured as a positive finite value."
        )

    body = item.DuplicateBrep()
    if orientation == Geometry.BrepSolidOrientation.Inward:
        body.Flip()
    if not body.Transform(Geometry.Transform.Scale(Geometry.Point3d.Origin, scale)):
        body.Dispose()
        raise ValueError("The room geometry could not be converted to meters.")

    return Room(
        source_index=source_index,
        name=name,
        brep_m=body,
        volume_m3=volume_m3,
        envelope_area_m2=area_m2,
        tolerance_m=tolerance * scale,
    )


def check_rooms(
    items: list[object], supplied_names: list[object], document: Rhino.RhinoDoc
) -> RoomChecks:
    """Check a complete flattened room list without changing input geometry.

    Args:
        items: One model-unit Brep per room, in input order.
        supplied_names: An empty list, or one nonblank string per input.
        document: Rhino document associated with this Grasshopper definition.

    Returns:
        Model-unit preview geometry and reports. Rooms are published only when
        every input passes the checks in this component.

    Raises:
        ValueError: If the document settings or input list lengths are invalid.
    """
    if not items:
        raise ValueError("Connect at least one room Brep.")
    if supplied_names and len(supplied_names) != len(items):
        raise ValueError(
            f"Names must be empty or contain {len(items)} entries; "
            f"received {len(supplied_names)}."
        )
    scale, tolerance = model_scale(document)
    result = RoomChecks()
    candidates = []

    for index, item in enumerate(items):
        name = f"Room {index + 1}"
        try:
            if not isinstance(item, Geometry.Brep):
                raise ValueError(
                    "Expected a Brep. Pass solids through a Brep parameter first."
                )
            if supplied_names:
                entered_name = supplied_names[index]
                if not isinstance(entered_name, str) or not entered_name.strip():
                    raise ValueError("The room name must be nonblank text.")
                name = entered_name.strip()
            room = prepare_room(item, name, index, scale, tolerance)
        except ValueError as error:
            message = f"[{index + 1}] {name}: ERROR - {error}"
            if isinstance(item, Geometry.GeometryBase):
                result.invalid.append(item)
        else:
            candidates.append(room)
            result.preview.append(item)
            message = (
                f"[{index + 1}] {name}: OK | "
                f"V = {room.volume_m3:.6g} m3 | "
                f"Envelope = {room.envelope_area_m2:.6g} m2"
            )
        result.report.append(message)
        if isinstance(item, Geometry.GeometryBase):
            bounds = item.GetBoundingBox(True)
            if bounds.IsValid:
                result.points.append(bounds.Center)
                result.labels.append(message)

    result.ready = len(candidates) == len(items)
    if result.ready:
        result.rooms = candidates
    else:
        # No consumer owns these normalized copies when the batch is rejected.
        for room in candidates:
            room.brep_m.Dispose()
    return result


# Grasshopper injects inputs and its environment into the script namespace.
geometry_input: Optional[list[object]] = globals()["geometry"]
name_input: Optional[list[object]] = globals()["names"]
component = globals()["ghenv"].Component

try:
    gh_document = component.OnPingDocument()
    if gh_document is None:
        raise ValueError("This component needs a Grasshopper document.")
    rhino_document = gh_document.RhinoDocument
    if rhino_document is None:
        raise ValueError("This component needs an associated Rhino document.")
    checks = check_rooms(
        [] if geometry_input is None else list(geometry_input),
        [] if name_input is None else list(name_input),
        rhino_document,
    )
except ValueError as error:
    checks = RoomChecks(report=[str(error)])

if not checks.ready:
    component.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "\n".join(checks.report))

rooms = checks.rooms
ready = checks.ready
preview = checks.preview
invalid = checks.invalid
points = checks.points
labels = checks.labels
report = checks.report
```

`Room` 用于把本次检查结果传给后续 Python 组件。`RoomChecks` 收集预览和报告。它们随本次求解重新创建，不记录历史，也不会修改 Rhino 源对象。

代码明确拒绝未设单位、自定义单位、无效容差、未闭合实体和非平面面。单个 Brep 中包含多个不相连实体时也会被拒绝；请把这些实体分别作为热区输入。没有自动封口或曲面离散化步骤。

## [CREATE] 搭建热区接入的 GH 定义

新建 GH 定义，按下面的端口与连线设置完成组件，再保存到指定位置。这一步保存实际连线和组件内脚本，不需要手写 GH 文件格式。

定位：[examples/rooms.gh](../../examples/rooms.gh)

### 放置组件并复制代码

1. 打开 Rhino 8 的 Grasshopper，从 Maths → Script 放置 **Python 3 Script**，将组件名称改为 **Rooms**。
2. 使用普通脚本模式，即直接执行 Python 语句的 Script-Mode。将默认脚本全部替换为上面的完整代码，不保留默认的 `RunScript` 类包装。
3. 将两个输入端口改名为 `geometry`、`names`，按下表设置。不要使用 IronPython 2 组件。
4. 保留特殊输出 `out`，在其后建立下表所列的七个输出。所有名称使用表中的小写拼写。
5. 保持默认的输入和输出数据转换设置，不启用 **Avoid Marshalling Inputs** 或 **Avoid Marshalling Outputs**，然后关闭编辑器。

输入端口设置如下：

| 端口 | Access | Type Hint | Flatten | 输入内容 |
|---|---|---|---|---|
| `geometry` | List | No Type Hint | 开启 | 每个热区对应一个 Brep；引用或生成的几何先通过 GH 的 Brep 参数 |
| `names` | List | No Type Hint | 开启 | 可不连接；连接时提供与实体一一对应的文本列表 |

两个输入保持可选，让脚本能够在缺少输入时给出说明。名称列表要么为空，要么与实体数量相同；空白名称会报错。名称可以使用中文，也可以重复，报告通过房间序号定位。

**两个输入均开启 Flatten。** 这样整个定义中的热区在一次求解中一并检查，`ready` 才代表这组完整输入。此组件的约定是一个扁平列表，不保留输入数据树的分支含义。

输出端口按下面顺序设置；保留默认输出转换，不额外设置输出类型转换：

| 端口 | 内容 | 如何使用 |
|---|---|---|
| `rooms` | 全部通过时的 `Room` 对象列表；有错误时为空 | 留给下一步围护处理组件 |
| `ready` | 整组是否通过本组件检查 | 接一个 Panel 查看状态 |
| `preview` | 通过检查的源 Brep，使用原模型单位 | 接有效热区的 Custom Preview |
| `invalid` | 出错的源几何，使用原模型单位 | 接错误热区的 Custom Preview |
| `points` | 可定位几何的包围盒中心，使用原模型单位 | 接 Text Tag 3D 的位置输入 |
| `labels` | 与定位点对应的名称、序号和检查说明 | 接 Text Tag 3D 的文字输入 |
| `report` | 按输入顺序排列的完整检查说明 | 接一个 Panel 阅读 |

`points` 用于放置标签，不表示房间重心。空输入、非几何对象或没有有效包围盒的对象仍有文字报告，但不会伪造定位点。全局错误，例如名称数量不一致或模型单位未设置，会给出整组说明。

### 接入房间并连接显示

1. 放置一个 **Brep** 参数。引用 Rhino 对象时，使用该参数的 **Set Multiple Breps** 选择房间实体；GH 生成的几何也先接入这个参数。将其输出连接到 `geometry`。
2. 如需名称，按实体列表的顺序提供文本列表并连接 `names`。留空时自动使用顺序名称。
3. 放置两个 **Custom Preview**。一个接 `preview` 并使用蓝绿色，另一个接 `invalid` 并使用红色；颜色通过各自的 Colour Swatch 接入。
4. 放置一个 **Text Tag 3D**，位置接 `points`，文字接 `labels`；文字大小按当前模型显示比例调整。
5. 给 `report` 和 `ready` 分别连接 Panel。关闭上游 Brep 参数和 Rooms 脚本组件自身的默认预览，保留两个 Custom Preview 与文字组件的预览，避免默认颜色覆盖检查颜色。
6. 创建 `examples` 目录，将这套连线保存为 `examples/rooms.gh`。如果使用 Rhino 引用对象，同时保存对应的 Rhino 模型；GH 定义中的引用依赖这些源对象。

查看错误时，先用报告中的房间序号和名称找到对象。非平面错误还会列出该 Brep 的面序号，从 1 开始；红色预览标记整个出错对象。修改几何后，面序号可能变化，应按新的报告定位。

任一热区失败时，有效对象仍可预览，但 `rooms` 整组为空。后续组件必须依赖 `rooms` 和 `ready`，不能把 `preview` 当作已经通过整组检查的计算输入。这里的 `ready` 尚未检查房间之间的重叠、邻接或引擎能力。

本轮尚未在实际 Rhino/GH 求解中验证原生测量、视口颜色、标签布局和跨组件传递 `Room` 的行为。本机接口核对针对 Rhino 8.25；其他 Rhino 8 小版本及发布后的插件加载行为不在本轮已验证范围内。
