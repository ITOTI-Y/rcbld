# RCBldEng 上游协议核对

核对日期：2026-09-07。用户指定 [andersonspy/RCBIdEng](https://github.com/andersonspy/RCBIdEng) 为协议确认来源。固定引用提交 `018c040e14c29ed11b794a4dad936d886415280e`，其提交日期为 2025-01-16，核对时 `main` 与标签 `v1.3.0` 指向该提交。本文是文档与样本层面的确认；没有执行 Windows 引擎。

当前重构项目使用 `rcbld/dev`。开发和兼容性基线按用户决定统一为 Python 3.9.11，见 [项目配置](../../pyproject.toml) 和 [版本文件](../../.python-version)。该决定不改变引擎进程边界，也不代表 Rhino 生命周期或全部 Proposed 架构已经验收。

> **后续静态证据（2026-09-07）**：正式 ZIP 的业务反汇编现已恢复。CLI 默认值、`cwd` 父目录定位、固定 `order=1` 已有静态依据；文本解析存在冒号截断差异，外部太阳使用 `Solar/AreaFrac` 并受首热区条件控制。本文保留 README/样本层面的事实；涉及具体实现时，同时参照 [静态逆向报告](artifacts/engine-v1.3.0/report/recovery.md)。这些证据尚未升级为运行契约。

## 发布资产与仓库文件树的区别

GitHub [v1.3.0 正式发行](https://github.com/andersonspy/RCBIdEng/releases/tag/v1.3.0) 的 `RCBldEng-v1.3.0.zip` 下载后按字节计算指纹，与用户提供的 ZIP 完全一致。发行记录标注发布时间为 2026-04-08；标签提交时间与发行发布时间分别记录，不能混同。

| 对象 | 字节数 | SHA-256 |
|---|---:|---|
| 正式发行 ZIP / 用户 ZIP | 32,579,839 | `824b0cf2f84cb26634d3c920dd38aa97ad041984c6bf21dfc55f0e76bcbf0355` |
| 正式 ZIP 内 EXE | 5,891,467 | `944939cbf14bad46f262543291758bb95527b6e70fa5c701c39d26b8560a4f43` |
| 固定提交文件树内 EXE | 5,891,853 | `f6da12f456b03115c90fcc4d3ee91c4ef030aec178244df8a0d474508e50824c` |

仓库 `RCBldEng/` 含 664 个文件，正式 ZIP 含 739 个文件。共同路径中 EXE 和 `base_library.zip` 的字节不同；仓库缺少正式 ZIP 中的 75 个 `.pyd` 文件，包括 PyArmor、Python 标准库和 NumPy/pandas 扩展，其余共同文件相同。上游 [忽略规则](https://github.com/andersonspy/RCBIdEng/blob/018c040e14c29ed11b794a4dad936d886415280e/.gitignore) 与发布包完整性仍需分开处理，不能用仓库目录代替正式发行目录。

仓库未提供项目 `.py` 源码或 `.sol` 文件。静态读取仓库 EXE 后，`RCBldEng`、`lib`、`weather`、`simulation` 同样只暴露 PyArmor 模块入口。新增信息来自 README、`.sim` 和历史 CSV，未从保护模块恢复解析器。原始 ZIP 的静态记录保留在 [engine-v1.3.0.md](engine-v1.3.0.md)。

## 证据等级与使用原则

| 等级 | 本次具备的证据 | 可据此实施的工作 |
|---|---|---|
| 发布身份 | 正式下载资产与用户 ZIP 的指纹一致 | 固定引擎资产、核对完整目录 |
| 上游声明 | README 的调用方式、命名规则和关键字说明 | 编制候选调用、输入校验及试验矩阵 |
| 样本事实 | 8 个 `.sim`、25 个 CSV、3 个 EPW 的实际文件结构 | 建立字段清单、引用检查和结果表头候选 |
| 运行契约 | 尚未具备 | 仍不能确认默认值、全部合法输入、字段作用、单位、退出码或数值精度 |

示例存在不等于正式发行包已经接受这些示例。历史 CSV 没有本轮运行记录或对应 EXE 指纹，不能直接升为 v1.3.0 的数值回归真值。目录中出现 `1st_order`、`2nd_order` 也不能证明当前 CLI 存在切换阶数的参数。

## 调用、路径与命名

README 给出的参数顺序是可执行文件、建筑标识、起始星期、`-sim` 和运行标识。起始星期示例为 `mon`。它声明名称大小写敏感、允许字母/数字/下划线、禁用空格与特殊字符，并给出 50 字符限制；具体校验对象及程序实际拒绝行为尚未核实。[调用与命名说明](https://github.com/andersonspy/RCBIdEng/blob/018c040e14c29ed11b794a4dad936d886415280e/README.md#input-files)

候选文件布局为 `Projects/<building>/<run>/<building>_<run>.sim`，同目录保存对应的 `_hourly.csv`、`_monthly.csv` 和 `_indoor_temperature.csv`。上游实际文件树将程序放在 `RCBldEng/`，天气放在 `Weather/`；README 的示意却将 EXE 放在根目录、天气放在 `Climate/TMYs/`。8 个 `.sim` 均使用作者机器的 Windows 绝对天气路径，不能原样移植。

实施前须分别确认 EXE 所在目录、子进程 `cwd`、项目查找基准和天气路径解析。旧 EXE 从 `cwd` 父目录寻找 `Projects` 的行为仍是历史线索；不能用 README 的树形示意排除或确认它。复制示例时仅在派生副本中替换天气路径，并保存原件指纹与修改记录。

README 列出的候选关键字包括 `if_pmv`、`if_print`、`solver`、`infl_style`、`DHW_style` 和 `weather_mode`。这组声明已可定位，但布尔值解析、大小写、支持选项和默认值仍需正式 ZIP 实测；不把“插值/平滑”说明直接实现成插件自动改写天气。[关键字说明](https://github.com/andersonspy/RCBIdEng/blob/018c040e14c29ed11b794a4dad936d886415280e/README.md#command-line-arguments-and-keyword-arguments)

## `.sim` 样本结构

8 个样本均可按 UTF-8 解码，均包含下表 21 个段。样本使用 `$段名:`、`键: 值`、空行和 `!!!` 注释；同一段内通过名称字段开始下一个对象。天气值自身带冒号，独立样本扫描按首个冒号分割以保留原值；这不等于引擎实际解析规则。后续反汇编确认，引擎仅在含 `!!!` 的行中重新连接多余冒号，无注释行会截断路径。样本中 `From ... To ...` 与 `From ... to ...` 均出现，实际解析器的大小写容忍度未知。

下表描述观察到的样本，不宣称所有段均为必需、全部键均已列出，或未出现的值不合法。字段单位来自样本注释时，仅作为待核实的输入语义；注释本身也可能错误。[完整双热区样本](https://github.com/andersonspy/RCBIdEng/blob/018c040e14c29ed11b794a4dad936d886415280e/Projects/residential_Philadelphia/1st/residential_Philadelphia_1st.sim)

| 段名 | 样本中的内容和关联 |
|---|---|
| `$Basics` | 天气路径、建筑名称/类型、地形/地面、12 个月地温、层数和几何量、热容类型或显式热容/有效质量面积 |
| `$Indoor Temperature Setpoint Schedules` | `Schedule Name`；各小时区间的工作日/周末供暖与制冷设定值，共 4 列 |
| `$Building Use Schedules` | `Schedule Name`；人员、设备、照明、HVAC、渗透各自的工作日/周末值，共 10 列 |
| `$Monthly Schedules` | 月区间引用上述日程名称，或指定渗透系数；样本区间使用 0 至 12 |
| `$External Wall Materials` | 材料名对应 U 值、吸收系数、发射率 |
| `$Internal Wall Materials` | 内墙材料条目，样本包含三元值 |
| `$Window Materials` | 窗材料名对应 U 值、发射率、SHGC；其后二项顺序与外墙不同 |
| `$Roof Materials` | 屋顶材料名及三元值 |
| `$External Floor Materials` | 外部楼板材料名及 U 值 |
| `$Internal Floor Materials` | 内部楼板材料名及 U 值 |
| `$Envelope Setting` | `Surface Name`；各材料的面积、窗挑檐/侧翼/地平遮挡角、遮阳类型/位置/控制 |
| `$HVAC` | `HVAC Name`；效率、部分负荷 COP、系统类型、热回收、容量、供回水/送风温度、风机参数 |
| `$Lighting Setting` | `Lighting Name`；照明负荷、寄生用能与控制系数 |
| `$Zones` | `Zone Name`；尺寸、工况、日程/HVAC/照明引用、围护引用、倍率、邻区名和接触面积 |
| `$DHW` | 生活热水分配和发生系统类型 |
| `$Pumps` | 单位流量功率、DHW 峰值流量及控制类型 |
| `$BEM` | 管理等级，不是完整建筑能耗模型对象 |
| `$PV` | 面积、方向、倾角、类型和通风方式 |
| `$SWH` | 面积、方向和倾角 |
| `$Wind Turbines` | 数量、直径和效率 |
| `$Energy Sources` | 供暖、制冷及 DHW 的能源类型 |

样本中的 `-` 随字段表示缺省、未使用或容量不限，不能统一转为零或视为非空调。日程中 0–24 和月程中 0–12 的端点还需解析器验证；不得把文件写法直接当作 Python 切片边界。

样本标注的 `Occupancy` 是每人面积，不能与核心人员密度直接共用数值；`Outdoor Air` 是每人流量，`Appliance` 和照明负荷按面积，容量另有单位。适配层必须逐字段核对单位和换算。样本还存在地板面积注释标成长度单位、COP20/COP0 注释混乱等情况，不能把注释整体当作权威 schema。

热区通过已命名模板引用照明、HVAC、月程和围护；内部墙/楼板引用材料。邻接字段包含墙、天花及楼板三类，样本有邻区与面积对，也有 `ground` 和 `-`。核心应保留真实邻接含义，协议中的特殊标识在适配边界映射；不得把字符串有值等同于邻接已经有效。

## 样本清单与优先顺序

| 项目 / 运行目录 | 热区数 | 用途 |
|---|---:|---|
| `residential_Philadelphia/1st` | 2 | 最小现成多热区输入，优先用于字段与相邻楼板确认 |
| `residential_Philadelphia/2nd_order` | 2 | 同项目历史结构对照，阶数能力需另行核验 |
| `office_Shanghai/1st_order` | 9 | 办公、核心/周边及 plenum 样本 |
| `office_Shanghai/2nd_order` | 9 | 同项目历史结构对照 |
| `office_Shanghai/test` | 9 | 提供分项结果表头及一个额外历史 hourly 文件 |
| `BRB/1st_order` | 13 | 更大分区模型及地区冷/热能源列 |
| `BRB/test` | 13 | 太阳分项及 PMV 表头样本 |
| `MF_NewYork/test` | 27 | 多户住宅及 hallway 样本 |

双热区 `residential_Philadelphia/1st/residential_Philadelphia_1st.sim` 的 SHA-256 为 `be8608fc32bfee1da6f956ec4eb02bbf846ec3fb26b4644ee392deb87115f4ed`。`office_Shanghai/test/office_Shanghai_test.sim` 为 `a2ebd8bff9ac39af69edeec1bf1b3db49a3ed9f1fda3a91de6aa036ed090a33d`。固定提交和这两个原始指纹用于定位候选输入，后续派生文件另记指纹。

上游同时包含上海、纽约和费城的 3 份天气。它们用于保持各上游示例的原天气条件；用户提供的广州 EPW 仍用于广州案例。替换天气会改变物理输入，不能再与原历史 CSV 直接作相同输入比较。此次临时取回上游仓库，不把其整套二进制和历史结果复制进当前项目。

## CSV 的实际结构与变化

对 25 个 CSV 做只读结构检查：9 个 hourly 文件均有 8760 条记录，8 个室温文件均有 8760 条，8 个 monthly 文件均有 12 条。各文件内部列数一致。hourly 和室温文件的首列列名为空，样本索引为 0–8759；monthly 首列名为 `month`，记录为 1–12。该结构不证明时序物理含义或数值正确性。

| 结果组 | hourly 列数（含索引） | monthly 列数 | 室温列数（含索引） |
|---|---:|---:|---:|
| 费城两个运行、上海一阶/二阶 | 25 | 20 | 费城 3；上海 10 |
| BRB 一阶 | 26 | 21 | 14 |
| 上海 test、纽约 test | 28 | 23 | 上海 10；纽约 28 |
| BRB test | 29 | 24 | 14 |
| 上海额外 `hourly - base.csv` | 26 | 无独立配套月表 | 无独立配套室温表 |

部分表头包含 `heat_transfer_window `，末尾有空格；test 目录中的另一类结果使用墙/窗传导及墙/窗太阳得热四个分项。能源汇总列随样本出现 `total_gas` 或地区供冷/供热字段，PMV 也并非所有文件都有。因此列号、固定列数、未经核实的旧/新列别名都不能作为正式解析契约。

结果适配器应在保留原始表头的同时识别已确认 schema；若规范化空白，必须检查规范化后的重名冲突。室温表只给索引与热区名，不能单独重建时间轴；需要与本次运行的 hourly 和输入对象映射一致。字段名称含 `energy`、`load` 或 `temperature` 均不能代替单位和聚合算法证据。

这些结果表支持设计结构测试：拒绝缺列/列冲突、保留可选量缺失状态、检查区名和行序关联。其数值生成版本、全部单位、负号含义、瞬时量与区间累计量、月表聚合方式尚未确认，禁止按统一系数求和后标为 kWh。

## `.sol` 与关键能力缺口

仓库没有 `.sol` 示例，README 也未定义外部太阳序列。旧插件写出顺序和旧 EXE 读取行为继续保留为历史候选，不能称为 v1.3.0 的已确认 `.sol` schema。下一步需在正式发行包上分别测试无外部太阳、仅窗变化、仅不透明面变化和仅后续热区提供太阳输入，确认长度、单位、面积基础和有效作用。

双热区样本的 `$Zones` 注释提出可省略非空调区，与本项目“非空调区自由室温及邻区传热参与计算”的要求存在语义差距。上海 plenum 和纽约 hallway 名称也不足以证明自由漂移模型成立。保留非空调需求并进行控制案例，不直接接受该注释作为新模型规则。

样本以方向围护、屋顶/地板设置和面积关联热区；没有确认任意墙面方位角、坡屋顶倾角的完整输入契约。PV/SWH 的方向/倾角字段不证明热区围护具有相同表达能力。相关近似或能力差距必须在几何接口定稿前说明。

## 后续执行边界

已有材料足够建立真实样本字段清单和解析候选，不再把“没有现成 `.sim` 或 CSV”作为阻塞。最先使用双热区原件的派生副本，记录唯一的路径替换；以完整正式 ZIP 在 Windows 上验证启动、项目定位、退出码、日志和本次产物。再逐项改变日程、工况、邻接、太阳和方向，避免同时改变多项输入掩盖协议差异。

运行前后保存原始输入、最终协议字节、天气和引擎指纹、参数向量与产物清单；通过后才将候选升级为运行契约。上游样本的命名、注释和结果只能作为来源证据，不能取代这一步，也不改变已接受的插件范围。

## Python 3.9.11 迁移

`.python-version` 固定 `3.9.11`，`requires-python` 设为 `>=3.9.11,<3.10`，Ruff 目标设为 `py39`。开发环境与宿主兼容线统一；精确补丁版本由版本文件选择，依赖声明限制在已选择的 3.9 系列，不宣称其他版本已经测试。

现有实现文档的天气代码将运行时求值的 `float | None` 改为 `Optional[float]`，移除 `zip(strict=True)`；头记录数已在进入 zip 前验证。其余标准库、内置泛型和两个工具的职责保持。无需为本次迁移添加第三方运行依赖，也不生成 Python 服务或部署包装层。

本轮使用实际 Python 3.9.11 执行发布身份、样本行列和保护入口检查，并从更新后的文档提取全部 4 个代码文件到独立临时目录。7 项回归测试、Ruff 规则与格式检查、按 Python 3.9 目标执行的类型检查均通过，现有项目入口也在 3.9.11 下运行通过。先前因账户用量上限被拒绝的最终验证已重新执行；引擎和天气原始指纹保持不变。上述结果只覆盖 Python 配置与离线工具，不代表 Windows 引擎或 Rhino 宿主验收。
