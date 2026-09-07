### E-extraction
- title: Pinned release and wrapper extraction
- observed_at: 2026-09-07T10:10:39.283910+00:00
- source_type: command
- source_ref: archive/RCBldEng-v1.3.0.zip; evidence/extraction.json
- severity: n/a_re
- status: observed
- content_hash: sha256:19d9faabfc547d6f98457de4f1ee318ddea10eefdc54f6b64842becddc113700
- artifact_path: evidence/extraction.json
- repro_command: |
    uv run --no-project --python 3.9.11 python extract_inputs.py ../../../../archive/RCBldEng-v1.3.0.zip "$analysis_dir"
- raw_excerpt: Five protected wrappers; release, EXE and PYD fingerprints checked; 12 CArchive and 723 PYZ entries.
- linked_workitem: WI-001
- supersedes: none
- notes: Offline static analysis; no engine code executed. See README.md for prerequisites.
