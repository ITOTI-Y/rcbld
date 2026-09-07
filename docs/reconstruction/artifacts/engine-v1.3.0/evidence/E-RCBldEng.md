### E-RCBldEng
- title: RCBldEng recovered disassembly
- observed_at: 2026-09-07T10:10:39.283910+00:00
- source_type: command
- source_ref: archive/RCBldEng-v1.3.0.zip; disassembly/RCBldEng.das
- severity: n/a_re
- status: observed
- content_hash: sha256:1235074886120e207d59ce715ba53e5586515aae90b4fea8518c033a3e13e5b3
- artifact_path: disassembly/RCBldEng.das
- repro_command: |
    python "$unpacker_dir/oneshot/shot.py" "$analysis_dir/input" -r "$analysis_dir/pyarmor_runtime.pyd" -o "$analysis_dir/recovered" --concurrent 1 --no-banner --unhide-all-noisy-logs
- raw_excerpt: 5 code objects; disassembly is not executable source.
- linked_workitem: WI-003
- supersedes: none
- notes: Offline static analysis; no engine code executed. See README.md for prerequisites.
