from __future__ import annotations

from typing import Literal, NamedTuple

from pydantic import Field, model_validator

from rcbld.models._share import BaseModel

Orientation = Literal["outward", "inward", "none"]


class Vec3(NamedTuple):
    x: float
    y: float
    z: float


def newell_normal(vertices: list[Vec3]) -> Vec3:
    x = y = z = 0
    for index, (ax, ay, az) in enumerate(vertices):
        bx, by, bz = vertices[(index + 1) % len(vertices)]
        x += (ay - by) * (az + bz)
        y += (az - bz) * (ax + bx)
        z += (ax - bx) * (ay + by)
    return Vec3(x, y, z)


class FacePolygon(BaseModel):
    vertices_m: list[Vec3]
    normal: Vec3
    area_m2: float
    is_planar: bool
    inner_loop_count: int = Field(default=0, ge=0)

    @model_validator(mode="after")
    def orient_counterclockwise(self) -> FacePolygon:
        if len(self.vertices_m) < 3:
            return self
        nx, ny, nz = newell_normal(self.vertices_m)
        if nx * self.normal[0] + ny * self.normal[1] + nz * self.normal[2] < 0:
            self.vertices_m = list(reversed(self.vertices_m))
        return self


class ReferenceFacts(BaseModel):
    reference_id: str = ""
    in_document: bool = False
    name: str = ""
    user_key: str = ""


class SolidFacts(BaseModel):
    is_valid: bool
    is_solid: bool = False
    component_count: int = 0
    orientation: Orientation = "none"
    volume_m3: float = 0.0
    area_m2: float = 0.0
    bounds_min_m: Vec3 = Vec3(0.0, 0.0, 0.0)
    bounds_max_m: Vec3 = Vec3(0.0, 0.0, 0.0)
    faces: list[FacePolygon] = Field(default_factory=list)
