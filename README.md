# 漏夏 Revival 中文翻译项目

> 将旧版 Kirikiri (吉里吉里) 引擎的 `.ks` 剧本翻译整合到新版 Ren'Py 的 `.rpy` 文件中。

## 翻译进度

### Day 2

- [x] 虎彦 (`torahiko02`)
- [x] 深 (`shin02`)
- [x] 孝之助 (`kounosuke02`)
- [x] 洸哉 (`river02`)
- [x] 辰樹 (`tatsuki02`)
- [x] 柔一 (`juuichi02`)

### Day 1 ~ Day 30

- [x] Welcome Party
- [x] Day 2
- [ ] Day 3
- [ ] Day 4
- [ ] Day 5
- [ ] Day 6
- [ ] Day 7
- [ ] Day 8
- [ ] Day 9
- [ ] Day 10
- [ ] Day 11
- [ ] Day 12
- [ ] Day 13
- [ ] Day 14
- [ ] Day 15
- [ ] Day 16
- [ ] Day 17
- [ ] Day 18
- [ ] Day 19
- [ ] Day 20
- [ ] Day 21
- [ ] Day 22
- [ ] Day 23
- [ ] Day 24
- [ ] Day 25
- [ ] Day 26
- [ ] Day 27
- [ ] Day 28
- [ ] Day 29
- [ ] Day 30

### 其他

- [ ] Welcome Party
- [ ] Endings
- [ ] Replay
- [ ] Save-Load
- [ ] 系统界面 (screens, options 等)

## 翻译规则

1. **优先使用旧版翻译**：所有翻译严格以 `extract/` 下的 `.ks` 文件为准
2. **新内容机翻**：旧版中不存在的台词，结合上下文进行机翻
3. **注释标记**：每条翻译上方添加 `# [旧版翻译]` 或 `# [机翻-新内容]` 注释
4. **占位符保留**：Ren'Py 变量如 `[fn]`、`[ln]`、`[漏れ]` 等保持原样

## 辅助工具

使用 `uv` 管理虚拟环境，避免污染系统。

### 环境设置

```bash
uv sync
source .venv/bin/activate
```

### 文本提取

从 `.rpy` 和 `.ks` 文件中提取已翻译/未翻译文本，按路线分类输出到 `output/texts/`：

```bash
# 提取所有文本
python scripts/extract_texts.py --mode both

# 仅提取 .rpy 文本
python scripts/extract_texts.py --mode rpy

# 仅提取 .ks 文本
python scripts/extract_texts.py --mode ks
```

输出结构：
```
output/texts/
├── translated/          # 已翻译文本 (按路线分 .jsonl)
├── untranslated/        # 未翻译文本 (按路线分 .jsonl)
├── ks_texts/            # 旧版 .ks 文本 (按路线分 .jsonl)
└── summary.json         # 统计摘要
```

### 向量嵌入

使用 Ollama 或 OpenAI 兼容 API 生成文本向量，用于相似度匹配辅助翻译：

```bash
# 使用 Ollama (默认 qwen3-embedding:8b)
python scripts/embed_texts.py

# 仅嵌入未翻译文本
python scripts/embed_texts.py --type untranslated

# 使用 OpenAI 兼容 API
python scripts/embed_texts.py --mode openai \
  --base-url https://api.example.com/v1 \
  --api-key your-key \
  --model text-embedding-3-small

# 自定义模型和批量大小
python scripts/embed_texts.py --model qwen3-embedding:8b --batch-size 100
```

输出结构：
```
output/embeddings/
├── translated/          # 已翻译文本向量
├── untranslated/        # 未翻译文本向量
└── ks_texts/            # 旧版文本向量
```

每个 `.jsonl` 条目包含原始字段 + `embedding` 向量 (4096 维)。支持断点续传。
