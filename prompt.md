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
├── torahiko/               # 虎彦路线专属脚本
├── 洸哉/                   # 洸哉路线专属脚本 (如有)
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
| `river02` | 洸哉 | `extract/orig/洸哉_s_01.ks` |
| `tatsuki02` | 辰樹 | `extract/orig/辰樹_m_01.ks` |
| `juuichi02` | 柔一 | `extract/orig/柔一_m_01.ks` |

## 角色脚本命名规则

- `<角色>_m_XX.ks` — 主线事件 (main)，数字越大进度越后
- `<角色>_s_XX.ks` — 散步/支线事件 (stroll)
- `<角色>_m_n.ks` — 特殊/通用主线

## 翻译工作流

1. 确定要翻译的 `.rpy` 文件和其中的标签 (如 `shin02`)
2. 在 `extract/` 中找到对应的 `.ks` 源文件
3. 按英文原文顺序匹配旧版中文翻译
4. 将翻译填入 `.rpy` 中的空字符串 `""`
5. 添加 `# [旧版翻译]` 注释标记
6. 旧版中不存在的内容 → 机翻 + `# [机翻-新内容]` 注释

## 占位符对照

| 占位符 | 含义 |
|--------|------|
| `[fn]` | 主角名 (first name) |
| `[ln]` | 主角姓 (last name) |
| `[漏れ]` | 第一人称代词 (旧版翻译中保留) |
