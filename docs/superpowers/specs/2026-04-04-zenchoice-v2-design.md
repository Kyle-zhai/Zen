# ZenChoice v2 — 玄学决策娱乐 App 设计文档

## 定位

**「每天一签，做个果断的人」**

从「决策鼓励工具」升级为「玄学决策娱乐 App」。三大并行功能解决日活、传播、差异化三个核心问题。

## 产品架构

### 三大并行功能

用户通过顶部 Segmented Control 或滑动切换，三个功能平级并存：

```
[ 📿 今日签 ]  [ 🎯 决策鼓励 ]  [ 🌟 我的命格 ]
```

| 功能 | 频率 | 解决什么 | 付费点 |
|------|------|---------|--------|
| 今日签 | 每日 | 日活引擎——每天有理由打开 | 免费1签/天，加签需订阅 |
| 决策鼓励 | 按需 | 核心差异化——输入纠结获得AI鼓励 | 免费2次/天，无限需订阅 |
| 我的命格 | 一次+分享 | 病毒传播器——人格标签天然想晒 | 免费测试，详细解读需订阅 |

### 用户旅程

```
每天打开 → 抽今日签（30秒，截图分享）
          ↓ 签里说"今天适合做决定"
      → 输入一个纠结 → AI多维鼓励 → 分享卡片
          ↓ 觉得好玩
      → 做决策命格测试 → 分享结果卡片
          ↓ 朋友看到
      → 朋友点链接 → 下载app → 自己也测/抽签
```

---

## 功能一：今日签

### 签文结构

每签包含四个部分：

| 字段 | 风格 | 示例 |
|------|------|------|
| 今日宜 | 正经，有指导性 | 对在意的人说一句真心话 |
| 今日忌 | 幽默，有反转感 | 深夜网购——你清醒时不会想要充气恐龙 |
| 幸运决策 | 引导跳转决策鼓励 | 一件你拖了超过三天的事 |
| 禅语 | 有意境的一句话 | 千里之行，始于不再躺平 |

### 签文示例

**签一**
- 宜：对在意的人说一句真心话
- 忌：在工作群里发"收到"之后偷偷翻白眼——今天会被截图
- 幸运决策：一件你拖了超过三天的事
- 禅语：「千里之行，始于不再躺平」

**签二**
- 宜：接受一个不完美但足够好的选项
- 忌：深夜网购——你清醒时不会想要一个充气恐龙
- 幸运决策：一个你一直在"再想想"的计划
- 禅语：「水不试，不知深浅；人不试，不知能耐」

**签三**
- 宜：把一个"也许有一天"变成"就今天"
- 忌：已读不回超过三个人——因果循环，下周轮到你
- 幸运决策：和钱有关的那个犹豫
- 禅语：「山不向你走来，你便向山走去」

**签四**
- 宜：允许自己改变主意，这不是软弱
- 忌：在朋友面前假装很淡定——他们早看出来了
- 幸运决策：一段你想修复的关系
- 禅语：「执念松手的那一刻，路就宽了」

### 不重样策略

- **宜**：200+ 条正经建议，按「人际/事业/自我/金钱/健康」五类轮换
- **忌**：300+ 条幽默忌语，AI动态生成 + 人工精选库混合
- **禅语**：古诗改编 + 原创金句各 150+，从未出现池中抽取
- **组合逻辑**：宜/忌/禅语独立抽取再组合 → 千万级组合，基本不重样
- **存储**：本地 JSON 内置基础库 + 远程更新扩展库

### 抽签动画（核心体验）

```
第一幕（0-1s）：
  画面暗下来，水墨晕开
  一个签筒从雾气中浮现（3D感的水墨渲染）

第二幕（1-3s）：用户点击/摇动手机
  签筒微微震动
  一根竹签缓缓升起，带着淡金色光芒
  墨滴从签尖落下，在宣纸上晕开

第三幕（3-5s）：
  宣纸铺展开，签文用毛笔字逐字显现
  最后盖上一枚朱砂印章（配"啪"的音效）
  背景山脉若隐若现
```

技术实现：SwiftUI Canvas + TimelineView 动画，配合 haptic feedback。

### 签文卡片（分享用）

水墨宣纸风格卡片，竖版，包含签文四要素 + 日期 + 朱砂印章 + 品牌水印 + CTA。

---

## 功能二：决策鼓励（已有，保留）

现有核心功能不变：输入纠结 → AI 生成多维度鼓励 → 分享精美卡片。

保留的社交扩展：
- **求加持**：生成链接邀请朋友写鼓励（encourage.html）
- **求见证**：生成链接邀请朋友署名见证（witness.html）
- **收件箱**：查看朋友回复，生成 BlessingWallCard / WitnessCardView

---

## 功能三：决策命格（我的命格）

### 决策星盘 · 四维度体系

