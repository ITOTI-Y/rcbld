# RCBld 重构现状证据：源码、引擎与示例

> **引擎基准更新（2026-09-06）**：用户已指定 `archive/RCBldEng-v1.3.0.zip` 为当前依据，详见 [v1.3.0 核验记录](engine-v1.3.0.md)。本文原有 EXE 解析、CPython 3.12、CLI、目录布局、计算行为及缺陷证据仅适用于旧 `archive/RCBldEng.exe`，不得直接视为新版契约。广州 EPW 已提供；`.sim/.sol` 可构造受控测试输入，无需现成文件。已接受的产品需求保持，待复核的技术建议仍未批准。

> **范围**：归档 C# 工程、`RCBldEng.exe`、手册及 `example.gh`。第 1–8 节为源码调查及后续主题；其后的引擎、接口、示例和技术栈章节补充交叉证据。仅调查和设计访谈，未修改业务代码。目录中存在的代码不等于已发布功能，静态字节码不等于经过运行验证的计算结果。
>
> **证据规则**：凡带 `路径:行号` 的句子均可直接回到当前归档源码核实。`[事实]` 是文件直接表达的行为/配置；`[推断]` 是从事实推得的重构影响；`[未知]` 表示该归档本身无法确认。

## 1. 结论摘要

1. **[事实]** 这是一个 Rhino/Grasshopper C# 插件的旧式 .NET Framework 项目：项目文件 `ToolsVersion="12.0"`、输出类型 `Library`、目标 `v4.8`（`archive/RCBldGH_code/RCBldGH/RCBldGH.csproj:1-16`）；解决方案记录 Visual Studio 17.7（`archive/RCBldGH_code/RCBldGH.sln:2-6`）。
2. **[事实]** 宿主 API 不是项目自带：`RhinoCommon.dll`、`Grasshopper.dll`、`GH_IO.dll` 都从项目内 `SDK\` 引用，且 `Private=False`（`RCBldGH.csproj:63-76`）。当前归档没有 `SDK` 目录；经典 NuGet 清单声明了 6 个 `net48` 包（`packages.config:1-9`），但当前归档也没有 `archive/RCBldGH_code/packages` 目录。**[推断]** 仅凭源码快照不能重建可编译/可部署环境，必须先确定 Rhino/Grasshopper 主版本和依赖获取方案。
3. **[事实]** 生成物被后置事件从目标 DLL 改名为 `.gha`，再删除 DLL；Debug 启动程序硬编码为 `C:\Program Files\Rhino 6\System\Rhino.exe`（`RCBldGH.csproj:315-327`）。这说明至少开发配置面向 Rhino 6 的 Grasshopper 加载方式；是否仍是发布支持矩阵未知。
4. **[事实]** 模型主链是“Rhino Brep/Surface → `SuperBrep`/`SuperSurface` → `EnvelopeSetting`/`Envelope` → `Zone`/`Schedule`/系统对象 → `ToCen()` 文本”。`SuperBrep(Brep)` 按面法线初分墙/地板/天花板（`Modules/SuperBrep.cs:43-78`）；`MaterialAssign4.0` 将材质、窗、相邻关系、Program、Schedule 写入 `SuperBrep`（`Components/2.Envelope/2.1envelopeSurface/MaterialAssign4.0.cs:91-161,543-718`）；`NewZoneComp`/`NewZoneComp1.1` 将 `EnvelopeSetting` 分类后构造成 `Zone`（`Components/2.Envelope/2.3zone/NewZoneComp.cs:52-172`、`NewZoneComp1.1.cs:50-169`）。
5. **[事实]** 当前 `.csproj` 明确同时编译多个版本/实验实现：`MaterialAssign.cs` 与 `MaterialAssign4.0.cs`、`NewZoneComp.cs` 与 `NewZoneComp1.1.cs`、`BasicsComp.cs` 与 `BasicsCompNew.cs`（`RCBldGH.csproj:80-104`）；还将 `studyAndTest` 中多份 Shadow/solar 代码列为 Compile（同上）。相反，目录中的 `MaterialAssign_new.cs`、`MaterialAssign3.1.cs`、旧 `ZoneComp.cs`/`ZoneComp2.0.cs`、`2.5Opaque` 的旧组件、`Components/other/**`、旧 `Components/Parametric tool/**` 等没有对应 Compile 项。**[推断]** 重构前不能按文件名选“最新版本”，要先以手册、`.gh` 文件和 EXE/运行证据确定产品面。
6. **[事实]** 存在少量可直接核实的正确性风险：面积按线性比例换算、`Zone` 无地板仍继续除以零、空 Brep 合并数组直接取 `[0]`、地板分类的 `else if` 遍历了错误集合、日程越界只报错不返回、日程区间只比较总长度不检查重叠/间隙等（详见第 6 节）。这些不是设计偏好，而是源码路径上的行为证据。

## 2. 技术栈、依赖和部署边界

### 2.1 编译/运行栈（源码事实）

| 层 | 证据 | 观察 |
|---|---|---|
| 语言/项目 | `RCBldGH.csproj:1-16` | 旧式 MSBuild/C# 项目，`OutputType=Library`，.NET Framework 4.8，`RootNamespace/AssemblyName=RCBldGH`。 |
| Rhino/Grasshopper | `RCBldGH.csproj:63-76` | 依赖 `SDK\RhinoCommon.dll`、`SDK\Grasshopper.dll`、`SDK\GH_IO.dll`；`Private=False`，由宿主或开发 SDK 提供。源码广泛使用 `GH_Component`、`GH_Param`、`GH_Goo`、`GH_AssemblyPriority` 和 `Rhino.Geometry`。 |
| Windows/.NET Framework API | `RCBldGH.csproj:35-62` | `System.Windows.Forms`、`System.Drawing`、`System.Web.Services`、`System.Runtime.Remoting`、`System.Xml` 等显式引用；这不是纯跨平台核心库。 |
| 经典 NuGet | `packages.config:1-9` | `Microsoft.CSharp 4.6.0`、`System.Buffers 4.5.1`、`System.Diagnostics.DiagnosticSource 5.0.0`、`System.Memory 4.5.4`、`System.Numerics.Vectors 4.5.0`、`System.Runtime.CompilerServices.Unsafe 5.0.0`，目标均为 `net48`。 |
| 解决方案工具链记录 | `RCBldGH.sln:2-6` | Solution Format 12，Visual Studio 17.7. 这只是解决方案头信息，不证明该版本实际构建成功。 |
| 插件输出 | `RCBldGH.csproj:307,315-317` | 导入 `Microsoft.CSharp.targets`；后置事件 `Copy "$(TargetPath)" "$(TargetDir)$(ProjectName).gha"` 后 `Erase "$(TargetPath)"`，最终把库作为 GHA 给 Grasshopper 加载。 |
| Debug 宿主 | `RCBldGH.csproj:322-327` | `StartProgram` 固定 `C:\Program Files\Rhino 6\System\Rhino.exe`。是否支持 Rhino 7/8，源码未声明。 |

### 2.2 快照中实际缺失/未证明存在的依赖

- `SDK\RhinoCommon.dll`、`SDK\Grasshopper.dll`、`SDK\GH_IO.dll` 是项目的 HintPath，但快照没有 `archive/RCBldGH_code/RCBldGH/SDK/` 目录（项目引用仍见 `RCBldGH.csproj:63-76`）。
- `packages.config` 所列包没有随快照带入 `archive/RCBldGH_code/packages/`；项目没有 PackageReference，仍依赖旧式 packages.config 恢复。
- `Resources.resx` 将图标大量作为 `ResXFileRef` 指向 `..\Resources\*.png`（例如 `Properties/Resources.resx:121-155,188-246`），图像文件在归档中存在；项目只把一部分资源标记为 CopyToOutputDirectory（`RCBldGH.csproj:203-304`）。**[未知]** 运行时是否依靠输出目录中的原始 PNG，不能只从源码确认，因为部分图标是嵌入 bitmap、部分是文件引用。
- 当前归档根目录可见 `RCBldEng.exe` 与 `example.gh`；其存在不代表插件可构建或示例可运行。EXE 和示例的静态取证见本文后续章节。

## 3. 插件元信息和加载身份

| 项目 | 证据 | 事实 |
|---|---|---|
| Assembly 标识 | `Properties/AssemblyInfo.cs:8-35` | 标题/产品为 `RCBldGH`，Description/Company/Product 等多为空；AssemblyVersion/FileVersion 都是 `1.0.0.0`；`ComVisible(false)`。 |
| Assembly Info | `RCBldGHInfo.cs:5-56` | `Name="RCBldGH"`，固定 Assembly GUID `7ad4028f-a394-4dac-8d88-e34c8bcbab67`；Icon、Description、AuthorName、AuthorContact 均返回 `null`/空字符串。 |
| 默认向导组件 | `RCBldGHComponent.cs:13-71` | 类别为 `Jorin/Test`，无输入、无输出、`SolveInstance` 空，Icon 为 `null`；ComponentGuid `74b31abf-ea4e-40a3-87df-caecdb70cacb`。它是向导生成的占位组件，不应被误当作业务入口。 |
| Grasshopper 类别优先级 | `ultaricon/Class1.cs:13-24` | `GH_AssemblyPriority` 注册短名 `RCBld`、符号 `R` 和 `Resources.OIG` 类别图标。 |
| GUID 兼容 | `RCBldGHComponent.cs:65-71` | 源码注释明确说明 ComponentGuid 改动会令旧 ghx 部分加载失败；其他业务组件也各自返回固定 GUID（例如 `Components/1.Material/MaterialSetting.cs:12-26`）。 |

## 4. 领域实体和关系（源码事实）

### 4.1 核心概念/关系表

| 概念 | 主要字段/关系 | 源码证据 | 在链路中的位置 |
|---|---|---|---|
| `Material` / `MaterialSetting` | `MaterialType` 分为 InternalFloor、ExternalFloor、InternalWall、ExternalWall、Ground、Roof、Window；材质含 Name、UValue、AbsorptionCoefficient、Emissivity、SHGC；设置对象持有六种围护材质 | `Modules/Material.cs:5-39` | 1.Material 组件创建材质；`MaterialSettingComp` 聚合并可选 Ground（`Components/1.Material/MaterialSetting.cs:28-75`）。 |
| `SuperSurface` | 一个 `GH_Surface`，含 `Material`、`Window` 列表、`IsInternal`、`RelativePosition`、`IsSlab`；可转换为 `EnvelopeSetting` | `Modules/SuperSurface.cs:23-96,148-178` | 单个几何面；窗会通过 BooleanDifference 切割主体（`Modules/SuperSurface.cs:180-191`）。 |
| `Opaque` / `Slab` / `Window` | `Opaque`/`Slab` 持 `GeometrySurface+Material`，互有 ToSlab/ToOpaque；`Window` 持窗面、材质、遮阳角度和枚举 | `Modules/Opaque.cs:9-28`、`Modules/Slab.cs:6-14`、`Modules/Window.cs:6-27` | EnvelopeSetting 的几何叶子对象；窗口由 Window 组件校验材质类型并包装为 `WindowGoo`（`Components/2.Envelope/2.2window/WindowComp.cs:110-160`）。 |
| `EnvelopeSetting` | `Opaques`、`Windows`、`Slabs`、`EnvelopeType`、WWR；提供平面/主材质/总面积/全部表面等查询 | `Modules/EnvelopeSetting.cs:164-189,282-388,391-565` | 一个可输送的围护设置；`EnvelopSurfaceParam` 负责 GH 预览/烘焙（`Components/2.Envelope/2.5Opaque/EnvelopSurfaceParam.cs:15-31,97-196,199-281`）。 |
| `Envelope` | 合并后的方向/材质/窗面积记录，另有 `ExternalFloorArea`；ToCen 只输出文本契约 | `Modules/EnvelopeSetting.cs:52-161` | `SuperBrep.MergeExternalEnvelope` 按 Roof/Ground/ExternalFloor/八方向外墙及内部面聚合（`Modules/SuperBrep.cs:466-665`）。 |
| `SuperBrep` | Rhino `Brep`、`MaterialSetting`、Wall/Floor/Ceiling 列表、`Envelop` 列表、相邻 Brep 与 Zone 属性 | `Modules/SuperBrep.cs:18-57,80-234,237-305` | `MaterialAssign4.0` 由房间 Brep 建立，按 AABB/面法线判断相邻和内部面（`Components/2.Envelope/2.1envelopeSurface/MaterialAssign4.0.cs:126-161,163-537`）。 |
| `Zone` | `EnvelopSurfaces` 是 Underground/ExternalFloor/InternalFloor/Wall/Roof 五类列表；保存 Program/HVAC/Schedule、内部材质、方向外墙设置、相邻 Zone | `Modules/Zone.cs:67-191` | `ZoneComp`/`NewZoneComp` 将若干 `EnvelopeSetting` 分类、闭合测试、辨识楼板/天花板并输出 `ZoneGoo`（`Components/2.Envelope/2.3zone/NewZoneComp.cs:107-250`）。 |
| `Program` | Occupancy、MetabolicRate、Appliance、Lighting、室外空气、渗透、通风、夜间冲洗、DHW、HVAC、三个 Schedule 关联 | `Modules/Zone.cs:47-66` | `ProgramComp` 将可选 GH 输入直接映射到 `Modules.Program`（`Components/3.Program/Program.cs:57-198`）；Zone Creator 再拷贝到 Zone。 |
| `Schedule` 与 Domain 对 | `ScheduleType` 为 Basic/BuildingUse/MonthlyCoefficient/MonthlyItss/MonthlyBus；`DataDetails` 是 `TimespanDataPair` 列表，月度组合使用 `TimespanSchedulePair` | `Modules/Schedule.cs:10-32,35-64`；`Domains/TimespanDataPair.cs:11-35`；`Domains/TimespanSchedulePair.cs:8-23` | 4.Schedule 生成 24 小时/12 月数据，再由 `ScheduleSetting` 提供给 Zone。 |
| 方向域 | 八方 S/SE/E/NE/N/NW/W/SW，另有 UP/DOWN/InValid | `Domains/Orientation.cs:3-19` | PV/SWH、方向分类和外墙合并共享同一枚举。`VectorTools.GetOrientation` 以参考平面 Y 轴为北（`Utils/VectorTools.cs:51-129`）。 |
| HVAC/COP | HVAC 由名称、冷热效率/COP 字典、系统/热回收/回风枚举、设计温度、容量等组成；COP 由 `Dictionary<int,double>` 表示 | `Modules/HVAC.cs:28-90`；`Domains/CopPairGroup.cs:6-24` | HvacComp 将 GH wrapper 映射为 HVAC；ToCen 依赖 `HeatingCops.Dictionary` 和 `CoolingCops.Dictionary`（`Components/3.Program/3.4Hvac/HvacComp.cs:84-260`；`Modules/HVAC.cs:103-144`）。 |
| 系统对象 | `DHW` 两个枚举；`EnergySources` 三个能源来源；`Pumps` 四个数值+控制枚举；`Renewable` 聚合 PV/SWH/WindTurbines | `Modules/DHW.cs:3-41`、`EnergySources.cs:3-46`、`Pumps.cs:5-91`、`Renewable.cs:3-23` | 6.Energy 组件生成并输出文本；`BusData`/`Data` 还承载 Basics、DHW、Pumps、BEM、Renewable、EnergySources、Schedules、Materials、HVAC、Zones 等跨组件总线字段（`Modules/BusData.cs:8-61`）。 |
| `CalibrationPara` | 多组材料、渗透、负荷、COP、供风温度和遗传算法参数列表/标量 | `Modules/CalibrationPara.cs:6-36` | 类型存在不代表校准可用；当前运行组件的校准参数代码被注释，EXE 主入口没有校准模式分派（见后文）。 |

### 4.2 几何到热区/围护/材料/工况的转换

1. **面初始化**：`SuperBrep(Brep)` 对 Brep 各 face 建 `SuperSurface`；采样法线 `Z>0.5` 进 Ceiling、`Z<-0.5` 进 Floor，其余进 Wall（`Modules/SuperBrep.cs:43-78`）。这是几何分类，不是物理语义；材质尚未决定。
2. **材质与相邻面分配**：`MaterialAssign4.0` 先给天花板/墙/底面按 `MaterialSetting` 赋 Roof/ExternalWall/Ground 或 ExternalFloor（`Components/2.Envelope/2.1envelopeSurface/MaterialAssign4.0.cs:126-153`），再用 AABB 粗筛、面法向和硬编码距离/面积阈值处理上下/墙面相邻，重标 InternalFloor/InternalWall 并登记接触面积（同文件 `:163-537`）。窗按质心投到 Wall 面并加入 `SuperSurface.Window`（同文件 `:543-560`）。
3. **Program/Schedule 注入**：当 Program 数量为 1 时复制给所有 SuperBrep；当数量等于房间数时按索引复制，同时读取 `schedules[i]` 的三个 Schedule（`MaterialAssign4.0.cs:562-672`）。
4. **围护合并**：`MergeExternalEnvelope()` 以 Roof/Ground/ExternalFloor 和八个方向建立 `Envelope`，把每个面 `EnvelopeSetting.GetPlanePartArea()` 汇总并收集窗；再将内部墙/楼板加入 `Envelop`（`Modules/SuperBrep.cs:466-665`）。其方向基准直接是 `Plane.WorldXY`（`Modules/SuperBrep.cs:563-566`）。
5. **Zone Creator 路径**：`NewZoneComp` 接收 EnvelopeSetting 列表，`Zone.AddSurface` 按 EnvelopeType/主材质放入五类列表（`Modules/Zone.cs:404-443`），调用 `IsZoneClosed`、`DistinguishFloor`、按地板面积算 Zone.Area 和按体积/面积算 Height，再把 Program/Schedule 复制到 Zone（`NewZoneComp.cs:107-250`）。`NewZoneComp1.1` 额外接收 SolarOP/SolarW，并按 Zone.Area 归一化（`NewZoneComp1.1.cs:106-169`）。
6. **文本边界**：各域对象通过 `ToCen()`/`ToText()` 拼接固定键名、枚举整数和单位注释，而非结构化 DTO；例如 Zone/SuperBrep 直接输出大量字符串（`Modules/Zone.cs:193-332`、`Modules/SuperBrep.cs:308-447`），Schedule 通过不同 ScheduleType 选择不同文本分支（`Modules/Schedule.cs:35-118`）。这使文本键、顺序、空值和单位成为隐式接口。

## 5. 功能分组与源码成熟度信号

> “成熟度”这里只表示**当前项目是否显式编译、是否有成套输入/输出、是否存在多个版本/实验痕迹**；不是“已发布/已验证”的结论。

| 组 | 当前项目边界 | 源码信号 | 取证判断 |
|---|---|---|---|
| 1.Material | 7 个材质组件 + MaterialSetting 均在 Compile（`RCBldGH.csproj:120,155-161`） | 有固定 GUID、图标、输入/输出，材料角色映射清楚（如 `ExternalWallMaterialComp.cs:23-57`） | **成套主流程候选**；没有范围/数值校验，MaterialSetting 的 Ground 可选。 |
| 2.Envelope | `MaterialAssign.cs`、`MaterialAssign4.0.cs`、窗/WWR/参数类型等在 Compile（`RCBldGH.csproj:81-87,110-117,152-154`） | 还存在 `MaterialAssign_new.cs`、`MaterialAssign3.1.cs`、`solarsurfaceAssign.cs`、旧 2.5 组件等未编译文件；两套赋值算法都保留 | **版本未收敛**；MaterialAssign4.0 是最复杂的房间 Brep→SuperBrep 路径，但不能仅凭名字视为最终版本。 |
| 3.Program | Program、HVAC/COP、类型枚举、Lighting 均在 Compile（`RCBldGH.csproj:89,118-119,140-145`） | GH 输入多为可选或 Generic wrapper；输出域对象和文本 | **功能较完整但契约弱类型**；数值约束分散在组件中。 |
| 4.Schedule | ScheduleSetting、日/月/24h 组件在 Compile（`RCBldGH.csproj:88,135-148`） | `TimespanTools` 负责压缩连续相同数据；DaySchedule 独立验证 | **有明确主流程，但校验边界存在缺陷**；月度组合没有统一时间区间验证。 |
| 5.Basics | `BasicsComp` 与 `BasicsCompNew` 同时 Compile（`RCBldGH.csproj:90-94`） | 旧版要求输入 Floors/Height/Length/Width/Area，New 版没有这些输入且默认地温为 12 个 18（`BasicsComp.cs:20-45,158-231`；`BasicsCompNew.cs:20-42,71-189`） | **同一概念存在不兼容版本**；无法从项目文件确定哪一个是用户入口。 |
| 6.Energy | DHW、EnergySource、Pump、PV/SWH/Wind、Renewable、枚举组件均在 Compile（`RCBldGH.csproj:106-109,121-142`） | 普遍有固定 GUID、图标、`ToCen`；Renewable 聚合要求三个子系统全非空（`RenewableComp.cs:36-92`） | **成套组件组**；许多输入单位只写在描述/文本中，数值域校验较少。 |
| 9.parametric / Types | DataRecord、Trigger、Bake、TypeList 均在 Compile（`RCBldGH.csproj:123-125,149-151`） | TypeList 是自定义 GH 参数与状态持久化（`Components/Types/TypeList.cs:11-34,117-200`）；另有旧 `Components/Parametric tool/trigger.cs`、`hao.cs` 未编译 | **工具/扩展边界明确但有旧目录分叉**。 |
| studyAndTest | `Shadow.cs`、`Shadow1.1.cs`、`ShadowAssign.cs`、`Shadow_new.cs`、`SolarCalculateBeamNew.cs`、`SolarDataFromEPW_New.cs` 被显式 Compile（`RCBldGH.csproj:99-104`） | 目录名为 studyAndTest，且保留多个版本；`Test.cs`、`WindowCustom.cs`、`WindowOrientation.cs` 未列入 Compile | **实验代码混入当前编译目标**；不能把目录名当作“完全未部署”，也不能把 Compile 当作“发布承诺”。 |
| other / datainterface | 目录存在 `EPWReader.cs`、多个 solar reader、`RunPy.cs` 等，但 `RCBldGH.csproj:80-200` 无任何 `Components\other\...` Compile 项 | `datainterface` 内另有 `*test.cs`、多个编号版本 | **按当前项目文件不参与本项目编译**；是否被其他外部工程/历史二进制使用未知。 |
| Reader/Simulation | 项目列出 `7.simulation` 和 `8.Reader`（`RCBldGH.csproj:95-98,126-128`） | 运行、导出、结果及 EXE 契约见本文后续章节 | **成套调用链，但错误处理、结果生命周期及列映射存在缺陷**。 |

## 6. 关键数据契约、单位疑点和可核实缺陷

### 6.1 单位/契约疑点（事实 + 影响推断）

1. **面积被用线性换算函数转换**：`Converter.ToMeters` 只把输入乘一次 `UnitScale`（`Utils/Converter.cs:56-60`），但 `Envelope` 文本把 `Area`/窗面积传入此函数并标注 `m2`（`Modules/EnvelopeSetting.cs:86-109,224-250`）。**[推断]** 当 Rhino 模型单位不是米时，面积应按平方比例换算；当前实现会产生比例错误。重构必须先定“内部几何单位/输出单位”的唯一规则。
2. **Ground Floor Area 单位冲突**：Basics 组件输入描述是 `m2`（`Components/5.Basics/BasicsComp.cs:29-37`），但 `Modules.Basics.ToCen()` 输出键写成 `unit: m`（`Modules/Basics.cs:114-120`）。这是可直接核对的接口文本冲突。
3. **面积来源没有显式单位模型**：`Opaque.Area`/`Slab.Area` 使用 Rhino 几何面积直接返回（`Modules/Opaque.cs:21-28`、`Modules/Slab.cs:8-14`）；`SuperBrep.GetZoneArea()` 直接累加同类面积（`Modules/SuperBrep.cs:450-461`），而 `EnvelopeSetting.ToCen()` 另行调用 `ToMeters`。**[推断]** 同一 `Area` 在不同输出路径可能采用不同换算策略。
4. **区间契约是隐式文本/整数**：`TimespanDataPair.ToCen()` 强制将 Interval 端点转为 `int`（`Domains/TimespanDataPair.cs:20-24`），`DaySchedule.ToString()` 也强制转 int（`Modules/Schedules/DaySchedule.cs:46-57`），但 `TimespanTools.IsIntegerTimespan` 目前未正确拒绝单端点小数（见下方缺陷）。
5. **方向依赖坐标约定**：`VectorTools.GetOrientation` 明确以参考平面 Y 轴为北（`Utils/VectorTools.cs:51-57,79-127`）；`SuperBrep.MergeExternalEnvelope` 却硬编码 `Plane.WorldXY`（`Modules/SuperBrep.cs:563-566`）。产品必须确认输入模型是否永远世界坐标、是否允许项目北向/旋转平面。
6. **输入值范围由 UI 文本而非统一域类型保证**：材质组件直接把 U 值/吸收率/发射率写入 `Material`（如 `ExternalWallMaterialComp.cs:23-57`），PV/SWH 只对角度枚举值做离散判断（`PvComp.cs:62-85`、`SwhComp.cs:58-80`）；很多负值/NaN/比例上限由调用方负责。重构需决定“构造即有效”还是保留占位 `NaN/-1`。
7. **空值策略不一致**：`BasicsCompNew` 给 Ground temperature 预填 12 个 18（`BasicsCompNew.cs:71-84`），旧 `BasicsComp` 则空值直接报错返回（`BasicsComp.cs:75-93`）；`MaterialSettingComp` 只把 Ground 设为 null（`Components/1.Material/MaterialSetting.cs:56-72`），而 `Renewable.ToCen()` 对 PV/SWH/Wind 全部无空值保护（`Modules/Renewable.cs:15-21`）。

### 6.2 少量高价值、可复核缺陷

| # | 缺陷证据 | 影响边界 |
|---|---|---|
| D1 | `Utils/TimespanTools.cs:33-40` 用 `HasFractionalPart(min) && HasFractionalPart(max)` 才判无效；一端为 `1.5`、另一端为 `2` 时返回有效。 | `DaySchedule` 的“端点必须为整数”契约可被单端点小数绕过；随后 `ToString()`/CEN 强制转 int（`Modules/Schedules/DaySchedule.cs:27-35,46-57`）。 |
| D2 | `Utils/TimespanTools.cs:13-30` 只检查每段落在 `[0,24]` 且长度和等于 24，未检查相邻、覆盖或重叠；精确比较 `Math.Abs(total-24)>0` 也没有容差。 | 例如两个重叠区间也可能通过总长度检查，生成的 Schedule 不是完整 24 小时分段；所有日程组件共享该验证。 |
| D3 | Building Use 越界只添加 Error，不 `return`，随后仍压缩并输出 Schedule（`Components/4.Schedule/Schedules/BuildingUseScheduleComp.cs:66-107`）。Indoor Temperature 同样在 10–32 校验失败后继续（`IndoorTempStptScheduleComp.cs:56-83`）。 | 无效数值可能进入 `Schedule.DataDetails`，错误消息不构成拒绝。 |
| D4 | `DayScheduleComp` 的构造函数没有访问修饰符，实际为 private：`DayScheduleComp.cs:11-20` 中是 `DayScheduleComp()`；GH 组件通常要求可公开实例化的无参构造。 | 这是组件发现/实例化边界的可核实风险；应在目标 Rhino/GH 版本中确认加载表现，不能靠静态构建结果替代。 |
| D5 | `Zone.IsZoneClosed` 在只判断 `resultBreps == null` 后直接读 `resultBreps[0]`（`Modules/Zone.cs:372-401`）；`Brep.JoinBreps` 可能返回空数组。 | 非闭合/无法合并输入可能触发索引异常，而不是返回 false/RuntimeMessage。`IsZoneClosedTest` 版本则遍历数组，说明两份实现契约已分叉（`Zone.cs:339-370`）。 |
| D6 | `Zone.DistinguishFloor` 的 `else if (surface.Slabs != null)` 分支仍 `foreach (var opaque in surface.Opaques)`（`Modules/Zone.cs:622-647`）。 | 只有 Slabs、Opaques 为 null 的 ExternalFloor surface 会在该分支解引用错误或被错误跳过；地板识别与 Zone.Area 计算受影响。 |
| D7 | `NewZoneComp`/旧 `ZoneComp` 在 NoFloor/MultiPlane 警告后仍以 `zone.Height = zoneVolume / zone.Area`（`NewZoneComp.cs:153-172`；`ZoneComp.cs:146-171`）；面积只在 Success 分支赋值。 | 异常地板状态继续输出 `Infinity/NaN` 高度或后续错误，而不是终止 Zone 契约。`NewZoneComp1.1` 还先把 SolarOP/SolarW 除以 `zone.Area`（`NewZoneComp1.1.cs:132-169`）。 |
| D8 | `MaterialAssign4.0` 完成房间循环后无条件用 `superBreps[0]` 生成 debug 输出（`Components/2.Envelope/2.1envelopeSurface/MaterialAssign4.0.cs:538-541`）。 | 空房间列表会越界；这是输入列表边界上的直接异常。 |
| D9 | `MaterialAssign4.0` 在 `programs.Count == 1` 或等于房间数时直接读取 `schedules[0]`/`schedules[i]`（`.../MaterialAssign4.0.cs:562-603,641-672`），但代码没有检查 Schedule 列表长度或三个成员是否存在。 | 缺失/长度不一致的 ScheduleSetting 会在索引处失败；Program 与 Schedule 的“一对多/按索引”契约没有显式诊断。 |
| D10 | `Envelope.ToCen()` 的 ExternalFloor 分支先正确输出 ExternalFloorArea，下一行却把同一 `ExternalFloorArea.Area` 再标为 `Window Area`（`Modules/EnvelopeSetting.cs:130-134`）。 | Ground/ExternalFloor CEN 文本携带语义错误的 Window Area；下游若按键解析会误读围护数据。 |
| D11 | `EnvelopeSetting.GetAreaFraction()` 返回 `windowAreaTotal/area`（`Modules/EnvelopeSetting.cs:491-535`），对空/零面积设置没有分母保护。 | WWR 可能为 NaN；而 `WWR` 属性直接暴露该值（`EnvelopeSetting.cs:179-186`）。 |
| D12 | `SuperSurface` 默认构造函数初始化 Id/位置/IsSlab，却没有初始化 `Window`（`Modules/SuperSurface.cs:27-33`）；`EnvelopeSetting` getter 随后直接访问 `this.Window.Count`（同文件 `:148-176`）。`SuperSurfaceGoo()` 会主动调用该默认构造（`Components/2.Envelope/2.1envelopeSurface/SuperSurfaceGoo.cs:8-16`）。 | GH 参数空值/反序列化路径可能在获取 EnvelopeSetting 时 NullReference；参数类型的“有效”只判断 `Value != null`（`SuperSurfaceGoo.cs:18-22`）。 |
| D13 | `ZoneGoo.Duplicate()` 直接 `return this`（`Components/2.Envelope/2.3zone/ZoneGoo.cs:6-17`）。 | Grasshopper 数据复制语义是别名而非独立 Goo；下游若修改 Zone/相邻列表可能影响原始分支。是否故意共享需产品/框架契约确认。 |
| D14 | `SuperBrep.MergeExternalEnvelope` 按 `Plane.WorldXY` 算外墙方向（`Modules/SuperBrep.cs:563-566`），而 `VectorTools` 的 API 允许传入任意基准平面（`Utils/VectorTools.cs:51-57`）。 | 建筑旋转/项目北向不在世界 XY 时，南北东西 Envelope 会错分；这是坐标约定问题，不应在重构中静默假定。 |

## 7. 对重构的接口边界（不作产品决策）

- **几何边界**：Rhino `Brep`/`GH_Surface` 出现在 `SuperBrep`、`SuperSurface`、`Opaque`/`Slab`/`Window` 和参数预览层；热区/文本域也携带 Rhino 类型（`Modules/SuperBrep.cs:86-87`、`Modules/Zone.cs:80-97`）。**[推断]** 若新核心要脱离 Rhino，必须在此处定义稳定的几何快照/单位化接口，而不能把 GH Goo 直接作为领域模型。
- **材质边界**：组件以 `GH_ObjectWrapper` 接收 `Material`/类型枚举（如 `WindowComp.cs:110-156`、`MaterialSetting.cs:45-75`），没有跨组件统一的强类型参数协议。
- **工况边界**：Program、ScheduleSetting 作为两个独立容器注入 Zone；Program 内又含三个 Schedule 属性（`Modules/Zone.cs:47-66`），存在同一语义多条注入路径。
- **序列化边界**：可见对外输出是自由字符串 `ToCen()`/`ToText()`，而非版本化 schema；对象还包含 GUID、枚举整数、默认 `NaN/-1`。实际 `.sim/.sol/CSV` 契约和 EXE 对照见后文，不能因旧函数名含 Cen 就把 `.cen` 当成当前运行文件扩展名。
- **宿主边界**：自定义 `GH_Param`、预览、烘焙、AssemblyPriority 都直接绑定 Grasshopper API（`EnvelopSurfaceParam.cs:15-31,97-196,199-281`；`ultaricon/Class1.cs:15-24`），插件壳与可测试核心应被分层。
- **版本边界**：组件固定 GUID 是 gh/ghx 兼容契约，不能在没有迁移策略时改名/重发（`RCBldGHComponent.cs:65-71`）；程序集版本当前固定 1.0.0.0（`Properties/AssemblyInfo.cs:25-36`）。

## 8. 后续设计主题（不是本轮问卷）

首轮只确认引擎边界、主要交付入口和结果用途，见 [decisions.md](decisions.md)。以下问题依赖首轮答案，不预先拍板：

- 宿主版本/平台、组件 GUID 与旧 GH 定义迁移策略。
- 热区与 Brep 的映射、邻接/地下/架空边界、斜面/曲面和项目北向支持。
- 材料、面积、热容、负荷、能量的单位及转换；日程覆盖、时间轴与闰年规则。
- 缺失数据与无效几何的拒绝边界；任务状态、取消、输出保留和错误诊断。
- 主流程、已编译实验组件与历史未编译代码各自对应的产品需求；不要求用户替我们判断哪个源文件“最新”。
- `.sim/.sol/CSV` 兼容边界、公共模型格式、批处理 API 及引擎版本识别。
- 计算适用性、行为对照与独立正确性基准；旧程序结果不是自动成立的物理真值。

## 引擎静态取证

### 方法与证据边界

对 `archive/RCBldEng.exe` 使用 `file`、`objdump -p`，随后按 PyInstaller 官方 CArchive 布局在内存解析目录、zlib 解压成员，使用匹配版本 CPython 的 `marshal`/`dis` 解码字节码。没有启动 EXE，没有导入或执行其业务模块；以下是静态行为证据，不是端到端运行证明，也不是经认证的数值结论。

- EXE：35,377,233 字节；SHA-256 `e059e98e4778e467d2e6f889998cafb1a52e6a37a3d24827750ea6ead12e2ed2`。
- PE：Windows console / x86-64 / PE32+，CLR Runtime Header 为零；外壳不是 .NET 托管引擎。
- PyInstaller：cookie 位于偏移 35,377,145，包起点 330,752；cookie 中 Python 版本值 312、库名 `python312.dll`。
- CArchive 748 个成员，逐一解压/核对未压缩长度成功，共 91,622,809 字节；PYZ 包含 735 个模块。
- 主入口 `RCBldEng.py`；业务模块 `lib.py`、`simulation.py`、`weather.py`、`comfort.py`。主入口与这四个模块共 158 个 code objects、22,694 条可解码指令。
- 依赖可确认 NumPy（`numpy.version` 常量为 1.26.4）与 pandas；包含 Windows `.pyd` 和 OpenBLAS DLL。打包目录中有通用标准库，不表示这些库都是业务必需依赖；不能按包内模块数设计新系统依赖。
- 字节码可分析不等于取得完整原始 Python 工程、注释、测试、许可证或可重建发布流程。

布局依据：[PyInstaller 官方 CArchiveReader](https://raw.githubusercontent.com/pyinstaller/pyinstaller/develop/PyInstaller/archive/readers.py)。下述 `EXE::模块.py:行号` 为字节码保留的原始源码行号，文件本身未作为源码存在于仓库。

### 实际命令行契约

现有调用形式为：

```text
RCBldEng.exe <project> <first_day> -sim <run_id> [key=value ...]
```

这不是从 `--help` 执行输出抄录的语法，而是调用方与字节码逐项核对所得：

- 插件：`Components/7.simulation/NewRunComp.cs:439-450`；旧版 `RunComp.cs:546-554`。
- EXE `RCBldEng.py:62-68`：主入口传入 `argv[:5]`，`main` 只取 `argv[1]`、`argv[2]`、`argv[4]`；`argv[3]` 没有被用于模式分派。第 5 个参数以后仅解析含 `=` 的项，按第一个等号切为键值。
- 因此旧注释里的 `calib/sens/opt` 不能算已实现的 CLI 模式；替换 `-sim` 这个占位参数也没有相应模式选择逻辑。
- EXE `RCBldEng.py:48-51` 将 `order=1` 写死。旧 `RunComp.cs:36,171-177` 提供并校验 1/2 阶，但 `:548-554` 不再把阶数传给引擎。现有入口不能承诺二阶计算。
- EXE 从当前工作目录的父目录推导 `Projects`，不是从任意输入文件路径推导（`RCBldEng.py:18-21`）；调用方把工作目录设为引擎目录（`NewRunComp.cs:441,520-530`）。

| 扩展键 | EXE 默认值 | 静态证据 |
|---|---|---|
| `if_pmv` | `False` | `RCBldEng.py:24`；可选舒适度结果路径存在 |
| `if_print` | `True` | `RCBldEng.py:25` |
| `solver` | `crank-nicholson` | `RCBldEng.py:26`；`simulation.py` 的 `iterate` 还出现 `euler`、`runge-kutta` 分支，未做数值验证 |
| `infl_style` | `constant` | `RCBldEng.py:27`；迭代存在 `real`、`constant` 分支 |
| `DHW_style` | `real` | `RCBldEng.py:28` |
| `weather_mode` | `default` | `RCBldEng.py:29`；`Simulation.__init__:40-43` 在非 default 时把值作为天气文件传入，并非已定义的一组枚举模式 |

工作日字符串使用 `mon/tue/wed/thr/fri/sat/sun`，不是常见的 `thu`（`RunComp.cs:163-168`；EXE `lib.py:840` 的 weekday 映射）。这些是旧协议约束，不是建议的新公共 API。

### 文件接口

```text
<引擎目录的父目录>/
  RCBldEng/RCBldEng.exe
  Projects/<project>/<run_id>/
    <project>_<run_id>.sim
    <project>_<run_id>.sol
    <project>_<run_id>_hourly.csv
    <project>_<run_id>_monthly.csv
    <project>_<run_id>_indoor_temperature.csv
```

| 接口 | 已观察到的内容 | 必须保留的未知/限制 |
|---|---|---|
| `.sim` | UTF-8 文本；`$段名:`、`字段: 值`、`!!!` 注释；段内以名称关联材料/计划/围护/HVAC/照明/热区；不是 JSON/XML，也不是把 Rhino 几何直接交给引擎 | 容错行为、必填字段、范围及跨字段约束未形成完整规范；不应仅换扩展名或序列化框架 |
| `.sol` | 可选太阳输入；`$solar` 头；每区 `zone: 窗序列;不透明围护序列`，序列以逗号分隔 | 插件在没有 SolarOP 的某个区上将整个缓冲区置 null，可能丢失其他区数据；长度/单位/时间轴需要专门核实 |
| 天气 | `.sim` 的 Basics/Weather File 指向天气文件；EXE 能按 EPW 列位置或特定 CSV 列名读取 | 归档无可用 EPW；自定义 CSV 根据首行末字段是否为空走不同分支，不能认为任意天气 CSV 均受支持 |
| Hourly CSV | pandas 导出，含索引列、year/month/day/hour、建筑级传热、冷热负荷、照明/设备/HVAC/DHW/泵/风机能量、电力/能源来源、可再生能源、人员及可选 PMV | 字段集合随能源来源与 if_pmv 变化；不能声明固定列数 |
| Monthly CSV | 按 month 聚合；室外温度取平均；除时间字段和室外温度外的列求和再乘 `1e-6`；删除 occupants | 不能直接据名称断言所有能耗列均为 kWh，更不能把这种聚合方式直接沿用为 PMV 语义；需逐量核对单位 |
| Indoor temperature CSV | 从 `agg_dict['indoor_temperature']` 构造 DataFrame 并写 CSV | 每个热区温度序列与时间轴/列名需要实际样例验收 |

来源：`NewRunComp.cs:209-435,471-487`；EXE `RCBldEng.py:21-57`、`lib.py:729-817`、`weather.py:28-74`、`simulation.py:751-819`。

模型段包含 Basics、温度设定计划、使用计划、月计划、各类材料、Envelope Setting、HVAC、Lighting Setting、Zones、DHW、Pumps、BEM 及可再生/能源来源配置。BUS 计划在引擎中按 10 列、ITSS 按 4 列、月计划按 1 列解析（EXE `lib.py:802-809`）。

### 接口/运行层的可核实缺陷

1. **生命周期会删旧结果**：`NewRunComp.cs:51-69` 在 `BeforeSolveInstance` 删除三种结果，而 `Run` 开关直到 `:80-83` 才判断；关闭运行或再次求解也可能删除上次结果。旧 `RunComp.cs:66-98` 同样如此。
2. **失败与成功不分**：`NewRunComp.cs:513-536` 同步 `WaitForExit()`、不检查退出码、无 stdout/stderr 捕获且吞异常；之后 `:485-493` 仍输出预期路径及 started 文本。不能用这些路径证明文件生成或本次运行成功。
3. **CSV 契约错配**：EXE `simulation.py:776-795` 按实际能源源生成 `total_*`，`:800-802` 还可加入 PMV。`HourlyReaderComp.cs:91-95` 跳过前 5 列后固定顺序分配，`MonthlyReaderComp.cs:90-94` 跳过首列后固定分配；端口却预设 district cooling/heating（各文件 `:31-53`）。缺少/增加能源列会导致后续指标错位，不只是显示名问题。
4. **全局工作目录和路径拼接**：`NewRunComp.cs:94-105` 的 `Substring(Length)` 得到空字符串，不能检查末尾分隔符；随后以字符串拼 EXE 路径。`:119` 修改整个 Rhino 进程当前目录；`:445-450` 未为带空格的项目/运行名建立参数边界。应通过明确工作目录和参数列表处理，而不是依赖旧字符串约定。
5. **聚合几何依赖坐标原点**：`BEM_New.cs:141-183` 的 min/max 初始值均为零，若建筑整体位于正坐标或负坐标区域，尺寸会把原点算进去。相同建筑平移后建筑尺寸不应变化；目前未在 Rhino 实际执行该案例。
6. **聚合空值判定对象不一致**：`BEM_New.cs:388-390` 用 HvacTemplate 非空判断是否加入 LightingTemplate，可能加入空照明模板或漏掉有照明但无 HVAC 的配置。

上述为静态可定位行为/风险；本轮不修改源码，不声称已完成运行时复现或修复。

## 手册与实际示例交叉核对

手册 `archive/RCBLDGH  Manual.docx` §1、§3.1、§3.2 描述 MaterialAssign → BEM → Run → CSV Reader 的工作流，与代码主链相符。但手册目录树中的 `.gha`、Projects 结果、天气文件并未随当前归档提供；不能按文档目录树声称安装包完整。

`archive/example.gh` 原始内容不可当 UTF-8 读取，但不是不可分析：用 raw-deflate（zlib `wbits=-15`）完整解压至 285,240 字节，解码器到达 EOF 且无尾随数据，得到 GH 二进制 Root/ArchiveVersion 结构。静态字符串与 GUID 检查确认：

- 引用 `RCBldGH, Version=1.0.0.0` 与 `Ladybug.Grasshopper, Version=0.0.0.1`。这是示例记录的程序集版本，不是引擎发布版本；新版是否继续需要 Ladybug 仍待功能范围决定。
- 记录 `MaterialAssign4.0`、`BEM3.0`、`Run2.0` 等组件标签。Run GUID `d78c67f6-0772-489d-94f8-0d6a0a39aa09` 与当前 `NewRunComp` 的 Run2.1 相同；不能仅因显示名差异断言不兼容。
- 天气引用是作者本机 `C:\Users\…\Downloads\CHN_Shanghai.Shanghai.583670_IWEC\CHN_Shanghai.Shanghai.583670_IWEC.epw`，非自包含相对路径；当前归档没有该天气文件。
- 没有在 Rhino 中打开、求解或核验完整连线，因此不能称这个 example 是已经成功运行的基准案例。

可提取手册正文仅包含截图占位标记；上述示例结论来自 GH 解压数据，不是从未查看的截图推断。

## 重构技术栈判断的适用条件

1. **用户已确认 Rhino/GH + Python**：GH 仍是建模、配置和计算入口；纯领域/校验/协议/运行管理/结果解析与 GH 生命周期和几何类型分离。首轮“优先 C#”仅为候选，已被用户的 Python 方向取代。
2. **用户已确认保留引擎**：不接管或重写 EXE 内的 Python 数值代码；字节码取证仅用于理解边界，不作为本次求解器实现来源。
3. **版本取决于宿主运行方式**：用户目标为 Rhino 8 及以上，但不等于所有未来大版本均已验证。[McNeel .NET 指南](https://developer.rhino3d.com/guides/rhinocommon/moving-to-dotnet-core/) 的 .NET 版本是宿主/包装层约束，不是 Python 解释器版本；仓库 `Python>=3.13` 空骨架与 Rhino 内置 CPython 也不能混同。详见下节。
4. **输入输出分层**：领域层表达建筑/热区/边界/工况/方案/任务/结果语义；旧 `.sim/.sol/CSV` 放在引擎适配边界。独立核心不意味着必须新增 CLI 或公开 JSON 接口。
5. **不预设额外系统**：现有证据不构成添加前端框架、数据库、HTTP API、队列或云服务的理由。

此前调查记录的验证能力：已实际执行二进制取证与静态解析并核对完整性；没有 Windows/Rhino/GH 运行表面，PATH 中未发现 Wine 或 dotnet，归档无 `.gha`、SDK DLL、还原后的 packages、EPW、`.sim/.sol` 或 CSV 基准。因此没有构建、插件加载、模拟成功或计算正确性的声明。本轮核对官方文档并记录 Q1–Q3，不重复运行上述调查，也不声称已补齐运行环境。

## Python/Rhino 8 技术约束核对

依据用户补充“基于 Python 重构、面向 Rhino 8 及以上”核对一手文档。下列事实来自官方页面，不是当前环境中执行 Rhino 的结果；发布到具体 Rhino 服务版本前仍需实际验收。

| 主题 | 官方事实与本项目影响 | 一手来源 |
|---|---|---|
| Python 版本 | 文档明确 Rhino 8 使用 CPython 3.9.11；可访问 RhinoCommon。宿主内核心不能要求 Python 3.13 才能导入；并不要求把 EXE 内的 Python 3.12 改为 3.9 | [What is Rhino.Python?](https://developer.rhino3d.com/guides/rhinopython/what-is-rhinopython/) |
| GH 生命周期 | Python 支持 `GH_ScriptInstance` SDK-Mode，提供 `BeforeRunScript`、`RunScript`、`AfterRunScript` 和预览方法；支持宿主适配，不是把业务逻辑重新塞进组件的理由 | [Grasshopper Scripting: Python](https://developer.rhino3d.com/guides/scripting/scripting-gh-python/#sdk-mode) |
| 插件化发布 | Script Editor 可把脚本发布为 GH `.gha`，共享代码库和数据，生成 Yak 包及可定制的 .NET 工程；因此 Python 重构不等于只能交付散装脚本组件 | [Creating Rhino/Grasshopper Script Plugins](https://developer.rhino3d.com/guides/scripting/projects-create/) |
| 最低版本 | 发布的 Build Target 指定最低 Rhino 版本，有 Windows/macOS 目标；文档还注明 GH 输入 `Required` 选项始于 8.14。不能把最新工具行为默认当作 Rhino 8.0 全部具备，也不能用跨平台包装目标证明本 EXE 能在 macOS 运行 | [Publishing Script Plugins](https://developer.rhino3d.com/guides/scripting/projects-publish/)、[Required Inputs](https://developer.rhino3d.com/guides/scripting/scripting-gh-python/#required-inputs) |
| 异步限制 | 官方明确 `# async: true` 不适用于 GH；允许后台计算并通过后续 GH 求解更新结果。异步运行层须与组件求解分离，不能照搬 ScriptEditor 的 async 标签 | [Asynchronous Execution](https://developer.rhino3d.com/guides/scripting/advanced-async/#async-in-grasshopper) |
| 包隔离 | Rhino 中的包环境仍共享进程、内存及解释器状态；自定义环境不保证同进程不同依赖版本的运行时隔离。当前无必要把 EXE 内的 NumPy/pandas 依赖复制到插件核心 | [Python Package Environments](https://developer.rhino3d.com/guides/scripting/advanced-pyvenvs/) |

**[推断/建议]** 首选“薄 GH Python 组件 + Rhino 几何适配 + 无宿主依赖的 Python 核心 + 原 EXE 子进程”。保留 Windows 本地计算约束，不新增 Python 服务；优先标准库及必要依赖。外部新版本 Python 进程仅在存在明确版本/隔离需求时重新评估。这些是技术建议，批准状态以 [决策记录](decisions.md) 为准。
