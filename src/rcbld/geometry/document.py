from math import isfinite

from Rhino import RhinoDoc, RhinoMath, UnitSystem
from System import Guid

from rcbld.models.geometry import ReferenceFacts


def document_scale(doc: RhinoDoc) -> tuple[float, float]:
    units = doc.ModelUnitSystem
    unsupported = (
        UnitSystem.NONE,  # ty: ignore[unresolved-attribute]
        UnitSystem.Unset,
        UnitSystem.CustomUnits,
    )
    if units in unsupported:
        raise ValueError(
            "Set a standard Rhino model unit, such as meters or millimeters."
        )
    scale = RhinoMath.UnitScale(units, UnitSystem.Meters)
    tolerance = doc.ModelAbsoluteTolerance
    if not isfinite(scale) or scale <= 0:
        raise ValueError("The model unit cannot be converted to meters.")
    if not isfinite(tolerance) or tolerance <= 0:
        raise ValueError("The Rhino absolute tolerance must be positive and finite.")
    return scale, tolerance


def resolve_reference_keys(
    references: list[object], document: RhinoDoc
) -> list[ReferenceFacts]:
    facts: list[ReferenceFacts] = []
    for reference in references:
        if not isinstance(reference, Guid) or reference == Guid.Empty:
            facts.append(ReferenceFacts())
            continue
        rhino_object = document.Objects.FindId(reference)
        if rhino_object is None:
            facts.append(ReferenceFacts(reference_id=str(reference)))
            continue
        facts.append(
            ReferenceFacts(
                reference_id=str(reference),
                in_document=True,
                name=rhino_object.Attributes.Name or "",
                user_key=rhino_object.Attributes.GetUserString("room_key") or "",
            )
        )
    return facts
