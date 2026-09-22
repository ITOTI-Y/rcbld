import importlib

from src.rcbld.geometry import document, preview, solids


def reload_geometry() -> None:
    importlib.reload(document)
    importlib.reload(solids)
    importlib.reload(preview)
