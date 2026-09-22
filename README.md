# rcbld

## Development setup

### Rhino / Grasshopper type stubs

The editor and `ty` resolve `Rhino`, `Grasshopper` and `System` imports from a
`.stubs` directory at the repository root. `.stubs` is git-ignored and must be a
symbolic link to the type stubs shipped with Rhino 8 (RhinoCode), so no
machine-specific path lives in the repository.

The stubs are installed under `~/.rhinocode/py39-rh8/site-stubs/` on the
machine that runs Rhino 8. Create the link once per clone:

```sh
# WSL / Linux (Rhino installed on the Windows side)
ln -s "/mnt/c/Users/<user>/.rhinocode/py39-rh8/site-stubs/rhino3d-<version>" .stubs

# macOS
ln -s "$HOME/.rhinocode/py39-rh8/site-stubs/rhino3d-<version>" .stubs
```

Replace `<user>` and `<version>` with the values found on your machine
(for example `rhino3d-8.30.26103.11001`). The link is read by:

- `.vscode/settings.json` via `python.analysis.stubPath` (Pylance) and
  `cursorpyright.analysis.stubPath` (Cursor);
- `pyproject.toml` via `[tool.ty.environment] extra-paths`.

Verify the setup with:

```sh
uv run ty check src
```

No `unresolved-import` diagnostics should be reported for `Rhino`,
`Grasshopper` or `System`. After upgrading Rhino, point the link at the new
`rhino3d-<version>` directory.
