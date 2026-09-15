from typing import Final, Literal

from pydantic import Field
from Rhino import Geometry

from rcbld.models._share import BaseModel

GeometryType: Final = Literal["wall", "roof", "floor"]
BoundaryType: Final = Literal["outdoor", "ground", "adjacent", "adiabatic"]


class SurfaceOverride(BaseModel):
    surface_key: str
    surface_signature: str
    boundary_type: BoundaryType
    neighbor_room_key: str = ""


class Surface(BaseModel):
    room_key: str
    surface_key: str
    surface_signature: str
    source_face_index: int
    geometry_type: GeometryType
    boundary_type: BoundaryType
    area_m2: float
    normal: Geometry.Vector3d
    brep_m: Geometry.Brep
    neighbor_room_key: str = ""
    contact_area_m2: float = 0.0


class Adjacency(BaseModel):
    first_room_key: str
    first_surface_key: str
    second_room_key: str
    second_surface_key: str
    contact_area_m2: float


class SurfaceChecks(BaseModel):
    surfaces: list[Surface] = Field(default_factory=list)
    adjacencies: list[Adjacency] = Field(default_factory=list)
    ready: bool = False
    preview: list[Geometry.Brep] = Field(default_factory=list)
    invalid: list[Geometry.Brep] = Field(default_factory=list)
    points: list[Geometry.Point3d] = Field(default_factory=list)
    labels: list[str] = Field(default_factory=list)
    report: list[str] = Field(default_factory=list)
    floor_area_m2: dict[str, float] = Field(default_factory=dict)
    envelope_area_m2: dict[str, float] = Field(default_factory=dict)
