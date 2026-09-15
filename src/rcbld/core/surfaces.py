from collections.abc import Iterable
from math import isfinite
from typing import Any, cast

from Rhino import Geometry, RhinoDoc

from rcbld.core._share import model_scale
from rcbld.models.rooms import Room
from rcbld.models.surfaces import (
    Adjacency,
    GeometryType,
    Surface,
    SurfaceChecks,
    SurfaceOverride,
)


def _read_room(item: object) -> Room:
    values = cast(Any, item)
    try:
        return Room(
            room_key=values.room_key,
            reference_id=values.reference_id,
            source_index=values.source_index,
            name=values.name,
            brep_m=values.brep_m,
            volume_m3=values.volume_m3,
            envelope_area_m2=values.envelope_area_m2,
            tolerance=values.tolerance,
        )
    except AttributeError as error:
        raise ValueError(
            "rooms must contain Room objects produced by the Rooms component."
        ) from error


def _read_override(item: object) -> SurfaceOverride:
    values = cast(Any, item)
    try:
        return SurfaceOverride(
            surface_key=values.surface_key,
            surface_signature=values.surface_signature,
            boundary_type=values.boundary_type,
            neighbor_room_key=values.neighbor_room_key,
        )
    except AttributeError as error:
        raise ValueError(
            "overrides must contain SurfaceOverride objects with surface_key, "
            "surface_signature, boundary_type and neighbor_room_key."
        ) from error


def _outward_normal(face: Geometry.BrepFace) -> Geometry.Vector3d:
    normal = face.NormalAt(face.Domain(0).Mid, face.Domain(1).Mid)
    if not normal.Unitize():  # ty: ignore[too-many-positional-arguments]
        raise ValueError("The face normal could not be determined.")
    return normal


def _geometry_type(normal: Geometry.Vector3d) -> GeometryType:
    if abs(normal.Z) >= max(abs(normal.X), abs(normal.Y)):
        return "roof" if normal.Z > 0 else "floor"
    return "wall"


def _signature(face_m: Geometry.Brep, normal: Geometry.Vector3d) -> str:
    box = face_m.GetBoundingBox(True)
    values = (
        box.Min.X,
        box.Min.Y,
        box.Min.Z,
        box.Max.X,
        box.Max.Y,
        box.Max.Z,
        normal.X,
        normal.Y,
        normal.Z,
    )
    return ":".join(f"{value:.6f}" for value in values)


def _dispose_all(surfaces: list[Surface]) -> None:
    for surface in surfaces:
        surface.brep_m.Dispose()  # ty: ignore[too-many-positional-arguments]


def _extract_faces(room: Room, tolerance: float) -> list[Surface]:
    surfaces: list[Surface] = []
    faces = cast(Iterable[Geometry.BrepFace], room.brep_m.Faces)
    try:
        for index, face in enumerate(faces):
            normal = _outward_normal(face)
            duplicate = face.DuplicateFace(False)
            try:
                area = duplicate.GetArea(1e-8, tolerance)
                if not isfinite(area) or area <= 0.0:
                    raise ValueError(
                        f"{room.room_key} face {index + 1} has no positive area."
                    )
                surfaces.append(
                    Surface(
                        room_key=room.room_key,
                        surface_key=f"{room.room_key}:face-{index + 1}",
                        surface_signature=_signature(duplicate, normal),
                        source_face_index=index,
                        geometry_type=_geometry_type(normal),
                        boundary_type="outdoor",
                        area_m2=area,
                        normal=normal,
                        brep_m=duplicate,
                    )
                )
            except ValueError:
                duplicate.Dispose()
                raise
    except ValueError:
        _dispose_all(surfaces)
        raise
    return surfaces


