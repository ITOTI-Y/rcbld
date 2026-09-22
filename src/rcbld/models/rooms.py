from pydantic import Field

from rcbld.models._share import BaseModel
from rcbld.models.geometry import FacePolygon, Vec3


class Room(BaseModel):
    room_key: str
    reference_id: str
    source_index: int
    name: str
    faces: list[FacePolygon]
    bounds_min_m: Vec3
    bounds_max_m: Vec3
    volume_m3: float
    envelope_area_m2: float
    tolerance_m: float


class RoomChecks(BaseModel):
    rooms: list[Room] = Field(default_factory=list)
    ready: bool = False
    preview_indices: list[int] = Field(default_factory=list)
    invalid_indices: list[int] = Field(default_factory=list)
    points: list[Vec3] = Field(default_factory=list)
    labels: list[str] = Field(default_factory=list)
    report: list[str] = Field(default_factory=list)
