#! python 3
# requirements: pydantic==2.13.5
# env: \\wsl.localhost\Ubuntu-24.04\home\pan\code\rcbld\src
import importlib
from typing import Optional

from Grasshopper.Kernel import GH_RuntimeMessageLevel

import rcbld.models as models
import rcbld.models.surfaces as surface_models

importlib.reload(models)
models.reload_models()

SurfaceOverride = surface_models.SurfaceOverride

key_input: Optional[list[object]] = globals()["surface_keys"]
signature_input: Optional[list[object]] = globals()["signatures"]
boundary_input: Optional[list[object]] = globals()["boundary_types"]
neighbor_input: Optional[list[object]] = globals()["neighbor_keys"]
component = globals()["ghenv"].Component

keys = [] if key_input is None else list(key_input)
signatures = [] if signature_input is None else list(signature_input)
boundaries = [] if boundary_input is None else list(boundary_input)
neighbors = [] if neighbor_input is None else list(neighbor_input)

overrides: list[SurfaceOverride] = []
report: list[str] = []
try:
    if not keys:
        raise ValueError("Connect at least one surface_keys entry.")
    if len(signatures) != len(keys) or len(boundaries) != len(keys):
        raise ValueError(
            f"signatures and boundary_types must each contain {len(keys)} entries."
        )
    if neighbors and len(neighbors) != len(keys):
        raise ValueError(f"neighbor_keys must be empty or contain {len(keys)} entries.")
    for index, key in enumerate(keys):
        neighbor = neighbors[index] if neighbors else ""
        override = SurfaceOverride(
            surface_key=str(key).strip(),
            surface_signature=str(signatures[index]).strip(),
            boundary_type=str(boundaries[index]).strip(),  # ty: ignore[invalid-argument-type]
            neighbor_room_key="" if neighbor is None else str(neighbor).strip(),
        )
        overrides.append(override)
        report.append(
            f"{override.surface_key}: {override.boundary_type}"
            + (
                f", neighbor = {override.neighbor_room_key}"
                if override.neighbor_room_key
                else ""
            )
        )
except ValueError as error:
    overrides = []
    report = [str(error)]
    component.AddRuntimeMessage(GH_RuntimeMessageLevel.Error, str(error))