def _check_overlap(rooms: list[Room], tolerance_m: float) -> None:
    for index, first in enumerate(rooms):
        first_box = first.brep_m.GetBoundingBox(True)
        for second in rooms[index + 1 :]:
            second_box = second.brep_m.GetBoundingBox(True)
            shared = Geometry.BoundingBox.Intersection(first_box, second_box)
            if not shared.IsValid:
                continue
            extent = Geometry.Point3d.Subtract(shared.Max, shared.Min)
            if min(extent.X, extent.Y, extent.Z) < tolerance_m:
                continue
            pieces = Geometry.Brep.CreateBooleanIntersection(
                first.brep_m, second.brep_m, tolerance_m
            )
            if pieces is None:
                raise ValueError(
                    f"Overlap between {first.room_key} and {second.room_key} "
                    "could not be determined. Check the solids with Intersect."
                )
            volume = 0.0
            for piece in cast(Iterable[Geometry.Brep], pieces):
                volume += abs(piece.GetVolume(1e-8, tolerance_m))
                piece.Dispose()  # ty: ignore[too-many-positional-arguments]
            if volume > 1e-6 * min(first.volume_m3, second.volume_m3):
                raise ValueError(
                    f"Rooms {first.room_key} and {second.room_key} overlap "
                    f"by {volume:.6g} m3."
                )


def _anchor_point(brep: Geometry.Brep) -> Geometry.Point3d:
    vertices = cast(Iterable[Geometry.BrepVertex], brep.Vertices)
    return next(iter(vertices)).Location


def _shared_plane(
    first: Surface,
    second: Surface,
    tolerance_m: float,
) -> Geometry.Plane | None:
    if Geometry.Vector3d.Multiply(first.normal, second.normal) > -1.0 + 1e-6:
        return None
    plane = Geometry.Plane(_anchor_point(first.brep_m), first.normal)
    distance = abs(plane.DistanceTo(_anchor_point(second.brep_m)))
    return plane if distance < tolerance_m else None


def _contact_area(
    first: Surface,
    second: Surface,
    plane: Geometry.Plane,
    tolerance_m: float,
) -> float:
    pieces = Geometry.Brep.CreatePlanarIntersection(
        first.brep_m, second.brep_m, plane, tolerance_m
    )
    if pieces is None:
        return 0.0
    area = 0.0
    for piece in cast(Iterable[Geometry.Brep], pieces):
        area += piece.GetArea(1e-8, tolerance_m)
        piece.Dispose()  # ty: ignore[too-many-positional-arguments]
    return area


def _pair_contacts(
    rooms: list[Room],
    surfaces: list[Surface],
    tolerance_m: float,
    adjacencies: list[Adjacency],
) -> None:
    by_room: dict[str, list[Surface]] = {room.room_key: [] for room in rooms}
    for surface in surfaces:
        by_room[surface.room_key].append(surface)
    for index, first in enumerate(rooms):
        for second in rooms[index + 1 :]:
            for first_part in by_room[first.room_key]:
                for second_part in by_room[second.room_key]:
                    plane = _shared_plane(first_part, second_part, tolerance_m)
                    if plane is None:
                        continue
                    area = _contact_area(first_part, second_part, plane, tolerance_m)
                    if area <= tolerance_m**2:
                        continue
                    for part, other in (
                        (first_part, second.room_key),
                        (second_part, first.room_key),
                    ):
                        if part.neighbor_room_key not in ("", other):
                            raise ValueError(
                                f"{part.surface_key} touches several rooms. "
                                "Split the face in Rhino so each part touches one room."
                            )
                        part.boundary_type = "adjacent"
                        part.neighbor_room_key = other
                        part.contact_area_m2 += area
                    adjacencies.append(
                        Adjacency(
                            first_room_key=first.room_key,
                            first_surface_key=first_part.surface_key,
                            second_room_key=second.room_key,
                            second_surface_key=second_part.surface_key,
                            contact_area_m2=area,
                        )
                    )


def _apply_ground(
    rooms: list[Room], surfaces: list[Surface], tolerance_m: float
) -> None:
    ground_z = min(room.brep_m.GetBoundingBox(True).Min.Z for room in rooms)
    for surface in surfaces:
        if surface.geometry_type != "floor" or surface.boundary_type != "outdoor":
            continue
        top_z = surface.brep_m.GetBoundingBox(True).Max.Z
        if top_z <= ground_z + tolerance_m:
            surface.boundary_type = "ground"


