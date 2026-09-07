# RCBldEng 反编译与源码恢复核查

核查日期：2026-09-07。当前计算基准仍为用户提供的 `archive/RCBldEng-v1.3.0.zip`。本次针对“源码遗失后能否从 EXE 确认行为”补充静态取证；没有修改引擎、运行仿真或实施插件代码。

## 结论

2026-09-07 后续使用用户指定的 `reverse-skill` 完成 Linux 静态恢复：已取得 `RCBldEng`、`lib`、`weather`、`simulation`、`comfort` 5 个模块、196 个代码对象的可读反汇编，并从原始 ZIP 重新提取后复现出完全一致的结果。此前“只能看到保护入口”的方法限制已突破。完整证据和命令已保存到仓库，见 [静态逆向报告](artifacts/engine-v1.3.0/report/recovery.md) 和 [复现说明](artifacts/engine-v1.3.0/README.md)。

已静态确认入口固定 `order=1`、输入从 `cwd` 父目录定位，以及 `.sim` 冒号解析与首热区太阳覆盖条件。新版可见分支使用 `Solar/AreaFrac`；尚未确认可用的独立 `.sol` 文件协议。自动反编译源码仍不可运行：4 份草稿有语法错误，入口草稿只有注释；未执行 Windows 引擎或完成数值对照。

同时核查了 3 个正式发行包及上游 `main` 的全部 9 次可达提交，覆盖 5 份不同的 EXE，未找到未保护的业务实现。这个结果限定于公开发行资产、所列提交和本地基准包，不代表不存在其他备份，也不证明保护层永远无法分析。

后续可在现有 Linux 环境继续核查已恢复的函数，不再把 Windows 作为静态协议分析的前提。原版启动、实际输入接受和物理数值对照仍需可运行完整发行包的环境；源码恢复与行为验收分开记录。

以下公开历史与初次容器分析保留为前一阶段记录，其“未恢复”表述只描述当时的方法边界；当前恢复范围以本节及新增证据包为准。

## 核查对象与来源