| 维度 | 阳极 | 阴极 | 测什么 |
|------|------|------|--------|
| 节奏 | 风 — 来去如风 | 山 — 稳如泰山 | 决策快还是慢 |
| 驱动 | 火 — 热血上头 | 水 — 冷静如水 | 靠感觉还是逻辑 |
| 胆量 | 龙 — 敢闯敢拼 | 龟 — 步步为营 | 冒险还是求稳 |
| 决后 | 剑 — 一剑不回 | 镜 — 时常回望 | 坚定还是反思 |

### 维度展示文案（用户可见）

| 维度 | 阳极 (中) | 阳极 (EN) | 阴极 (中) | 阴极 (EN) |
|------|----------|-----------|----------|-----------|
| 节奏 | 疾行 | Swift | 缓行 | Still |
| 驱动 | 炽感 | Blaze | 冷观 | Frost |
| 胆量 | 敢破 | Brave | 善守 | Guard |
| 决后 | 不回 | Forge | 常省 | Gaze |

中文统一两字，英文统一五字母。

### 十六星宿

| 四字禅语 | EN Code | 星宿名 | EN Name | 一句话 (中) | One-liner (EN) |
|---------|---------|--------|---------|------------|----------------|
| 疾风烈焰 | Wildfire | 破晓星 | Dawnstar | 三秒决定，绝不回头看爆炸 | Decides in three seconds, never looks back |
| 焰起潮生 | Flaretide | 流焰星 | Flamestar | 热血上头就冲了，冲完写检讨 | Charges in headfirst, journals about it after |
| 暖风不散 | Hearthwind | 守焰星 | Embstar | 感觉到位就选最稳的，安心入睡 | Follows the heart to the safest shore |
| 烛照四壁 | Candleglow | 残烛星 | Wickstar | 选了安全的路，总觉得错过烟火 | Takes the safe road, dreams of fireworks |
| 冰河破晓 | Icebreak | 凌霄星 | Peakstar | 半秒算完最优解，直接梭哈 | Calculates the odds, then goes all in |
| 寒潭映月 | Moonpool | 弈枰星 | Gamestar | 秒算最优解后冒险，赢了还要复盘 | Bets smart, wins big, still reviews the tape |
| 霜落无声 | Silentfrost | 青磐星 | Ironstar | 算出最稳方案，闭眼执行 | Finds the safest plan and never looks back |
| 水纹未定 | Ripplecalm | 玑衡星 | Polestar | 找到安全路线，但总想再优化 | Finds the answer, keeps solving anyway |
| 蛰雷将发 | Dormthunder | 伏龙星 | Wyrmstar | 沉默三天，突然爆发，一骑绝尘 | Silent for days, then strikes like lightning |
| 山雨欲来 | Stormbrewing | 踟蹰星 | Miststar | 鼓了很久勇气冲了，然后后悔 | Gathers courage for weeks, regrets in minutes |
| 春山如故 | Springmount | 温玉星 | Jadestar | 慢慢感受，温柔选了最稳的路 | Feels deeply, chooses gently, sleeps soundly |
| 月落两端 | Halfmoon | 怀萤星 | Glowstar | 什么都想兼顾，惦记着远方 | Holds both sides, gazes at the horizon |
| 深渊回响 | Depthecho | 伏虎星 | Graspstar | 深谋远虑后出手，谁劝都没用 | Plans for weeks, strikes once, never wavers |
| 长河未央 | Riverlong | 问渠星 | Seekstar | 做完分析才冒险，每晚重新分析 | Analyzes before the leap, re-analyzes after |
| 止水无波 | Stillwater | 太素星 | Calmstar | 想清楚了稳稳落子，波澜不惊 | Thinks it through, places the stone, breathes |
| 雾锁连环 | Fogchain | 永漏星 | Loopstar | 分析→犹豫→再分析→循环中 | Thinks, doubts, rethinks — forever loading |

### 测试设计

8-10 道场景选择题，每题测一个维度（部分题交叉验证）。

题目风格：具体生活场景 + 两个选项，轻松有趣。

示例：

> **Q1: 朋友突然问你"周末去露营吗"——**
> A. 去啊！边说边查天气 → +风
> B. 我看看日程……回头跟你说 → +山

> **Q4: 菜单上两道菜都想吃，服务员站在旁边了——**
> A.「就这个吧」指了最近的那道 → +风
> B. 再看一遍菜单，让服务员先去忙 → +山

> **Q7: 你做了一个大决定。第二天醒来——**
> A. 已经在执行了，想那么多干嘛 → +剑
> B. 在被窝里把昨天的决定又想了三遍 → +镜

### 命格结果卡片（分享用）

深色水墨风格卡片：
- 顶部：「✦ 决策星盘 ✦」
- 中部：四字禅语（大字）+ 星宿名
- 一句话描述
- 四维标签（如：缓行 · 炽感 · 敢破 · 不回）
- 底部：品牌水印 + 「测测你是哪颗星」CTA

### 付费扩展：详细命格解读

订阅用户可解锁：
- 详细性格分析（300-500字）
- 决策建议
- 最佳拍档星宿 / 天敌星宿
- 每周星宿运势（与每日签联动）

---

## 视觉设计

### 整体风格

