# 项目架构与翻译文件映射

## 引擎迁移

| 旧版 | 新版 |
|------|------|
| Kirikiri (吉里吉里) `.ks` | Ren'Py `.rpy` |

## 目录结构

```
extract/                    # 旧版 Kirikiri 解包脚本
├── orig/                   # 公共脚本 & 角色路线
│   ├── X日目.ks            # 每日地图选择控制
│   ├── 角色_m_XX.ks        # 角色主线事件 (m = main)
│   ├── 角色_s_XX.ks        # 角色支线事件 (s = stroll)
│   └── 系统脚本...
├── torahiko/               # 虎彦路线专属（完整翻译，同文件名时优先）
└── ...

rpy/                        # 新版 Ren'Py 翻译目标
├── day X.rpy               # 第X天所有路线合并
├── common.rpy              # 公共文本
├── Endings.rpy             # 结局
├── screens.rpy             # UI 界面
└── 其他系统文件
```

## 第 2 天文件映射

Ren'Py 的 `rpy/day 2.rpy` 合并了旧版多个 `.ks` 文件的内容：

| Ren'Py 标签 | 角色 | 旧版来源 |
|-------------|------|----------|
| `torahiko02` | 虎彦 | `extract/torahiko/2日目.ks` |
| `shin02` | 深 | `extract/orig/深_m_01.ks` |
| `kounosuke02` | 孝之助 | `extract/orig/孝之助_m_01.ks` |
| `kouya02` | 洸哉 | `extract/orig/洸哉_s_01.ks` |
| `tatsuki02` | 辰樹 | `extract/orig/辰樹_m_01.ks` |
| `juuichi02` | 柔一 | `extract/orig/柔一_m_01.ks` |

## 角色脚本命名规则

- `<角色>_m_XX.ks` — 主线事件 (main)，数字越大进度越后
- `<角色>_s_XX.ks` — 散步/支线事件 (stroll)
- `<角色>_m_n.ks` — 特殊/通用主线

## 翻译工作流

> ⚠️ **关键**：KS 与 RPY 是多对多关系，**绝对禁止按行号顺序自动匹配**。必须逐条手工比对语义！

1. 确定要翻译的 `.rpy` 文件和其中的标签 (如 `shin02`)
2. 在 `extract/` 中找到对应的 `.ks` 源文件（见各天文件映射表）
3. **逐条手工匹配**：对每条 EN 文本，在 KS 文件中 `grep` 搜索对应 CN 文本
4. 将匹配到的翻译通过 `translate.py update --batch` 写入翻译表
5. 运行 `translate.py apply` 写回 `.rpy`，自动添加 `# [旧版翻译]` 标记
6. 随机抽查 10 条验证 → 循环直到连续 3 次 0 错误
7. 旧版 KS 中不存在的内容使用 LLM 机翻，标记 `translation_type: "机翻"`

## 占位符对照

| 占位符 | 含义 |
|--------|------|
| `[fn]` | 主角名 (first name) |
| `[ln]` | 主角姓 (last name) |
| `[漏れ]` | 第一人称代词 (旧版翻译中保留) |

---

# ⚠️ 手工重匹配规范 — 必须严格遵守

## 核心禁令

> **绝对禁止使用任何自动匹配算法！**

自动匹配算法（包括嵌入向量匹配、LLM自动对齐等）在处理多分支路由（如Day 11的tennis/dodge/swimming）时会产生**60-70%的错误率**。所有KS到RPY的映射必须手工逐条完成。

## 成功方法论（Day 11 验证通过）

### 第一步：搜索正确的KS行号

对于每条条目（EN+CN配对），**必须**手动在对应KS文件中搜索CN文本：

```bash
# 在对应KS文件中搜索中文文本
grep "中文文本片段" extract/路径/文件名.ks

# 确认返回的行号包含完整的中文内容
cat extract/路径/文件名.ks | sed -n '行号p'
```

### 第二步：创建修复JSONL

将搜索结果写入JSONL修复文件：

```jsonl
{"id":"条目ID","translation_source":"extract/路径/文件名.ks","ks_lines":"行号"}
```

### 第三步：应用修复

```bash
python scripts/translate.py update --batch fix_file.jsonl
python scripts/translate.py apply --file "文件名.rpy"
```

### 第四步：抽查验证

随机抽查10条，检查ks_lines是否已填充：

```python
import json, random
entries = [json.loads(line) for line in open('translation_table.jsonl')]
target = [e for e in entries if e.get('rpy_file') == 'target.rpy' and e.get('translation')]
samples = random.sample(target, 10)
errors = sum(1 for e in samples if not e.get('ks_lines'))
print(f'Errors: {errors}/10')
```

### 第五步：循环直到连续3次0错误

重复步骤1-4，**直到连续3次随机抽查结果全部为0错误**。

