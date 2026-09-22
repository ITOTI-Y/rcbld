from typing import cast

from Rhino import Geometry
from System.Collections import Generic

from rcbld.models.geometry import FacePolygon, Vec3


def point3d(vec: Vec3, scale: float) -> Geometry.Point3d:
    return Geometry.Point3d(vec.x / scale, vec.y / scale, vec.z / scale)


def polygon_brep(polygon: FacePolygon, scale: float, tolerance: float) -> Geometry.Brep:
    points = [point3d(vertex, scale) for vertex in polygon.vertices_m]
    curve = Geometry.PolylineCurve(cast(Generic.IEnumerable, points + points[:1]))
    try:
        breps = Geometry.Brep.CreatePlanarBreps(curve, tolerance)
    finally:
        curve.Dispose()  # ty: ignore[too-many-positional-arguments]
    if not breps:
        raise ValueError(
            f"A preview face could not be built from {len(points)} vertices."
        )
    return breps[0]
