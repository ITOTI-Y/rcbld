### E-simulation
- title: simulation recovered disassembly
- observed_at: 2026-09-07T10:10:39.283910+00:00
- source_type: command
- source_ref: archive/RCBldEng-v1.3.0.zip; disassembly/simulation.das
- severity: n/a_re
- status: observed
- content_hash: sha256:9a5c011fcc65e3cb6c5667946054483488433a11faa0d7bafeaf688398f2be74
- artifact_path: disassembly/simulation.das
- repro_command: |
    python "$unpacker_dir/oneshot/shot.py" "$analysis_dir/input" -r "$analysis_dir/pyarmor_runtime.pyd" -o "$analysis_dir/recovered" --concurrent 1 --no-banner --unhide-all-noisy-logs
- raw_excerpt: 45 code objects; disassembly is not executable source.
- linked_workitem: WI-003
- supersedes: none
- notes: Offline static analysis; no engine code executed. See README.md for prerequisites.
