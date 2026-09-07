# v1.3.0 静态恢复证据包

2026-09-07 在 Linux 上从用户指定的正式 ZIP 恢复 5 个业务模块的反汇编。入口、解析器和太阳覆盖分支的结论见 [报告](report/recovery.md)。这里保存的是静态证据，未运行 Windows 引擎，也未恢复可直接使用的完整源码。

## 文件与使用边界

| 路径 | 内容 |
|---|---|
| `disassembly/*.das` | 完整反汇编，保留工具原始输出及字节偏移 |
| `decompiler-drafts/*.txt` | 自动反编译的失败草稿，仅用于检查工具局限，不导入项目 |
| [manifest.json](manifest.json) | 引擎、工具版本和 28 个生成证据文件的 SHA-256；不包含报告等手工文档 |
| [extract_inputs.py](extract_inputs.py) | 从精确指纹的 ZIP 提取保护入口；CPython 3.9.11，标准库，无目标执行 |
| [evidence](evidence/E-extraction.md) | PE 信息、重复恢复结果、脱敏日志与 Evidence 记录 |
| [scope.md](scope.md)、[timeline.md](timeline.md)、[workitems.md](workitems.md) | reverse-skill 的范围、过程和覆盖记录 |
| [field-journal.md](field-journal.md) | 本地方法记录，无外部发布 |

不归档含运行时密钥的 `.seq`、外层解密中间文件或原始未脱敏日志。正式 ZIP 足以重新生成这些中间产物。`manifest.json` 的完整性检查不能证明算法或工具输出正确。

## 工具来源

