#! python 3
# requirements: pydantic==2.13.5
# env: \\wsl.localhost\Ubuntu-24.04\home\pan\code\rcbld\src
import importlib
from typing import Any, Optional

from Grasshopper.Kernel import GH_RuntimeMessageLevel
from Grasshopper.Kernel.Types import IGH_GeometricGoo

import rcbld.core.rooms as room_core
import rcbld.models as models
import rcbld.models.rooms as room_models

importlib.reload(models)
models.reload_models()
importlib.reload(room_core)

check_rooms = room_core.check_rooms
RoomChecks = room_models.RoomChecks

geometry_input: Optional[list[object]] = globals()["geometry"]
name_input: Optional[list[object]] = globals()["names"]
key_input: Optional[list[object]] = globals()["keys"]
component = globals()["ghenv"].Component


def read_references(parameter: Any) -> list[object]:
    references: list[object] = []
    for goo in parameter.VolatileData.AllData(False):
        if isinstance(goo, IGH_GeometricGoo) and goo.IsReferencedGeometry:
            references.append(goo.ReferenceID)
        else:
            references.append(None)
    return references


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
        [] if key_input is None else list(key_input),
        read_references(component.Params.Input[0]),
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
