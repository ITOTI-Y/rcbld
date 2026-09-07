### E-engine-imports
- title: engine PE sections, imports and exports
- observed_at: 2026-09-07T10:10:39.283910+00:00
- source_type: command
- source_ref: archive/RCBldEng-v1.3.0.zip; evidence/engine-pe.json
- severity: n/a_re
- status: observed
- content_hash: sha256:d186c70c2c8487f7cbec162dff6ec87862cc9428c467f99100d353333a76ebfc
- artifact_path: evidence/engine-pe.json
- repro_command: |
    rabin2 -I -S -i -E -j "$analysis_dir/RCBldEng.exe"
- raw_excerpt: Complete rabin2 JSON; import presence does not prove a runtime behavior.
- linked_workitem: WI-002
- supersedes: none
- notes: Offline static analysis; no engine code executed. See README.md for prerequisites.
