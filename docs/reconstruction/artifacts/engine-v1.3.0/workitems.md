# Work items

| ID | title | role | targets | surface | status | evidence | notes |
|---|---|---|---|---|---|---|---|
| WI-001 | 授权、技能安装与精确版本提取 | lead | v1.3.0 ZIP | process | done | E-extraction | 保留用户原件，安装上游固定版本 |
| WI-002 | PE 导入导出与运行时身份 | cre | EXE、PYD | PE | done | E-engine-imports, E-runtime-imports | 完整 JSON；未执行目标 |
| WI-003 | 静态恢复与局部协议分析 | cre | 五个业务模块 | bytecode | done | E-RCBldEng, E-lib, E-weather, E-simulation, E-comfort | 196 个代码对象；只深查 CLI、文本解析和太阳覆盖 |
| WI-004 | 重复恢复、证据归档与交付检查 | cce/doc | 证据包 | process | done | E-validation, E-decompiler-log | 原版运行和数值验证明确未覆盖 |

## Coverage

- [x] 指定样本的 PE 与保护层分析
- [x] 反汇编核心发现关联 Evidence
- [x] 输入到太阳覆盖的调用路径
- [x] 关键阶段时间记录
- [x] 按 docs-generator 结构形成普通逆向报告，flavor = null
- [x] 本地方法日志；没有对外发布
- [x] 最终证据图、哈希与文档检查；extract_inputs.py 的 Ruff 与格式检查通过

完整源码、全部计算算法、Windows 运行与数值验收不在本轮完成范围，详见报告。
