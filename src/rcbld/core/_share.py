from math import isfinite

from Rhino import RhinoDoc, RhinoMath, UnitSystem


def model_scale(document: RhinoDoc) -> tuple[float, float]:
    units = document.ModelUnitSystem
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
    tolerance = document.ModelAbsoluteTolerance
    if not isfinite(scale) or scale <= 0:
        raise ValueError("The model unit cannot be converted to meters.")
    if not isfinite(tolerance) or tolerance <= 0:
        raise ValueError("The Rhino absolute tolerance must be positive and finite.")
    return scale, tolerance
