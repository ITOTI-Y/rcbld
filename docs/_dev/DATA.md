# DATA

本表登记重构核验使用的引擎与天气资产。`created` 为首次登记日期，不表示上游文件的制作日期；保留用户提供的原始文件名。`quality: unverified` 表示尚未完成业务适用性验证，已完成的结构检查另列于 notes。

## raw-rcbldeng-v1-3-0

- **path**: `archive/RCBldEng-v1.3.0.zip`
- **format**: zip，内含 Windows x64 PE 程序、DLL、PYD 与运行资源
- **source**: 用户提供并指定为当前引擎基准；2026-09-07 与 [上游 v1.3.0 正式发行资产](https://github.com/andersonspy/RCBIdEng/releases/tag/v1.3.0) 按 SHA-256 核对一致，未执行内部版本命令
- **purpose**: 新插件的引擎接口与运行能力核验
- **flow**: `user-provided release + upstream v1.3.0 asset -> identity and protocol verification -> future engine adapter`
- **status**: active
- **quality**: unverified
- **created**: 2026-09-06
- **updated**: 2026-09-07
- **size**: 32,579,839 bytes
- **notes**: SHA-256 `824b0cf2f84cb26634d3c920dd38aa97ad041984c6bf21dfc55f0e76bcbf0355`；739 个文件的 ZIP CRC 检查通过。未执行 EXE，未证明输入兼容性或计算正确性。静态证据见 [v1.3.0 核验记录](../reconstruction/engine-v1.3.0.md)；公开历史和业务模块恢复范围见 [反编译核查](../reconstruction/engine-recovery.md)。

### Schema

压缩包根目录为 `RCBldEng/`，入口为 `RCBldEng/RCBldEng.exe`，需保留同目录依赖及其相对布局。关键依赖包括 `python39.dll`、`pyarmor_runtime_005387/pyarmor_runtime.pyd`、NumPy/pandas 扩展与资源。不能将该目录发布包按旧单文件 EXE 的方式只复制入口文件。

包内未发现项目源码、README、版本变更说明、接口文档、EPW、`.sim/.sol` 或结果 CSV。可见业务模块为 PyArmor 保护入口；已按指定上游的固定提交确认 README 和样本结构，见 [上游协议核对](../reconstruction/engine-protocol.md)；实际解析行为与物理量语义仍待正式发布包运行确认，不沿用旧版协议作为已确认契约。

## derived-rcbldeng-v1-3-0-static-recovery

- **path**: `docs/reconstruction/artifacts/engine-v1.3.0/`
- **format**: UTF-8 反汇编/失败源码草稿、JSON 清单、日志、Markdown 证据与标准库提取脚本
- **source**: 从 `raw-rcbldeng-v1-3-0` 派生；reverse-skill `7e2097f`、静态解包工具 `e64b5a2`，精确版本见 [复现说明](../reconstruction/artifacts/engine-v1.3.0/README.md)
- **purpose**: 在无 Windows 环境下保存可复核的业务反汇编和局部协议结论
- **flow**: `pinned ZIP -> protected wrappers + runtime -> static decryption -> disassembly -> bounded protocol findings`
- **status**: active
- **quality**: unverified
- **created**: 2026-09-07
- **updated**: 2026-09-07
- **size**: 5 份反汇编共 2,056,676 bytes；其余生成证据的大小和 SHA-256 见 [manifest.json](../reconstruction/artifacts/engine-v1.3.0/manifest.json)
- **notes**: 196 个代码对象；从原件重新提取后反汇编逐字节一致。4 份自动草稿语法失败，入口草稿只有注释。保留失败输出，未执行目标或草稿，未校验数值等价；不作为运行代码。原始 ZIP、EPW 不改写；含密钥的中间文件不归档。

### Schema

`disassembly/<module>.das` 保存代码对象名称、参数/常量表和字节偏移；`decompiler-drafts/<module>.txt` 为未修复的工具草稿。`manifest.json.files` 以相对路径映射 `bytes` 与 `sha256`，覆盖 28 个生成证据文件，不覆盖手写文档。`evidence/E-*.md` 关联来源、复现命令、产物哈希与工作项；`report/recovery.md` 中的 validated 仅指静态指令核对，candidate 表示待运行验证推断。目录不随插件部署，完整内容可从固定原件和工具版本再生。

## raw-rcbldeng-legacy

- **path**: `archive/RCBldEng.exe`
- **format**: Windows x64 PE / PyInstaller 单文件程序
- **source**: 既有归档，具体发布版本未知
- **purpose**: 保留旧协议和旧行为调查的历史证据
- **flow**: `legacy archive -> historical reconstruction evidence`
- **status**: deprecated
- **quality**: unverified
- **created**: 2026-09-06
- **updated**: 2026-09-07
- **size**: 35,377,233 bytes
- **notes**: SHA-256 `e059e98e4778e467d2e6f889998cafb1a52e6a37a3d24827750ea6ead12e2ed2`；已被用户指定的 v1.3.0 发布包取代。2026-09-07 当前 `dev` 检出未包含此旧文件，本条保留历史指纹及取证来源；本轮未删除旧资产，也未以其他 EXE 代替。schema: not_applicable，二进制资产；历史接口取证见 [evidence.md](../reconstruction/evidence.md#引擎静态取证)。旧版运行与数值正确性也未通过验收。

## raw-guangzhou-weather

- **path**: `archive/Guangdong_Guangzhou_GD_592870.epw`
- **format**: epw，UTF-8 可解码的 CSV 文本
- **source**: 用户提供；文件头注明 Climate.Onebuilding.org、SRC-TMYx、NCEI ISD/ERA5，原始记录期 2011–2025。未另行确认下载来源与再分发许可
- **purpose**: 广州气象条件下的引擎输入与时间轴验证
- **flow**: `user-provided weather file -> structural inspection -> future v1.3.0 controlled simulation`
- **status**: active
- **quality**: unverified
- **created**: 2026-09-06
- **updated**: 2026-09-07
- **size**: 1,610,108 bytes
- **notes**: SHA-256 `039dcba8fc42628f0fd8fec2f602d7938d62c8e4aa183d6bf527ff4f76e8419f`；已确认 8760 条数据记录、每条 35 列；月/日/小时连续，所检 12 个气象字段无缺测、非有限值或越界。天气观测缺失指示共 5164 条，单独报告。检查工具及回归测试已在 Python 3.9.11 验证；全部 EPW 语义和 v1.3.0 读取行为仍未覆盖，不据此认定生产适用性。

### Schema

前 8 条为 EPW 头记录，第 9 条起为逐时气象记录，无列名行。LOCATION 指定广州、站号 `592870`、纬度 `23.20990°`、经度 `113.4822°`、UTC+8、海拔 `15.2 m`。DATA PERIODS 指定每小时 1 条记录、1 月 1 日至 12 月 31 日、起始星期 Sunday。

原始 35 列按 CSV 字符串保存；离线工具读取前 5 列时间字段及观测指示/天气代码，并检查干球、露点、湿度、气压、水平红外、总水平/直射法向/散射水平辐射、风向、风速及两类云量。类型、单位、缺测阈值与范围完整定义在 [天气工具文档](03_WEATHER_IMPL.md)。源文件不改写、不填零；参考年只用于检查月/日/小时覆盖，不选择模拟日历。其他列及完整头字段尚未实施语义校验。

当前文件的来源年份为 2014、2015、2016、2017、2020、2021、2023、2024、2025，分钟均为 30；首条为 `2023,1,1,1,30`，末条为 `2017,12,31,24,30`。不得按来源年份重新排序；如何转换为模拟日历、如何解释第 24 小时与分钟字段，仍需新版引擎验证。时区、星期、源年份和行序分别保留。
