### E-weather
- title: weather recovered disassembly
- observed_at: 2026-09-07T10:10:39.283910+00:00
- source_type: command
- source_ref: archive/RCBldEng-v1.3.0.zip; disassembly/weather.das
- severity: n/a_re
- status: observed
- content_hash: sha256:fe5591ff233994b50ab0aa07258f71ec8c4442ed430284eddab3dcad8c0df3e3
- artifact_path: disassembly/weather.das
- repro_command: |
    python "$unpacker_dir/oneshot/shot.py" "$analysis_dir/input" -r "$analysis_dir/pyarmor_runtime.pyd" -o "$analysis_dir/recovered" --concurrent 1 --no-banner --unhide-all-noisy-logs
- raw_excerpt: 19 code objects; disassembly is not executable source.
- linked_workitem: WI-003
- supersedes: none
- notes: Offline static analysis; no engine code executed. See README.md for prerequisites.
