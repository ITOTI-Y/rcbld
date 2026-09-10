import importlib

from . import _share, rooms


def reload_models() -> None:
    importlib.reload(_share)
    importlib.reload(rooms)
