# 原版与新版本路线差异对比文档

> 本文档以 RPY 文件为准，对比原版 Kirikiri (.ks) 脚本与新版本 Ren'Py (.rpy) 脚本的路线差异。
> 涵盖：Day 文件、Welcome Party、Endings、Replay 以及特殊 KS 文件（キャンプ、海水浴、エンディング等）。

## 目录

- [总览](#总览)
- [各天详细对比](#各天详细对比)
  - [Day 2](#day-2)
  - [Day 3](#day-3)
  - [Day 4](#day-4)
  - [Day 5](#day-5)
  - [Day 6](#day-6)
  - [Day 7](#day-7)
  - [Day 8](#day-8)
  - [Day 9](#day-9)
  - [Day 10](#day-10)
  - [Day 11](#day-11)
  - [Day 12](#day-12)
  - [Day 13](#day-13)
  - [Day 14](#day-14)
  - [Day 15](#day-15)
  - [Day 16](#day-16)
  - [Day 17](#day-17)
  - [Day 18](#day-18)
  - [Day 19](#day-19)
  - [Day 20](#day-20)
  - [Day 21](#day-21)
  - [Day 22](#day-22)
  - [Day 23](#day-23)
  - [Day 24](#day-24)
  - [Day 25](#day-25)
  - [Day 26](#day-26)
  - [Day 27](#day-27)
  - [Day 28](#day-28)
  - [Day 29](#day-29)
  - [Day 30](#day-30)
  - [Welcome Party](#welcome-party)
  - [Endings](#endings)
  - [Replay](#replay)
  - [nameinput](#nameinput)
  - [キャンプ01.ks](#キャンプ01.ks)
  - [キャンプ02.ks](#キャンプ02.ks)
  - [c_海水浴.ks](#c_海水浴.ks)
  - [オープニング.ks](#オープニング.ks)
  - [エンディング.ks](#エンディング.ks)
  - [オープニング.ks](#オープニング.ks)
  - [エンディング.ks](#エンディング.ks)
- [特殊文件对比](#特殊文件对比)
  - [Welcome Party](#welcome-party)
  - [Endings](#endings)
  - [Replay](#replay)
  - [nameinput](#nameinput)
  - [キャンプ01.ks](#キャンプ01.ks)
  - [キャンプ02.ks](#キャンプ02.ks)
  - [c_海水浴.ks](#c_海水浴.ks)
  - [オープニング.ks](#オープニング.ks)
  - [エンディング.ks](#エンディング.ks)
  - [オープニング.ks](#オープニング.ks)
  - [エンディング.ks](#エンディング.ks)
- [新增路线汇总](#新增路线汇总)
- [删除路线汇总](#删除路线汇总)

## 总览

| 文件/天数 | 类型 | RPY 标签数 | 旧版存在标签 | 新版独有标签 | 旧版存在条目 | 新版独有条目 |
|-----------|------|-----------|-------------|-------------|-------------|-------------|
| Day 2 | Day | 19 | 6 | 13 | 11 | 200 |
| Day 3 | Day | 7 | 3 | 4 | 298 | 114 |
| Day 4 | Day | 19 | 5 | 14 | 433 | 310 |
| Day 5 | Day | 11 | 2 | 9 | 162 | 283 |
| Day 6 | Day | 18 | 2 | 16 | 213 | 783 |
| Day 7 | Day | 23 | 1 | 22 | 302 | 1354 |
| Day 8 | Day | 13 | 3 | 10 | 121 | 521 |
| Day 9 | Day | 28 | 6 | 22 | 450 | 592 |
| Day 10 | Day | 22 | 5 | 17 | 416 | 447 |
| Day 11 | Day | 19 | 4 | 15 | 593 | 463 |
| Day 12 | Day | 18 | 4 | 14 | 546 | 646 |
| Day 13 | Day | 16 | 2 | 14 | 42 | 478 |
| Day 14 | Day | 1 | 0 | 1 | 0 | 400 |
| Day 15 | Day | 28 | 1 | 27 | 163 | 1335 |
| Day 16 | Day | 31 | 0 | 31 | 0 | 2131 |
| Day 17 | Day | 14 | 0 | 14 | 0 | 685 |
| Day 18 | Day | 8 | 0 | 8 | 0 | 301 |
| Day 19 | Day | 11 | 0 | 11 | 0 | 557 |
| Day 20 | Day | 27 | 0 | 27 | 0 | 1329 |
| Day 21 | Day | 16 | 0 | 16 | 0 | 868 |
| Day 22 | Day | 36 | 0 | 36 | 0 | 3147 |
| Day 23 | Day | 9 | 0 | 9 | 0 | 801 |
| Day 24 | Day | 22 | 0 | 22 | 0 | 896 |
| Day 25 | Day | 8 | 0 | 8 | 0 | 563 |
| Day 26 | Day | 15 | 0 | 15 | 0 | 1791 |
| Day 27 | Day | 11 | 0 | 11 | 0 | 769 |
| Day 28 | Day | 13 | 0 | 13 | 0 | 893 |
| Day 29 | Day | 21 | 0 | 21 | 0 | 2459 |
| Day 30 | Day | 29 | 0 | 29 | 0 | 2513 |
| Welcome Party | 特殊RPY | 10 | 0 | 10 | 0 | 44 |
| Endings | 特殊RPY | 17 | 0 | 17 | 0 | 46 |
| Replay | 特殊RPY | 1 | 0 | 1 | 0 | 102 |
| nameinput | 特殊RPY | 3 | 0 | 3 | 0 | 0 |
| キャンプ01.ks | 特殊KS | 0 | 0 | 0 | 0 | 0 |
| キャンプ02.ks | 特殊KS | 0 | 0 | 0 | 0 | 0 |
| c_海水浴.ks | 特殊KS | 0 | 0 | 0 | 0 | 0 |
| オープニング.ks | 特殊KS | 0 | 0 | 0 | 0 | 0 |
| エンディング.ks | 特殊KS | 0 | 0 | 0 | 0 | 0 |
| オープニング.ks | 特殊KS | 0 | 0 | 0 | 0 | 0 |
| エンディング.ks | 特殊KS | 0 | 0 | 0 | 0 | 0 |

## 各天详细对比

### Day 2

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 2日目.ks (虎彦路线) | torahiko |
| 其他 | 3日目.ks | torahiko |
| 其他 | 3日目.ks | orig |
| 辰樹 | 辰樹_m_01.ks | orig |
| 孝之助 | 孝之助_m_01.ks | orig |
| 洸哉 | 洸哉_s_01.ks | orig |
| 深 | 深_m_01.ks | orig |
| 柔一 | 柔一_m_01.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day02 | 未知 | ８月２日 | 1 | ✗ 新版独有 |
| end02 | 未知 | - | 0 | ✗ 新版独有 |
| juuichi02 | 柔一 | Meeting on the Second Day | 1 | ✓ 旧版存在 |
| kounosuke02 | 孝之助 | At the bookstore | 1 | ✓ 旧版存在 |
| river02 | 洸哉 | Let's Cool Off at the Riverbed | 0 | ✓ 旧版存在 |
| river02_can_remember | 未知 | Oh, I remember! | 25 | ✗ 新版独有 |
| river02_cannot_remember | 未知 | Hmm, I can't remember | 35 | ✗ 新版独有 |
| river02_memory | 未知 | A Story from Long Ago | 89 | ✗ 新版独有 |
| river02_story_time | 未知 | Calling, Somewhere from Within | 36 | ✗ 新版独有 |
| shin02 | 深 | Old Memories and a Capricious Cat | 0 | ✓ 旧版存在 |
| shin02_actually_cheap | 未知 | - | 0 | ✗ 新版独有 |
| shin02_amaki_recipe | 未知 | Exploring the Mansion | 0 | ✗ 新版独有 |
| shin02_an_import | 未知 | - | 0 | ✗ 新版独有 |
| shin02_something_handmade | 未知 | - | 0 | ✗ 新版独有 |
| tatsuki02 | 辰樹 | Playing with Tatsu-nii | 7 | ✓ 旧版存在 |
| tatsuki02_coworkers | 未知 | The One who cares | 9 | ✗ 新版独有 |
| tatsuki02_eat | 未知 | - | 1 | ✗ 新版独有 |
| tatsuki02_hangout | 未知 | Let's go play | 4 | ✗ 新版独有 |
| torahiko02 | 虎彦 | The Village Discovery | 2 | ✓ 旧版存在 |

#### 新版独有路线

- **day02** (未知): 1 条未翻译文本
- **end02** (未知): 0 条未翻译文本
- **river02_can_remember** (未知): 25 条未翻译文本
- **river02_cannot_remember** (未知): 35 条未翻译文本
- **river02_memory** (未知): 89 条未翻译文本
- **river02_story_time** (未知): 36 条未翻译文本
- **shin02_actually_cheap** (未知): 0 条未翻译文本
- **shin02_amaki_recipe** (未知): 0 条未翻译文本
- **shin02_an_import** (未知): 0 条未翻译文本
- **shin02_something_handmade** (未知): 0 条未翻译文本
- **tatsuki02_coworkers** (未知): 9 条未翻译文本
- **tatsuki02_eat** (未知): 1 条未翻译文本
- **tatsuki02_hangout** (未知): 4 条未翻译文本

---

### Day 3

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 3日目.ks (虎彦路线) | torahiko |
| 其他 | 4日目.ks | torahiko |
| 其他 | 4日目.ks | orig |
| 峻 | 峻_m_01.ks | orig |
| 深 | 深_s_01.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| candy03 | 深 | An Incompatible Person | 32 | ✓ 旧版存在 |
| candy03_shin | 未知 | What's Shin-kun's favorite? | 68 | ✗ 新版独有 |
| candy03_tatsuki | 未知 | Do you come here a lot, Tatsu-nii? | 45 | ✗ 新版独有 |
| day03 | 未知 | ８月3日 | 1 | ✗ 新版独有 |
| end03 | 未知 | - | 0 | ✗ 新版独有 |
| shun03 | 峻 | His Strongest Weapon, Once Again | 181 | ✓ 旧版存在 |
| torahiko03 | 虎彦 | The Minosato Guided Tour | 85 | ✓ 旧版存在 |

#### 新版独有路线

- **candy03_shin** (未知): 68 条未翻译文本
- **candy03_tatsuki** (未知): 45 条未翻译文本
- **day03** (未知): 1 条未翻译文本
- **end03** (未知): 0 条未翻译文本

---

### Day 4

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 4日目.ks (虎彦路线) | torahiko |
| 其他 | 5日目.ks | torahiko |
| 其他 | 5日目.ks | orig |
| 辰樹 | 辰樹_s_01.ks | orig |
| 孝之助 | 孝之助_m_02.ks | orig |
| 峻 | 峻_s_05.ks | orig |
| 深 | 深_m_02.ks | orig |
| 柔一 | 柔一_m_02.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day04 | 未知 | ８月4日 | 0 | ✗ 新版独有 |
| day04_phonecall | 未知 | - | 11 | ✗ 新版独有 |
| day04_regularday | 未知 | - | 1 | ✗ 新版独有 |
| end04 | 未知 | - | 0 | ✗ 新版独有 |
| juuichi04 | 柔一 | Firefly's Light, Lamplight, and the Day of a Promise. | 110 | ✓ 旧版存在 |
| juuichi04_rideback | 未知 | I Would Like a Ride Back, Please! | 124 | ✗ 新版独有 |
| kounosuke04 | 孝之助 | Reunion with Yukiharu | 71 | ✓ 旧版存在 |
| shin04 | 未知 | Shin-kun's Shopping | 34 | ✗ 新版独有 |
| shin04_after | 未知 | Imposed Image | 11 | ✗ 新版独有 |
| shin04_commoner | 未知 | - | 4 | ✗ 新版独有 |
| shin04_familial | 未知 | - | 4 | ✗ 新版独有 |
| shun04 | 峻 | Lemonade and Marbles | 90 | ✓ 旧版存在 |
| shun04_biteshun | 未知 | A Bite from Shun-kun | 18 | ✗ 新版独有 |
| shun04_bitesou | 未知 | A Bite from Soutarou-Kun | 32 | ✗ 新版独有 |
| tatsuki04 | 辰樹 | Drunk Dragons | 37 | ✓ 旧版存在 |
| tatsuki04_help | 未知 | Help | 28 | ✗ 新版独有 |
| tatsuki04_party | 未知 | Just a little bit... | 32 | ✗ 新版独有 |
| tatsuki04_scold | 未知 | With Guts! | 11 | ✗ 新版独有 |
| torahiko04 | 虎彦 | Torahiko's Practice | 125 | ✓ 旧版存在 |

#### 新版独有路线

- **day04** (未知): 0 条未翻译文本
- **day04_phonecall** (未知): 11 条未翻译文本
- **day04_regularday** (未知): 1 条未翻译文本
- **end04** (未知): 0 条未翻译文本
- **juuichi04_rideback** (未知): 124 条未翻译文本
- **shin04** (未知): 34 条未翻译文本
- **shin04_after** (未知): 11 条未翻译文本
- **shin04_commoner** (未知): 4 条未翻译文本
- **shin04_familial** (未知): 4 条未翻译文本
- **shun04_biteshun** (未知): 18 条未翻译文本
- **shun04_bitesou** (未知): 32 条未翻译文本
- **tatsuki04_help** (未知): 28 条未翻译文本
- **tatsuki04_party** (未知): 32 条未翻译文本
- **tatsuki04_scold** (未知): 11 条未翻译文本

---

### Day 5

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 5日目.ks (虎彦路线) | torahiko |
| 其他 | 6日目.ks | torahiko |
| 其他 | 6日目.ks | orig |
| 辰樹 | 辰樹_s_06.ks | orig |
| 洸哉 | 洸哉_s_02.ks | orig |
| 柔一 | 柔一_m_03.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day05 | 未知 | ８月5日 | 1 | ✗ 新版独有 |
| end05 | 未知 | - | 0 | ✗ 新版独有 |
| juuichi05 | 柔一 | Pure, Ephemeral, Beautiful | 154 | ✓ 旧版存在 |
| kouya05 | 未知 | Candy Wars | 61 | ✗ 新版独有 |
| kouya05_cheese | 未知 | An Italian Feeling | 25 | ✗ 新版独有 |
| kouya05_salad | 未知 | Unity is Strong | 31 | ✗ 新版独有 |
| kouya05_takoyaki | 未知 | Just Eat | 106 | ✗ 新版独有 |
| tatsuki05 | 辰樹 | - | 8 | ✓ 旧版存在 |
| tatsuki05_accept | 未知 | - | 34 | ✗ 新版独有 |
| tatsuki05_avoid | 未知 | - | 13 | ✗ 新版独有 |
| tatsuki05_busy | 未知 | - | 12 | ✗ 新版独有 |

#### 新版独有路线

- **day05** (未知): 1 条未翻译文本
- **end05** (未知): 0 条未翻译文本
- **kouya05** (未知): 61 条未翻译文本
- **kouya05_cheese** (未知): 25 条未翻译文本
- **kouya05_salad** (未知): 31 条未翻译文本
- **kouya05_takoyaki** (未知): 106 条未翻译文本
- **tatsuki05_accept** (未知): 34 条未翻译文本
- **tatsuki05_avoid** (未知): 13 条未翻译文本
- **tatsuki05_busy** (未知): 12 条未翻译文本

---

### Day 6

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 6日目.ks (虎彦路线) | torahiko |
| 其他 | 7日目.ks | torahiko |
| 其他 | 7日目.ks | orig |
| 辰樹 | 辰樹_s_02.ks | orig |
| 孝之助 | 孝之助_s_02.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day06 | 未知 | ８月6日 | 37 | ✗ 新版独有 |
| day06_accepttest | 未知 | I consent. | 22 | ✗ 新版独有 |
| day06_declinetest | 未知 | - | 12 | ✗ 新版独有 |
| day06_kounotest | 未知 | Gossip-loving Tanuki | 157 | ✗ 新版独有 |
| day06_pick_kounosuke | 未知 | - | 3 | ✗ 新版独有 |
| day06_pick_shun | 未知 | - | 4 | ✗ 新版独有 |
| day06_pick_torahiko | 未知 | - | 3 | ✗ 新版独有 |
| day06_shuntest | 未知 | Small Wolf | 188 | ✗ 新版独有 |
| day06_testbegin | 未知 | Secret of the Seven Wonders | 32 | ✗ 新版独有 |
| day06_testend | 未知 | Heading home | 9 | ✗ 新版独有 |
| day06_testofcourage | 未知 | - | 78 | ✗ 新版独有 |
| day06_toratest | 未知 | The Cowardly Tiger | 169 | ✗ 新版独有 |
| end06 | 未知 | - | 0 | ✗ 新版独有 |
| kounosuke06 | 孝之助 | Right, let's take Paranormal Pictures | 29 | ✓ 旧版存在 |
| torahiko06 | 虎彦 | First time use | 184 | ✓ 旧版存在 |
| torahiko06_delicious | 未知 | Amazing | 19 | ✗ 新版独有 |
| torahiko06_disgusting | 未知 | What should I do...? | 25 | ✗ 新版独有 |
| torahiko06_notgood | 未知 | Pasta should be... | 25 | ✗ 新版独有 |

#### 新版独有路线

- **day06** (未知): 37 条未翻译文本
- **day06_accepttest** (未知): 22 条未翻译文本
- **day06_declinetest** (未知): 12 条未翻译文本
- **day06_kounotest** (未知): 157 条未翻译文本
- **day06_pick_kounosuke** (未知): 3 条未翻译文本
- **day06_pick_shun** (未知): 4 条未翻译文本
- **day06_pick_torahiko** (未知): 3 条未翻译文本
- **day06_shuntest** (未知): 188 条未翻译文本
- **day06_testbegin** (未知): 32 条未翻译文本
- **day06_testend** (未知): 9 条未翻译文本
- **day06_testofcourage** (未知): 78 条未翻译文本
- **day06_toratest** (未知): 169 条未翻译文本
- **end06** (未知): 0 条未翻译文本
- **torahiko06_delicious** (未知): 19 条未翻译文本
- **torahiko06_disgusting** (未知): 25 条未翻译文本
- **torahiko06_notgood** (未知): 25 条未翻译文本

---

### Day 7

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 7日目.ks (虎彦路线) | torahiko |
| 其他 | 8日目.ks | torahiko |
| 其他 | c_海水浴.ks | orig |
| 其他 | 8日目.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| beach07_buckleup | 未知 | - | 15 | ✗ 新版独有 |
| beach07_choice | 未知 | - | 0 | ✗ 新版独有 |
| beach07_hangloose | 未知 | - | 18 | ✗ 新版独有 |
| beach07_invite_juuichi | 未知 | Phone call from Juuichi | 35 | ✗ 新版独有 |
| beach07_invite_kounosuke | 未知 | Phone call from Kounosuke | 25 | ✗ 新版独有 |
| beach07_invite_kouya | 未知 | Phone call from Kouya | 20 | ✗ 新版独有 |
| beach07_invite_shin | 未知 | Phone call from Shin | 22 | ✗ 新版独有 |
| beach07_invite_shun | 未知 | Phone call from Shun | 32 | ✗ 新版独有 |
| beach07_invite_soutarou | 未知 | Phone call from Soutarou | 31 | ✗ 新版独有 |
| beach07_invite_tatsuki | 未知 | Phone call from Big Bro Tatsuki | 14 | ✗ 新版独有 |
| beach07_invite_torahiko | 未知 | Phone call from Torahiko | 26 | ✗ 新版独有 |
| beach07_juuichi | 柔一 | Reckless, Let's Go! Paradise | 395 | ✗ 新版独有 |
| beach07_kounosuke | 孝之助 | Swimming Rings and the sea, that's Summer! | 92 | ✗ 新版独有 |
| beach07_kouya | 洸哉 | Something Floating in the Water | 91 | ✗ 新版独有 |
| beach07_kyoutarou | 京慈 | See-through | 120 | ✗ 新版独有 |
| beach07_meetup | 未知 | Everyone Assemble | 173 | ✗ 新版独有 |
| beach07_packing | 未知 | Did I forget anything? | 29 | ✗ 新版独有 |
| beach07_ridehome | 未知 | Bus Ride Home | 32 | ✗ 新版独有 |
| beach07_shin | 深 | Sunscreen is a Man's Love | 70 | ✗ 新版独有 |
| beach07_shun | 峻 | The Blue Sea! The Shining Sun! And Shun-kun! | 50 | ✗ 新版独有 |
| beach07_tatsuki | 辰樹 | The Beach | 58 | ✗ 新版独有 |
| beach07_torahiko | 虎彦 | With Torahiko | 302 | ✓ 旧版存在 |
| day07 | 未知 | ８月7日 | 6 | ✗ 新版独有 |

#### 新版独有路线

- **beach07_buckleup** (未知): 15 条未翻译文本
- **beach07_choice** (未知): 0 条未翻译文本
- **beach07_hangloose** (未知): 18 条未翻译文本
- **beach07_invite_juuichi** (未知): 35 条未翻译文本
- **beach07_invite_kounosuke** (未知): 25 条未翻译文本
- **beach07_invite_kouya** (未知): 20 条未翻译文本
- **beach07_invite_shin** (未知): 22 条未翻译文本
- **beach07_invite_shun** (未知): 32 条未翻译文本
- **beach07_invite_soutarou** (未知): 31 条未翻译文本
- **beach07_invite_tatsuki** (未知): 14 条未翻译文本
- **beach07_invite_torahiko** (未知): 26 条未翻译文本
- **beach07_juuichi** (柔一): 395 条未翻译文本
- **beach07_kounosuke** (孝之助): 92 条未翻译文本
- **beach07_kouya** (洸哉): 91 条未翻译文本
- **beach07_kyoutarou** (京慈): 120 条未翻译文本
- **beach07_meetup** (未知): 173 条未翻译文本
- **beach07_packing** (未知): 29 条未翻译文本
- **beach07_ridehome** (未知): 32 条未翻译文本
- **beach07_shin** (深): 70 条未翻译文本
- **beach07_shun** (峻): 50 条未翻译文本
- **beach07_tatsuki** (辰樹): 58 条未翻译文本
- **day07** (未知): 6 条未翻译文本

---

### Day 8

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 8日目.ks (虎彦路线) | torahiko |
| 其他 | 9日目.ks | torahiko |
| 其他 | 9日目.ks | orig |
| 孝之助 | 孝之助_s_03.ks | orig |
| 辰樹 | 辰樹_s_07.ks | orig |
| 洸哉 | 洸哉_s_03.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day08 | 未知 | ８月8日 | 14 | ✗ 新版独有 |
| day08_pictures_kouno | 未知 | Someone I know, but don't know | 102 | ✗ 新版独有 |
| day08_pictures_shun | 未知 | The Seventh Wonder | 111 | ✗ 新版独有 |
| day08_pictures_tora | 未知 | Wasn't it Kounosuke..... | 110 | ✗ 新版独有 |
| end08 | 未知 | - | 0 | ✗ 新版独有 |
| kounosuke08 | 孝之助 | Spirit Photography results | 11 | ✓ 旧版存在 |
| kouya08 | 洸哉 | Secret Concert Meeting | 98 | ✓ 旧版存在 |
| kouya08_pass | 未知 | Cherish your Alone Time | 9 | ✗ 新版独有 |
| kouya08_teachme | 未知 | Secret and Private Lesson | 86 | ✗ 新版独有 |
| tatsuki08 | 辰樹 | Just another Day for Tatsuki and Torahiko | 12 | ✓ 旧版存在 |
| tatsuki08_couple | 未知 | - | 25 | ✗ 新版独有 |
| tatsuki08_join | 未知 | - | 35 | ✗ 新版独有 |
| tatsuki08_stop | 未知 | - | 29 | ✗ 新版独有 |

#### 新版独有路线

- **day08** (未知): 14 条未翻译文本
- **day08_pictures_kouno** (未知): 102 条未翻译文本
- **day08_pictures_shun** (未知): 111 条未翻译文本
- **day08_pictures_tora** (未知): 110 条未翻译文本
- **end08** (未知): 0 条未翻译文本
- **kouya08_pass** (未知): 9 条未翻译文本
- **kouya08_teachme** (未知): 86 条未翻译文本
- **tatsuki08_couple** (未知): 25 条未翻译文本
- **tatsuki08_join** (未知): 35 条未翻译文本
- **tatsuki08_stop** (未知): 29 条未翻译文本

---

### Day 9

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 9日目.ks (虎彦路线) | torahiko |
| 其他 | 10日目.ks | torahiko |
| 其他 | 10日目.ks | orig |
| 辰樹 | 辰樹_s_05.ks | orig |
| 峻 | 峻_s_07.ks | orig |
| 洸哉 | 洸哉_s_04.ks | orig |
| 深 | 深_m_03.ks | orig |
| 柔一 | 柔一_m_04.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day09 | 未知 | ８月9日 | 1 | ✗ 新版独有 |
| end09 | 未知 | - | 0 | ✗ 新版独有 |
| juuichi09 | 柔一 | Rain Poems | 42 | ✓ 旧版存在 |
| juuichi09_borrow | 未知 | I Would Also Like to Borrow the Bear's Hands | 8 | ✗ 新版独有 |
| juuichi09_help | 未知 | Once Past the Border, One May Do Anything | 32 | ✗ 新版独有 |
| juuichi09_nohelp | 未知 | There's Nothing More Embarrassing than Asking | 24 | ✗ 新版独有 |
| juuichi09_return | 未知 | Returning it now | 8 | ✗ 新版独有 |
| juuichi09_talk | 未知 | In the Waiting Area | 101 | ✗ 新版独有 |
| kouya09 | 洸哉 | Taking Shelter in the Park from Rain | 161 | ✓ 旧版存在 |
| shin09 | 深 | Who went into the forest...? | 4 | ✓ 旧版存在 |
| shin09_call | 未知 | One day in the woods, I met Shin-kun | 95 | ✗ 新版独有 |
| shin09_continue | 未知 | Is something wrong with Shin-kun? | 26 | ✗ 新版独有 |
| shin09_cpr | 未知 | Basking in the Sun | 74 | ✗ 新版独有 |
| shin09_follow | 未知 | - | 21 | ✗ 新版独有 |
| shin09_ignore | 未知 | - | 8 | ✗ 新版独有 |
| shin09_rest | 未知 | - | 11 | ✗ 新版独有 |
| shin09_shout | 未知 | Secret Place | 54 | ✗ 新版独有 |
| shin09a | 未知 | - | 0 | ✗ 新版独有 |
| shin09b | 未知 | - | 0 | ✗ 新版独有 |
| shun09 | 峻 | 3 Black Sets | 37 | ✓ 旧版存在 |
| shun09_fighting | 未知 | ←↓→＋Ｐ | 23 | ✗ 新版独有 |
| shun09_oldgame | 未知 | Dungeon Mapping | 42 | ✗ 新版独有 |
| shun09_puzzle | 未知 | ＮＥＸＴ□□□□ | 23 | ✗ 新版独有 |
| tatsuki09 | 辰樹 | - | 13 | ✓ 旧版存在 |
| tatsuki09_goout | 未知 | - | 12 | ✗ 新版独有 |
| tatsuki09_hangout | 未知 | - | 11 | ✗ 新版独有 |
| tatsuki09_help | 未知 | - | 18 | ✗ 新版独有 |
| torahiko09 | 虎彦 | Sake For A Rainy Day  | 193 | ✓ 旧版存在 |

#### 新版独有路线

- **day09** (未知): 1 条未翻译文本
- **end09** (未知): 0 条未翻译文本
- **juuichi09_borrow** (未知): 8 条未翻译文本
- **juuichi09_help** (未知): 32 条未翻译文本
- **juuichi09_nohelp** (未知): 24 条未翻译文本
- **juuichi09_return** (未知): 8 条未翻译文本
- **juuichi09_talk** (未知): 101 条未翻译文本
- **shin09_call** (未知): 95 条未翻译文本
- **shin09_continue** (未知): 26 条未翻译文本
- **shin09_cpr** (未知): 74 条未翻译文本
- **shin09_follow** (未知): 21 条未翻译文本
- **shin09_ignore** (未知): 8 条未翻译文本
- **shin09_rest** (未知): 11 条未翻译文本
- **shin09_shout** (未知): 54 条未翻译文本
- **shin09a** (未知): 0 条未翻译文本
- **shin09b** (未知): 0 条未翻译文本
- **shun09_fighting** (未知): 23 条未翻译文本
- **shun09_oldgame** (未知): 42 条未翻译文本
- **shun09_puzzle** (未知): 23 条未翻译文本
- **tatsuki09_goout** (未知): 12 条未翻译文本
- **tatsuki09_hangout** (未知): 11 条未翻译文本
- **tatsuki09_help** (未知): 18 条未翻译文本

---

### Day 10

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 10日目.ks (虎彦路线) | torahiko |
| 其他 | 11日目.ks | torahiko |
| 其他 | 11日目.ks | orig |
| 辰樹 | 辰樹_m_02.ks | orig |
| 孝之助 | 孝之助_m_03.ks | orig |
| 峻 | 峻_m_02.ks | orig |
| 柔一 | 柔一_m_045.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day10 | 未知 | ８月10日 | 1 | ✗ 新版独有 |
| end10 | 未知 | - | 0 | ✗ 新版独有 |
| juuichi10 | 柔一 | Let's Go to Kazenari! | 22 | ✓ 旧版存在 |
| juuichi10_hesitation | 未知 | - | 4 | ✗ 新版独有 |
| juuichi10_manage | 未知 | - | 68 | ✗ 新版独有 |
| juuichi10_memo | 未知 | Nothing Ventured, Nothing Gained | 173 | ✗ 新版独有 |
| juuichi10_memory | 未知 | - | 2 | ✗ 新版独有 |
| juuichi10_understood | 未知 | - | 2 | ✗ 新版独有 |
| kounosuke10 | 孝之助 | Tanuki in the forest | 63 | ✓ 旧版存在 |
| kounosuke10_busy | 未知 | - | 4 | ✗ 新版独有 |
| kounosuke10_lastweek | 未知 | - | 22 | ✗ 新版独有 |
| shun10 | 峻 | Square button | 10 | ✓ 旧版存在 |
| shun10_badgame | 未知 | - | 5 | ✗ 新版独有 |
| shun10_gametalk1 | 未知 | - | 12 | ✗ 新版独有 |
| shun10_gametalk2 | 未知 | - | 7 | ✗ 新版独有 |
| shun10_goodgame | 未知 | Gaku-san's store | 58 | ✗ 新版独有 |
| shun10_newgame | 未知 | Not Being Sold on Launch Day | 19 | ✗ 新版独有 |
| shun10_nostalgia | 未知 | - | 22 | ✗ 新版独有 |
| shun10_play | 未知 | - | 14 | ✗ 新版独有 |
| shun10_sleepy | 未知 | Don't Break Him | 34 | ✗ 新版独有 |
| tatsuki10 | 辰樹 | Part-time job at the Midoriya Group | 183 | ✓ 旧版存在 |
| torahiko10 | 虎彦 | The Ooshima Inn | 138 | ✓ 旧版存在 |

#### 新版独有路线

- **day10** (未知): 1 条未翻译文本
- **end10** (未知): 0 条未翻译文本
- **juuichi10_hesitation** (未知): 4 条未翻译文本
- **juuichi10_manage** (未知): 68 条未翻译文本
- **juuichi10_memo** (未知): 173 条未翻译文本
- **juuichi10_memory** (未知): 2 条未翻译文本
- **juuichi10_understood** (未知): 2 条未翻译文本
- **kounosuke10_busy** (未知): 4 条未翻译文本
- **kounosuke10_lastweek** (未知): 22 条未翻译文本
- **shun10_badgame** (未知): 5 条未翻译文本
- **shun10_gametalk1** (未知): 12 条未翻译文本
- **shun10_gametalk2** (未知): 7 条未翻译文本
- **shun10_goodgame** (未知): 58 条未翻译文本
- **shun10_newgame** (未知): 19 条未翻译文本
- **shun10_nostalgia** (未知): 22 条未翻译文本
- **shun10_play** (未知): 14 条未翻译文本
- **shun10_sleepy** (未知): 34 条未翻译文本

---

### Day 11

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 11日目.ks (虎彦路线) | torahiko |
| 其他 | 12日目.ks | torahiko |
| 其他 | 12日目.ks | orig |
| 辰樹 | 辰樹_s_03.ks | orig |
| 深 | 深_s_02.ks | orig |
| 柔一 | 柔一_s_01.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day11 | 未知 | ８月11日 | 1 | ✗ 新版独有 |
| end11 | 未知 | - | 0 | ✗ 新版独有 |
| juuichi11 | 柔一 | The Library has a ominous scent | 125 | ✓ 旧版存在 |
| juuichi11_dodge | 未知 | The Impertinent, Salty Taste of Youth | 72 | ✗ 新版独有 |
| juuichi11_swimming | 未知 | 120% Wrath | 26 | ✗ 新版独有 |
| juuichi11_tennis | 未知 | Aim For the Prince of Tennis | 40 | ✗ 新版独有 |
| shin11 | 深 | Rain of Friday | 92 | ✓ 旧版存在 |
| shin11_leave | 未知 | - | 26 | ✗ 新版独有 |
| shin11_stay | 未知 | - | 24 | ✗ 新版独有 |
| tatsuki11 | 辰樹 | Fireworks Gathering | 31 | ✓ 旧版存在 |
| tatsuki11_bottom | 未知 | What's left over? | 44 | ✗ 新版独有 |
| tatsuki11_fireworks | 未知 | At the General Store | 40 | ✗ 新版独有 |
| tatsuki11_food | 未知 | - | 42 | ✗ 新版独有 |
| tatsuki11_fountain | 未知 | Dragon | 24 | ✗ 新版独有 |
| tatsuki11_proceed | 未知 | Drinking but not drunk | 36 | ✗ 新版独有 |
| tatsuki11_rocket | 未知 | Rocket Firework | 31 | ✗ 新版独有 |
| tatsuki11_showtime | 未知 | Let's set off Fireworks! | 47 | ✗ 新版独有 |
| tatsuki11_stop | 未知 | Abstinence | 10 | ✗ 新版独有 |
| torahiko11 | 虎彦 | The Mysterious Plums | 345 | ✓ 旧版存在 |

#### 新版独有路线

- **day11** (未知): 1 条未翻译文本
- **end11** (未知): 0 条未翻译文本
- **juuichi11_dodge** (未知): 72 条未翻译文本
- **juuichi11_swimming** (未知): 26 条未翻译文本
- **juuichi11_tennis** (未知): 40 条未翻译文本
- **shin11_leave** (未知): 26 条未翻译文本
- **shin11_stay** (未知): 24 条未翻译文本
- **tatsuki11_bottom** (未知): 44 条未翻译文本
- **tatsuki11_fireworks** (未知): 40 条未翻译文本
- **tatsuki11_food** (未知): 42 条未翻译文本
- **tatsuki11_fountain** (未知): 24 条未翻译文本
- **tatsuki11_proceed** (未知): 36 条未翻译文本
- **tatsuki11_rocket** (未知): 31 条未翻译文本
- **tatsuki11_showtime** (未知): 47 条未翻译文本
- **tatsuki11_stop** (未知): 10 条未翻译文本

---

### Day 12

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 12日目.ks (虎彦路线) | torahiko |
| 其他 | 13日目.ks | torahiko |
| 其他 | 13日目.ks | orig |
| 辰樹 | 辰樹_m_03.ks | orig |
| 洸哉 | 洸哉_s_05.ks | orig |
| 柔一 | 柔一_s_02.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day12 | 未知 | ８月12日 | 1 | ✗ 新版独有 |
| end12 | 未知 | - | 0 | ✗ 新版独有 |
| juuichi12 | 柔一 | Soutarou's Worries | 56 | ✓ 旧版存在 |
| juuichi12_body | 未知 | Sleep Brings Up a Child Well | 89 | ✗ 新版独有 |
| juuichi12_stick | 未知 | Lament of the Burning Match | 53 | ✗ 新版独有 |
| kouya12 | 洸哉 | Unexpected Encounter | 109 | ✓ 旧版存在 |
| kouya12_continue | 未知 | Continuing On. | 41 | ✗ 新版独有 |
| kouya12_go | 未知 | Let's Go Right Now | 18 | ✗ 新版独有 |
| kouya12_lake | 未知 | Memory of the Lake | 76 | ✗ 新版独有 |
| kouya12_me | 未知 | He said... | 64 | ✗ 新版独有 |
| kouya12_pass | 未知 | I'll Go on Ahead. | 23 | ✗ 新版独有 |
| kouya12_you | 未知 | Old Talk | 40 | ✗ 新版独有 |
| tatsuki12 | 辰樹 | A secret shared between us | 211 | ✓ 旧版存在 |
| tatsuki12_force | 未知 | Changing Clothes | 84 | ✗ 新版独有 |
| tatsuki12_quiet | 未知 | Changing | 31 | ✗ 新版独有 |
| tatsuki12_shigure | 未知 | Uncle Shigure | 66 | ✗ 新版独有 |
| tatsuki12_tappei | 未知 | Tappei Midoriya | 60 | ✗ 新版独有 |
| torahiko12 | 虎彦 | Torahiko's Super Coach | 170 | ✓ 旧版存在 |

#### 新版独有路线

- **day12** (未知): 1 条未翻译文本
- **end12** (未知): 0 条未翻译文本
- **juuichi12_body** (未知): 89 条未翻译文本
- **juuichi12_stick** (未知): 53 条未翻译文本
- **kouya12_continue** (未知): 41 条未翻译文本
- **kouya12_go** (未知): 18 条未翻译文本
- **kouya12_lake** (未知): 76 条未翻译文本
- **kouya12_me** (未知): 64 条未翻译文本
- **kouya12_pass** (未知): 23 条未翻译文本
- **kouya12_you** (未知): 40 条未翻译文本
- **tatsuki12_force** (未知): 84 条未翻译文本
- **tatsuki12_quiet** (未知): 31 条未翻译文本
- **tatsuki12_shigure** (未知): 66 条未翻译文本
- **tatsuki12_tappei** (未知): 60 条未翻译文本

---

### Day 13

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 13日目.ks (虎彦路线) | torahiko |
| 其他 | 14日目.ks | torahiko |
| 其他 | 14日目.ks | orig |
| 辰樹 | 辰樹_s_04.ks | orig |
| 峻 | 峻_s_01.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day13 | 未知 | ８月13日 | 1 | ✗ 新版独有 |
| end13 | 未知 | - | 0 | ✗ 新版独有 |
| shun13 | 峻 | Hearing Strange Sounds | 5 | ✓ 旧版存在 |
| shun13_alone | 未知 | I shouldn't disturb them... | 10 | ✗ 新版独有 |
| shun13_carpenters | 未知 | The Carpenters of Minasato | 113 | ✗ 新版独有 |
| shun13_gohome | 未知 | From the Middle of the Day | 1 | ✗ 新版独有 |
| shun13_play | 未知 | Let's Play Together | 35 | ✗ 新版独有 |
| shun13_surprise | 未知 | Chasing | 9 | ✗ 新版独有 |
| tatsuki13 | 辰樹 | Teacher and Field Work | 37 | ✓ 旧版存在 |
| tatsuki13_done | 未知 | Rain letting up | 66 | ✗ 新版独有 |
| tatsuki13_inside | 未知 | Light Work | 27 | ✗ 新版独有 |
| tatsuki13_kyouji | 未知 | Let's take a shortcut! | 27 | ✗ 新版独有 |
| tatsuki13_outside | 未知 | Harvesting Time | 28 | ✗ 新版独有 |
| tatsuki13_rest | 未知 | Back to work | 75 | ✗ 新版独有 |
| tatsuki13_tatsuki | 未知 | Teamwork | 48 | ✗ 新版独有 |
| tatsuki13_torahiko | 未知 | Power Game | 38 | ✗ 新版独有 |

#### 新版独有路线

- **day13** (未知): 1 条未翻译文本
- **end13** (未知): 0 条未翻译文本
- **shun13_alone** (未知): 10 条未翻译文本
- **shun13_carpenters** (未知): 113 条未翻译文本
- **shun13_gohome** (未知): 1 条未翻译文本
- **shun13_play** (未知): 35 条未翻译文本
- **shun13_surprise** (未知): 9 条未翻译文本
- **tatsuki13_done** (未知): 66 条未翻译文本
- **tatsuki13_inside** (未知): 27 条未翻译文本
- **tatsuki13_kyouji** (未知): 27 条未翻译文本
- **tatsuki13_outside** (未知): 28 条未翻译文本
- **tatsuki13_rest** (未知): 75 条未翻译文本
- **tatsuki13_tatsuki** (未知): 48 条未翻译文本
- **tatsuki13_torahiko** (未知): 38 条未翻译文本

---

### Day 14

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 14日目.ks (虎彦路线) | torahiko |
| 其他 | 15日目.ks | torahiko |
| 其他 | キャンプ01.ks | orig |
| 其他 | 15日目.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day14 | 未知 | How about tomorrow | 400 | ✗ 新版独有 |

#### 新版独有路线

- **day14** (未知): 400 条未翻译文本

---

### Day 15

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 15日目.ks (虎彦路线) | torahiko |
| 其他 | 16日目.ks | torahiko |
| 其他 | キャンプ02.ks | orig |
| 其他 | 16日目.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| camp15_choice | 未知 | - | 0 | ✗ 新版独有 |
| camp15_confess_juuichi | 未知 | Words Sinking With the Setting Sun | 32 | ✗ 新版独有 |
| camp15_confess_kounosuke | 未知 | The Spoiler Tanuki | 26 | ✗ 新版独有 |
| camp15_confess_kouya | 未知 | Time Limit - Countdown Phase | 63 | ✗ 新版独有 |
| camp15_confess_shin | 未知 | I'm not fond of Sunsets | 26 | ✗ 新版独有 |
| camp15_confess_shun | 未知 | I don't want it to end | 26 | ✗ 新版独有 |
| camp15_confess_tatsuki | 未知 | Tatsu-nii | 58 | ✗ 新版独有 |
| camp15_confess_torahiko | 未知 | It's Not Half Done | 34 | ✗ 新版独有 |
| camp15_explore | 未知 | Nature | 12 | ✗ 新版独有 |
| camp15_juuichi | 柔一 | Hot Springs, Steamy Romance, what's the difference? | 176 | ✗ 新版独有 |
| camp15_kounosuke | 孝之助 | Exploration Showdown | 162 | ✗ 新版独有 |
| camp15_kouya | 洸哉 | Kouya's search for the light | 226 | ✗ 新版独有 |
| camp15_mumble1 | 未知 | - | 2 | ✗ 新版独有 |
| camp15_mumble2 | 未知 | - | 2 | ✗ 新版独有 |
| camp15_packup | 未知 | Packing up | 27 | ✗ 新版独有 |
| camp15_shin | 深 | Tale of the Lying Kitten | 112 | ✗ 新版独有 |
| camp15_shun | 峻 | Shun and the God of Marriage | 63 | ✗ 新版独有 |
| camp15_tatsuki | 孝之助 | Exploration Party | 113 | ✗ 新版独有 |
| camp15_torahiko | 虎彦 | Wilderness Survival | 163 | ✓ 旧版存在 |
| camp15_wakeup_juuichi | 未知 | - | 30 | ✗ 新版独有 |
| camp15_wakeup_kounosuke | 未知 | BWAH! | 21 | ✗ 新版独有 |
| camp15_wakeup_kouya | 未知 | On the edge of sleep | 23 | ✗ 新版独有 |
| camp15_wakeup_shin | 未知 | Morning needles | 17 | ✗ 新版独有 |
| camp15_wakeup_shun | 未知 | Ride me, my Wolf! | 45 | ✗ 新版独有 |
| camp15_wakeup_tatsuki | 未知 | Morning, Tatsu-nii | 4 | ✗ 新版独有 |
| camp15_wakeup_torahiko | 未知 | A Heavy Wakeup | 35 | ✗ 新版独有 |
| day15 | 未知 | ８月15日 | 0 | ✗ 新版独有 |
| end15 | 未知 | - | 0 | ✗ 新版独有 |

#### 新版独有路线

- **camp15_choice** (未知): 0 条未翻译文本
- **camp15_confess_juuichi** (未知): 32 条未翻译文本
- **camp15_confess_kounosuke** (未知): 26 条未翻译文本
- **camp15_confess_kouya** (未知): 63 条未翻译文本
- **camp15_confess_shin** (未知): 26 条未翻译文本
- **camp15_confess_shun** (未知): 26 条未翻译文本
- **camp15_confess_tatsuki** (未知): 58 条未翻译文本
- **camp15_confess_torahiko** (未知): 34 条未翻译文本
- **camp15_explore** (未知): 12 条未翻译文本
- **camp15_juuichi** (柔一): 176 条未翻译文本
- **camp15_kounosuke** (孝之助): 162 条未翻译文本
- **camp15_kouya** (洸哉): 226 条未翻译文本
- **camp15_mumble1** (未知): 2 条未翻译文本
- **camp15_mumble2** (未知): 2 条未翻译文本
- **camp15_packup** (未知): 27 条未翻译文本
- **camp15_shin** (深): 112 条未翻译文本
- **camp15_shun** (峻): 63 条未翻译文本
- **camp15_tatsuki** (孝之助): 113 条未翻译文本
- **camp15_wakeup_juuichi** (未知): 30 条未翻译文本
- **camp15_wakeup_kounosuke** (未知): 21 条未翻译文本
- **camp15_wakeup_kouya** (未知): 23 条未翻译文本
- **camp15_wakeup_shin** (未知): 17 条未翻译文本
- **camp15_wakeup_shun** (未知): 45 条未翻译文本
- **camp15_wakeup_tatsuki** (未知): 4 条未翻译文本
- **camp15_wakeup_torahiko** (未知): 35 条未翻译文本
- **day15** (未知): 0 条未翻译文本
- **end15** (未知): 0 条未翻译文本

---

### Day 16

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 16日目.ks (虎彦路线) | torahiko |
| 其他 | 17日目.ks | torahiko |
| 其他 | 17日目.ks | orig |
| 辰樹 | 辰樹_m_04.ks | orig |
| 孝之助 | 孝之助_m_04.ks | orig |
| 峻 | 峻_m_03.ks | orig |
| 洸哉 | 洸哉_s_06.ks | orig |
| 深 | 深_m_04.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day16 | 未知 | ８月16日 | 0 | ✗ 新版独有 |
| end16 | 未知 | - | 0 | ✗ 新版独有 |
| kounosuke16 | 未知 | Call from Kounosuke | 19 | ✗ 新版独有 |
| kounosuke16_bedroom | 未知 | Kounosuke's Ambition | 26 | ✗ 新版独有 |
| kounosuke16_photos_no | 未知 | Kounosuke's grand plan | 30 | ✗ 新版独有 |
| kounosuke16_photos_yes | 未知 | Kounosuke's photos | 14 | ✗ 新版独有 |
| kounosuke16_plan | 未知 | Unextraordinary Tanuki | 76 | ✗ 新版独有 |
| kounosuke16_yukiharu_no | 未知 | Little Tanuki | 28 | ✗ 新版独有 |
| kounosuke16_yukiharu_yes | 未知 | Kuri's Appliance Store | 22 | ✗ 新版独有 |
| kouya16 | 未知 | Ticket Riots | 306 | ✗ 新版独有 |
| map16 | 未知 | - | 1 | ✗ 新版独有 |
| shin16 | 未知 | Let's go hang out at Shin-kun's! | 6 | ✗ 新版独有 |
| shin16_amaki_past | 未知 | - | 5 | ✗ 新版独有 |
| shin16_amaki_recent | 未知 | - | 4 | ✗ 新版独有 |
| shin16_desk_inside | 未知 | Cell Phone | 55 | ✗ 新版独有 |
| shin16_desk_top | 未知 | Secret Diary | 49 | ✗ 新版独有 |
| shin16_garden | 未知 | - | 82 | ✗ 新版独有 |
| shin16_lesson_accept | 未知 | - | 26 | ✗ 新版独有 |
| shin16_lesson_decline | 未知 | - | 42 | ✗ 新版独有 |
| shin16_sit | 未知 | Where should we eat? | 13 | ✗ 新版独有 |
| shin16_sit_bed | 未知 | - | 3 | ✗ 新版独有 |
| shin16_sit_floor | 未知 | - | 18 | ✗ 新版独有 |
| shin16_snacks | 未知 | Snack Time | 92 | ✗ 新版独有 |
| shun16 | 未知 | Well-ordered Room | 128 | ✗ 新版独有 |
| shun16_evening | 未知 | Evening time | 104 | ✗ 新版独有 |
| shun16_plans_camping | 未知 | Things in Particular | 12 | ✗ 新版独有 |
| shun16_plans_discuss | 未知 | Things in Particular | 32 | ✗ 新版独有 |
| shun16_plans_festival | 未知 | Things in Particular | 19 | ✗ 新版独有 |
| shun16_sex | 未知 | Muffled Sensation | 267 | ✗ 新版独有 |
| tatsuki16 | 未知 | Unexpected! | 532 | ✗ 新版独有 |
| torahiko16 | 未知 | The Genius's Suffering | 120 | ✗ 新版独有 |

#### 新版独有路线

- **day16** (未知): 0 条未翻译文本
- **end16** (未知): 0 条未翻译文本
- **kounosuke16** (未知): 19 条未翻译文本
- **kounosuke16_bedroom** (未知): 26 条未翻译文本
- **kounosuke16_photos_no** (未知): 30 条未翻译文本
- **kounosuke16_photos_yes** (未知): 14 条未翻译文本
- **kounosuke16_plan** (未知): 76 条未翻译文本
- **kounosuke16_yukiharu_no** (未知): 28 条未翻译文本
- **kounosuke16_yukiharu_yes** (未知): 22 条未翻译文本
- **kouya16** (未知): 306 条未翻译文本
- **map16** (未知): 1 条未翻译文本
- **shin16** (未知): 6 条未翻译文本
- **shin16_amaki_past** (未知): 5 条未翻译文本
- **shin16_amaki_recent** (未知): 4 条未翻译文本
- **shin16_desk_inside** (未知): 55 条未翻译文本
- **shin16_desk_top** (未知): 49 条未翻译文本
- **shin16_garden** (未知): 82 条未翻译文本
- **shin16_lesson_accept** (未知): 26 条未翻译文本
- **shin16_lesson_decline** (未知): 42 条未翻译文本
- **shin16_sit** (未知): 13 条未翻译文本
- **shin16_sit_bed** (未知): 3 条未翻译文本
- **shin16_sit_floor** (未知): 18 条未翻译文本
- **shin16_snacks** (未知): 92 条未翻译文本
- **shun16** (未知): 128 条未翻译文本
- **shun16_evening** (未知): 104 条未翻译文本
- **shun16_plans_camping** (未知): 12 条未翻译文本
- **shun16_plans_discuss** (未知): 32 条未翻译文本
- **shun16_plans_festival** (未知): 19 条未翻译文本
- **shun16_sex** (未知): 267 条未翻译文本
- **tatsuki16** (未知): 532 条未翻译文本
- **torahiko16** (未知): 120 条未翻译文本

---

### Day 17

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 17日目.ks (虎彦路线) | torahiko |
| 其他 | 18日目.ks | torahiko |
| 其他 | 18日目.ks | orig |
| 孝之助 | 孝之助_m_05.ks | orig |
| 峻 | 峻_m_03.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day17 | 未知 | ８月17日 | 0 | ✗ 新版独有 |
| end17 | 未知 | - | 0 | ✗ 新版独有 |
| kounosuke17 | 未知 | Taking pictures with Kounosuke | 11 | ✗ 新版独有 |
| kounosuke17_accept | 未知 | - | 2 | ✗ 新版独有 |
| kounosuke17_ate | 未知 | - | 11 | ✗ 新版独有 |
| kounosuke17_confession | 未知 | - | 32 | ✗ 新版独有 |
| kounosuke17_cooldown | 未知 | - | 22 | ✗ 新版独有 |
| kounosuke17_decline | 未知 | - | 2 | ✗ 新版独有 |
| kounosuke17_notyet | 未知 | - | 16 | ✗ 新版独有 |
| kounosuke17_photography | 未知 | Memories at sunset | 303 | ✗ 新版独有 |
| kounosuke17_reward | 未知 | - | 4 | ✗ 新版独有 |
| kounosuke17_what | 未知 | - | 14 | ✗ 新版独有 |
| shun17 | 未知 | The Next Morning | 54 | ✗ 新版独有 |
| torahiko17 | 未知 | The Day Of Battles | 214 | ✗ 新版独有 |

#### 新版独有路线

- **day17** (未知): 0 条未翻译文本
- **end17** (未知): 0 条未翻译文本
- **kounosuke17** (未知): 11 条未翻译文本
- **kounosuke17_accept** (未知): 2 条未翻译文本
- **kounosuke17_ate** (未知): 11 条未翻译文本
- **kounosuke17_confession** (未知): 32 条未翻译文本
- **kounosuke17_cooldown** (未知): 22 条未翻译文本
- **kounosuke17_decline** (未知): 2 条未翻译文本
- **kounosuke17_notyet** (未知): 16 条未翻译文本
- **kounosuke17_photography** (未知): 303 条未翻译文本
- **kounosuke17_reward** (未知): 4 条未翻译文本
- **kounosuke17_what** (未知): 14 条未翻译文本
- **shun17** (未知): 54 条未翻译文本
- **torahiko17** (未知): 214 条未翻译文本

---

### Day 18

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 18日目.ks (虎彦路线) | torahiko |
| 其他 | 19日目.ks | torahiko |
| 其他 | 19日目.ks | orig |
| 峻 | 峻_s_03.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day18 | 未知 | ８月18日 | 0 | ✗ 新版独有 |
| end18 | 未知 | - | 0 | ✗ 新版独有 |
| map18 | 未知 | - | 1 | ✗ 新版独有 |
| shun18 | 未知 | The Strongest Weapon and Shin | 123 | ✗ 新版独有 |
| shun18_support_neither | 未知 | Which Side...? | 21 | ✗ 新版独有 |
| shun18_support_shin | 未知 | Which Side...? | 24 | ✗ 新版独有 |
| shun18_support_shun | 未知 | Which Side...? | 49 | ✗ 新版独有 |
| torahiko18 | 未知 | A Solitary Struggle | 83 | ✗ 新版独有 |

#### 新版独有路线

- **day18** (未知): 0 条未翻译文本
- **end18** (未知): 0 条未翻译文本
- **map18** (未知): 1 条未翻译文本
- **shun18** (未知): 123 条未翻译文本
- **shun18_support_neither** (未知): 21 条未翻译文本
- **shun18_support_shin** (未知): 24 条未翻译文本
- **shun18_support_shun** (未知): 49 条未翻译文本
- **torahiko18** (未知): 83 条未翻译文本

---

### Day 19

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 19日目.ks (虎彦路线) | torahiko |
| 其他 | 20日目.ks | torahiko |
| 其他 | 20日目.ks | orig |
| 洸哉 | 洸哉_s_07.ks | orig |
| 柔一 | 柔一_m_05.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day19 | 未知 | ８月19日 | 0 | ✗ 新版独有 |
| end19 | 未知 | - | 0 | ✗ 新版独有 |
| juuichi19 | 未知 | A Midsummer Day's Dream | 64 | ✗ 新版独有 |
| juuichi19_cup | 未知 | In the Mood for a Cup | 19 | ✗ 新版独有 |
| juuichi19_friend | 未知 | The Cost of a Confession. | 67 | ✗ 新版独有 |
| juuichi19_lover | 未知 | A Happy Ending | 45 | ✗ 新版独有 |
| juuichi19_softserve | 未知 | The Age of Softness | 16 | ✗ 新版独有 |
| juuichi19_talk | 未知 | Something that Will Never Come True | 85 | ✗ 新版独有 |
| kouya19 | 未知 | Live Concert | 117 | ✗ 新版独有 |
| map19 | 未知 | - | 1 | ✗ 新版独有 |
| torahiko19 | 未知 | The Day When The Hearts Are Connected | 143 | ✗ 新版独有 |

#### 新版独有路线

- **day19** (未知): 0 条未翻译文本
- **end19** (未知): 0 条未翻译文本
- **juuichi19** (未知): 64 条未翻译文本
- **juuichi19_cup** (未知): 19 条未翻译文本
- **juuichi19_friend** (未知): 67 条未翻译文本
- **juuichi19_lover** (未知): 45 条未翻译文本
- **juuichi19_softserve** (未知): 16 条未翻译文本
- **juuichi19_talk** (未知): 85 条未翻译文本
- **kouya19** (未知): 117 条未翻译文本
- **map19** (未知): 1 条未翻译文本
- **torahiko19** (未知): 143 条未翻译文本

---

### Day 20

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 20日目.ks (虎彦路线) | torahiko |
| 其他 | 21日目.ks | torahiko |
| 其他 | 21日目.ks | orig |
| 辰樹 | 辰樹_m_45.ks | orig |
| 峻 | 峻_s_04.ks | orig |
| 洸哉 | 洸哉_m_01.ks | orig |
| 深 | 深_m_05.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day20 | 未知 | ８月20日 | 0 | ✗ 新版独有 |
| end20 | 未知 | - | 0 | ✗ 新版独有 |
| kouya20 | 未知 | Lodgings and Staying Over | 75 | ✗ 新版独有 |
| kouya20_accept | 未知 | To Three Wonderful Days | 190 | ✗ 新版独有 |
| kouya20_crude | 未知 | Wild Man | 17 | ✗ 新版独有 |
| kouya20_dinner | 未知 | A Restful Night | 90 | ✗ 新版独有 |
| kouya20_steady | 未知 | Gentleman | 18 | ✗ 新版独有 |
| map20 | 未知 | - | 1 | ✗ 新版独有 |
| shin20 | 未知 | Shin-kun and Amaki-san | 5 | ✗ 新版独有 |
| shin20_baking | 未知 | - | 113 | ✗ 新版独有 |
| shin20_homework | 未知 | - | 99 | ✗ 新版独有 |
| shun20 | 未知 | The Blue Moon and the Wolf | 19 | ✗ 新版独有 |
| shun20_angry_gaku | 未知 | Light Brown Fur Coat | 8 | ✗ 新版独有 |
| shun20_exhausted | 未知 | The Right Way to Spend a Summer Night | 42 | ✗ 新版独有 |
| shun20_kiss | 未知 | Saying Goodnight | 28 | ✗ 新版独有 |
| shun20_lap | 未知 | Lap pillow | 66 | ✗ 新版独有 |
| shun20_play_accept | 未知 | Nighttime invitation | 34 | ✗ 新版独有 |
| shun20_play_refuse | 未知 | - | 16 | ✗ 新版独有 |
| shun20_visit_kounosuke | 未知 | Chasing Kounosuke's Moon | 56 | ✗ 新版独有 |
| shun20_visit_tatsuki | 未知 | The Midoriya Family's Bowl | 54 | ✗ 新版独有 |
| tatsuki20 | 未知 | Half Holiday | 129 | ✗ 新版独有 |
| tatsuki20_alcohol | 未知 | Here's something to drink | 4 | ✗ 新版独有 |
| tatsuki20_drunk | 未知 | Drunken Dragon | 24 | ✗ 新版独有 |
| tatsuki20_fish | 未知 | Salted Salmon | 6 | ✗ 新版独有 |
| tatsuki20_hotsprings | 未知 | Midoriya Group at the Hot Springs | 103 | ✗ 新版独有 |
| tatsuki20_sweets | 未知 | A Gift of Summer | 49 | ✗ 新版独有 |
| torahiko20 | 未知 | Kouya's Confession | 83 | ✗ 新版独有 |

#### 新版独有路线

- **day20** (未知): 0 条未翻译文本
- **end20** (未知): 0 条未翻译文本
- **kouya20** (未知): 75 条未翻译文本
- **kouya20_accept** (未知): 190 条未翻译文本
- **kouya20_crude** (未知): 17 条未翻译文本
- **kouya20_dinner** (未知): 90 条未翻译文本
- **kouya20_steady** (未知): 18 条未翻译文本
- **map20** (未知): 1 条未翻译文本
- **shin20** (未知): 5 条未翻译文本
- **shin20_baking** (未知): 113 条未翻译文本
- **shin20_homework** (未知): 99 条未翻译文本
- **shun20** (未知): 19 条未翻译文本
- **shun20_angry_gaku** (未知): 8 条未翻译文本
- **shun20_exhausted** (未知): 42 条未翻译文本
- **shun20_kiss** (未知): 28 条未翻译文本
- **shun20_lap** (未知): 66 条未翻译文本
- **shun20_play_accept** (未知): 34 条未翻译文本
- **shun20_play_refuse** (未知): 16 条未翻译文本
- **shun20_visit_kounosuke** (未知): 56 条未翻译文本
- **shun20_visit_tatsuki** (未知): 54 条未翻译文本
- **tatsuki20** (未知): 129 条未翻译文本
- **tatsuki20_alcohol** (未知): 4 条未翻译文本
- **tatsuki20_drunk** (未知): 24 条未翻译文本
- **tatsuki20_fish** (未知): 6 条未翻译文本
- **tatsuki20_hotsprings** (未知): 103 条未翻译文本
- **tatsuki20_sweets** (未知): 49 条未翻译文本
- **torahiko20** (未知): 83 条未翻译文本

---

### Day 21

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 21日目.ks (虎彦路线) | torahiko |
| 其他 | 22日目.ks | torahiko |
| 其他 | 22日目.ks | orig |
| 洸哉 | 洸哉_m_02.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day21 | 未知 | ８月21日 | 0 | ✗ 新版独有 |
| end21 | 未知 | - | 0 | ✗ 新版独有 |
| kouya21 | 未知 | Waking Up Somewhere Else | 171 | ✗ 新版独有 |
| kouya21_avoid | 未知 | Negative Answer | 11 | ✗ 新版独有 |
| kouya21_badend | 未知 | One Ending | 14 | ✗ 新版独有 |
| kouya21_chase | 未知 | His Whereabouts | 32 | ✗ 新版独有 |
| kouya21_forest | 未知 | His Form | 25 | ✗ 新版独有 |
| kouya21_go | 未知 | Positive Answer | 21 | ✗ 新版独有 |
| kouya21_gohome | 未知 | His Hand | 22 | ✗ 新版独有 |
| kouya21_lake | 未知 | His Direction | 27 | ✗ 新版独有 |
| kouya21_letter | 未知 | Dining Table and a Letter | 91 | ✗ 新版独有 |
| kouya21_reason | 未知 | His Reason | 113 | ✗ 新版独有 |
| kouya21_river | 未知 | His Place | 20 | ✗ 新版独有 |
| kouya21_stay | 未知 | Cowardly Housewatch | 10 | ✗ 新版独有 |
| kouya21_unsure | 未知 | Your Answer | 43 | ✗ 新版独有 |
| torahiko21 | 未知 | The Bath And The Rain | 268 | ✗ 新版独有 |

#### 新版独有路线

- **day21** (未知): 0 条未翻译文本
- **end21** (未知): 0 条未翻译文本
- **kouya21** (未知): 171 条未翻译文本
- **kouya21_avoid** (未知): 11 条未翻译文本
- **kouya21_badend** (未知): 14 条未翻译文本
- **kouya21_chase** (未知): 32 条未翻译文本
- **kouya21_forest** (未知): 25 条未翻译文本
- **kouya21_go** (未知): 21 条未翻译文本
- **kouya21_gohome** (未知): 22 条未翻译文本
- **kouya21_lake** (未知): 27 条未翻译文本
- **kouya21_letter** (未知): 91 条未翻译文本
- **kouya21_reason** (未知): 113 条未翻译文本
- **kouya21_river** (未知): 20 条未翻译文本
- **kouya21_stay** (未知): 10 条未翻译文本
- **kouya21_unsure** (未知): 43 条未翻译文本
- **torahiko21** (未知): 268 条未翻译文本

---

### Day 22

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 22日目.ks (虎彦路线) | torahiko |
| 其他 | 23日目.ks | torahiko |
| 其他 | 23日目.ks | orig |
| 辰樹 | 辰樹_m_n.ks | orig |
| 孝之助 | 孝之助_m_n.ks | orig |
| 峻 | 峻_m_04.ks | orig |
| 洸哉 | 洸哉_m_03.ks | orig |
| 柔一 | 柔一_m_06.ks | orig |
| 深 | 深_m_n.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day22 | 未知 | ８月22日 | 0 | ✗ 新版独有 |
| end22 | 未知 | - | 0 | ✗ 新版独有 |
| juuichi22 | 未知 | Like a Sudden Flame | 527 | ✗ 新版独有 |
| juuichi22_continue | 未知 | I Choose Not to Go Back | 5 | ✗ 新版独有 |
| juuichi22_keep | 未知 | Just the Two of Us | 106 | ✗ 新版独有 |
| juuichi22_stop | 未知 | After the Festival | 21 | ✗ 新版独有 |
| kounosuke22 | 未知 | Kounosuke, Summer Festival | 18 | ✗ 新版独有 |
| kounosuke22_eat | 未知 | - | 6 | ✗ 新版独有 |
| kounosuke22_fireworks | 未知 | - | 32 | ✗ 新版独有 |
| kounosuke22_game | 未知 | - | 10 | ✗ 新版独有 |
| kounosuke22_shooting | 未知 | - | 91 | ✗ 新版独有 |
| kouya22 | 未知 | Crossing of Fate--Front to Back | 407 | ✗ 新版独有 |
| shin22 | 未知 | Nervous? First Date | 31 | ✗ 新版独有 |
| shin22_beautiful | 未知 | - | 3 | ✗ 新版独有 |
| shin22_cute | 未知 | - | 5 | ✗ 新版独有 |
| shin22_festival | 未知 | Everywhere I go it's sweet.... | 73 | ✗ 新版独有 |
| shin22_fireworks | 未知 | His smile illuminated by the flower in the sky | 36 | ✗ 新版独有 |
| shin22_hand | 未知 | - | 13 | ✗ 新版独有 |
| shin22_parents | 未知 | The Bon Dance | 135 | ✗ 新版独有 |
| shun22 | 未知 | - | 0 | ✗ 新版独有 |
| shun22_badend | 未知 | 3 Tails | 50 | ✗ 新版独有 |
| shun22_proceed | 未知 | Rendezvous | 195 | ✗ 新版独有 |
| tatsuki22 | 未知 | Festival | 162 | ✗ 新版独有 |
| tatsuki22_delivery | 未知 | Dash! | 253 | ✗ 新版独有 |
| tatsuki22_drums | 未知 | Beat of the Drum | 64 | ✗ 新版独有 |
| tatsuki22_easy | 未知 | Being Methodical | 70 | ✗ 新版独有 |
| tatsuki22_first | 未知 | Aiming for Victory | 61 | ✗ 新版独有 |
| tatsuki22_god | 未知 | The Importance of Paper? | 109 | ✗ 新版独有 |
| tatsuki22_help | 未知 | Miracle of God | 68 | ✗ 新版独有 |
| tatsuki22_masochist | 未知 | PUNCH!!! | 7 | ✗ 新版独有 |
| tatsuki22_power | 未知 | Max Power Boy! | 39 | ✗ 新版独有 |
| tatsuki22_prank | 未知 | Mischief | 14 | ✗ 新版独有 |
| tatsuki22_ringtoss | 未知 | At the Night Stands | 1 | ✗ 新版独有 |
| tatsuki22_school | 未知 | Won't you join in? | 72 | ✗ 新版独有 |
| tatsuki22_triple | 未知 | What I Desire | 23 | ✗ 新版独有 |
| torahiko22 | 未知 | Cooking & Costumes | 440 | ✗ 新版独有 |

#### 新版独有路线

- **day22** (未知): 0 条未翻译文本
- **end22** (未知): 0 条未翻译文本
- **juuichi22** (未知): 527 条未翻译文本
- **juuichi22_continue** (未知): 5 条未翻译文本
- **juuichi22_keep** (未知): 106 条未翻译文本
- **juuichi22_stop** (未知): 21 条未翻译文本
- **kounosuke22** (未知): 18 条未翻译文本
- **kounosuke22_eat** (未知): 6 条未翻译文本
- **kounosuke22_fireworks** (未知): 32 条未翻译文本
- **kounosuke22_game** (未知): 10 条未翻译文本
- **kounosuke22_shooting** (未知): 91 条未翻译文本
- **kouya22** (未知): 407 条未翻译文本
- **shin22** (未知): 31 条未翻译文本
- **shin22_beautiful** (未知): 3 条未翻译文本
- **shin22_cute** (未知): 5 条未翻译文本
- **shin22_festival** (未知): 73 条未翻译文本
- **shin22_fireworks** (未知): 36 条未翻译文本
- **shin22_hand** (未知): 13 条未翻译文本
- **shin22_parents** (未知): 135 条未翻译文本
- **shun22** (未知): 0 条未翻译文本
- **shun22_badend** (未知): 50 条未翻译文本
- **shun22_proceed** (未知): 195 条未翻译文本
- **tatsuki22** (未知): 162 条未翻译文本
- **tatsuki22_delivery** (未知): 253 条未翻译文本
- **tatsuki22_drums** (未知): 64 条未翻译文本
- **tatsuki22_easy** (未知): 70 条未翻译文本
- **tatsuki22_first** (未知): 61 条未翻译文本
- **tatsuki22_god** (未知): 109 条未翻译文本
- **tatsuki22_help** (未知): 68 条未翻译文本
- **tatsuki22_masochist** (未知): 7 条未翻译文本
- **tatsuki22_power** (未知): 39 条未翻译文本
- **tatsuki22_prank** (未知): 14 条未翻译文本
- **tatsuki22_ringtoss** (未知): 1 条未翻译文本
- **tatsuki22_school** (未知): 72 条未翻译文本
- **tatsuki22_triple** (未知): 23 条未翻译文本
- **torahiko22** (未知): 440 条未翻译文本

---

### Day 23

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 23日目.ks (虎彦路线) | torahiko |
| 其他 | 24日目.ks | torahiko |
| 其他 | 24日目.ks | orig |
| 辰樹 | 辰樹_m_06.ks | orig |
| 孝之助 | 孝之助_m_055.ks | orig |
| 洸哉 | 洸哉_m_035.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day23 | 未知 | ８月23日 | 0 | ✗ 新版独有 |
| end23 | 未知 | - | 0 | ✗ 新版独有 |
| kouya23 | 未知 | 4th Day's Aspiration Survey Book | 64 | ✗ 新版独有 |
| kouya23_accepted | 未知 | Speech of Warning | 108 | ✗ 新版独有 |
| kouya23_leader_known | 未知 | That Guy and the Impromptu Interview | 53 | ✗ 新版独有 |
| kouya23_leader_unknown | 未知 | Whoever That Guy Is and the Impromptu Interview | 68 | ✗ 新版独有 |
| tatsuki23 | 未知 | After the Festival | 115 | ✗ 新版独有 |
| torahiko23 | 未知 | A Sea For Two | 216 | ✗ 新版独有 |
| torahiko23_sex | 未知 | A Sea For Two | 177 | ✗ 新版独有 |

#### 新版独有路线

- **day23** (未知): 0 条未翻译文本
- **end23** (未知): 0 条未翻译文本
- **kouya23** (未知): 64 条未翻译文本
- **kouya23_accepted** (未知): 108 条未翻译文本
- **kouya23_leader_known** (未知): 53 条未翻译文本
- **kouya23_leader_unknown** (未知): 68 条未翻译文本
- **tatsuki23** (未知): 115 条未翻译文本
- **torahiko23** (未知): 216 条未翻译文本
- **torahiko23_sex** (未知): 177 条未翻译文本

---

### Day 24

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 24日目.ks (虎彦路线) | torahiko |
| 其他 | 25日目.ks | torahiko |
| 其他 | 25日目.ks | orig |
| 孝之助 | 孝之助_m_06.ks | orig |
| 峻 | 峻_s_06.ks | orig |
| 深 | 深_m_06.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day24 | 未知 | ８月24日 | 0 | ✗ 新版独有 |
| end24 | 未知 | - | 0 | ✗ 新版独有 |
| kounosuke24 | 未知 | Checking up on him | 42 | ✗ 新版独有 |
| kounosuke24_annoyed | 未知 | - | 16 | ✗ 新版独有 |
| kounosuke24_patience | 未知 | - | 39 | ✗ 新版独有 |
| map24 | 未知 | - | 1 | ✗ 新版独有 |
| shin24 | 未知 | Just like always... | 37 | ✗ 新版独有 |
| shin24_baking | 未知 | - | 7 | ✗ 新版独有 |
| shin24_confess | 未知 | Because I'm selfish... | 42 | ✗ 新版独有 |
| shin24_homework | 未知 | - | 4 | ✗ 新版独有 |
| shin24_insult | 未知 | A Confession? Or... | 42 | ✗ 新版独有 |
| shin24_kiss | 未知 | - | 24 | ✗ 新版独有 |
| shin24_please_go | 未知 | Don't Come Again | 64 | ✗ 新版独有 |
| shin24_rape | 未知 | You are a HORRIBLE PERSON, you MONSTER. | 46 | ✗ 新版独有 |
| shin24_regret | 未知 | I didn't mean to... | 13 | ✗ 新版独有 |
| shun24 | 未知 | A Boy's Hill | 8 | ✗ 新版独有 |
| shun24_confusion | 未知 | Uncertain Palpitating | 19 | ✗ 新版独有 |
| shun24_enka | 未知 | Enka-ish | 43 | ✗ 新版独有 |
| shun24_pop | 未知 | Pop Idol-like | 38 | ✗ 新版独有 |
| shun24_practice | 未知 | The Next Rhythm | 27 | ✗ 新版独有 |
| torahiko24 | 未知 | The Pretending School Visit | 145 | ✗ 新版独有 |
| torahiko24_sex | 未知 | The Pretending School Visit | 239 | ✗ 新版独有 |

#### 新版独有路线

- **day24** (未知): 0 条未翻译文本
- **end24** (未知): 0 条未翻译文本
- **kounosuke24** (未知): 42 条未翻译文本
- **kounosuke24_annoyed** (未知): 16 条未翻译文本
- **kounosuke24_patience** (未知): 39 条未翻译文本
- **map24** (未知): 1 条未翻译文本
- **shin24** (未知): 37 条未翻译文本
- **shin24_baking** (未知): 7 条未翻译文本
- **shin24_confess** (未知): 42 条未翻译文本
- **shin24_homework** (未知): 4 条未翻译文本
- **shin24_insult** (未知): 42 条未翻译文本
- **shin24_kiss** (未知): 24 条未翻译文本
- **shin24_please_go** (未知): 64 条未翻译文本
- **shin24_rape** (未知): 46 条未翻译文本
- **shin24_regret** (未知): 13 条未翻译文本
- **shun24** (未知): 8 条未翻译文本
- **shun24_confusion** (未知): 19 条未翻译文本
- **shun24_enka** (未知): 43 条未翻译文本
- **shun24_pop** (未知): 38 条未翻译文本
- **shun24_practice** (未知): 27 条未翻译文本
- **torahiko24** (未知): 145 条未翻译文本
- **torahiko24_sex** (未知): 239 条未翻译文本

---

### Day 25

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 25日目.ks (虎彦路线) | torahiko |
| 其他 | 26日目.ks | torahiko |
| 其他 | 26日目.ks | orig |
| 辰樹 | 辰樹_m_07.ks | orig |
| 洸哉 | 洸哉_m_04.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day25 | 未知 | ８月25日 | 0 | ✗ 新版独有 |
| end25 | 未知 | - | 0 | ✗ 新版独有 |
| kouya25 | 未知 | First Day at a New Job | 94 | ✗ 新版独有 |
| kouya25_band_meet | 未知 | First Time with the Three Guys | 27 | ✗ 新版独有 |
| kouya25_band_reunion | 未知 | Reunion of the Three Guys | 27 | ✗ 新版独有 |
| kouya25_musikus | 未知 | Welcome to Musikus | 159 | ✗ 新版独有 |
| tatsuki25 | 未知 | The Result of Sorrow | 94 | ✗ 新版独有 |
| torahiko25 | 未知 | Candies Roundtable | 162 | ✗ 新版独有 |

#### 新版独有路线

- **day25** (未知): 0 条未翻译文本
- **end25** (未知): 0 条未翻译文本
- **kouya25** (未知): 94 条未翻译文本
- **kouya25_band_meet** (未知): 27 条未翻译文本
- **kouya25_band_reunion** (未知): 27 条未翻译文本
- **kouya25_musikus** (未知): 159 条未翻译文本
- **tatsuki25** (未知): 94 条未翻译文本
- **torahiko25** (未知): 162 条未翻译文本

---

### Day 26

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 26日目.ks (虎彦路线) | torahiko |
| 其他 | 27日目.ks | torahiko |
| 其他 | 27日目.ks | orig |
| 孝之助 | 孝之助_m_07.ks | orig |
| 峻 | 峻_m_05.ks | orig |
| 洸哉 | 洸哉_m_05.ks | orig |
| 深 | 深_m_07.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day26 | 未知 | ８月26日 | 0 | ✗ 新版独有 |
| end26 | 未知 | - | 0 | ✗ 新版独有 |
| kounosuke26 | 未知 | Encouragement | 56 | ✗ 新版独有 |
| kounosuke26_encourage | 未知 | Hunting a Tricky Tanuki | 51 | ✗ 新版独有 |
| kounosuke26_excuse | 未知 | Reason For Giving Up | 28 | ✗ 新版独有 |
| kounosuke26_kouno_house | 未知 | - | 10 | ✗ 新版独有 |
| kounosuke26_spiritual_guidence | 未知 | - | 4 | ✗ 新版独有 |
| kouya26 | 未知 | Chain Connection | 197 | ✗ 新版独有 |
| kouya26_sex | 未知 | Continuing Speech | 240 | ✗ 新版独有 |
| shin26 | 未知 | Amaki wants to talk | 53 | ✗ 新版独有 |
| shin26_condemn | 未知 | A Guardian's Duty | 78 | ✗ 新版独有 |
| shin26_explain | 未知 | A Friend's Company | 115 | ✗ 新版独有 |
| shun26 | 未知 | Some Kind of Idea | 276 | ✗ 新版独有 |
| shun26_sex | 未知 | Muffled continued | 477 | ✗ 新版独有 |
| torahiko26 | 未知 | The Big Decision | 206 | ✗ 新版独有 |

#### 新版独有路线

- **day26** (未知): 0 条未翻译文本
- **end26** (未知): 0 条未翻译文本
- **kounosuke26** (未知): 56 条未翻译文本
- **kounosuke26_encourage** (未知): 51 条未翻译文本
- **kounosuke26_excuse** (未知): 28 条未翻译文本
- **kounosuke26_kouno_house** (未知): 10 条未翻译文本
- **kounosuke26_spiritual_guidence** (未知): 4 条未翻译文本
- **kouya26** (未知): 197 条未翻译文本
- **kouya26_sex** (未知): 240 条未翻译文本
- **shin26** (未知): 53 条未翻译文本
- **shin26_condemn** (未知): 78 条未翻译文本
- **shin26_explain** (未知): 115 条未翻译文本
- **shun26** (未知): 276 条未翻译文本
- **shun26_sex** (未知): 477 条未翻译文本
- **torahiko26** (未知): 206 条未翻译文本

---

### Day 27

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 27日目.ks (虎彦路线) | torahiko |
| 其他 | 28日目.ks | torahiko |
| 其他 | 28日目.ks | orig |
| 洸哉 | 洸哉_m_06.ks | orig |
| 深 | 深_m_08.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day27 | 未知 | ８月27日 | 0 | ✗ 新版独有 |
| end27 | 未知 | - | 0 | ✗ 新版独有 |
| kouya27 | 未知 | Your Equipment is a Towel Bedsheet | 231 | ✗ 新版独有 |
| shin27 | 未知 | Onward to Shin's House | 1 | ✗ 新版独有 |
| shin27_childhood_goodbye | 未知 | This isn't a Dream, is it? | 42 | ✗ 新版独有 |
| shin27_childhood_memory | 未知 | Early Childhood | 48 | ✗ 新版独有 |
| shin27_house | 未知 | The Word He Desires | 165 | ✗ 新版独有 |
| shin27_normalend | 未知 | Shattered Determination | 65 | ✗ 新版独有 |
| shin27_number_promise | 未知 | A Promise | 11 | ✗ 新版独有 |
| shin27_sex | 未知 | I Love You | 97 | ✗ 新版独有 |
| torahiko27 | 未知 | Afterglow | 109 | ✗ 新版独有 |

#### 新版独有路线

- **day27** (未知): 0 条未翻译文本
- **end27** (未知): 0 条未翻译文本
- **kouya27** (未知): 231 条未翻译文本
- **shin27** (未知): 1 条未翻译文本
- **shin27_childhood_goodbye** (未知): 42 条未翻译文本
- **shin27_childhood_memory** (未知): 48 条未翻译文本
- **shin27_house** (未知): 165 条未翻译文本
- **shin27_normalend** (未知): 65 条未翻译文本
- **shin27_number_promise** (未知): 11 条未翻译文本
- **shin27_sex** (未知): 97 条未翻译文本
- **torahiko27** (未知): 109 条未翻译文本

---

### Day 28

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 28日目.ks (虎彦路线) | torahiko |
| 其他 | 29日目.ks | torahiko |
| 其他 | 29日目.ks | orig |
| 辰樹 | 辰樹_m_75.ks | orig |
| 峻 | 峻_s_02.ks | orig |
| 洸哉 | 洸哉_m_07.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day28 | 未知 | ８月28日 | 0 | ✗ 新版独有 |
| end28 | 未知 | - | 0 | ✗ 新版独有 |
| kouya28 | 未知 | Noisy Atmosphere | 169 | ✗ 新版独有 |
| shun28 | 未知 | Falling Into Nothing | 27 | ✗ 新版独有 |
| shun28_catch | 未知 | Trying to Carry Him Under My Arm | 10 | ✗ 新版独有 |
| shun28_cushion | 未知 | Cushion Experience | 36 | ✗ 新版独有 |
| shun28_recover | 未知 | Nursing Under the Shade of a Tree | 24 | ✗ 新版独有 |
| shun28_tail | 未知 | Overcome it with Tail Power | 8 | ✗ 新版独有 |
| tatsuki28 | 未知 | I can't do it | 15 | ✗ 新版独有 |
| tatsuki28_dumbass | 未知 | YOU DUMBASS! | 226 | ✗ 新版独有 |
| tatsuki28_goodbye | 未知 | Goodbye | 78 | ✗ 新版独有 |
| tatsuki28_shutdown | 未知 | A Button between Tatsuki's Eyebrows... | 78 | ✗ 新版独有 |
| torahiko28 | 未知 | A Small Fireworks Display | 222 | ✗ 新版独有 |

#### 新版独有路线

- **day28** (未知): 0 条未翻译文本
- **end28** (未知): 0 条未翻译文本
- **kouya28** (未知): 169 条未翻译文本
- **shun28** (未知): 27 条未翻译文本
- **shun28_catch** (未知): 10 条未翻译文本
- **shun28_cushion** (未知): 36 条未翻译文本
- **shun28_recover** (未知): 24 条未翻译文本
- **shun28_tail** (未知): 8 条未翻译文本
- **tatsuki28** (未知): 15 条未翻译文本
- **tatsuki28_dumbass** (未知): 226 条未翻译文本
- **tatsuki28_goodbye** (未知): 78 条未翻译文本
- **tatsuki28_shutdown** (未知): 78 条未翻译文本
- **torahiko28** (未知): 222 条未翻译文本

---

### Day 29

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 29日目.ks (虎彦路线) | torahiko |
| 其他 | 30日目.ks | torahiko |
| 其他 | 30日目.ks | orig |
| 辰樹 | 辰樹_m_08.ks | orig |
| 孝之助 | 孝之助_m_08.ks | orig |
| 洸哉 | 洸哉_m_08.ks | orig |
| 柔一 | 柔一_m_07.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day29 | 未知 | ８月29日 | 0 | ✗ 新版独有 |
| end29 | 未知 | - | 0 | ✗ 新版独有 |
| juuichi29 | 未知 | Dreaming of the Two from that Day | 158 | ✗ 新版独有 |
| juuichi29_confession | 未知 | Words Reflected in the Sunset | 64 | ✗ 新版独有 |
| juuichi29_kodori | 未知 | The Search for the Crescent | 309 | ✗ 新版独有 |
| juuichi29_rival_captain | 未知 | Rivals Then, Friends Now | 42 | ✗ 新版独有 |
| juuichi29_rival_ten | 未知 | Rivals Then, Friends Now | 39 | ✗ 新版独有 |
| juuichi29_sex | 未知 | Deep Twilight, Strong Feelings | 174 | ✗ 新版独有 |
| juuichi29_ten_fight | 未知 | War Cry Chat | 73 | ✗ 新版独有 |
| juuichi29_wolf | 未知 | That Ferocious Man | 251 | ✗ 新版独有 |
| kounosuke29 | 未知 | What was promised | 3 | ✗ 新版独有 |
| kounosuke29_homework | 未知 | The Words I Could Not Say | 46 | ✗ 新版独有 |
| kounosuke29_sex | 未知 | A Lover's Proof | 320 | ✗ 新版独有 |
| kouya29 | 未知 | What Lies Ahead of Him | 140 | ✗ 新版独有 |
| kouya29_sex | 未知 | His Tune | 260 | ✗ 新版独有 |
| tatsuki29 | 未知 | Feeling the Wind | 25 | ✗ 新版独有 |
| tatsuki29_destruction | 未知 | Becoming a Legend | 32 | ✗ 新版独有 |
| tatsuki29_flying | 未知 | Skylab | 158 | ✗ 新版独有 |
| tatsuki29_friends | 未知 | Our Friends | 52 | ✗ 新版独有 |
| torahiko29 | 未知 | The Joy of Studying | 110 | ✗ 新版独有 |
| torahiko29_sex | 未知 | The Joy of Studying | 203 | ✗ 新版独有 |

#### 新版独有路线

- **day29** (未知): 0 条未翻译文本
- **end29** (未知): 0 条未翻译文本
- **juuichi29** (未知): 158 条未翻译文本
- **juuichi29_confession** (未知): 64 条未翻译文本
- **juuichi29_kodori** (未知): 309 条未翻译文本
- **juuichi29_rival_captain** (未知): 42 条未翻译文本
- **juuichi29_rival_ten** (未知): 39 条未翻译文本
- **juuichi29_sex** (未知): 174 条未翻译文本
- **juuichi29_ten_fight** (未知): 73 条未翻译文本
- **juuichi29_wolf** (未知): 251 条未翻译文本
- **kounosuke29** (未知): 3 条未翻译文本
- **kounosuke29_homework** (未知): 46 条未翻译文本
- **kounosuke29_sex** (未知): 320 条未翻译文本
- **kouya29** (未知): 140 条未翻译文本
- **kouya29_sex** (未知): 260 条未翻译文本
- **tatsuki29** (未知): 25 条未翻译文本
- **tatsuki29_destruction** (未知): 32 条未翻译文本
- **tatsuki29_flying** (未知): 158 条未翻译文本
- **tatsuki29_friends** (未知): 52 条未翻译文本
- **torahiko29** (未知): 110 条未翻译文本
- **torahiko29_sex** (未知): 203 条未翻译文本

---

### Day 30

#### 旧版 KS 路线文件

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | 30日目.ks (虎彦路线) | torahiko |
| 其他 | エンディング.ks | torahiko |
| 其他 | エンディング.ks | orig |
| 辰樹 | 辰樹_m_09.ks | orig |
| 孝之助 | 孝之助_m_09.ks | orig |
| 峻 | 峻_m_06.ks | orig |
| 洸哉 | 洸哉_m_09.ks | orig |
| 柔一 | 柔一_m_08.ks | orig |
| 深 | 深_m_09.ks | orig |

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| day30 | 未知 | ８月30日 | 0 | ✗ 新版独有 |
| juuichi30 | 未知 | Our First and Last Village Date | 99 | ✗ 新版独有 |
| juuichi30_goodbye_album | 未知 | A Gift to Remember | 49 | ✗ 新版独有 |
| juuichi30_goodbye_jacket | 未知 | - | 23 | ✗ 新版独有 |
| juuichi30_sex | 未知 | Mixed Heartbeats | 385 | ✗ 新版独有 |
| kounosuke30 | 未知 | - | 6 | ✗ 新版独有 |
| kounosuke30_badend | 未知 | Kounosuke | 16 | ✗ 新版独有 |
| kounosuke30_confession | 未知 | Confession | 3 | ✗ 新版独有 |
| kounosuke30_farewell_nana | 未知 | Bye Bye | 3 | ✗ 新版独有 |
| kounosuke30_gathering | 未知 | - | 151 | ✗ 新版独有 |
| kounosuke30_goodend | 未知 | Once again, A Tanuki in the Forest | 78 | ✗ 新版独有 |
| kounosuke30_meteor | 未知 | - | 49 | ✗ 新版独有 |
| kounosuke30_promise | 未知 | Recalled Promise | 12 | ✗ 新版独有 |
| kouya30 | 未知 | The Summer that Passed By | 253 | ✗ 新版独有 |
| shin30 | 未知 | Farewell Party | 214 | ✗ 新版独有 |
| shin30_bakery | 未知 | My Dream | 36 | ✗ 新版独有 |
| shin30_goodbye | 未知 | The Last Day | 58 | ✗ 新版独有 |
| shin30_goodbye_kiss | 未知 | A Kiss Goodbye, and for a New Beginning | 28 | ✗ 新版独有 |
| shin30_goodbye_normal | 未知 | Don't Cry | 3 | ✗ 新版独有 |
| shin30_lastnight | 未知 | Two People Watching the Stars, Wishing | 53 | ✗ 新版独有 |
| shin30_number_swap | 未知 | Number Exchange | 27 | ✗ 新版独有 |
| shun30 | 未知 | Wishing Stars Flowing Through the Night | 216 | ✗ 新版独有 |
| tatsuki30 | 未知 | Every Day is my Favorite Day | 80 | ✗ 新版独有 |
| tatsuki30_chuukichi | 未知 | Chuukichi... | 14 | ✗ 新版独有 |
| tatsuki30_sex | 未知 | Night of the Meteor Shower | 214 | ✗ 新版独有 |
| tatsuki30_tappei | 未知 | Tappei... | 6 | ✗ 新版独有 |
| tatsuki30_tatsuki | 未知 | Tatsuki | 2 | ✗ 新版独有 |
| tatsuki30_walk | 未知 | At Summer's Conclusion | 142 | ✗ 新版独有 |
| torahiko30 | 未知 | The Moonlight Promise | 293 | ✗ 新版独有 |

#### 新版独有路线

- **day30** (未知): 0 条未翻译文本
- **juuichi30** (未知): 99 条未翻译文本
- **juuichi30_goodbye_album** (未知): 49 条未翻译文本
- **juuichi30_goodbye_jacket** (未知): 23 条未翻译文本
- **juuichi30_sex** (未知): 385 条未翻译文本
- **kounosuke30** (未知): 6 条未翻译文本
- **kounosuke30_badend** (未知): 16 条未翻译文本
- **kounosuke30_confession** (未知): 3 条未翻译文本
- **kounosuke30_farewell_nana** (未知): 3 条未翻译文本
- **kounosuke30_gathering** (未知): 151 条未翻译文本
- **kounosuke30_goodend** (未知): 78 条未翻译文本
- **kounosuke30_meteor** (未知): 49 条未翻译文本
- **kounosuke30_promise** (未知): 12 条未翻译文本
- **kouya30** (未知): 253 条未翻译文本
- **shin30** (未知): 214 条未翻译文本
- **shin30_bakery** (未知): 36 条未翻译文本
- **shin30_goodbye** (未知): 58 条未翻译文本
- **shin30_goodbye_kiss** (未知): 28 条未翻译文本
- **shin30_goodbye_normal** (未知): 3 条未翻译文本
- **shin30_lastnight** (未知): 53 条未翻译文本
- **shin30_number_swap** (未知): 27 条未翻译文本
- **shun30** (未知): 216 条未翻译文本
- **tatsuki30** (未知): 80 条未翻译文本
- **tatsuki30_chuukichi** (未知): 14 条未翻译文本
- **tatsuki30_sex** (未知): 214 条未翻译文本
- **tatsuki30_tappei** (未知): 6 条未翻译文本
- **tatsuki30_tatsuki** (未知): 2 条未翻译文本
- **tatsuki30_walk** (未知): 142 条未翻译文本
- **torahiko30** (未知): 293 条未翻译文本

---

## 特殊文件对比

### Welcome Party

**类型**: special_rpy

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| begin | 未知 | The Letter | 8 | ✗ 新版独有 |
| party_end | 未知 | The Party in Full Swing | 1 | ✗ 新版独有 |
| sit_with_juuichi | 未知 | Juuichi-san is still continuing with judo, huh? | 7 | ✗ 新版独有 |
| sit_with_kounosuke | 未知 | Next to Kounosuke | 0 | ✗ 新版独有 |
| sit_with_kouya | 未知 | Next to Kouya | 4 | ✗ 新版独有 |
| sit_with_kyoutarou | 未知 | Across from Kyouji-senpai and Soutarou-kun | 4 | ✗ 新版独有 |
| sit_with_shin | 未知 | Next to Shin-kun | 0 | ✗ 新版独有 |
| sit_with_shun | 未知 | Dinner with Shun | 1 | ✗ 新版独有 |
| sit_with_tatsuki | 未知 | Together With Tatsu-nii | 4 | ✗ 新版独有 |
| sit_with_torahiko | 未知 | Torahiko's Welcome | 15 | ✗ 新版独有 |

#### 新版独有路线

- **begin** (未知): 8 条未翻译文本
- **party_end** (未知): 1 条未翻译文本
- **sit_with_juuichi** (未知): 7 条未翻译文本
- **sit_with_kounosuke** (未知): 0 条未翻译文本
- **sit_with_kouya** (未知): 4 条未翻译文本
- **sit_with_kyoutarou** (未知): 4 条未翻译文本
- **sit_with_shin** (未知): 0 条未翻译文本
- **sit_with_shun** (未知): 1 条未翻译文本
- **sit_with_tatsuki** (未知): 4 条未翻译文本
- **sit_with_torahiko** (未知): 15 条未翻译文本

---

### Endings

**类型**: special_rpy

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| ending_message | 未知 | - | 0 | ✗ 新版独有 |
| endings | 未知 | - | 0 | ✗ 新版独有 |
| fin | 未知 | - | 0 | ✗ 新版独有 |
| juuichi_ending | 未知 | - | 0 | ✗ 新版独有 |
| kounosuke_done | 未知 | - | 0 | ✗ 新版独有 |
| kounosuke_end_bad | 未知 | - | 5 | ✗ 新版独有 |
| kounosuke_end_good | 未知 | - | 5 | ✗ 新版独有 |
| kounosuke_ending | 未知 | - | 0 | ✗ 新版独有 |
| kouya_ending | 未知 | - | 0 | ✗ 新版独有 |
| new_afterword | 未知 | - | 1 | ✗ 新版独有 |
| shin_done | 未知 | - | 0 | ✗ 新版独有 |
| shin_end_normal | 未知 | - | 22 | ✗ 新版独有 |
| shin_end_true | 未知 | - | 13 | ✗ 新版独有 |
| shin_ending | 未知 | - | 0 | ✗ 新版独有 |
| shun_ending | 未知 | - | 0 | ✗ 新版独有 |
| tatsuki_ending | 未知 | - | 0 | ✗ 新版独有 |
| torahiko_ending | 未知 | - | 0 | ✗ 新版独有 |

#### 新版独有路线

- **ending_message** (未知): 0 条未翻译文本
- **endings** (未知): 0 条未翻译文本
- **fin** (未知): 0 条未翻译文本
- **juuichi_ending** (未知): 0 条未翻译文本
- **kounosuke_done** (未知): 0 条未翻译文本
- **kounosuke_end_bad** (未知): 5 条未翻译文本
- **kounosuke_end_good** (未知): 5 条未翻译文本
- **kounosuke_ending** (未知): 0 条未翻译文本
- **kouya_ending** (未知): 0 条未翻译文本
- **new_afterword** (未知): 1 条未翻译文本
- **shin_done** (未知): 0 条未翻译文本
- **shin_end_normal** (未知): 22 条未翻译文本
- **shin_end_true** (未知): 13 条未翻译文本
- **shin_ending** (未知): 0 条未翻译文本
- **shun_ending** (未知): 0 条未翻译文本
- **tatsuki_ending** (未知): 0 条未翻译文本
- **torahiko_ending** (未知): 0 条未翻译文本

---

### Replay

**类型**: special_rpy

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| nanafuse00 | 未知 | A Lie | 102 | ✗ 新版独有 |

#### 新版独有路线

- **nanafuse00** (未知): 102 条未翻译文本

---

### nameinput

**类型**: special_rpy

#### RPY 路线标签对比

| 标签 | 角色 | 事件 | 条目数 | 旧版状态 |
|------|------|------|--------|---------|
| name_input | 未知 | My name is... | 0 | ✗ 新版独有 |
| ready | 未知 | - | 0 | ✗ 新版独有 |
| yourname | 未知 | - | 0 | ✗ 新版独有 |

#### 新版独有路线

- **name_input** (未知): 0 条未翻译文本
- **ready** (未知): 0 条未翻译文本
- **yourname** (未知): 0 条未翻译文本

---

### キャンプ01.ks

**类型**: special_ks

#### 旧版 KS 对应文件/角色

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | キャンプ01.ks | orig |
| 深 | キャンプ01.ks | orig |
| 孝之助 | キャンプ01.ks | orig |
| 洸哉 | キャンプ01.ks | orig |
| 峻 | キャンプ01.ks | orig |
| 辰樹 | キャンプ01.ks | orig |
| 柔一 | キャンプ01.ks | orig |
| 京慈 | キャンプ01.ks | orig |

---

### キャンプ02.ks

**类型**: special_ks

#### 旧版 KS 对应文件/角色

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | キャンプ02.ks | orig |
| 深 | キャンプ02.ks | orig |
| 孝之助 | キャンプ02.ks | orig |
| 洸哉 | キャンプ02.ks | orig |
| 峻 | キャンプ02.ks | orig |
| 辰樹 | キャンプ02.ks | orig |
| 柔一 | キャンプ02.ks | orig |
| 京慈 | キャンプ02.ks | orig |
| 共通（分岐） | キャンプ02.ks | orig |

---

### c_海水浴.ks

**类型**: special_ks

#### 旧版 KS 对应文件/角色

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 共通 | c_海水浴.ks | orig |
| 虎彦 | c_海水浴.ks | orig |
| 深 | c_海水浴.ks | orig |
| 孝之助 | c_海水浴.ks | orig |
| 洸哉 | c_海水浴.ks | orig |
| 峻 | c_海水浴.ks | orig |
| 辰樹 | c_海水浴.ks | orig |
| 柔一 | c_海水浴.ks | orig |
| 京慈 | c_海水浴.ks | orig |

---

### オープニング.ks

**类型**: special_ks

#### 旧版 KS 对应文件/角色

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 共通 | オープニング.ks (orig) | orig |
| 共通 | オープニング.ks (torahiko) | torahiko |

---

### エンディング.ks

**类型**: special_ks

#### 旧版 KS 对应文件/角色

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | エンディング.ks (orig) | orig |
| 虎彦 | エンディング.ks (torahiko) | torahiko |
| 深 | エンディング.ks (orig) | orig |
| 深 | エンディング.ks (torahiko) | torahiko |
| 孝之助 | エンディング.ks (orig) | orig |
| 孝之助 | エンディング.ks (torahiko) | torahiko |
| 洸哉 | エンディング.ks (orig) | orig |
| 洸哉 | エンディング.ks (torahiko) | torahiko |
| 峻 | エンディング.ks (orig) | orig |
| 峻 | エンディング.ks (torahiko) | torahiko |
| 柔一 | エンディング.ks (torahiko) | torahiko |
| 京慈 | エンディング.ks (torahiko) | torahiko |
| 七伏 | エンディング.ks (torahiko) | torahiko |

---

### オープニング.ks

**类型**: special_ks

#### 旧版 KS 对应文件/角色

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 共通 | オープニング.ks (orig) | orig |
| 共通 | オープニング.ks (torahiko) | torahiko |

---

### エンディング.ks

**类型**: special_ks

#### 旧版 KS 对应文件/角色

| 角色 | 文件名 | 来源目录 |
|------|--------|---------|
| 虎彦 | エンディング.ks (orig) | orig |
| 虎彦 | エンディング.ks (torahiko) | torahiko |
| 深 | エンディング.ks (orig) | orig |
| 深 | エンディング.ks (torahiko) | torahiko |
| 孝之助 | エンディング.ks (orig) | orig |
| 孝之助 | エンディング.ks (torahiko) | torahiko |
| 洸哉 | エンディング.ks (orig) | orig |
| 洸哉 | エンディング.ks (torahiko) | torahiko |
| 峻 | エンディング.ks (orig) | orig |
| 峻 | エンディング.ks (torahiko) | torahiko |
| 柔一 | エンディング.ks (torahiko) | torahiko |
| 京慈 | エンディング.ks (torahiko) | torahiko |
| 七伏 | エンディング.ks (torahiko) | torahiko |

---

## 新增路线汇总

以下是仅在 Ren'Py 新版本中出现、在原版 KS 中不存在的路由标签：

| 文件/天数 | 标签 | 角色 | 条目数 |
|-----------|------|------|--------|
| Day 2 | day02 | 未知 | 1 |
| Day 2 | end02 | 未知 | 0 |
| Day 2 | river02_can_remember | 未知 | 25 |
| Day 2 | river02_cannot_remember | 未知 | 35 |
| Day 2 | river02_memory | 未知 | 89 |
| Day 2 | river02_story_time | 未知 | 36 |
| Day 2 | shin02_actually_cheap | 未知 | 0 |
| Day 2 | shin02_amaki_recipe | 未知 | 0 |
| Day 2 | shin02_an_import | 未知 | 0 |
| Day 2 | shin02_something_handmade | 未知 | 0 |
| Day 2 | tatsuki02_coworkers | 未知 | 9 |
| Day 2 | tatsuki02_eat | 未知 | 1 |
| Day 2 | tatsuki02_hangout | 未知 | 4 |
| Day 3 | candy03_shin | 未知 | 68 |
| Day 3 | candy03_tatsuki | 未知 | 45 |
| Day 3 | day03 | 未知 | 1 |
| Day 3 | end03 | 未知 | 0 |
| Day 4 | day04 | 未知 | 0 |
| Day 4 | day04_phonecall | 未知 | 11 |
| Day 4 | day04_regularday | 未知 | 1 |
| Day 4 | end04 | 未知 | 0 |
| Day 4 | juuichi04_rideback | 未知 | 124 |
| Day 4 | shin04 | 未知 | 34 |
| Day 4 | shin04_after | 未知 | 11 |
| Day 4 | shin04_commoner | 未知 | 4 |
| Day 4 | shin04_familial | 未知 | 4 |
| Day 4 | shun04_biteshun | 未知 | 18 |
| Day 4 | shun04_bitesou | 未知 | 32 |
| Day 4 | tatsuki04_help | 未知 | 28 |
| Day 4 | tatsuki04_party | 未知 | 32 |
| Day 4 | tatsuki04_scold | 未知 | 11 |
| Day 5 | day05 | 未知 | 1 |
| Day 5 | end05 | 未知 | 0 |
| Day 5 | kouya05 | 未知 | 61 |
| Day 5 | kouya05_cheese | 未知 | 25 |
| Day 5 | kouya05_salad | 未知 | 31 |
| Day 5 | kouya05_takoyaki | 未知 | 106 |
| Day 5 | tatsuki05_accept | 未知 | 34 |
| Day 5 | tatsuki05_avoid | 未知 | 13 |
| Day 5 | tatsuki05_busy | 未知 | 12 |
| Day 6 | day06 | 未知 | 37 |
| Day 6 | day06_accepttest | 未知 | 22 |
| Day 6 | day06_declinetest | 未知 | 12 |
| Day 6 | day06_kounotest | 未知 | 157 |
| Day 6 | day06_pick_kounosuke | 未知 | 3 |
| Day 6 | day06_pick_shun | 未知 | 4 |
| Day 6 | day06_pick_torahiko | 未知 | 3 |
| Day 6 | day06_shuntest | 未知 | 188 |
| Day 6 | day06_testbegin | 未知 | 32 |
| Day 6 | day06_testend | 未知 | 9 |
| Day 6 | day06_testofcourage | 未知 | 78 |
| Day 6 | day06_toratest | 未知 | 169 |
| Day 6 | end06 | 未知 | 0 |
| Day 6 | torahiko06_delicious | 未知 | 19 |
| Day 6 | torahiko06_disgusting | 未知 | 25 |
| Day 6 | torahiko06_notgood | 未知 | 25 |
| Day 7 | beach07_buckleup | 未知 | 15 |
| Day 7 | beach07_choice | 未知 | 0 |
| Day 7 | beach07_hangloose | 未知 | 18 |
| Day 7 | beach07_invite_juuichi | 未知 | 35 |
| Day 7 | beach07_invite_kounosuke | 未知 | 25 |
| Day 7 | beach07_invite_kouya | 未知 | 20 |
| Day 7 | beach07_invite_shin | 未知 | 22 |
| Day 7 | beach07_invite_shun | 未知 | 32 |
| Day 7 | beach07_invite_soutarou | 未知 | 31 |
| Day 7 | beach07_invite_tatsuki | 未知 | 14 |
| Day 7 | beach07_invite_torahiko | 未知 | 26 |
| Day 7 | beach07_juuichi | 柔一 | 395 |
| Day 7 | beach07_kounosuke | 孝之助 | 92 |
| Day 7 | beach07_kouya | 洸哉 | 91 |
| Day 7 | beach07_kyoutarou | 京慈 | 120 |
| Day 7 | beach07_meetup | 未知 | 173 |
| Day 7 | beach07_packing | 未知 | 29 |
| Day 7 | beach07_ridehome | 未知 | 32 |
| Day 7 | beach07_shin | 深 | 70 |
| Day 7 | beach07_shun | 峻 | 50 |
| Day 7 | beach07_tatsuki | 辰樹 | 58 |
| Day 7 | day07 | 未知 | 6 |
| Day 8 | day08 | 未知 | 14 |
| Day 8 | day08_pictures_kouno | 未知 | 102 |
| Day 8 | day08_pictures_shun | 未知 | 111 |
| Day 8 | day08_pictures_tora | 未知 | 110 |
| Day 8 | end08 | 未知 | 0 |
| Day 8 | kouya08_pass | 未知 | 9 |
| Day 8 | kouya08_teachme | 未知 | 86 |
| Day 8 | tatsuki08_couple | 未知 | 25 |
| Day 8 | tatsuki08_join | 未知 | 35 |
| Day 8 | tatsuki08_stop | 未知 | 29 |
| Day 9 | day09 | 未知 | 1 |
| Day 9 | end09 | 未知 | 0 |
| Day 9 | juuichi09_borrow | 未知 | 8 |
| Day 9 | juuichi09_help | 未知 | 32 |
| Day 9 | juuichi09_nohelp | 未知 | 24 |
| Day 9 | juuichi09_return | 未知 | 8 |
| Day 9 | juuichi09_talk | 未知 | 101 |
| Day 9 | shin09_call | 未知 | 95 |
| Day 9 | shin09_continue | 未知 | 26 |
| Day 9 | shin09_cpr | 未知 | 74 |
| Day 9 | shin09_follow | 未知 | 21 |
| Day 9 | shin09_ignore | 未知 | 8 |
| Day 9 | shin09_rest | 未知 | 11 |
| Day 9 | shin09_shout | 未知 | 54 |
| Day 9 | shin09a | 未知 | 0 |
| Day 9 | shin09b | 未知 | 0 |
| Day 9 | shun09_fighting | 未知 | 23 |
| Day 9 | shun09_oldgame | 未知 | 42 |
| Day 9 | shun09_puzzle | 未知 | 23 |
| Day 9 | tatsuki09_goout | 未知 | 12 |
| Day 9 | tatsuki09_hangout | 未知 | 11 |
| Day 9 | tatsuki09_help | 未知 | 18 |
| Day 10 | day10 | 未知 | 1 |
| Day 10 | end10 | 未知 | 0 |
| Day 10 | juuichi10_hesitation | 未知 | 4 |
| Day 10 | juuichi10_manage | 未知 | 68 |
| Day 10 | juuichi10_memo | 未知 | 173 |
| Day 10 | juuichi10_memory | 未知 | 2 |
| Day 10 | juuichi10_understood | 未知 | 2 |
| Day 10 | kounosuke10_busy | 未知 | 4 |
| Day 10 | kounosuke10_lastweek | 未知 | 22 |
| Day 10 | shun10_badgame | 未知 | 5 |
| Day 10 | shun10_gametalk1 | 未知 | 12 |
| Day 10 | shun10_gametalk2 | 未知 | 7 |
| Day 10 | shun10_goodgame | 未知 | 58 |
| Day 10 | shun10_newgame | 未知 | 19 |
| Day 10 | shun10_nostalgia | 未知 | 22 |
| Day 10 | shun10_play | 未知 | 14 |
| Day 10 | shun10_sleepy | 未知 | 34 |
| Day 11 | day11 | 未知 | 1 |
| Day 11 | end11 | 未知 | 0 |
| Day 11 | juuichi11_dodge | 未知 | 72 |
| Day 11 | juuichi11_swimming | 未知 | 26 |
| Day 11 | juuichi11_tennis | 未知 | 40 |
| Day 11 | shin11_leave | 未知 | 26 |
| Day 11 | shin11_stay | 未知 | 24 |
| Day 11 | tatsuki11_bottom | 未知 | 44 |
| Day 11 | tatsuki11_fireworks | 未知 | 40 |
| Day 11 | tatsuki11_food | 未知 | 42 |
| Day 11 | tatsuki11_fountain | 未知 | 24 |
| Day 11 | tatsuki11_proceed | 未知 | 36 |
| Day 11 | tatsuki11_rocket | 未知 | 31 |
| Day 11 | tatsuki11_showtime | 未知 | 47 |
| Day 11 | tatsuki11_stop | 未知 | 10 |
| Day 12 | day12 | 未知 | 1 |
| Day 12 | end12 | 未知 | 0 |
| Day 12 | juuichi12_body | 未知 | 89 |
| Day 12 | juuichi12_stick | 未知 | 53 |
| Day 12 | kouya12_continue | 未知 | 41 |
| Day 12 | kouya12_go | 未知 | 18 |
| Day 12 | kouya12_lake | 未知 | 76 |
| Day 12 | kouya12_me | 未知 | 64 |
| Day 12 | kouya12_pass | 未知 | 23 |
| Day 12 | kouya12_you | 未知 | 40 |
| Day 12 | tatsuki12_force | 未知 | 84 |
| Day 12 | tatsuki12_quiet | 未知 | 31 |
| Day 12 | tatsuki12_shigure | 未知 | 66 |
| Day 12 | tatsuki12_tappei | 未知 | 60 |
| Day 13 | day13 | 未知 | 1 |
| Day 13 | end13 | 未知 | 0 |
| Day 13 | shun13_alone | 未知 | 10 |
| Day 13 | shun13_carpenters | 未知 | 113 |
| Day 13 | shun13_gohome | 未知 | 1 |
| Day 13 | shun13_play | 未知 | 35 |
| Day 13 | shun13_surprise | 未知 | 9 |
| Day 13 | tatsuki13_done | 未知 | 66 |
| Day 13 | tatsuki13_inside | 未知 | 27 |
| Day 13 | tatsuki13_kyouji | 未知 | 27 |
| Day 13 | tatsuki13_outside | 未知 | 28 |
| Day 13 | tatsuki13_rest | 未知 | 75 |
| Day 13 | tatsuki13_tatsuki | 未知 | 48 |
| Day 13 | tatsuki13_torahiko | 未知 | 38 |
| Day 14 | day14 | 未知 | 400 |
| Day 15 | camp15_choice | 未知 | 0 |
| Day 15 | camp15_confess_juuichi | 未知 | 32 |
| Day 15 | camp15_confess_kounosuke | 未知 | 26 |
| Day 15 | camp15_confess_kouya | 未知 | 63 |
| Day 15 | camp15_confess_shin | 未知 | 26 |
| Day 15 | camp15_confess_shun | 未知 | 26 |
| Day 15 | camp15_confess_tatsuki | 未知 | 58 |
| Day 15 | camp15_confess_torahiko | 未知 | 34 |
| Day 15 | camp15_explore | 未知 | 12 |
| Day 15 | camp15_juuichi | 柔一 | 176 |
| Day 15 | camp15_kounosuke | 孝之助 | 162 |
| Day 15 | camp15_kouya | 洸哉 | 226 |
| Day 15 | camp15_mumble1 | 未知 | 2 |
| Day 15 | camp15_mumble2 | 未知 | 2 |
| Day 15 | camp15_packup | 未知 | 27 |
| Day 15 | camp15_shin | 深 | 112 |
| Day 15 | camp15_shun | 峻 | 63 |
| Day 15 | camp15_tatsuki | 孝之助 | 113 |
| Day 15 | camp15_wakeup_juuichi | 未知 | 30 |
| Day 15 | camp15_wakeup_kounosuke | 未知 | 21 |
| Day 15 | camp15_wakeup_kouya | 未知 | 23 |
| Day 15 | camp15_wakeup_shin | 未知 | 17 |
| Day 15 | camp15_wakeup_shun | 未知 | 45 |
| Day 15 | camp15_wakeup_tatsuki | 未知 | 4 |
| Day 15 | camp15_wakeup_torahiko | 未知 | 35 |
| Day 15 | day15 | 未知 | 0 |
| Day 15 | end15 | 未知 | 0 |
| Day 16 | day16 | 未知 | 0 |
| Day 16 | end16 | 未知 | 0 |
| Day 16 | kounosuke16 | 未知 | 19 |
| Day 16 | kounosuke16_bedroom | 未知 | 26 |
| Day 16 | kounosuke16_photos_no | 未知 | 30 |
| Day 16 | kounosuke16_photos_yes | 未知 | 14 |
| Day 16 | kounosuke16_plan | 未知 | 76 |
| Day 16 | kounosuke16_yukiharu_no | 未知 | 28 |
| Day 16 | kounosuke16_yukiharu_yes | 未知 | 22 |
| Day 16 | kouya16 | 未知 | 306 |
| Day 16 | map16 | 未知 | 1 |
| Day 16 | shin16 | 未知 | 6 |
| Day 16 | shin16_amaki_past | 未知 | 5 |
| Day 16 | shin16_amaki_recent | 未知 | 4 |
| Day 16 | shin16_desk_inside | 未知 | 55 |
| Day 16 | shin16_desk_top | 未知 | 49 |
| Day 16 | shin16_garden | 未知 | 82 |
| Day 16 | shin16_lesson_accept | 未知 | 26 |
| Day 16 | shin16_lesson_decline | 未知 | 42 |
| Day 16 | shin16_sit | 未知 | 13 |
| Day 16 | shin16_sit_bed | 未知 | 3 |
| Day 16 | shin16_sit_floor | 未知 | 18 |
| Day 16 | shin16_snacks | 未知 | 92 |
| Day 16 | shun16 | 未知 | 128 |
| Day 16 | shun16_evening | 未知 | 104 |
| Day 16 | shun16_plans_camping | 未知 | 12 |
| Day 16 | shun16_plans_discuss | 未知 | 32 |
| Day 16 | shun16_plans_festival | 未知 | 19 |
| Day 16 | shun16_sex | 未知 | 267 |
| Day 16 | tatsuki16 | 未知 | 532 |
| Day 16 | torahiko16 | 未知 | 120 |
| Day 17 | day17 | 未知 | 0 |
| Day 17 | end17 | 未知 | 0 |
| Day 17 | kounosuke17 | 未知 | 11 |
| Day 17 | kounosuke17_accept | 未知 | 2 |
| Day 17 | kounosuke17_ate | 未知 | 11 |
| Day 17 | kounosuke17_confession | 未知 | 32 |
| Day 17 | kounosuke17_cooldown | 未知 | 22 |
| Day 17 | kounosuke17_decline | 未知 | 2 |
| Day 17 | kounosuke17_notyet | 未知 | 16 |
| Day 17 | kounosuke17_photography | 未知 | 303 |
| Day 17 | kounosuke17_reward | 未知 | 4 |
| Day 17 | kounosuke17_what | 未知 | 14 |
| Day 17 | shun17 | 未知 | 54 |
| Day 17 | torahiko17 | 未知 | 214 |
| Day 18 | day18 | 未知 | 0 |
| Day 18 | end18 | 未知 | 0 |
| Day 18 | map18 | 未知 | 1 |
| Day 18 | shun18 | 未知 | 123 |
| Day 18 | shun18_support_neither | 未知 | 21 |
| Day 18 | shun18_support_shin | 未知 | 24 |
| Day 18 | shun18_support_shun | 未知 | 49 |
| Day 18 | torahiko18 | 未知 | 83 |
| Day 19 | day19 | 未知 | 0 |
| Day 19 | end19 | 未知 | 0 |
| Day 19 | juuichi19 | 未知 | 64 |
| Day 19 | juuichi19_cup | 未知 | 19 |
| Day 19 | juuichi19_friend | 未知 | 67 |
| Day 19 | juuichi19_lover | 未知 | 45 |
| Day 19 | juuichi19_softserve | 未知 | 16 |
| Day 19 | juuichi19_talk | 未知 | 85 |
| Day 19 | kouya19 | 未知 | 117 |
| Day 19 | map19 | 未知 | 1 |
| Day 19 | torahiko19 | 未知 | 143 |
| Day 20 | day20 | 未知 | 0 |
| Day 20 | end20 | 未知 | 0 |
| Day 20 | kouya20 | 未知 | 75 |
| Day 20 | kouya20_accept | 未知 | 190 |
| Day 20 | kouya20_crude | 未知 | 17 |
| Day 20 | kouya20_dinner | 未知 | 90 |
| Day 20 | kouya20_steady | 未知 | 18 |
| Day 20 | map20 | 未知 | 1 |
| Day 20 | shin20 | 未知 | 5 |
| Day 20 | shin20_baking | 未知 | 113 |
| Day 20 | shin20_homework | 未知 | 99 |
| Day 20 | shun20 | 未知 | 19 |
| Day 20 | shun20_angry_gaku | 未知 | 8 |
| Day 20 | shun20_exhausted | 未知 | 42 |
| Day 20 | shun20_kiss | 未知 | 28 |
| Day 20 | shun20_lap | 未知 | 66 |
| Day 20 | shun20_play_accept | 未知 | 34 |
| Day 20 | shun20_play_refuse | 未知 | 16 |
| Day 20 | shun20_visit_kounosuke | 未知 | 56 |
| Day 20 | shun20_visit_tatsuki | 未知 | 54 |
| Day 20 | tatsuki20 | 未知 | 129 |
| Day 20 | tatsuki20_alcohol | 未知 | 4 |
| Day 20 | tatsuki20_drunk | 未知 | 24 |
| Day 20 | tatsuki20_fish | 未知 | 6 |
| Day 20 | tatsuki20_hotsprings | 未知 | 103 |
| Day 20 | tatsuki20_sweets | 未知 | 49 |
| Day 20 | torahiko20 | 未知 | 83 |
| Day 21 | day21 | 未知 | 0 |
| Day 21 | end21 | 未知 | 0 |
| Day 21 | kouya21 | 未知 | 171 |
| Day 21 | kouya21_avoid | 未知 | 11 |
| Day 21 | kouya21_badend | 未知 | 14 |
| Day 21 | kouya21_chase | 未知 | 32 |
| Day 21 | kouya21_forest | 未知 | 25 |
| Day 21 | kouya21_go | 未知 | 21 |
| Day 21 | kouya21_gohome | 未知 | 22 |
| Day 21 | kouya21_lake | 未知 | 27 |
| Day 21 | kouya21_letter | 未知 | 91 |
| Day 21 | kouya21_reason | 未知 | 113 |
| Day 21 | kouya21_river | 未知 | 20 |
| Day 21 | kouya21_stay | 未知 | 10 |
| Day 21 | kouya21_unsure | 未知 | 43 |
| Day 21 | torahiko21 | 未知 | 268 |
| Day 22 | day22 | 未知 | 0 |
| Day 22 | end22 | 未知 | 0 |
| Day 22 | juuichi22 | 未知 | 527 |
| Day 22 | juuichi22_continue | 未知 | 5 |
| Day 22 | juuichi22_keep | 未知 | 106 |
| Day 22 | juuichi22_stop | 未知 | 21 |
| Day 22 | kounosuke22 | 未知 | 18 |
| Day 22 | kounosuke22_eat | 未知 | 6 |
| Day 22 | kounosuke22_fireworks | 未知 | 32 |
| Day 22 | kounosuke22_game | 未知 | 10 |
| Day 22 | kounosuke22_shooting | 未知 | 91 |
| Day 22 | kouya22 | 未知 | 407 |
| Day 22 | shin22 | 未知 | 31 |
| Day 22 | shin22_beautiful | 未知 | 3 |
| Day 22 | shin22_cute | 未知 | 5 |
| Day 22 | shin22_festival | 未知 | 73 |
| Day 22 | shin22_fireworks | 未知 | 36 |
| Day 22 | shin22_hand | 未知 | 13 |
| Day 22 | shin22_parents | 未知 | 135 |
| Day 22 | shun22 | 未知 | 0 |
| Day 22 | shun22_badend | 未知 | 50 |
| Day 22 | shun22_proceed | 未知 | 195 |
| Day 22 | tatsuki22 | 未知 | 162 |
| Day 22 | tatsuki22_delivery | 未知 | 253 |
| Day 22 | tatsuki22_drums | 未知 | 64 |
| Day 22 | tatsuki22_easy | 未知 | 70 |
| Day 22 | tatsuki22_first | 未知 | 61 |
| Day 22 | tatsuki22_god | 未知 | 109 |
| Day 22 | tatsuki22_help | 未知 | 68 |
| Day 22 | tatsuki22_masochist | 未知 | 7 |
| Day 22 | tatsuki22_power | 未知 | 39 |
| Day 22 | tatsuki22_prank | 未知 | 14 |
| Day 22 | tatsuki22_ringtoss | 未知 | 1 |
| Day 22 | tatsuki22_school | 未知 | 72 |
| Day 22 | tatsuki22_triple | 未知 | 23 |
| Day 22 | torahiko22 | 未知 | 440 |
| Day 23 | day23 | 未知 | 0 |
| Day 23 | end23 | 未知 | 0 |
| Day 23 | kouya23 | 未知 | 64 |
| Day 23 | kouya23_accepted | 未知 | 108 |
| Day 23 | kouya23_leader_known | 未知 | 53 |
| Day 23 | kouya23_leader_unknown | 未知 | 68 |
| Day 23 | tatsuki23 | 未知 | 115 |
| Day 23 | torahiko23 | 未知 | 216 |
| Day 23 | torahiko23_sex | 未知 | 177 |
| Day 24 | day24 | 未知 | 0 |
| Day 24 | end24 | 未知 | 0 |
| Day 24 | kounosuke24 | 未知 | 42 |
| Day 24 | kounosuke24_annoyed | 未知 | 16 |
| Day 24 | kounosuke24_patience | 未知 | 39 |
| Day 24 | map24 | 未知 | 1 |
| Day 24 | shin24 | 未知 | 37 |
| Day 24 | shin24_baking | 未知 | 7 |
| Day 24 | shin24_confess | 未知 | 42 |
| Day 24 | shin24_homework | 未知 | 4 |
| Day 24 | shin24_insult | 未知 | 42 |
| Day 24 | shin24_kiss | 未知 | 24 |
| Day 24 | shin24_please_go | 未知 | 64 |
| Day 24 | shin24_rape | 未知 | 46 |
| Day 24 | shin24_regret | 未知 | 13 |
| Day 24 | shun24 | 未知 | 8 |
| Day 24 | shun24_confusion | 未知 | 19 |
| Day 24 | shun24_enka | 未知 | 43 |
| Day 24 | shun24_pop | 未知 | 38 |
| Day 24 | shun24_practice | 未知 | 27 |
| Day 24 | torahiko24 | 未知 | 145 |
| Day 24 | torahiko24_sex | 未知 | 239 |
| Day 25 | day25 | 未知 | 0 |
| Day 25 | end25 | 未知 | 0 |
| Day 25 | kouya25 | 未知 | 94 |
| Day 25 | kouya25_band_meet | 未知 | 27 |
| Day 25 | kouya25_band_reunion | 未知 | 27 |
| Day 25 | kouya25_musikus | 未知 | 159 |
| Day 25 | tatsuki25 | 未知 | 94 |
| Day 25 | torahiko25 | 未知 | 162 |
| Day 26 | day26 | 未知 | 0 |
| Day 26 | end26 | 未知 | 0 |
| Day 26 | kounosuke26 | 未知 | 56 |
| Day 26 | kounosuke26_encourage | 未知 | 51 |
| Day 26 | kounosuke26_excuse | 未知 | 28 |
| Day 26 | kounosuke26_kouno_house | 未知 | 10 |
| Day 26 | kounosuke26_spiritual_guidence | 未知 | 4 |
| Day 26 | kouya26 | 未知 | 197 |
| Day 26 | kouya26_sex | 未知 | 240 |
| Day 26 | shin26 | 未知 | 53 |
| Day 26 | shin26_condemn | 未知 | 78 |
| Day 26 | shin26_explain | 未知 | 115 |
| Day 26 | shun26 | 未知 | 276 |
| Day 26 | shun26_sex | 未知 | 477 |
| Day 26 | torahiko26 | 未知 | 206 |
| Day 27 | day27 | 未知 | 0 |
| Day 27 | end27 | 未知 | 0 |
| Day 27 | kouya27 | 未知 | 231 |
| Day 27 | shin27 | 未知 | 1 |
| Day 27 | shin27_childhood_goodbye | 未知 | 42 |
| Day 27 | shin27_childhood_memory | 未知 | 48 |
| Day 27 | shin27_house | 未知 | 165 |
| Day 27 | shin27_normalend | 未知 | 65 |
| Day 27 | shin27_number_promise | 未知 | 11 |
| Day 27 | shin27_sex | 未知 | 97 |
| Day 27 | torahiko27 | 未知 | 109 |
| Day 28 | day28 | 未知 | 0 |
| Day 28 | end28 | 未知 | 0 |
| Day 28 | kouya28 | 未知 | 169 |
| Day 28 | shun28 | 未知 | 27 |
| Day 28 | shun28_catch | 未知 | 10 |
| Day 28 | shun28_cushion | 未知 | 36 |
| Day 28 | shun28_recover | 未知 | 24 |
| Day 28 | shun28_tail | 未知 | 8 |
| Day 28 | tatsuki28 | 未知 | 15 |
| Day 28 | tatsuki28_dumbass | 未知 | 226 |
| Day 28 | tatsuki28_goodbye | 未知 | 78 |
| Day 28 | tatsuki28_shutdown | 未知 | 78 |
| Day 28 | torahiko28 | 未知 | 222 |
| Day 29 | day29 | 未知 | 0 |
| Day 29 | end29 | 未知 | 0 |
| Day 29 | juuichi29 | 未知 | 158 |
| Day 29 | juuichi29_confession | 未知 | 64 |
| Day 29 | juuichi29_kodori | 未知 | 309 |
| Day 29 | juuichi29_rival_captain | 未知 | 42 |
| Day 29 | juuichi29_rival_ten | 未知 | 39 |
| Day 29 | juuichi29_sex | 未知 | 174 |
| Day 29 | juuichi29_ten_fight | 未知 | 73 |
| Day 29 | juuichi29_wolf | 未知 | 251 |
| Day 29 | kounosuke29 | 未知 | 3 |
| Day 29 | kounosuke29_homework | 未知 | 46 |
| Day 29 | kounosuke29_sex | 未知 | 320 |
| Day 29 | kouya29 | 未知 | 140 |
| Day 29 | kouya29_sex | 未知 | 260 |
| Day 29 | tatsuki29 | 未知 | 25 |
| Day 29 | tatsuki29_destruction | 未知 | 32 |
| Day 29 | tatsuki29_flying | 未知 | 158 |
| Day 29 | tatsuki29_friends | 未知 | 52 |
| Day 29 | torahiko29 | 未知 | 110 |
| Day 29 | torahiko29_sex | 未知 | 203 |
| Day 30 | day30 | 未知 | 0 |
| Day 30 | juuichi30 | 未知 | 99 |
| Day 30 | juuichi30_goodbye_album | 未知 | 49 |
| Day 30 | juuichi30_goodbye_jacket | 未知 | 23 |
| Day 30 | juuichi30_sex | 未知 | 385 |
| Day 30 | kounosuke30 | 未知 | 6 |
| Day 30 | kounosuke30_badend | 未知 | 16 |
| Day 30 | kounosuke30_confession | 未知 | 3 |
| Day 30 | kounosuke30_farewell_nana | 未知 | 3 |
| Day 30 | kounosuke30_gathering | 未知 | 151 |
| Day 30 | kounosuke30_goodend | 未知 | 78 |
| Day 30 | kounosuke30_meteor | 未知 | 49 |
| Day 30 | kounosuke30_promise | 未知 | 12 |
| Day 30 | kouya30 | 未知 | 253 |
| Day 30 | shin30 | 未知 | 214 |
| Day 30 | shin30_bakery | 未知 | 36 |
| Day 30 | shin30_goodbye | 未知 | 58 |
| Day 30 | shin30_goodbye_kiss | 未知 | 28 |
| Day 30 | shin30_goodbye_normal | 未知 | 3 |
| Day 30 | shin30_lastnight | 未知 | 53 |
| Day 30 | shin30_number_swap | 未知 | 27 |
| Day 30 | shun30 | 未知 | 216 |
| Day 30 | tatsuki30 | 未知 | 80 |
| Day 30 | tatsuki30_chuukichi | 未知 | 14 |
| Day 30 | tatsuki30_sex | 未知 | 214 |
| Day 30 | tatsuki30_tappei | 未知 | 6 |
| Day 30 | tatsuki30_tatsuki | 未知 | 2 |
| Day 30 | tatsuki30_walk | 未知 | 142 |
| Day 30 | torahiko30 | 未知 | 293 |
| Welcome Party | begin | 未知 | 8 |
| Welcome Party | party_end | 未知 | 1 |
| Welcome Party | sit_with_juuichi | 未知 | 7 |
| Welcome Party | sit_with_kounosuke | 未知 | 0 |
| Welcome Party | sit_with_kouya | 未知 | 4 |
| Welcome Party | sit_with_kyoutarou | 未知 | 4 |
| Welcome Party | sit_with_shin | 未知 | 0 |
| Welcome Party | sit_with_shun | 未知 | 1 |
| Welcome Party | sit_with_tatsuki | 未知 | 4 |
| Welcome Party | sit_with_torahiko | 未知 | 15 |
| Endings | ending_message | 未知 | 0 |
| Endings | endings | 未知 | 0 |
| Endings | fin | 未知 | 0 |
| Endings | juuichi_ending | 未知 | 0 |
| Endings | kounosuke_done | 未知 | 0 |
| Endings | kounosuke_end_bad | 未知 | 5 |
| Endings | kounosuke_end_good | 未知 | 5 |
| Endings | kounosuke_ending | 未知 | 0 |
| Endings | kouya_ending | 未知 | 0 |
| Endings | new_afterword | 未知 | 1 |
| Endings | shin_done | 未知 | 0 |
| Endings | shin_end_normal | 未知 | 22 |
| Endings | shin_end_true | 未知 | 13 |
| Endings | shin_ending | 未知 | 0 |
| Endings | shun_ending | 未知 | 0 |
| Endings | tatsuki_ending | 未知 | 0 |
| Endings | torahiko_ending | 未知 | 0 |
| Replay | nanafuse00 | 未知 | 102 |
| nameinput | name_input | 未知 | 0 |
| nameinput | ready | 未知 | 0 |
| nameinput | yourname | 未知 | 0 |

## 删除路线汇总

以下是原版 KS 中存在、但在 Ren'Py 新版本中已删除的路线文件：

| 角色 | 出现文件 |
|------|---------|
| 七伏 | エンディング.ks |
