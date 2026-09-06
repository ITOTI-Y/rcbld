# RCBldEng v1.3.0 基准核验

核验日期：2026-09-06。用户已明确以 `archive/RCBldEng-v1.3.0.zip` 为后续重构基准。本文记录新版的直接证据；[原始调查](evidence.md) 中关于旧 EXE 的接口、算法和缺陷只能作为历史线索。资产登记见 [DATA.md](../_dev/DATA.md)。

## 结论与适用范围

新版是包含依赖的 Windows x64 目录发布包，PyInstaller 元数据指示 CPython 3.9。`RCBldEng`、`lib`、`weather`、`simulation` 均只暴露 PyArmor 保护入口，原先用于旧 EXE 的静态反汇编路径未能读取新版业务函数。因此，尚未恢复或验证新版 `.sim/.sol` 协议，也无法判断旧版 `Solar_OP` 缺陷是否已经修复。

广州 EPW 已提供并通过记录数和列数检查；没有现成 `.sim/.sol` 不再列为需要用户提供的材料。可以根据旧协议构造候选测试输入，但必须用 v1.3.0 实际接受输入、产生结果的证据确认兼容性。本轮没有运行 EXE，也没有启动插件实现。

## 发布包身份与完整性

| 对象 | 大小 / 字节 | SHA-256 |
|---|---|---|
| `archive/RCBldEng-v1.3.0.zip` | 32,579,839 | `824b0cf2f84cb26634d3c920dd38aa97ad041984c6bf21dfc55f0e76bcbf0355` |
| ZIP 内 `RCBldEng/RCBldEng.exe` | 5,891,467 | `944939cbf14bad46f262543291758bb95527b6e70fa5c701c39d26b8560a4f43` |
| 旧 `archive/RCBldEng.exe`，仅保留历史证据 | 35,377,233 | `e059e98e4778e467d2e6f889998cafb1a52e6a37a3d24827750ea6ead12e2ed2` |

v1.3.0 名称来自用户指定的文件名，尚未通过程序版本命令或发布说明独立核对。上述指纹限定本次结论的对象；不能仅凭文件名或大小判断功能版本。

ZIP 含 739 个文件，不计目录项，解压后的文件大小合计 84,423,813 字节。`zipfile.ZipFile.testzip()` 返回 `None`，全部文件 CRC 检查通过。这证明包内数据与其 CRC 一致，不证明运行成功或数值正确。

入口是 `RCBldEng/RCBldEng.exe`。同目录发布内容包括 `python39.dll`、`pyarmor_runtime_005387/pyarmor_runtime.pyd`、NumPy/pandas 扩展及运行资源。EXE、Python DLL 与 PyArmor 扩展的 PE Machine 均为 `0x8664`，即 x64。后续部署须保留完整目录及相对布局；只复制 EXE 的旧交付假设不再适用。

包内未发现项目 Python 源码、README、版本变更说明、接口文档、EPW、`.sim/.sol` 或结果 CSV。随包第三方资源不作为项目接口资料。

## 静态核验方法与边界

