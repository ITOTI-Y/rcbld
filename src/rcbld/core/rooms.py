from collections.abc import Callable
from math import isfinite
from typing import Optional

from rcbld.core.polygon import length

from rcbld.models.geometry import ReferenceFacts, SolidFacts, Vec3
from rcbld.models.rooms import Room, RoomChecks


def _face_numbers(
    facts: SolidFacts,
    predicate: Callable[[int], bool],
) -> str:
    return ", ".join(
        str(index + 1) for index, _ in enumerate(facts.faces) if predicate(index)
    )


def prepare_room(
    facts: SolidFacts,
    name: str,
    room_key: str,
    reference_id: str,
    source_index: int,
    tolerance_m: float,
) -> Room:
    if not facts.is_valid:
        raise ValueError(
            "Rhino reports invalid geometry. Inspect the source with Check."
        )
    if not facts.is_solid:
        raise ValueError("The room is not a closed solid. Check open edges and joins.")
    if facts.component_count > 1:
        raise ValueError(
            "One input contains separate solids. Supply one solid per room."
        )

    faces = facts.faces
    curved = _face_numbers(facts, lambda index: not faces[index].is_planar)
    if curved:
        raise ValueError("Non-planar face numbers: " + curved)
    holed = _face_numbers(facts, lambda index: faces[index].inner_loop_count > 0)
    if holed:
        raise ValueError(
            "Faces with openings (inner loops): " + holed + ". Fill or split them."
        )
    broken = _face_numbers(facts, lambda index: len(faces[index].vertices_m) < 3)
    if broken:
        raise ValueError(
            "Face boundaries that are not closed polylines: " + broken + "."
        )
    unnormalized = _face_numbers(
        facts, lambda index: abs(length(faces[index].normal) - 1.0) > 1e-6
    )
    if unnormalized:
        raise ValueError("The face normal could not be determined: " + unnormalized)

    if facts.orientation == "none":
        raise ValueError("The solid orientation cannot be determined.")
    if not isfinite(facts.volume_m3) or facts.volume_m3 <= 0:
        raise ValueError(
            "The room volume could not be measured as a positive finite value."
        )
    if not isfinite(facts.area_m2) or facts.area_m2 <= 0:
        raise ValueError(
            "The envelope area could not be measured as a positive finite value."
        )

    return Room(
        room_key=room_key,
        reference_id=reference_id,
        source_index=source_index,
        name=name,
        faces=faces,
        bounds_min_m=facts.bounds_min_m,
        bounds_max_m=facts.bounds_max_m,
        volume_m3=facts.volume_m3,
        envelope_area_m2=facts.area_m2,
        tolerance_m=tolerance_m,
    )


def resolve_room_keys(references: list[ReferenceFacts]) -> list[str]:
    keys: list[str] = []
    for index, reference in enumerate(references):
        if not reference.reference_id:
            raise ValueError(
                f"[{index + 1}] The input is not a referenced Rhino object. "
                "Bake it or supply keys."
            )
        if not reference.in_document:
            raise ValueError(
                f"[{index + 1}] Referenced object {reference.reference_id} "
                "is not in the document."
            )
        keys.append(
            reference.name.strip()
            or reference.user_key.strip()
            or reference.reference_id[:8]
        )
    return keys


def _center(facts: SolidFacts) -> Vec3:
    low, high = facts.bounds_min_m, facts.bounds_max_m
    return Vec3(
        (low[0] + high[0]) / 2,
        (low[1] + high[1]) / 2,
        (low[2] + high[2]) / 2,
    )

def _boxes_touch(first: Room, second: Room, tolerance_m: float) -> bool:
    for axis in range(3):
        low = max(first.bounds_min_m[axis], second.bounds_min_m[axis])
        high = min(first.bounds_max_m[axis], second.bounds_max_m[axis])
        if high - low < tolerance_m:
            return False
    return True

def _check_overlap(
    rooms: list[Room],
    tolerance_m: float,
    overlap_volume: Callable[[int, int], Optional[float]]
) -> None:
    for index, first in enumerate(rooms):
        for second in rooms[index + 1:]:
            if not _boxes_touch(first, second, tolerance_m):
                continue
            volume = overlap_volume(first.source_index, second.source_index)
            if volume is None:
                raise ValueError(
                    f"Overlap between {first.room_key} and {second.room_key} "
                    "could not be determined. Check the solids with Intersect."
                )
            if volume > 1e-6 * min(first.volume_m3, second.volume_m3):
                raise ValueError(
                    f"Rooms {first.room_key} and {second.room_key} overlap "
                    f"by {volume:.6g} m3."
                )

def check_rooms(
    facts: list[Optional[SolidFacts]],
    supplied_names: list[object],
    supplied_keys: list[object],
    references: list[ReferenceFacts],
    tolerance_m: float,
    overlap_volume: Callable[[int, int], Optional[float]],
) -> RoomChecks:
    if not facts:
        raise ValueError("Connect at least one room Brep.")
    if supplied_names and len(supplied_names) != len(facts):
        raise ValueError(
            f"Names must be empty or contain {len(facts)} entries; "
            f"received {len(supplied_names)}."
        )
    if len(references) != len(facts):
        raise ValueError(
            f"References must contain {len(facts)} entries; received {len(references)}."
        )
    if supplied_keys:
        if len(supplied_keys) != len(facts):
            raise ValueError(
                f"Keys must be empty or contain {len(facts)} entries; "
                f"received {len(supplied_keys)}."
            )
        keys: list[str] = []
        for entered_key in supplied_keys:
            if not isinstance(entered_key, str) or not entered_key.strip():
                raise ValueError("Every room key must be nonblank text.")
            keys.append(entered_key.strip())
    else:
        keys = resolve_room_keys(references)
    if len(set(keys)) != len(keys):
        raise ValueError(
            "Room keys must be unique. Rename copied Rhino objects or supply keys."
        )

    result = RoomChecks()
    candidates: list[Room] = []

    for index, item in enumerate(facts):
        name = f"Room {index + 1}"
        try:
            if item is None:
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
                references[index].reference_id,
                index,
                tolerance_m,
            )
        except ValueError as error:
            message = f"[{index + 1}] {name}: ERROR - {error}"
            result.invalid_indices.append(index)
        else:
            candidates.append(room)
            result.preview_indices.append(index)
            message = (
                f"[{index + 1}] {name}: OK | "
                f"V = {room.volume_m3:.6g} m3 | "
                f"Envelope = {room.envelope_area_m2:.6g} m2"
            )
        result.report.append(message)
        if item is not None:
            result.points.append(_center(item))
            result.labels.append(message)

    if len(candidates) != len(facts):
        return result
    try:
        _check_overlap(candidates, tolerance_m, overlap_volume)
    except ValueError as error:
        result.report.append(str(error))
    result.rooms = candidates
    result.ready = True
    return result
