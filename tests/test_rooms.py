import pytest
from Rhino import Geometry
from System import Guid

from rcbld.core.rooms import check_rooms


def make_box(x: float, y: float, z: float) -> Geometry.Brep:
    box = Geometry.Box(
        Geometry.Plane.WorldXY,
        Geometry.Interval(0.0, x),
        Geometry.Interval(0.0, y),
        Geometry.Interval(0.0, z),
    )
    return box.ToBrep()


def test_single_box_is_ready(rhino_doc):
    brep = make_box(4.0, 3.0, 2.5)
    checks = check_rooms([brep], ["Office"], ["R1"], [Guid.Empty], rhino_doc)
    assert checks.ready, checks.report
    room = checks.rooms[0]
    assert room.name == "Office"
    assert room.room_key == "R1"
    assert room.volume_m3 == pytest.approx(30.0, rel=1e-6)
    assert room.envelope_area_m2 == pytest.approx(59.0, rel=1e-6)


def test_millimeter_document_scales_to_meters(mm_doc):
    brep = make_box(4000.0, 3000.0, 2500.0)
    checks = check_rooms([brep], [], ["R1"], [Guid.Empty], mm_doc)
    assert checks.ready, checks.report
    assert checks.rooms[0].volume_m3 == pytest.approx(30.0, rel=1e-6)


def test_open_brep_is_rejected(rhino_doc):
    brep = make_box(2.0, 2.0, 2.0)
    open_brep = brep.Faces[0].DuplicateFace(False)
    checks = check_rooms([open_brep], [], ["R1"], [Guid.Empty], rhino_doc)
    assert not checks.ready
    assert "not a closed solid" in checks.report[0]
    assert checks.invalid == [open_brep]


def test_duplicate_keys_raise(rhino_doc):
    breps = [make_box(1.0, 1.0, 1.0), make_box(2.0, 2.0, 2.0)]
    with pytest.raises(ValueError, match="unique"):
        check_rooms(breps, [], ["R1", "R1"], [Guid.Empty, Guid.Empty], rhino_doc)


def test_missing_reference_without_keys_raises(rhino_doc):
    with pytest.raises(ValueError, match="not a referenced Rhino object"):
        check_rooms([make_box(1.0, 1.0, 1.0)], [], [], [Guid.Empty], rhino_doc)
