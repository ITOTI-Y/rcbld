from typing import Optional

from Grasshopper.Kernel import GH_RuntimeMessageLevel

from src.core.rooms import check_rooms
from src.models.rooms import RoomChecks

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