正式发行资产来自用户指定的 [RCBIdEng 仓库](https://github.com/andersonspy/RCBIdEng)。v1.3.0 使用本地原件，前一轮已经确认其 ZIP 与正式下载资产完全一致；本轮下载 v1.2.0 和 v1.1 到独立临时目录，3 个 ZIP 的全部成员 CRC 检查均通过。

| 发行资产 | ZIP 大小 / 字节 | ZIP SHA-256 |
|---|---:|---|
| [v1.3.0](https://github.com/andersonspy/RCBIdEng/releases/download/v1.3.0/RCBldEng-v1.3.0.zip) | 32,579,839 | `824b0cf2f84cb26634d3c920dd38aa97ad041984c6bf21dfc55f0e76bcbf0355` |
| [v1.2.0](https://github.com/andersonspy/RCBIdEng/releases/download/v1.2.0/RCBIdEng-v1.2.0.zip) | 32,637,489 | `5e64063518a065af44fb14623210ee999f9790a6715c34ce97569e1f49b4bf4b` |
| [v1.1](https://github.com/andersonspy/RCBIdEng/releases/download/v1.1/RCBldEng_v1.1.zip) | 38,185,448 | `856cd8f2997147ba5008c786a9ce7ca00ec881d33a6fae33f8c4cb6829fbbd6b` |

| 不同的 EXE | 大小 / 字节 | EXE SHA-256 |
|---|---:|---|
| 正式 v1.3.0 | 5,891,467 | `944939cbf14bad46f262543291758bb95527b6e70fa5c701c39d26b8560a4f43` |
| 正式 v1.2.0 | 5,892,784 | `21193b22aa9e94452cd02c3a641545f9e165a8fb4937b347aa7baede612a18f0` |
| 正式 v1.1 | 5,892,260 | `266f72c865d740157d25a2fe15c828b2ab0eba4f8940569933e8e0375acde952` |
| 最早包含引擎的提交 `45b6cf8` | 5,891,887 | `f06ca482a3b85678dd859325897c3b91c08f515c8e6fd0dc19b3b9eb3e2a13ee` |
| 当前仓库提交 `018c040` | 5,891,853 | `f6da12f456b03115c90fcc4d3ee91c4ef030aec178244df8a0d474508e50824c` |

通过 GitHub API 读取提交列表和每次提交的递归文件树，均未发生分页遗漏或树截断。9 次提交按时间顺序为 `a4a0344`、`987a127`、`45b6cf8`、`224c030`、`50f6a99`、`482645e`、`8d16724`、`65d8124`、`018c040`。前两次只有 README，后续文件树没有 `.py/.pyw/.ipynb/.pyc/.pyo/.pdb/.bak/.old` 源码或备份候选；压缩归档候选只有 `base_library.zip`。

最早引擎来自 [完整提交 45b6cf818a258fc6486c4e87b2c5a9e3e2c525d8](https://github.com/andersonspy/RCBIdEng/tree/45b6cf818a258fc6486c4e87b2c5a9e3e2c525d8)，当前仓库固定为 [018c040e14c29ed11b794a4dad936d886415280e](https://github.com/andersonspy/RCBIdEng/tree/018c040e14c29ed11b794a4dad936d886415280e)。公开历史中共有 4 个不同的 EXE Git blob，其中两个与 v1.1、v1.2.0 发行包内 EXE 一致；加上不同的正式 v1.3.0 EXE，共检查 5 份二进制。仓库最新 EXE 仍不能替代正式发行包。

此前旧单文件 EXE 的历史指纹和反汇编记录仍见 [原始调查](evidence.md)；当前工作区没有该原件，本次在公开历史中也没有找到同一指纹的副本，未将其旧版结论升级为新版事实。

## 正式 v1.3.0 的直接证据

按照 [PyInstaller CArchive 容器布局](https://raw.githubusercontent.com/pyinstaller/pyinstaller/develop/PyInstaller/archive/readers.py) 解析 EXE，校验解压长度、Python 版本和 PYZ magic number，再使用实际 CPython 3.9.11 的 `marshal` 与 `dis` 读取代码对象。全程没有导入或执行引擎业务模块。

3 个正式包的 CArchive 均有 12 个条目，PYZ 均有 723 个条目：722 个有代码载荷，另一个为 `jaraco` 命名空间包。首次完整扫描因未处理类型 3 的命名空间条目而中止；按 [官方读取器对该类型的定义](https://raw.githubusercontent.com/pyinstaller/pyinstaller/develop/PyInstaller/loader/pyimod01_archive.py) 修正后，3 个包全部重新扫描通过。

| v1.3.0 业务模块 | 可见代码对象数 | 受保护字节载荷大小 / 字节 |
|---|---:|---:|
| `RCBldEng` | 1 | 2,849 |
| `lib` | 1 | 70,706 |
| `weather` | 1 | 12,538 |
| `simulation` | 1 | 36,410 |
| `comfort` | 1 | 9,356 |

这 5 个对象均为模块入口，没有可见的嵌套函数。它们的 `co_names` 相同：`pyarmor_runtime_005387`、`__pyarmor__`、`__name__`、`__file__`。入口反汇编显示导入保护运行时，并以模块名、文件名、字节载荷调用 `__pyarmor__`。另外可读的 `pyarmor_runtime_005387` Python 包只负责导入原生扩展，不计作业务模块。

每个正式包的 `base_library.zip` 含 162 个可读取的 Python 3.9 `.pyc`，未发现以引擎或上述业务模块命名的副本。对 PYZ 全部可见代码对象的名称和字符串常量检索 `Solar_OP`、`Solar_W`、`$Zones`、`External Wall Materials`、`Indoor Temperature Setpoint Schedules`，3 个版本均无命中。此检查只排查明文线索，不声称已检索受保护载荷内部内容。

v1.3.0 的原生保护扩展为 `pyarmor_runtime_005387/pyarmor_runtime.pyd`，大小 617,472 字节，SHA-256 为 `20cad40330c4a7102d3bb34e38197f60f38b7195d83d2a393d1ab0728b141551`。PE 为 Windows x64，导入 `python39.dll`，导出 `PyInit_pyarmor_runtime`。其中出现 `PyArmor v8+ runtime module` 字符串；这只能支持 v8+ 运行时标识，不能确定具体补丁版本、保护选项或当前许可状态。

PE 导入表还包含 `PyMarshal_ReadObjectFromString`、`PyCode_NewWithPosOnlyArgs` 和 `PyEval_EvalCode`。这些符号为进一步跟踪原生加载过程提供候选入口，不能证明已取得解密结果，也不能保证普通 Python 的 `inspect` 能读取业务函数。[PyArmor 官方说明](https://pyarmor.readthedocs.io/en/stable/topic/obfuscated-script.html) 明确描述了原生运行时、平台和 Python 主次版本约束，以及对代码对象检查的限制。

## 初次核查时的协议缺口

| 问题 | 本次结论 | 下一步需要的证据 |
|---|---|---|
| `.sim` 必需段、默认值、引用解析 | 上游样本可提供候选，业务解析器尚未恢复 | 固定引擎下的成功基线、逐项删改输入及错误响应 |
| `.sol` 文件定位、布局、长度、单位 | 未恢复读取代码，也没有正式版运行证据 | 被引擎实际接受的太阳输入和受控结果差异 |
| `Solar_OP` 旧缺陷是否修复 | 未知 | 窗和不透明面分别变化，以及仅后续热区有输入的对照案例 |
| 非空调区与邻区耦合 | 未知 | 单区与双区控制模型的自由室温及邻区响应 |
| 输出列、符号、单位与聚合 | 历史 CSV 只支持结构候选 | 本次输入、引擎指纹、逐时输出及月表之间的对应验证 |

受控输入输出验证可以逐项建立使用契约，仍不能覆盖所有隐藏分支或证明全部物理算法正确。已有样本和候选协议见 [上游协议核对](engine-protocol.md)。

## 后续取证顺序

1. 在 Windows x64 上使用完整、指纹匹配的 v1.3.0 发布目录，保留原件，建立独立工作副本。先确认进程能启动并保存实际命令、工作目录、退出码和日志。
2. 用上游双热区样本的派生副本建立成功基线，仅记录必需的天气路径调整。按前表逐个改变输入，保存最终输入字节和每次新生成的结果，避免把历史 CSV 当作本次输出。
3. 若关键语义仍无法由对照确定，再分析原生保护加载过程，尝试在受控执行中取得解析或计算代码对象。PE 导入符号可作为分析线索；能否恢复、恢复范围和额外限制需要实测，不能预先承诺。
4. 对取得的代码记录来源 EXE 指纹、模块和函数位置，并与原版对照案例交叉验证。仅在证据支持后更新解析契约或缺陷状态；保留尚未覆盖的分支。

初次核查没有 Windows/Wine 执行入口，未执行上述运行步骤。后续 Linux 静态分析已解密业务载荷并保存反汇编；原版运行与完整源码恢复仍未完成，当前结果见本文开头的更新。

## 产物与验证边界

下载包、解出的 `.pyc`、保护入口反汇编、完整模块清单、GitHub API 响应及 PE 信息均位于本会话临时目录 `/tmp/rcbld-engine-recovery-ztr2pgfl/`；提取和字节码扫描脚本分别为 `/tmp/rcbld-recovery-audit-20260907.py` 与 `/tmp/rcbld-bytecode-audit-20260907.py`。这些临时文件不是仓库依赖，环境回收后不能保证保留；本记录保存了用于重新取得原件和限定结论的来源、指纹、方法与关键结果。

本轮验证覆盖 ZIP CRC、CArchive 解压长度、Python/PYZ magic number、可见代码对象读取、Git blob 对应关系和静态 PE 信息。没有恢复可运行的业务源码，没有运行 Windows 引擎、仿真数值测试或 Rhino/GH 验收；原始发布包与天气文件保持不变。

文档检查中，报告指纹、大小、模块数量及本轮涉及 3 个文档的 11 个相对链接均通过核对。全仓链接检查发现既有手工实施文档中的 4 个未来文件目标尚未创建：`tools/__init__.py`、`tools/audit_release.py`、`tools/audit_weather.py`、`tests/test_audits.py`。它们仍是文档交付的待实施对象，本轮保留原状，不将全仓链接检查报告为全部通过。