从 ZIP 精确读取 `RCBldEng/RCBldEng.exe`，写入本任务的独立临时目录。依照 [PyInstaller CArchiveReader](https://raw.githubusercontent.com/pyinstaller/pyinstaller/develop/PyInstaller/archive/readers.py) 的容器布局解析目录、解压所需成员，并用匹配的 CPython 3.9.25 执行 `marshal`/`dis`。全程未导入或执行引擎业务模块，未改变原始 ZIP 或旧 EXE。

| 检查 | 实际结果 |
|---|---|
| PyInstaller cookie 偏移 | 5,891,379 |
| CArchive 起点 | 320,000 |
| cookie 的 Python 版本与库名 | `309`、`python39.dll` |
| CArchive 条目数 | 12 |
| PYZ 模块数 | 723 |
| 所读取成员的解压长度、PYZ Python magic number | 与目录记录、CPython 3.9 匹配 |
| `RCBldEng`、`lib`、`weather`、`simulation` | 每个模块只有 1 个可见模块级代码对象，未暴露嵌套业务函数 |

四个模块均导入 `pyarmor_runtime_005387.__pyarmor__`，再以模块名、文件名和字节载荷调用它；反汇编可见 `IMPORT_NAME`、`IMPORT_FROM` 和 `CALL_FUNCTION 3`。该入口形态与 [PyArmor 官方说明](https://pyarmor.readthedocs.io/en/stable/topic/obfuscated-script.html) 一致。官方文档说明其运行时依赖平台与 Python 主次版本；使用 Linux Python 3.9 读取保护入口不代表能在 Linux 执行随包 Windows 扩展。

本轮未确认 PyArmor 的具体版本、保护选项或许可条件。上述静态结果只说明当前方法不能读取新版解析器，不声称协议永远无法确认。后续可通过新版接口资料或受控黑箱运行建立契约。

## 既有决策中的技术事实更新

已确认的产品方向保持有效：保留用户指定的计算引擎，重构 Rhino/GH 插件及外围流程，使用 Python，干净切换旧 GH 定义。更换引擎基准不等于批准 ADR-004 或全部 Proposed 契约，也不扩大到重写内核。

| 原始记录及位置 | 当前适用性 |
|---|---|
| ADR-001、ADR-004：引擎自带 CPython 3.12 | 仅适用于旧 EXE。v1.3.0 包含 Python 3.9，且为目录发布；宿主解释器仍独立选择和验收。 |
| ADR-001：入口固定 `order=1` | 旧版事实，新版未知。不能宣称新版仅支持一阶，也不能承诺二阶。 |
| ADR-004：从 `cwd` 父目录寻找 `Projects/<project>/<run_id>` | 旧版约束，新版需运行确认；不得直接固化为新版目录契约。 |
| 旧 CLI：`RCBldEng.exe <project> <first_day> -sim <run_id>` | 仅作为新版黑箱调用候选，参数、可选键及默认值均未确认。 |
| 旧 `.sim` 段、名称引用、BUS/ITSS/月日程结构 | 可依据旧 EXE 和 C# 写出端构造输入候选，不能称为已验证的新版 schema。 |
| ADR-009：`.sol` 按热区提供窗及不透明围护太阳序列 | 新版是否支持、是否可选、顺序、单位、长度及实际作用均待核验。 |
| ADR-003、ADR-012、ADR-013：输出列、非空调耦合、非正交/坡面表达 | 产品需求保持；旧算法及接口证据不能替代新版能力验收。 |
| 旧 `simulation.py:177` 的 `q_sol_op == Solar_OP` | 旧版使用比较并丢弃结果，未赋值；v1.3.0 的修复状态未知。 |
| 旧 `solarGain` 依据首个热区有无 `Solar_OP` 分支 | 新版未知；加入“仅后续热区提供太阳输入”的控制案例。 |
| 原文“归档无 EPW”“补齐现成 `.sim/.sol`” | 当前已提供广州 EPW；`.sim/.sol` 由受控测试构造，真实结果基准仍待生成。 |

旧太阳输入缺陷的依据为旧 EXE 的 `Simulation.solarGain` 字节码：源码行号 177 对应 `COMPARE_OP ==` 后接 `POP_TOP`，行号 178 对 `Solar_W` 执行 `STORE_ATTR q_sol_w`。当前版本未暴露同一函数，不能将该缺陷写成 v1.3.0 已知问题或已修复项。

## 广州天气检查

文件为 `archive/Guangdong_Guangzhou_GD_592870.epw`，SHA-256 为 `039dcba8fc42628f0fd8fec2f602d7938d62c8e4aa183d6bf527ff4f76e8419f`。按 UTF-8 和 CSV 读取，8 条头记录后有 8760 条非空数据记录，每条 35 列。LOCATION 指定广州、站号 `592870`、UTC+8；DATA PERIODS 指定每小时 1 条记录、Sunday 起始、1 月 1 日至 12 月 31 日。

来源年份跨多个年份，分钟字段均为 30；首条为 `2023,1,1,1,30`，末条为 `2017,12,31,24,30`。源年份、模拟日历、起始星期与小时区间需要分别处理，不按来源年份重排记录，也不静默改写分钟字段。基础结构检查尚未涵盖全部气象值、缺测哨兵和新版天气解析器。

## 后续验收入口

当前环境为 Linux x86_64，PATH 中未发现 `wine`、`wine64`、`pwsh` 或 `dotnet`；会话未提供 Windows/Rhino 运行入口。没有运行 EXE、安装插件或生成模拟 CSV。新版协议提取和旧缺陷复核仍未完成，阻塞点为业务逻辑受保护且缺少可用的目标运行环境。

1. 在 Windows 上保留完整发布目录，确认启动、实际 CLI、输入查找方式、退出码和日志；使用独立运行目录，保留失败证据。
2. 根据旧协议构造单热区候选输入，以新版实际响应逐项核对必需字段和引用，再接入广州 EPW。测试数值标为人为控制条件，不充当办公/住宅预设。
3. 若新版接受外部太阳序列，对照无外部太阳、只改变窗太阳、只改变不透明太阳及部分热区提供太阳输入的结果；先验证字段实际作用，再核实物理量纲、长度和时间轴。
4. 将新版实际接受的输入、输出及版本指纹登记为基准，再验证非空调耦合、非正交平面、坡屋顶和 GH 生命周期。引擎内缺陷如实报告，不在结果层静默补偿。

以上是验收顺序，未声称已构造可运行模型或通过数值验证。完成新版身份核验与记录更新后，仍需上述运行证据才能定稿引擎适配器契约。
