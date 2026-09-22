# `.sol` 太阳输入协议（1.1 源码确认）

记录日期：2026-09-22。来源：用户提供的 `RCBlDEng_Codes1.1.zip`，含可读 Python 源码 `RCBldEng.py`、`lib.py`、`simulation.py`、`weather.py`、`comfort.py` 与一个 2025-01-14 的单文件 EXE（35 377 233 字节，md5 `3e4e28f81748953148e9ce7ae7638dda`）。源码已存入 [archive/RCBldEng_Codes1.1/](../../archive/RCBldEng_Codes1.1/)，EXE 未入库。该 EXE 与 `archive/RCBldEng-v1.3.0.zip` 中的正式 EXE（5 891 467 字节，md5 `a7659fadfeeb56dfc70fce2ecde24ee8`）是不同构建。

**用户说明（2026-09-22）**：v1.3 有意关闭了对 `.sol` 辐射输入的计算；本次重构将在插件侧重新构筑辐射计算，后续引擎将重新开启对辐射输入的读取。因此本文记录的 1.1 协议是引擎重新开启时的目标契约，也是插件侧辐射输出的写出目标；[逆向报告](artifacts/engine-v1.3.0/report/recovery.md) 中 v1.3.0 的 `Solar/AreaFrac` 路径是当前正式包的实际行为，两者并存于文档，直至引擎新版发布。

## 文件定位与存在性

依据 `RCBldEng.py:16-45`。

- 路径：`<cwd 的父目录>/Projects/<building>/<runcode>/<building>_<runcode>.sol`，与 `.sim` 同目录同名，仅扩展名不同。
- 文件缺失：跳过读取，全部热区走内部太阳模型。
- 空文件（首字符读取为空）：打印 `No RCBldGH radiance`，同样走内部模型。
- 编码：UTF-8 文本，逐行读取。

## 行格式

```text
<热区名>:<w_0>,<w_1>,...,<w_{N-1}>;<op_0>,<op_1>,...,<op_{N-1}>
```

- 不含 `:` 的行被忽略。`$solar` 这类无冒号头行无害；`$solar:` 会被当作热区名并触发 `KeyError`。
- 热区名取首个 `:` 之前的原文，未做空白裁剪，必须与 `.sim` 中 `Zone Name:` 解析后的键逐字相同（`lib.py:759-761` 对该键做了 strip），否则 `KeyError` 终止运行。热区名内不得含 `:`。
- `;` 之前的逗号序列写入 `Solar_W`（窗），之后的序列写入 `Solar_OP`（不透明面）。两段都经 `np.array(...).astype(float)` 转换，空字段或非数值文本会 `ValueError` 终止；行尾换行符可被 `float()` 容忍。
- 序列长度 N 必须等于天气行数（EPW 为 8760），否则在 `simulation.py:179` 的 `q_sol_op + q_sol_w` 广播处报错。

## 单位与物理语义

依据 `simulation.py:82-179, 209-210, 518` 与 `lib.py:1027-1031`。

- `Solar_W` 直接替换 `zone.q_sol_w`，与内部路径的 `gain/zone.Af` 同量纲：按楼面面积 `Af` 归一化的逐时热流，单位 W/m²（楼面）。`hourlyAggregate` 再乘 `Af·3600` 得到每小时能量 J，写入 hourly CSV 的 `heat_transfer_window`。
- 内部路径的 `q_sol_w` 定义为“透过窗的短波得热 − 天空长波损失 `q_sol_w_rfl`”。外部 `Solar_W` 替换的是这一整项，若插件只写出短波透射得热，则该热区窗的长波散热被取消。插件侧重构时需要决定是否在写出前自行扣除长波项，并在文档中声明。
- `q_sol = q_sol_w + q_sol_op` 进入 `q_m = prm·(0.5·q_int + q_sol)` 与 `q_st = prs·(0.5·q_int + q_sol)`，即分配到内部质量节点与中央节点，气体节点不直接接收太阳项。
- 内部路径中窗的得热已含遮阳修正系数 `SRF_overhang·SRF_fin·SRF_horizon`、可动遮阳 `shading_SRF` 与框架系数 `(1 − frame_factor)`；外部序列替换后这些修正全部失效，遮阳必须在插件侧算入。

## 已确认的分支与缺陷

- 分支门控（`simulation.py:87-88`）：只检查 `pre_dict['Zones']` 中第一个热区是否有 `Solar_OP` 属性。首个热区无该属性时，其余热区的外部输入全部被忽略。首个热区有该属性时，仍先对所有热区执行内部计算，再逐区用外部值覆盖有属性的热区。
- 缺陷（`simulation.py:177`）：`zone.q_sol_op==self.pre_dict['Zones'][zname].Solar_OP` 是比较表达式，结果被丢弃；`Solar_OP` 从未生效，不透明面始终使用内部计算。旧 EXE 字节码推断的这一缺陷现在有源码级确认。
- `Solar_W` 的赋值（第 178 行）有效。

## 对重构的约束

1. 插件侧辐射计算的输出单位固定为 W/m²（楼面归一化）逐时序列，长度与天气文件一致；写出前按热区名与 `.sim` 键逐字对齐，并拒绝含 `:` 或前后空白的名称。
2. 引擎重新开启读取时，需修复第 177 行的赋值，并把分支门控改为逐区判断；这两项列为引擎侧变更需求，不在插件侧静默补偿。
3. 是否在 `Solar_W` 中扣除长波损失项、是否把遮阳修正并入外部序列，在插件侧辐射模块定稿前由用户决定；两种选择都要在 [decisions.md](decisions.md) ADR-009 中记录。
4. v1.3.0 正式包对 `.sol` 的忽略是有意行为，Windows 端到端验收中“提供 `.sol` 后结果无变化”属于预期，不作为缺陷记录。
