# 项目架构

Kirikiri `.ks` 旧版脚本 → Ren'Py `.rpy` 新版翻译目标。

```
extract/
├── orig/       # 公共路线 KS
└── torahiko/   # 虎彦专属路线 KS（同文件名时优先）
rpy/            # 翻译目标 RPY
```

# 翻译工作流

## 核心原则

> **绝对禁止任何形式的自动匹配。** KS 与 RPY 是多对多关系，逐行号对应会产生链式偏移。
> 链式偏移的根因：RPY 英文对话顺序 ≠ KS 中文对话行号顺序。任何基于行号增量或 LLM 的对齐都会产生系统性错误。

## 正确流程

### 第1步：定位 KS 源文件
根据 `rpy/day X.rpy` 中的 `translate chinese_simplified xxx_` 前缀确定角色，对照路由映射表找到 `.ks` 文件。

### 第2步：逐条手工匹配
对每条 translation_table 条目，**手动**在对应 KS 文件中找到与该 EN 文本语义对应的 CN 行：

```bash
grep "中文文本片段" extract/路径/文件名.ks
sed -n '行号p' extract/路径/文件名.ks
```

匹配依据（按优先级）：
1. **说话人匹配** — EN 的 `speaker` 字段必须与 KS 中 `【名字】` 一致（见说话人对照表）
2. **语义匹配** — 对话含义相同
3. **顺序一致性** — RPY 条目按 `source_line` 排序后的对话顺序应与 KS 文件中的对话顺序一致

### 第3步：写入修复 JSONL
```jsonl
{"id":"条目ID","translation":"KS中的CN文本","translation_type":"旧版翻译","translation_source":"extract/路径/文件名.ks","ks_lines":"行号"}
```
- `translation_type` 取值：`旧版翻译` | `原版缩写`(EN为压缩版本) | `原版扩写` | `机翻` | `人工`
- `ks_lines` 必须指向**对话内容行**，不能只指向 `【说话人】` 头行
- 提取 CN 时过滤 `【说话人】` 头、`;注释`、舞台指令 `[...]`，保留 `[漏れ]` `[咱]` `[博行]` `[fn]` `[ln]` `[西村]` `[l]` `[wdt]` 等占位符

### 第4步：应用
```bash
python scripts/translate.py update --batch fix.jsonl
python scripts/translate.py apply --file "day X.rpy"
```

### 第5步：验证 — 说话人匹配法
链式偏移最可靠的检测手段是 EN 说话人 vs CN 说话人对比：

```python
import json, re
speaker_map = {
    'fn': ['博行','主人公'], 'to': ['虎彦'], 'ta': ['辰樹','辰树'],
    'su': ['峻'], 'ka': ['洸哉'], 'ko': ['孝之助'],
    'ju': ['柔一'], 'si': ['深'], 'so': ['宗太郎'], 'ky': ['京慈'],
}
# 如果 EN speaker 与 CN 首行【说话人】不匹配，则为链式偏移
```

随机抽查 20 条检查，循环直到**连续 3 轮 0 错误**。

## 说话人对照表

| EN speaker | CN 说话人 |
|-----------|----------|
| fn | 博行 / 主人公 |
| to | 虎彦 |
| ta | 辰樹 / 辰树 |
| su | 峻 |
| ka | 洸哉 |
| ko | 孝之助 |
| ju | 柔一 |
| si | 深 |
| so | 宗太郎 |
| ky | 京慈 |
| who | ？？？ |

## 占位符

| 占位符 | 含义 |
|--------|------|
| `[fn]` | 主角名 |
| `[ln]` | 主角姓 |
| `[漏れ]` | 第一人称 |
| `[咱]` | 第一人称（简体） |
| `[博行]` | 主角名 |
| `[西村]` | 主角姓 |
| `[l]` `[wdt]` `[wds]` | 等待/暂停标记 |
| `[nor]` `[rd]` | 换行/回行标记 |

## 关键教训

1. **链式偏移是最常见的错误类型** — 一次匹配错误会导致整个路段的所有条目系统性偏移 2~3 行，EN 对话被映射到相邻角色的 CN 文本
2. **ks_lines 必须指向对话行** — 不能只指向 `【说话人】` 头所在行
3. **translate.py update 只更新指定字段** — 必须同时在 batch JSONL 中提供 `translation` 和 `ks_lines`
4. **不要依赖 LLM sub-agent 做全路段匹配** — 会产生链式偏移，错误率 10%~25%
5. **验证比匹配更重要** — 每轮修复后必须重新随机抽查
6. **禁止自动匹配脚本** — 曾导致 Day 12 偏移达 50+ 行，Day 15 偏移 96 条

## Day 15 路由映射（已验证）

| RPY 前缀 | KS 源文件 | 条目数 |
|---------|----------|--------|
| camp15_torahiko* | extract/torahiko/15日目.ks | ~200 |
| camp15_wakeup_* / camp15_explore / camp15_* (所有其他路由) / camp15_confess_* / camp15_packup | extract/orig/キャンプ02.ks | ~1311 |

キャンプ02.ks 中包含以下路由段：
- `*tatuki-camp2asa` ~ `*kounosuke-camp2asa` (唤醒，6个角色，L42-657)
- `*asobou` (早餐后讨论，L827-935)
- `*wani` (辰樹探险队，L938-1459)
- `*shun-camp2asobu` (峻路线，L1462-1801)
- `*kouya-camp2asobu` (洸哉路线，L2195-3044)
- `*juichi-camp2asobu` (柔一路线，L3047-3699)
- `*shin-camp2asobu` (深路线，L3700-4216)
- `*kounosuke-camp2asobu` (孝之助路线，L4217-5084)
- `*atokataduke` ~ `*yuyake` (收拾/黄昏/告白，L5085-6175)

## Day 13 路由映射（已验证）

| RPY 前缀 | KS 源文件 | 条目数 |
|---------|----------|--------|
| day13 | extract/orig/13日目.ks | 1 |
| shun13 / shun13_play / shun13_alone / shun13_carpenters / shun13_gohome / shun13_surprise | extract/orig/峻_s_01.ks | 174 |
| tatsuki13 / tatsuki13_tatsuki / tatsuki13_torahiko / tatsuki13_* | extract/orig/辰樹_s_04.ks | 346 |

13日目.ks 通过 `storage=` 引入外部文件：`storage="辰樹_s_04.ks"` 和 `storage="峻_s_01.ks"`。
