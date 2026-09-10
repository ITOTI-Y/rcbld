from collections.abc import Iterable
from math import isfinite
from typing import cast

import Rhino
from Rhino import Geometry

from src.models.rooms import Room, RoomChecks


def model_scale(document: Rhino.RhinoDoc) -> tuple[float, float]:
    units = document.ModelUnitSystem
    unsupported = (
        Rhino.UnitSystem.None_,
        Rhino.UnitSystem.Unset,
        Rhino.UnitSystem.CustomUnits
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
    item: Geometry.Brep,
    name: str,
    source_index: int,
    scale: float,
    tolerance: float
) -> Room:
    if not item.IsValid:
        raise ValueError(
            "Rhino reports invalid geometry. Inspect the source with Check."
        )
    if not item.IsSolid:
        raise ValueError("The room is not a closed solid. Check open edges and joins.")

    pieces = item.GetConnectedComponents() # ty: ignore[too-many-positional-arguments]
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
        for index, face in enumerate(cast(Iterable[Geometry.BrepFace],item.Faces))
        if not face.IsPlanar(tolerance)
    ]

    if curved_faces:
        raise ValueError("Non-planar face numbers: " + ", ".join(curved_faces))

    orientation = item.SolidOrientation
    if orientation not in (
        Geometry.BrepSolidOrientation.Outward,
        Geometry.BrepSolidOrientation.Inward
    ):
        raise ValueError("The solid orientation cannot be determined.")

    volume_m3 = abs(item.GetVolume(1e-8, tolerance)) * scale**3
    area_m2 = item.GetArea(1e-8, tolerance) * scale ** 2
    if not isfinite(volume_m3) or volume_m3 <= 0:
        raise ValueError(
            "The room volume could not be measured as a positive finite value."
        )
    if not isfinite(area_m2) or area_m2 <= 0:
        raise ValueError(
            "The envelope area could not be measured as a positive finite value."
        )

    body = item.DuplicateBrep() # ty: ignore[too-many-positional-arguments]
    if orientation == Geometry.BrepSolidOrientation.Inward:
        body.Flip() # ty: ignore[too-many-positional-arguments]
    if not body.Transform(Geometry.Transform.Scale(cast(Geometry.Point3d, Geometry.Point3d.Origin), scale)):
        body.Dispose() # ty: ignore[too-many-positional-arguments]
        raise ValueError("The room geometry could not be converted to meters.")

    return Room(
        source_index=source_index,
        name=name,
        brep_m=body,
        volume_m3=volume_m3,
        envelope_area_m2=area_m2,
        tolerance=tolerance
    )

def check_rooms(
    items: list[object],
    supplied_names: list[object],
    document: Rhino.RhinoDoc,
) -> RoomChecks:
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
            room = prepare_room(item, name, index,scale, tolerance)
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
        for room in candidates:
            room.brep_m.Dispose() # ty: ignore[too-many-positional-arguments]
    return result
