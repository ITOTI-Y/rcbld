# DATA

本表登记重构核验使用的引擎与天气资产。`created` 为首次登记日期，不表示上游文件的制作日期；保留用户提供的原始文件名。`quality: unverified` 表示尚未完成业务适用性验证，已完成的结构检查另列于 notes。

## raw-rcbldeng-v1-3-0

- **path**: `archive/RCBldEng-v1.3.0.zip`
- **format**: zip，内含 Windows x64 PE 程序、DLL、PYD 与运行资源
- **source**: 用户提供，并明确指定为当前引擎基准；v1.3.0 标识来自文件名，未通过程序版本命令核对
- **purpose**: 新插件的引擎接口与运行能力核验
- **flow**: `user-provided release -> reconstruction engine verification -> future engine adapter`
- **status**: active
- **quality**: unverified
- **created**: 2026-09-06
- **updated**: 2026-09-06
- **size**: 32,579,839 bytes
- **notes**: SHA-256 `824b0cf2f84cb26634d3c920dd38aa97ad041984c6bf21dfc55f0e76bcbf0355`；739 个文件的 ZIP CRC 检查通过。未执行 EXE，未证明输入兼容性或计算正确性。静态证据见 [v1.3.0 核验记录](../reconstruction/engine-v1.3.0.md)。

### Schema

压缩包根目录为 `RCBldEng/`，入口为 `RCBldEng/RCBldEng.exe`，需保留同目录依赖及其相对布局。关键依赖包括 `python39.dll`、`pyarmor_runtime_005387/pyarmor_runtime.pyd`、NumPy/pandas 扩展与资源。不能将该目录发布包按旧单文件 EXE 的方式只复制入口文件。

包内未发现项目源码、README、版本变更说明、接口文档、EPW、`.sim/.sol` 或结果 CSV。可见业务模块为 PyArmor 保护入口；实际输入输出 schema 待新版黑箱运行或接口资料确认，不沿用旧版协议作为已确认契约。

## raw-rcbldeng-legacy

- **path**: `archive/RCBldEng.exe`
- **format**: Windows x64 PE / PyInstaller 单文件程序
- **source**: 既有归档，具体发布版本未知
- **purpose**: 保留旧协议和旧行为调查的历史证据
- **flow**: `legacy archive -> historical reconstruction evidence`
- **status**: deprecated
- **quality**: unverified
- **created**: 2026-09-06
- **updated**: 2026-09-06
- **size**: 35,377,233 bytes
- **notes**: SHA-256 `e059e98e4778e467d2e6f889998cafb1a52e6a37a3d24827750ea6ead12e2ed2`；已被用户指定的 v1.3.0 发布包取代，文件保留。schema: not_applicable，二进制资产；历史接口取证见 [evidence.md](../reconstruction/evidence.md#引擎静态取证)。旧版运行与数值正确性也未通过验收。

## raw-guangzhou-weather

- **path**: `archive/Guangdong_Guangzhou_GD_592870.epw`
- **format**: epw，UTF-8 可解码的 CSV 文本
- **source**: 用户提供；文件头注明 Climate.Onebuilding.org、SRC-TMYx、NCEI ISD/ERA5，原始记录期 2011–2025。未另行确认下载来源与再分发许可
- **purpose**: 广州气象条件下的引擎输入与时间轴验证
- **flow**: `user-provided weather file -> structural inspection -> future v1.3.0 controlled simulation`
- **status**: active
- **quality**: unverified
- **created**: 2026-09-06
- **updated**: 2026-09-06
- **size**: 1,610,108 bytes
- **notes**: SHA-256 `039dcba8fc42628f0fd8fec2f602d7938d62c8e4aa183d6bf527ff4f76e8419f`；已确认 8760 条数据记录、每条 35 列。尚未检查全部气象值、缺测哨兵或 v1.3.0 读取行为，基础结构通过不表示可直接用于生产计算。

### Schema

前 8 条为 EPW 头记录，第 9 条起为逐时气象记录，无列名行。LOCATION 指定广州、站号 `592870`、纬度 `23.20990°`、经度 `113.4822°`、UTC+8、海拔 `15.2 m`。DATA PERIODS 指定每小时 1 条记录、1 月 1 日至 12 月 31 日、起始星期 Sunday。

本轮结构检查将 35 列保留为原始字符串，只读取前 5 列的年、月、日、小时、分钟；未来气象消费者须按 [EPW 数据字典](https://bigladdersoftware.com/epx/docs/24-2/auxiliary-programs/energyplus-weather-file-epw-data-dictionary.html) 确定各气象列的类型、单位与缺测哨兵，不能统一填零或直接按浮点数处理全部列。新增气象消费者时再同步其消费字段和校验契约。

当前文件的来源年份为 2014、2015、2016、2017、2020、2021、2023、2024、2025，分钟均为 30；首条为 `2023,1,1,1,30`，末条为 `2017,12,31,24,30`。不得按来源年份重新排序；如何转换为模拟日历、如何解释第 24 小时与分钟字段，仍需新版引擎验证。时区、星期、源年份和行序分别保留。