## 关键教训

1. **不要信任自动匹配** — 多分支路由（tennis/dodge/swimming等）无法用算法自动处理
2. **发现错误立即修复** — 不要只报告而不修复
3. **分批小批量处理** — 每次5-10条，持续循环
4. **EN和CN是独立翻译** — 内容相似但不一定逐行对应，语义相近即可接受
5. **使用 `grep` 手动搜索** — 不要依赖agents进行大规模搜索，直接grep更快更准

## Day 11 路由对应关系（已验证）

| RPY前缀 | KS源文件 | 条目数 | 状态 |
|---------|----------|--------|------|
| torahiko11 | extract/torahiko/11日目.ks | 346 | ✅ 已完成 |
| tatsuki11 | extract/orig/辰樹_s_03.ks | 305 | ✅ 已完成 |
| shin11 | extract/orig/深_s_02.ks | 91 | ✅ 已完成 |
| juuichi11 | extract/orig/柔一_s_01.ks | 261 | ✅ 已完成 |

## Day 12 路由对应关系（已验证）

| RPY前缀 | KS源文件 | 条目数 | 状态 |
|---------|----------|--------|------|
| torahiko12 | extract/torahiko/12日目.ks | 171 | ✅ 已完成 |
| juuichi12 | extract/orig/柔一_s_02.ks | 199 | ✅ 已完成 |
| kouya12 | extract/orig/洸哉_s_05.ks | 373 | ✅ 已完成 |
| tatsuki12 (主线) | extract/orig/辰樹_m_03.ks | 212 | ✅ 已完成 |
| tatsuki12_force | extract/orig/辰樹_m_03.ks | 84 | ✅ 已完成 |
| tatsuki12_quiet | extract/orig/辰樹_m_03.ks | 31 | ✅ 已完成 |
| tatsuki12_shigure | extract/orig/辰樹_m_03.ks | 66 | ✅ 已完成 |
| tatsuki12_tappei | extract/orig/辰樹_m_03.ks | 61 | ✅ 已完成 |

> ⚠️ **辰樹_m_03.ks 包含4条分支路线**（force/quiet/shigure/tappei），对应KS行号段不同，必须在修复JSONL中逐条指明 `ks_lines` 而非依赖自动计算。

## Day 12 关键教训

### 1. 已翻译条目≠已正确匹配
tatsuki12 原有 35 条带 `ks_lines` 的翻译，其中仅前 8 条（0-7）匹配正确，剩余 27 条（8-34）被自动匹配算法**系统性偏移**（偏移量从 2 行逐步扩大到 50+ 行），CN文本与EN语义完全不对应。

### 2. 偏移量非线性增长
自动匹配的偏移不是常数——随着KS文件中的空行、注释行、舞台指令行增多，偏移逐步累积。辰樹_m_03.ks 中条目 131+ 的偏移量达 40-50 行，导致翻译指向完全错误的场景（如 "Guh, ow..." 的疼痛感叹被映射到 "加班" 讨论）。

### 3. `translate.py update` 只更新指定字段
仅更新 `ks_lines` 不会自动从KS提取翻译。必须同时在 batch JSONL 中提供 `translation` 字段。提取翻译时需过滤 `【说话人】` 头、`;注释`、`[舞台指令]`，保留 `[咱]`/`[博行]`/`[fn]`/`[ln]` 等占位符。

### 4. 分支路由的 ks_lines 补全策略
force/quiet/shigure/tappei 分支条目的RPY文件已有正确CN文本（来自之前的 apply），但 translation_table 缺少 `ks_lines`。可以直接从 RPY 的CN文本反向搜索 KS 对应行号，无需重新翻译。

### 5. 验证必须覆盖所有子分支
Day 12 共 1198 条，单次 `apply` 曾只写入 778 条（遗漏了 tatsuki12 的 419 条未翻译项）。修复后 `apply` 写入 1197 条（仅 1 条为有意空白的停顿条目）。

## Day 13 路由对应关系（已验证）

| RPY前缀 | KS源文件 | 条目数 | 状态 |
|---------|----------|--------|------|
| day13 | extract/orig/13日目.ks | 1 | ✅ 已完成 |
| shun13 / shun13_play | extract/orig/峻_s_01.ks | 174 | ✅ 已完成 |
| tatsuki13 / tatsuki13_tatsuki / tatsuki13_torahiko | extract/orig/辰樹_s_04.ks | 346 | ✅ 已完成 |

> **13日目.ks 引入外部文件**：`storage="辰樹_s_04.ks"`（辰樹路线）和 `storage="峻_s_01.ks"`（峻路线）。shun13 的分支（play/alone/carpenters/gohome/surprise）均在同一个 `峻_s_01.ks` 内通过 `*label` 标签跳转实现。
