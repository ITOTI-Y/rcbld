from collections.abc import Iterable
from math import isfinite
from typing import cast

from Rhino import Geometry, RhinoDoc
from System import Guid

from rcbld.core._share import model_scale
from rcbld.models.rooms import Room, RoomChecks


def prepare_room(
    item: Geometry.Brep,
    name: str,
    room_key: str,
    reference_id: str,
    source_index: int,
    scale: float,
    tolerance: float,
) -> Room:
    if not item.IsValid:
        raise ValueError(
            "Rhino reports invalid geometry. Inspect the source with Check."
        )
    if not item.IsSolid:
        raise ValueError("The room is not a closed solid. Check open edges and joins.")

    pieces = item.GetConnectedComponents()  # ty: ignore[too-many-positional-arguments]
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
        for index, face in enumerate(cast(Iterable[Geometry.BrepFace], item.Faces))
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

    volume_m3 = abs(item.GetVolume(1e-8, tolerance)) * scale**3
    area_m2 = item.GetArea(1e-8, tolerance) * scale**2
    if not isfinite(volume_m3) or volume_m3 <= 0:
        raise ValueError(
            "The room volume could not be measured as a positive finite value."
        )
    if not isfinite(area_m2) or area_m2 <= 0:
        raise ValueError(
            "The envelope area could not be measured as a positive finite value."
        )

    body = item.DuplicateBrep()  # ty: ignore[too-many-positional-arguments]
    if orientation == Geometry.BrepSolidOrientation.Inward:
        body.Flip()  # ty: ignore[too-many-positional-arguments]
    if not body.Transform(
        Geometry.Transform.Scale(cast(Geometry.Point3d, Geometry.Point3d.Origin), scale)
    ):
        body.Dispose()  # ty: ignore[too-many-positional-arguments]
        raise ValueError("The room geometry could not be converted to meters.")

    return Room(
        room_key=room_key,
        reference_id=reference_id,
        source_index=source_index,
        name=name,
        brep_m=body,
        volume_m3=volume_m3,
        envelope_area_m2=area_m2,
        tolerance=tolerance,
    )


def check_rooms(
    items: list[object],
    supplied_names: list[object],
    supplied_keys: list[object],
    references: list[object],
    document: RhinoDoc,
) -> RoomChecks:
    if not items:
        raise ValueError("Connect at least one room Brep.")
    if supplied_names and len(supplied_names) != len(items):
        raise ValueError(
            f"Names must be empty or contain {len(items)} entries; "
            f"received {len(supplied_names)}."
        )
    if len(references) != len(items):
        raise ValueError(
            f"References must contain {len(items)} entries; received {len(references)}."
        )
    if supplied_keys:
        if len(supplied_keys) != len(items):
            raise ValueError(
                f"Keys must be empty or contain {len(items)} entries; "
                f"received {len(supplied_keys)}."
            )
        keys: list[str] = []
        for entered_key in supplied_keys:
            if not isinstance(entered_key, str) or not entered_key.strip():
                raise ValueError("Every room key must be nonblank text.")
            keys.append(entered_key.strip())
    else:
        keys = resolve_room_keys(references, document)
    if len(set(keys)) != len(keys):
        raise ValueError(
            "Room keys must be unique. Rename copied Rhino objects or supply keys."
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
            room = prepare_room(
                item,
                name,
                keys[index],
                _reference_text(references[index]),
                index,
                scale,
                tolerance,
            )
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
            room.brep_m.Dispose()  # ty: ignore[too-many-positional-arguments]
    return result


def _reference_text(reference: object) -> str:
    if isinstance(reference, Guid) and reference != Guid.Empty:
        return str(reference)
    return ""


def resolve_room_keys(references: list[object], document: RhinoDoc) -> list[str]:
    keys: list[str] = []
    for index, reference in enumerate(references):
        if not isinstance(reference, Guid) or reference == Guid.Empty:
            raise ValueError(
                f"[{index + 1}] The input is not a referenced Rhino object. "
                "Bake it or supply keys."
            )
        rhino_object = document.Objects.FindId(reference)
        if rhino_object is None:
            raise ValueError(
                f"[{index + 1}] Referenced object {reference} is not in the document."
            )
        name = rhino_object.Attributes.Name or ""
        user_key = rhino_object.Attributes.GetUserString("room_key") or ""
        keys.append(name.strip() or user_key.strip() or str(reference)[:8])
    return keys