def _apply_overrides(
    surfaces: list[Surface],
    overrides: list[SurfaceOverride],
    room_keys: set[str],
) -> None:
    by_key = {surface.surface_key: surface for surface in surfaces}
    seen: set[str] = set()

    for item in overrides:
        override = _read_override(item)
        if override.surface_key in seen:
            raise ValueError(f"Duplicate override for {override.surface_key}.")
        seen.add(override.surface_key)
        surface = by_key.get(override.surface_key)
        if surface is None:
            raise ValueError(
                f"Override names an unknown surface: {override.surface_key}."
            )
        if surface.surface_signature != override.surface_signature:
            raise ValueError(
                f"{override.surface_key} changed since it was confirmed. "
                "Copy the current signature and confirm again."
            )
        if surface.neighbor_room_key:
            raise ValueError(
                f"{override.surface_key} touches {surface.neighbor_room_key}; "
                "a detected contact cannot be overridden."
            )
        if override.boundary_type == "adjacent":
            if (
                override.neighbor_room_key not in room_keys
                or override.neighbor_room_key == surface.room_key
            ):
                raise ValueError(
                    f"{override.surface_key} needs the key of another room "
                    "in this batch as neighbor_room_key."
                )
        elif override.neighbor_room_key:
            raise ValueError(
                f"{override.surface_key} is {override.boundary_type}; "
                "only adjacent surfaces name a neighbor."
            )
        surface.boundary_type = override.boundary_type
        surface.neighbor_room_key = override.neighbor_room_key


def _document_copy(brep_m: Geometry.Brep, scale: float) -> Geometry.Brep:
    copy = brep_m.DuplicateBrep()  # ty: ignore[too-many-positional-arguments]
    origin = cast(Geometry.Point3d, Geometry.Point3d.Origin)
    if not copy.Transform(Geometry.Transform.Scale(origin, 1.0 / scale)):
        copy.Dispose()  # ty: ignore[too-many-positional-arguments]
        raise ValueError("The preview geometry could not be converted to model units.")
    return copy


def _label(surface: Surface) -> str:
    text = (
        f"{surface.surface_key}: {surface.geometry_type}, {surface.boundary_type}, "
        f"A = {surface.area_m2:.6g} m2"
    )
    if surface.neighbor_room_key:
        text += f", neighbor = {surface.neighbor_room_key}"
    return text


def check_surfaces(
    rooms: list[object],
    upstream_ready: bool,
    overrides: list[SurfaceOverride],
    document: RhinoDoc,
) -> SurfaceChecks:
    if not upstream_ready:
        raise ValueError("Connect a ready Rooms result before checking surfaces.")
    if not rooms:
        raise ValueError("The rooms list is empty.")
    scale, document_tolerance = model_scale(document)
    tolerance_m = document_tolerance * scale
    room_values = [_read_room(item) for item in rooms]
    room_keys = [room.room_key for room in room_values]
    if len(set(room_keys)) != len(room_keys):
        raise ValueError("Room keys must be unique.")

    result = SurfaceChecks()
    surfaces: list[Surface] = []

    try:
        _check_overlap(room_values, tolerance_m)
        for room in room_values:
            surfaces.extend(_extract_faces(room, tolerance_m))
        _pair_contacts(room_values, surfaces, tolerance_m, result.adjacencies)
        _apply_ground(room_values, surfaces, tolerance_m)
        _apply_overrides(surfaces, overrides, set(room_keys))
        for surface in surfaces:
            if surface.contact_area_m2 > surface.area_m2 + tolerance_m**2:
                raise ValueError(
                    f"Contact area exceeds the face area at {surface.surface_key}."
                )
    except ValueError as error:
        _dispose_all(surfaces)
        result.adjacencies = []
        result.invalid = [_document_copy(room.brep_m, scale) for room in room_values]
        result.report.append(str(error))
        return result

    for room in room_values:
        parts = [surface for surface in surfaces if surface.room_key == room.room_key]
        result.envelope_area_m2[room.room_key] = sum(part.area_m2 for part in parts)
        result.floor_area_m2[room.room_key] = sum(
            part.area_m2 for part in parts if part.geometry_type == "floor"
        )
    for surface in surfaces:
        preview = _document_copy(surface.brep_m, scale)
        result.preview.append(preview)
        result.points.append(preview.GetBoundingBox(True).Center)
        label = _label(surface)
        result.labels.append(label)
        result.report.append(label)
    result.surfaces = surfaces
    result.ready = True
    return result