| 工具 | 本次固定版本与用途 |
|---|---|
| [reverse-skill](https://github.com/zhaoxuya520/reverse-skill/tree/7e2097fd90d25c2f976f6eba26d6c00aa88051df) | `7e2097f`；安装 Codex router，保留完整仓库相对引用；Linux 路由 R7 |
| [radare2](https://github.com/radareorg/radare2/releases/tag/6.2.2) | 6.2.2；读取 EXE/PYD 的节、导入和导出；官方 deb 解包到分析目录 |
| [Pyarmor-Static-Unpack-1shot](https://github.com/Lil-House/Pyarmor-Static-Unpack-1shot/tree/e64b5a288a1161862196e473fe40ea691205b58e) | `e64b5a2`，CLI 0.4.1；静态解密、Python 3.9 字节码解析和反汇编 |
| [PyCryptodome](https://pypi.org/project/pycryptodome/3.23.0/) | 3.23.0；隔离分析环境中的加密原语 |
| CPython / g++ | 提取使用 3.9.11；解包工具使用主机 3.12.3 和 g++ 编译的静态解析器 |

技能已安装于 `/home/ubuntu/.codex/skills/reverse-skill-router/`，上游完整目录位于其 `repository/`。安装记录为同目录 `INSTALLATION.json`；只调整入口相对路径和案件目录约定。未改全局 AGENTS、MCP 或项目 Python 基线。后续新会话可发现该技能，本轮已直接读取并使用。

本机没有 CMake，按工具自身 CMake 源文件清单使用 g++ 编译，未改其解析实现。实际命令、结果和编译警告分别见 `evidence/unpacker-build-command.json`、`evidence/unpacker-build-result.json`、`evidence/unpacker-build.log`。分析工具是取证依赖，不是插件运行依赖。

## 复现恢复

以下在项目根目录执行，需要 `uv`、CPython 3.9.11、主机 Python 3.12、Git、g++ 及网络下载工具源码。若 3.9.11 已安装在自定义目录，可把 `--python 3.9.11` 换为解释器绝对路径。本次实际路径为 `/tmp/rcbld-python-3911/cpython-3.9.11-linux-x86_64-gnu/bin/python3.9`。工具下载和编译只发生在新建临时目录。

```bash
recovery_root=$(mktemp -d /tmp/rcbld-static-reproduce-XXXXXX)
analysis_dir="$recovery_root/sample"
unpacker_dir="$recovery_root/unpacker"
uv run --no-project --python 3.9.11 python \
  docs/reconstruction/artifacts/engine-v1.3.0/extract_inputs.py \
  archive/RCBldEng-v1.3.0.zip "$analysis_dir"
git clone https://github.com/Lil-House/Pyarmor-Static-Unpack-1shot "$unpacker_dir"
git -C "$unpacker_dir" switch --detach e64b5a288a1161862196e473fe40ea691205b58e
uv run --no-project --python 3.12 python - "$unpacker_dir" <<'PY'
from pathlib import Path
import re
import subprocess
import sys

root = Path(sys.argv[1])
source = root / 'pycdc'
listing = (source / 'CMakeLists.txt').read_text()
block = re.search(r'add_executable\(pyarmor-1shot\s+(.*?)\)', listing, re.S)
if block is None:
    raise ValueError('Missing source list')
sources = [source / name for name in block.group(1).split()]
if not all(path.is_file() and path.suffix == '.cpp' for path in sources):
    raise ValueError('Unexpected source list')
subprocess.run([
    'g++', '-std=c++11', '-O1', '-static', '-static-libgcc', '-static-libstdc++',
    '-I', str(source), '-o', str(root / 'oneshot/pyarmor-1shot'),
    *map(str, sources),
], check=True)
PY
uv run --no-project --python 3.12 --with pycryptodome==3.23.0 python \
  "$unpacker_dir/oneshot/shot.py" "$analysis_dir/input" \
  -r "$analysis_dir/pyarmor_runtime.pyd" -o "$analysis_dir/recovered" \
  --concurrent 1 --no-banner --unhide-all-noisy-logs \
  > "$analysis_dir/unpacker.log" 2>&1
sha256sum "$analysis_dir/recovered/"*.das
```

命令执行目标是静态解包工具，不是 Windows EXE。工具原始日志和 `.seq` 含密钥材料，应留在分析目录；本证据包仅保存删除密钥行后的日志。退出码为 0 仍可能包含反编译失败，必须同时查看日志、代码对象数和语法检查。

PE 检查使用 `rabin2 -I -S -i -E -j "$analysis_dir/RCBldEng.exe"`，PYD 替换为同目录 `pyarmor_runtime.pyd`。若使用解包的官方 deb，需要将其 `usr/bin` 加入 PATH，并设置 `LD_LIBRARY_PATH` 为其 `usr/lib`。

## 验证记录

已从原件用本包脚本重新提取，并重跑同一固定工具版本。5 份 `.das` 均与首次恢复逐字节一致，具体哈希和命令见 [recovery-validation.json](evidence/recovery-validation.json)。这是提取与恢复的可重复性验证，不是独立反编译器交叉验证。

自动草稿只进行 `ast.parse` / `compile(..., 'exec')`，没有 `exec` 或导入；4 份发生语法错误，入口草稿只有注释、零函数。原始日志中 209 行匹配 `warning|error|failed|unsupported`，该数量不等于 209 个独立缺陷。失败输出保留，未修改草稿迎合检查。

证据图和哈希由已安装技能执行只读检查：

```bash
uv run --no-project --python 3.12 python \
  /home/ubuntu/.codex/skills/reverse-skill-router/repository/skills/case-review/scripts/review_case.py \
  docs/reconstruction/artifacts/engine-v1.3.0 --verify-hashes --strict
```

最终检查记录见 [case-review.md](report/case-review.md)。提取成功路径、错误指纹拒绝、已有输出保护、原件与证据哈希、技能安装及相对链接检查见 [delivery-validation.json](report/delivery-validation.json)；新增脚本的 Ruff 规则和格式检查通过。仍未覆盖 Windows 加载、许可检查、完整输入接受、仿真数值、Rhino/GH 生命周期和全部计算分支。
