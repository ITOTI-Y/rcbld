"""Load RhinoCommon into plain CPython via Rhino.Inside before any rcbld import.

Requires Windows, 64-bit CPython 3.9 and an installed Rhino 8. The dotnet
runtime can be overridden with RCBLD_RHINO_RUNTIME (net8.0 or net7.0).
"""

import os
import sys

import pytest

if sys.platform != "win32":
    pytest.skip("Rhino.Inside only runs on Windows.", allow_module_level=True)

import rhinoinside

rhinoinside.load(8, os.environ.get("RCBLD_RHINO_RUNTIME", "net8.0"))

import Rhino  # noqa: E402


@pytest.fixture(scope="session")
def rhino_doc():
    document = Rhino.RhinoDoc.CreateHeadless(None)
    document.ModelUnitSystem = Rhino.UnitSystem.Meters
    document.ModelAbsoluteTolerance = 0.001
    yield document
    document.Dispose()


@pytest.fixture(scope="session")
def mm_doc():
    document = Rhino.RhinoDoc.CreateHeadless(None)
    document.ModelUnitSystem = Rhino.UnitSystem.Millimeters
    document.ModelAbsoluteTolerance = 0.01
    yield document
    document.Dispose()
