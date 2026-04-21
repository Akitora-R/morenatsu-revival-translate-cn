# 漏夏 Revival 中文翻译项目

> 将旧版 Kirikiri (吉里吉里) 引擎的 `.ks` 剧本翻译整合到新版 Ren'Py 的 `.rpy` 文件中。

## 项目概要

旧版游戏（2017年）的 `.ks` 剧本文件中包含中文翻译，新版 Ren'Py 引擎（2019年）中 `.rpy` 文件的翻译均为空。
本项目的工作是：比对旧版 KS 翻译内容，将其对齐并填入新版 RPY 的空翻译 block 中。

### 翻译流程

```
┌──────────────┐    ┌──────────────────┐    ┌──────────────┐
│  1. 提取文本   │───▶│  2. 人工对齐翻译表  │───▶│  3. 写入 RPY  │
│   init       │    │   update         │    │   apply      │
└──────────────┘    └──────────────────┘    └──────────────┘
       │                    │                       │
  从 .rpy 提取         比对 .ks 翻译          把翻译表内容
  所有 translate       按 block ID 对齐       写回 .rpy 文件
  block → JSONL        → JSONL               自动处理 marker
                                                 和缩进
```

### 核心规则

1. **优先使用旧版翻译**：所有翻译以 `extract/` 下 `.ks` 文件为准
2. **新增内容标记**：旧版中不存在的台词，使用机翻或人工翻译，标记类型为 `机翻` 或 `人工`
3. **翻译来源注释**：每条翻译上方自动插入注释，格式 `# [旧版翻译] 来源: 3日目.ks (KS 18-19)`
4. **占位符保留**：Ren'Py 变量如 `[fn]`、`[ln]`、`[漏れ]` 等保持原样

## 快速开始

```bash
# 环境设置
uv sync
source .venv/bin/activate

# 查看翻译进度
python scripts/translate.py status

# 从 RPY 文件初始化翻译表（仅首次）
python scripts/translate.py init

# 提取旧版 KS 文本（用于比对参考）
python scripts/extract_texts.py --mode ks --ks-dirs extract/orig extract/torahiko
```

## 翻译管理脚本 `translate.py`

所有翻译操作通过 `translate.py` 的子命令完成。

### `init` — 从 RPY 文件初始化翻译表

从所有 `rpy/` 目录下的 `.rpy` 文件中提取 `translate` block，生成 `translation_table.jsonl`。
已有条目不会被覆盖，可安全重复运行。

```bash
python scripts/translate.py init
```

### `status` — 查看翻译进度

```bash
python scripts/translate.py status
```

### `export-untranslated` — 导出未翻译条目

```bash
# 导出指定路线
python scripts/translate.py export-untranslated --prefix candy03

# 导出指定文件
python scripts/translate.py export-untranslated --file "day 3.rpy"
```

### `update` — 更新翻译表

**单条更新**：
```bash
python scripts/translate.py update \
    --block-id torahiko03_57e52401 \
    --translation "你好" --type "旧版翻译" \
    --source "3日目.ks" --ks-lines "18-19"
```

**批量更新**（JSONL 格式）：
```bash
# 每行一个 JSON 对象：{"id":"xxx","translation":"xxx","translation_type":"旧版翻译","translation_source":"深_s_01.ks","ks_lines":"18"}
python scripts/translate.py update --batch updates.jsonl
```

### `apply` — 将翻译写回 RPY 文件

```bash
# 预览修改（不写入文件）
python scripts/translate.py apply --dry-run

# 写入指定文件
python scripts/translate.py apply --file "day 3.rpy"

# 写入指定天数及之后的文件
python scripts/translate.py apply --start-day 3

# 写入所有文件
python scripts/translate.py apply
```

`apply` 会自动处理：
- 插入 `# [旧版翻译] 来源: 文件名 (KS 行号)` 注释
- 正确保留 narration（4空格+引号）和 speaker（4空格+发言者+引号）的缩进
- 跳过 `translate chinese_simplified strings:` 块（`old`/`new` 格式）
- 覆盖已有的旧翻译（如有标记则更新）

### `embed` — 计算文本向量嵌入（可选）

```bash
python scripts/translate.py embed --model paraphrase-multilingual:278m
python scripts/translate.py embed --model paraphrase-multilingual:278m --file "day 3.rpy"
```

## 翻译表格式

`translation_table.jsonl` 每行一个 JSON 对象，按 `rpy_file` + `source_line` 排序。

```json
{
  "id": "torahiko03_57e52401",
  "rpy_file": "day 3.rpy",
  "source_line": 99,
  "speaker": "gm",
  "source": "「Hello. This is [ln] speaking...」",
  "translation": "「你好，这里是[西村]家。」",
  "translation_type": "旧版翻译",
  "translation_source": "3日目.ks",
  "ks_lines": "18-19",
  "embedding": null
}
```

| 字段 | 说明 |
|------|------|
| `id` | translate block ID（唯一键） |
| `rpy_file` | 源 RPY 文件名 |
| `source_line` | RPY 文件中对应的行号 |
| `speaker` | 发言者前缀（`fn`/`gm`/`ka` 等），空字符串表示旁白 |
| `source` | 英文原文 |
| `translation` | 中文翻译，空字符串表示未翻译 |
| `translation_type` | `"旧版翻译"` / `"机翻"` / `"人工"` / `""` |
| `translation_source` | 来源文件或模型（如 `"3日目.ks"`、`"gpt-4o"`） |
| `ks_lines` | 旧版 KS 源文件中的行号范围（如 `"18-19"`） |
| `embedding` | 文本向量，`null` 表示未计算 |

## 文件结构

```
├── rpy/                          # Ren'Py 翻译文件（目标）
├── extract/
│   ├── orig/                     # 旧版 KS 中文翻译（源）
│   └── torahiko/                 # 部分路线的旧版翻译
├── scripts/
│   ├── translate.py              # 翻译管理核心脚本
│   ├── extract_texts.py          # 文本提取（KS/RPY）
│   └── generate_mapping.py       # 路线映射生成
├── output/
│   └── texts/
│       └── ks_texts/             # 提取的 KS 文本（JSONL）
├── docs/
│   └── route_differences.md      # 路线差异对比文档
└── translation_table.jsonl       # 翻译表（核心数据）
```

## Speaker 映射

| RPY 前缀 | 日文名 | 角色 |
|----------|--------|------|
| `fn` | 博行 | 主人公 |
| `gm` | 奶奶 | 奶奶 |
| `ka` | 洸哉 | 洸哉 |
| `ky` | 京慈 | 京慈 |
| `to` | 虎彦 | 虎彦 |
| `ta` | 辰樹 | 辰樹 |
| `si` | 深 | 深 |
| `su` | 峻 | 峻 |
| `kn` | 孝之助 | 孝之助 |
| `ju` | 柔一 | 柔一 |
| `so` | 宗太郎 | 宗太郎 |

## 翻译进度

| 文件 | 已翻译 | 总数 | 状态 |
|------|--------|------|------|
| Welcome Party.rpy | 1336 | 1380 | 96.8% |
| day 3.rpy | 419 | 422 | 99.3% |
| day 2.rpy | 864 | 1076 | 80.3% |
| 其他 26 个文件 | 8 | ~29000 | 待处理 |
| **合计** | **2629** | **34191** | **7.7%** |