水墨 + 玄学，已在 v1.5 中建立：
- **色板**：inkBlack `#1A1A2E`、gooseYellow `#D4A574`、ivory `#F5F0E8`、cinnabar `#C44536`
- **字体**：Noto Serif SC (H5) / system serif (iOS)
- **元素**：山脉剪影、朱砂印章、宣纸纹理、墨晕渐变
- **动画**：水墨晕开、毛笔逐字书写、印章盖下

### 各功能视觉差异

| 功能 | 底色 | 主色调 | 氛围 |
|------|------|--------|------|
| 今日签 | 宣纸暖色 | 古铜金 + 墨色 | 庄重仪式感 |
| 决策鼓励 | 深色墨底 | 金 + 白 | 神秘鼓励感 |
| 我的命格 | 深色星空感 | 金 + 朱砂 | 玄学命理感 |

---

## 产品地图

```
首页（三栏切换 Segmented Control）
├── 📿 今日签（默认首屏）
│   ├── 抽签动画 → 签文卡片
│   ├── 保存/分享卡片
│   └── 「这个决定就今天做」→ 跳转决策鼓励
│
├── 🎯 决策鼓励
│   ├── 输入纠结 → AI多维度鼓励
│   ├── 分享卡片
│   └── 求加持 / 求见证（社交扩展）
│
├── 🌟 我的命格
│   ├── 测试入口（未测时）
│   ├── 结果卡片 + 分享
│   ├── 详细解读（付费）
│   └── 「查看好友命格」→ 对比卡片
│
├── 📥 收件箱（加持/见证回复）
│
├── 📜 历史记录（归档的决策）
│
└── ⚙️ 设置 / 订阅
```

---

## 传播策略

### 一句话定位
「每天一签，做个果断的人」

### 传播路径
1. **种子用户**：小红书/朋友圈发决策命格测试 →「测测你是哪颗纠结星」
2. **日常传播**：用户每天抽签截图发朋友圈 → 水墨风卡片自带辨识度
3. **深度互动**：真有纠结时用AI鼓励 → 走心内容二次传播
4. **社交裂变**：求加持/见证链接 → 朋友帮忙 → 朋友也下载

### 付费转化
- 免费：每日1签 + 2次AI鼓励 + 1次命格测试
- 订阅：无限签 + 无限AI + 详细命格解读 + 每周运势

---

## 数据模型新增

### daily_fortunes（签文库）

本地 JSON + 远程更新。结构：

```json
{
  "id": "fortune_001",
  "category": "interpersonal",
  "should": "对在意的人说一句真心话",
  "should_en": "Say something honest to someone you care about",
  "should_not": "在工作群里发'收到'之后偷偷翻白眼——今天会被截图",
  "should_not_en": "Rolling your eyes after typing 'noted' — someone will screenshot it today",
  "lucky_decision": "一件你拖了超过三天的事",
  "lucky_decision_en": "Something you've been putting off for three days",
  "zen_quote": "千里之行，始于不再躺平",
  "zen_quote_en": "A thousand miles begins with getting off the couch"
}
```

### zen_types（命格定义）

本地 JSON，16 条记录：

```json
{
  "id": "dormthunder",
  "code_cn": "蛰雷将发",
  "code_en": "Dormthunder",
  "star_cn": "伏龙星",
  "star_en": "Wyrmstar",
  "tagline_cn": "沉默三天，突然爆发，一骑绝尘",
  "tagline_en": "Silent for days, then strikes like lightning",
  "dimensions": { "tempo": "mountain", "drive": "fire", "risk": "dragon", "after": "sword" },
  "labels_cn": ["缓行", "炽感", "敢破", "不回"],
  "labels_en": ["Still", "Blaze", "Brave", "Forge"],
  "detail_cn": "（付费解读内容，300-500字）",
  "detail_en": "（paid detailed reading, 300-500 words）"
}
```

### zen_test_questions（测试题目）

本地 JSON，8-10 道题：

```json
{
  "id": 1,
  "question_cn": "朋友突然问你"周末去露营吗"——",
  "question_en": "A friend suddenly asks 'Wanna go camping this weekend?'—",
  "option_a_cn": "去啊！边说边查天气",
  "option_a_en": "Sure! Already checking the weather",
  "option_b_cn": "我看看日程……回头跟你说",
  "option_b_en": "Let me check my calendar… I'll get back to you",
  "dimension": "tempo",
  "option_a_pole": "wind",
  "option_b_pole": "mountain"
}
```

### user_fortune_history（用户抽签记录）

本地存储（UserDefaults / SwiftData），记录每日签文ID + 日期，避免短期重复。

### user_zen_type（用户命格结果）

本地存储，记录测试答案 + 计算结果。

---

## 技术要点

- **动画**：SwiftUI Canvas + TimelineView，配合 UIImpactFeedbackGenerator
- **签文更新**：App 内置基础库，启动时静默检查远程 JSON 更新
- **命格测试**：纯本地计算，无需网络
- **国际化**：所有文案中英双语，根据系统语言自动切换
- **现有功能**：决策鼓励、社交功能（求加持/见证/收件箱）保持不变
