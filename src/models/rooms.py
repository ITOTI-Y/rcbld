from pydantic import Field
from Rhino import Geometry

from src.models._share import BaseModel


class Room(BaseModel):
    source_index: int
    name: str
    brep_m: Geometry.Brep
    volume_m3: float
    envelope_area_m2: float
    tolerance: float

class RoomChecks(BaseModel):
    rooms: list[Room] = Field(default_factory=list)
    ready: bool = False
    preview: list[Geometry.Brep] = Field(default_factory=list)
    invalid: list[Geometry.GeometryBase] = Field(default_factory=list)
    points: list[Geometry.Point3d] = Field(default_factory=list)
    labels: list[str] = Field(default_factory=list)
    report: list[str] = Field(default_factory=list)
