# Case scope

## meta
- case_id: pyarmor-static
- created: 2026-09-07T09:50:24+00:00
- archived: 2026-09-07T10:14:00+00:00
- operator: Codex, local analysis
- project_root: /mnt/scratch/rcbld
- primary_skill: radare2/SKILL.md
- primary_id: R7
- lead_role: lead
- specialist_roles: [cre, cce, doc]; roles performed by the same agent
- original_case: /tmp/rcbld-engine-recovery-ztr2pgfl/work/pyarmor-static

## auth
- status: granted
- basis: user_authorization
- evidence_of_auth: 用户提供引擎并说明源码遗失，明确要求反编译确认行为；2026-09-07 指定安装 reverse-skill，在无 Windows 环境下继续逆向。

## in_scope
- assets:
  - /mnt/scratch/rcbld/archive/RCBldEng-v1.3.0.zip
  - 该 ZIP 中 EXE、PyArmor PYD 和五个业务模块的本地派生副本
- surfaces: [PE, CArchive, PYZ, protected_Python_bytecode]
- activities: [static_inspection, offline_decryption, disassembly, protocol_analysis, evidence_preservation]

## out_of_scope
- assets: [unrelated_systems, unrelated_user_files]
- activities: [target_network_access, engine_replacement, original_asset_modification, community_publication]

## network_profile
- mode: offline
- notes: 目标样本仅本地分析。经本任务授权从 GitHub/PyPI 获取技能和分析工具，不连接任何引擎目标服务。

## deliverables
- report: true
- field_journal: true
- diagrams: true
- timeline: true

## constraints
- data_handling: 原始 ZIP 与天气不改写；归档反汇编与脱敏日志，密钥中间文件留在临时目录。
- runtime: 无 Windows/Wine；未执行 EXE 或保护运行时。
- coverage: 局部静态协议确认，不承诺完整源码或数值等价。

## signoff
- ready_for_act: true
- checklist:
  - [x] 用户授权已记录
  - [x] 精确版本与本地范围已确定
  - [x] 离线目标分析
  - [x] 排除范围已核对
  - [x] 角色由主代理承担，无后台子代理
