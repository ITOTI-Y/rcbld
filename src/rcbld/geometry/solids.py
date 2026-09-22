from collections.abc import Iterable
from typing import Callable, Optional, cast

from Rhino import Geometry

from rcbld.models.geometry import FacePolygon, Orientation, SolidFacts, Vec3

_ORIENTATIONS: dict[object, Orientation] = {
    Geometry.BrepSolidOrientation.Outward: "outward",
    Geometry.BrepSolidOrientation.Inward: "inward",
}


def _vec(point: Geometry.Point3d, scale: float) -> Vec3:
    return Vec3(point.X * scale, point.Y * scale, point.Z * scale)


def _face_polygon(
    face: Geometry.BrepFace, scale: float, tolerance: float, flip: bool
) -> FacePolygon:
    normal = face.NormalAt(face.Domain(0).Mid, face.Domain(1).Mid)
    normal.Unitize()  # ty: ignore[too-many-positional-arguments]
    sign = -1.0 if flip else 1.0

    duplicate = face.DuplicateFace(False)
    try:
        area = duplicate.GetArea(1e-8, tolerance) * scale**2
    finally:
        duplicate.Dispose()

    curve = face.OuterLoop.To3dCurve()  # ty: ignore[too-many-positional-arguments]
    try:
        is_polyline, polyline = cast(
            Callable[[], tuple[bool, Geometry.Polyline]],
            curve.TryGetPolyline,
        )()
        vertices = (
            [_vec(point, scale) for point in cast(Iterable[Geometry.Point3d], polyline)]
            if is_polyline
            else []
        )
        if is_polyline and polyline.IsClosed and len(vertices) > 1:
            vertices.pop()
    finally:
        curve.Dispose()  # ty: ignore[too-many-positional-arguments]

    return FacePolygon(
        vertices_m=vertices,
        normal=(sign * normal.X, sign * normal.Y, sign * normal.Z),
        area_m2=area,
        is_planar=face.IsPlanar(tolerance),
        inner_loop_count=face.Loops.Count - 1,
    )


def describe_solid(
    brep: Geometry.Brep,
    scale: float,
    tolerance: float,
) -> SolidFacts:
    box = brep.GetBoundingBox(True)
    bounds_min = _vec(box.Min, scale) if box.IsValid else (0.0, 0.0, 0.0)
    bounds_max = _vec(box.Max, scale) if box.IsValid else (0.0, 0.0, 0.0)
    if not brep.IsValid:
        return SolidFacts(
            is_valid=False, bounds_min_m=bounds_min, bounds_max_m=bounds_max
        )

    pieces = brep.GetConnectedComponents()  # ty: ignore[too-many-positional-arguments]
    try:
        component_count = len(pieces)
    finally:
        for piece in pieces:
            piece.Dispose()

    orientation = _ORIENTATIONS.get(brep.SolidOrientation, "none")
    faces = [
        _face_polygon(face, scale, tolerance, orientation == "inward")
        for face in cast(Iterable[Geometry.BrepFace], brep.Faces)
    ]

    return SolidFacts(
        is_valid=True,
        is_solid=brep.IsSolid,
        component_count=component_count,
        orientation=orientation,
        volume_m3=abs(brep.GetVolume(1e-8, tolerance)) * scale**3,
        area_m2=brep.GetArea(1e-8, tolerance) * scale**2,
        bounds_min_m=bounds_min,
        bounds_max_m=bounds_max,
        faces=faces,
    )


def solids_overlap_volume(
    first: Geometry.Brep,
    second: Geometry.Brep,
    tolerance: float,
) -> Optional[float]:
    pieces = Geometry.Brep.CreateBooleanIntersection(first, second, tolerance)
    if pieces is None:
        return None
    volume = 0.0
    for piece in cast(Iterable[Geometry.Brep], pieces):
        volume += abs(piece.GetVolume(1e-8, tolerance))
        piece.Dispose()  # ty: ignore[too-many-positional-arguments]
    return volume
