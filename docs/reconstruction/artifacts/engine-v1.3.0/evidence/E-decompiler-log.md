### E-decompiler-log
- title: Decompiler warnings and errors
- observed_at: 2026-09-07T10:10:39.283910+00:00
- source_type: command
- source_ref: archive/RCBldEng-v1.3.0.zip; evidence/unpacker-redacted.log
- severity: n/a_re
- status: observed
- content_hash: sha256:4940445dd92fb0840e3d24b789e649a8f34e9c67b6b3dd6c13a646d07fa4aa2b
- artifact_path: evidence/unpacker-redacted.log
- repro_command: |
    Repeat the README.md unpacking command with --unhide-all-noisy-logs; capture stdout and stderr. Runtime key line is redacted for this archive.
- raw_excerpt: 209 lines matched warning/error/failed/unsupported; exit code zero is not source recovery success.
- linked_workitem: WI-004
- supersedes: none
- notes: Offline static analysis; no engine code executed. See README.md for prerequisites.
