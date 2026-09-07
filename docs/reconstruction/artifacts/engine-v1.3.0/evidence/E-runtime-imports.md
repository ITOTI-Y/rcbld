### E-runtime-imports
- title: runtime PE sections, imports and exports
- observed_at: 2026-09-07T10:10:39.283910+00:00
- source_type: command
- source_ref: archive/RCBldEng-v1.3.0.zip; evidence/runtime-pe.json
- severity: n/a_re
- status: observed
- content_hash: sha256:78824eae2560db51bc6487a086e7bb76f6233620b8bbfae2be1c4042a2857753
- artifact_path: evidence/runtime-pe.json
- repro_command: |
    rabin2 -I -S -i -E -j "$analysis_dir/pyarmor_runtime.pyd"
- raw_excerpt: Complete rabin2 JSON; import presence does not prove a runtime behavior.
- linked_workitem: WI-002
- supersedes: none
- notes: Offline static analysis; no engine code executed. See README.md for prerequisites.
