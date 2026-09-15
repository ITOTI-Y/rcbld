#! python 3
# requirements: pydantic==2.13.5
# env: \\wsl.localhost\Ubuntu-24.04\home\pan\code\rcbld\src
import importlib
from typing import Optional

from Grasshopper.Kernel import GH_RuntimeMessageLevel

import rcbld.core.surfaces as surface_core
import rcbld.models as models
import rcbld.models.surfaces as surface_models
from rcbld.models.surfaces import SurfaceOverride

importlib.reload(models)
models.reload_models()
importlib.reload(surface_core)

check_surfaces = surface_core.check_surfaces
SurfaceChecks = surface_models.SurfaceChecks

room_input: Optional[list[object]] = globals()["rooms"]
ready_input: object = globals()["ready"]
override_input: Optional[list[SurfaceOverride]] = globals()["overrides"]
component = globals()["ghenv"].Component

try:
    gh_document = component.OnPingDocument()
    if gh_document is None:
        raise ValueError("This component needs a Grasshopper document.")
    rhino_document = gh_document.RhinoDocument
    if rhino_document is None:
        raise ValueError("This component needs an associated Rhino document.")
    checks = check_surfaces(
        [] if room_input is None else list(room_input),
        ready_input is True,
        [] if override_input is None else list(override_input),
        rhino_document,
    )
except ValueError as error:
    checks = SurfaceChecks(report=[str(error)])

if not checks.ready:
    component.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, "\n".join(checks.report))

surfaces = checks.surfaces
adjacencies = checks.adjacencies
ready = checks.ready
preview = checks.preview
invalid = checks.invalid
points = checks.points
labels = checks.labels
surface_keys = [item.surface_key for item in checks.surfaces]
signatures = [item.surface_signature for item in checks.surfaces]
room_keys = list(checks.floor_area_m2)
floor_area_m2 = [checks.floor_area_m2[key] for key in room_keys]
envelope_area_m2 = [checks.envelope_area_m2[key] for key in room_keys]
report = checks.report
