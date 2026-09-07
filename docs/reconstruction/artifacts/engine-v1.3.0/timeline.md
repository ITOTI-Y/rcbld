# Timeline (append-only)

## 2026-09-07T09:50:24+00:00 | lead | init
- action: 安装固定版本 reverse-skill 并初始化本地案件
- command_or_ref: 官方 skill-installer；master-route.sh；case-init.sh；case-guard.sh
- result_summary: 路由 R7 radare2；用户授权已记录，offline-sample 范围通过 guard
- artifacts: scope.md, workitems.md
- evidence_ids: []
- decision_delta: 不要求用户重复授权；使用 Linux 静态路径
- carry_forward_refs: scope.md
- next: PE 身份与导入导出

## 2026-09-07T09:54:25+00:00 | cre | PE reconnaissance
- action: 从官方 deb 解包 radare2 6.2.2，读取两个 PE 的节、导入和导出
- command_or_ref: rabin2 -I -S -i -E -j
- result_summary: 已取得 Python 加载和原生运行时分析线索；未执行 Windows 程序
- artifacts: evidence/engine-pe.json, evidence/runtime-pe.json
- evidence_ids: E-engine-imports, E-runtime-imports
- decision_delta: 采用已审阅的 PyArmor 静态解包工具，尝试跨平台恢复
- carry_forward_refs: E-runtime-imports
- next: 编译解析器并恢复五个模块

## 2026-09-07T10:14:00+00:00 | cre/cce/doc | recovery and archive
- action: 汇记已完成的静态解密、反汇编、重复提取和协议核对，并保存仓库证据包
- command_or_ref: README.md；evidence/unpacker-build-command.json；evidence/recovery-validation.json
- result_summary: 五模块共 196 个代码对象；反汇编重复生成一致。四份自动源码语法失败，入口只剩注释。定位 CLI、冒号解析和首区太阳覆盖条件。
- artifacts: disassembly/, decompiler-drafts/, evidence/, report/recovery.md
- evidence_ids: E-extraction, E-RCBldEng, E-lib, E-weather, E-simulation, E-comfort, E-validation, E-decompiler-log
- decision_delta: 先前只能看保护入口的静态边界已突破；仍不具备原版运行和数值等价证据
- carry_forward_refs: E-validation, report/recovery.md
- next: 证据图审查、提取脚本检查、文档事实与链接检查

## 2026-09-07T10:21:31+00:00 | cce/doc | delivery checks
- action: 完成提取脚本、归档哈希、相对链接和证据图验证
- command_or_ref: README.md；report/delivery-validation.json；report/case-review.md
- result_summary: CPython 3.9.11 下正常提取、错误指纹拒绝、已有目录保护通过；28 个生成证据哈希一致，原始 ZIP/EPW 未变，Ruff 检查通过。严格证据图检查无错误或警告。
- artifacts: report/delivery-validation.json, report/case-review.md
- evidence_ids: E-extraction, E-validation, E-decompiler-log
- decision_delta: 修正导入排序和格式；复核 .sol 子串的 12 次命中均为函数名，未误报为文件协议。
- carry_forward_refs: report/recovery.md, report/delivery-validation.json
- next: 交付本轮静态分析；完整运行验证与进一步算法核查单独推进
