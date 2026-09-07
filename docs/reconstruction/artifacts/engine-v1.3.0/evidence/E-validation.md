### E-validation
- title: Recovery repeatability and source limitations
- observed_at: 2026-09-07T10:10:39.283910+00:00
- source_type: command
- source_ref: archive/RCBldEng-v1.3.0.zip; evidence/recovery-validation.json
- severity: n/a_re
- status: observed
- content_hash: sha256:fe6434c49a515d8c0402c213448b92104badedd89992fbb0c2a270306d937dcd
- artifact_path: evidence/recovery-validation.json
- repro_command: |
    See README.md: repeat extraction and unpacking, then compare sha256sum of all five .das files; compile drafts without executing them.
- raw_excerpt: Five disassemblies reproduced byte-for-byte; four drafts fail syntax checks; entry-point draft has no functions.
- linked_workitem: WI-004
- supersedes: none
- notes: Offline static analysis; no engine code executed. See README.md for prerequisites.
