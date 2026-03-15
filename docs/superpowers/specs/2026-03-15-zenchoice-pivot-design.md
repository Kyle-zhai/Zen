# ZenChoice 产品转型设计文档

> 从玄学占卜到社交爆点鼓励工具

## 1. 产品定位

用户输入"今天想做什么"，app 通过多维度荒诞视角给出鼓励，帮用户"去做想做的事"。不提供专业建议，只提供有社交传播力的心理助推。

**核心价值主张：** 用最荒诞的逻辑，给你最真诚的鼓励。

**目标用户：** 18-35岁，有想法但犹豫不决，活跃于社交平台，喜欢分享有趣内容。

## 2. 核心交互流程

```
打开App → 输入框「今天想做什么？」
         ↓
   点击「去吧」按钮
         ↓
   墨水动画（保留现有 2.2s 仪式感等待）
         ↓
   展示鼓励结果：
     - 多个维度的鼓励语（免费版3-4个 / 订阅版5+个）
     - 每个维度有标题 + emoji + 一段荒诞但有力的鼓励
         ↓
   底部操作栏：
     [分享金句卡]  [存入勇气档案]  [再来一次]
```

- 无双模式切换，只有单一"输入→鼓励"流程
- 保留现有墨水动画仪式感
- 结果页可左右滑动浏览各维度鼓励语

## 3. 内容系统

### 3.1 维度池

维度池包含 30+ 个维度，每个维度代表一个荒诞但有趣的视角。每个维度包含 10-20 条模板，用 `{wish}` 占位符插入用户输入。

**维度分类：**

| 类别 | 维度示例 |
|------|---------|
| 荒诞科学 | 量子物理学家、NASA临时工、生物进化学家、气象学家 |
| 社会角色 | 隔壁王阿姨、出租车司机、酒吧老板、幼儿园小朋友 |
| 职业视角 | 脱口秀演员、电影编剧、律师、美食评论家 |
| 时间维度 | 80岁的你、10岁的你、平行宇宙的你、100年后的历史学家 |
| 文化视角 | 古希腊哲学家、武侠小说旁白、英国管家、日本热血动漫旁白 |
| 互联网 | 微博热评区、豆瓣小组组长、知乎高赞回答、Reddit热帖 |

### 3.2 模板风格要求

- **长度**：每条鼓励语 80-150 字
- **风格**：荒诞、具体、有细节、有转折，像社交平台上会被截图转发的段子
- **结构**：先铺设一个荒诞的前提 → 用歪理把逻辑推到极致 → 最后回扣到"所以你该去做"

**模板示例：**

> **🦕 进化论视角**
> 38亿年前，一个单细胞生物决定不再躺平，拼了命地分裂。它的后代爬上了岸，长出了腿，扛过了五次物种大灭绝，学会了直立行走，发明了外卖和Wi-Fi。这一切，就是为了让你——它最新的版本——坐在这里纠结要不要{wish}？你对得起那个单细胞吗？去，别让38亿年的努力白费。

> **👵 隔壁王阿姨视角**
> 哎哟我跟你说，我们楼下老张的儿子，去年也是犹豫要不要{wish}，犹豫了一整年，你猜怎么着？今年还在犹豫。人家隔壁单元那个小李，想都没想就去了，现在人家过得多好。我虽然不认识小李，也不知道他过得好不好，但是这不重要，重要的是你别当老张的儿子。

> **🎬 电影编剧视角**
> 我写过387个剧本，凡是主角在关键时刻说"算了还是别了"的，全都扑街了，豆瓣3.2分，评论区骂声一片。凡是主角深吸一口气说"老子去了"的，最低也是7.8分起步。你现在想{wish}，这是你人生电影的转折点。拜托，给观众一个值回票价的故事。

> **🔭 NASA临时工视角**
> 我刚查了一下，今天地球的自转速度是每小时1670公里，公转速度是每秒29.8公里，同时整个太阳系正以每秒220公里的速度绕银河系中心旋转。也就是说你在读这段话的时候已经在宇宙中移动了上千公里。宇宙都这么拼命在动了，你还好意思不去{wish}？

> **📱 微博热评区视角**
> 这条「我今天要不要{wish}」如果发到微博上，热评第一一定是"去啊！犹豫什么！"，第二条是"我去年也这样纠结，后来去了，真香"，第三条是一个跟话题完全无关的人在吵架。但前两条是对的。听热评的。

> **🧒 10岁的你视角**
> 你10岁的时候，计划是当宇航员、开跑车、养一只恐龙。现在你长大了，想{wish}而已，居然还要犹豫？10岁的你如果知道了会非常失望的——不是对这个决定失望，是对你居然需要一个app来鼓励你这件事感到失望。所以快去吧，别让那个小孩看扁了你。

### 3.3 免费版 vs 订阅版内容

| | 免费版 | 订阅版 |
|--|--------|--------|
| 生成方式 | 本地模板组合 | LLM 个性化生成 |
| 维度数量 | 3-4个随机 | 5+个 |
| 维度选择 | 系统随机 | 用户可自选角度 |
| 语气风格 | 系统随机混合 | 用户可选（毒鸡汤/温柔/荒诞/互联网梗等） |
| 内容重复度 | 模板有限，会重复 | 每次独一无二 |

## 4. 金句卡与分享

### 4.1 金句卡设计

```
┌─────────────────────────┐
│                         │
│   「我今天想辞职」        │
│                         │
│   你的祖先从海里爬上岸、  │
│   躲过了冰河期、扛过了    │
│   黑死病，就是为了让你    │
│   今天纠结要不要辞职？    │
│   去。别让38亿年的        │
│   努力白费。              │
│                         │
│          ── 进化论视角 🦕  │
│                         │
│   ·  app名  ·  2026.3.15 │
└─────────────────────────┘
```

- 只展示**一个维度**，用户可滑动选择分享哪个
- 极简黑白/米白设计，保留禅意美学
- 底部带 app 名称水印（增长飞轮关键触点）
- 紧凑卡片比例（适合朋友圈/Instagram Stories）

### 4.2 分享渠道

- 中国市场：微信/小红书/朋友圈
- 非中国市场：iMessage/Instagram/WhatsApp

## 5. 勇气档案

替代现有 `MainContentView.swift` 中的 `HistorySheet`。复用同一个 Supabase `courage_records` 表（原 `decision_records` 表迁移重命名）。

每次使用自动保存一条记录：
- 日期
- 用户输入的"想做什么"
- 生成的鼓励内容（所有维度，JSON存储）
- 是否分享过

档案页面是一个时间线列表，纯个人记录。不做打卡、不做提醒、不做社交压力。

`CourageArchiveView.swift` 替代现有 `HistorySheet`，在 `MainContentView` 中以 sheet 方式呈现。

**订阅版额外功能 — 年度勇气报告：**
- 年底生成一份总结，如："你今年鼓起了47次勇气，最常想做的事是健身（12次），最大胆的想法是辞职"
- 可分享为一张年度卡片

## 6. 盈利模式

### 6.1 订阅制

| | 中国市场 | 非中国市场 |
|--|---------|-----------|
| 月订阅 | ¥18/月 | $3.99/月 |
| 年订阅 | ¥128/年（约¥10.7/月） | $29.99/年（约$2.5/月） |

### 6.2 订阅解锁内容

- LLM 生成独一无二的个性化鼓励
- 自选维度角度
- 自选语气风格
- 维度数量 5+
- 勇气档案回顾 + 年度勇气报告
- 金句卡自定义样式（字体/背景色）

### 6.3 成本结构

- 每次 LLM API 调用成本约 $0.01-0.03
- 假设订阅用户日均使用 2 次，月成本约 $0.6-1.8
- 中国市场可用 DeepSeek/通义千问等国产模型进一步压低成本
- 定价留有充足利润空间

## 7. 市场策略

### 7.1 中国 vs 非中国市场差异

| | 中国市场 | 非中国市场 |
|--|---------|-----------|
| LLM 后端 | DeepSeek/通义千问 | Claude/GPT |
| 内容语言 | 中文模板 | 英文模板 |
| 维度本地化 | 隔壁大妈、甲方、考研导师视角 | therapist、TikTok creator 视角 |
| 传播策略 | 小红书种草 + 金句卡截图传播 | TikTok/Instagram Reels 展示 |
| 支付 | Apple IAP（国区） | Apple IAP（国际区） |

### 7.2 增长飞轮

```
用户输入 → 获得有趣鼓励 → 分享金句卡（带app水印）
                                    ↓
                          朋友在社交平台看到
                                    ↓
                            下载app → 新用户
```

金句卡的内容本身就是广告——如果鼓励语足够有趣，用户会主动分享，每张卡片都是一次免费获客。

## 8. 数据模型

### 8.1 新 Swift 数据模型

```swift
// 维度定义
struct Dimension: Identifiable, Codable {
    let id: String              // e.g. "evolution", "aunt_wang"
    let category: String        // e.g. "荒诞科学", "社会角色"
    let emoji: String           // e.g. "🦕"
    let title: String           // e.g. "进化论视角"
    let titleEN: String         // e.g. "Evolution"
    let templates: [String]     // 中文模板数组，含 {wish} 占位符
    let templatesEN: [String]   // 英文模板数组，含 {wish} 占位符
}

// 单个维度的鼓励结果
struct DimensionResult: Codable, Identifiable {
    let id: UUID
    let dimensionId: String
    let dimensionTitle: String
    let emoji: String
    let content: String         // 最终生成的鼓励语（已替换占位符）
}

// 一次完整的鼓励结果
struct EncouragementResult {
    let wish: String
    let dimensions: [DimensionResult]
    let generatedAt: Date
    let isLLMGenerated: Bool
}

// 用户档案（替代现有 UserProfile）
struct UserProfile: Codable, Identifiable, Sendable {
    let id: UUID
    var name: String
    var subscriptionStatus: SubscriptionStatus
    var createdAt: Date?

    enum CodingKeys: String, CodingKey {
        case id, name
        case subscriptionStatus = "subscription_status"
        case createdAt = "created_at"
    }
}

enum SubscriptionStatus: String, Codable, Sendable {
    case free
    case monthly
    case yearly
}

// 勇气档案记录（替代现有 DecisionRecord）
struct CourageRecord: Codable, Identifiable, Sendable {
    let id: UUID
    var userId: UUID
    var wish: String
    var dimensions: [DimensionResult]   // JSON 编码存储
    var isShared: Bool
    var isLLMGenerated: Bool
    var createdAt: Date?

    enum CodingKeys: String, CodingKey {
        case id, wish, dimensions
        case userId = "user_id"
        case isShared = "is_shared"
        case isLLMGenerated = "is_llm_generated"
        case createdAt = "created_at"
    }
}
```

### 8.2 Supabase 数据库迁移

**profiles 表（ALTER）：**
- 删除列：`birth_date`、`is_paid`
- 新增列：`subscription_status TEXT DEFAULT 'free'`

**decision_records → courage_records（重命名 + 改结构）：**
- 保留列：`id`、`user_id`、`wish`、`created_at`
- 删除列：`recommended_date`、`free_reasons`、`premium_report`
- 新增列：`dimensions JSONB`、`is_shared BOOLEAN DEFAULT false`、`is_llm_generated BOOLEAN DEFAULT false`

**迁移策略：** v1 直接新建表 + 弃用旧表。当前用户量极小（开发阶段），无需数据迁移。如已上线则需要写 Supabase migration SQL 保留历史数据。

### 8.3 ZenViewModel 改动明细

**保留：**
- `@Observable` class 声明和响应式架构
- `userName` 属性
- `isAnimating`、`showResult` 等 UI 状态
- `wishText` 输入绑定
- `initialize()` 方法骨架（改为新的初始化逻辑）
- 历史记录获取逻辑（改为 `CourageRecord`）

**删除：**
- `selectedMode: DivinationMode`
- `birthDate: Date`
- `isPaid: Bool`（改为 `subscriptionStatus`）
- `divine()`、`divineTodayAuspice()`、`divineFindBestDay()`
- `currentResult: DivinationResult?`

**新增：**
- `subscriptionStatus: SubscriptionStatus`
- `currentResult: EncouragementResult?`
- `generateEncouragement()` — 调用 Engine 或 LLM
- `selectedDimensions: [String]?` — 订阅版自选维度
- `selectedTone: String?` — 订阅版自选语气
- `archiveRecords: [CourageRecord]`

## 9. SettingsView 改动

**删除：**
- 出生日期 DatePicker
- "会员"区块（isPaid 解锁逻辑）
- "引擎"标签（"禅择玄学引擎 v3.14"）

**改为：**
- 保留"你的名字"输入
- 新增"订阅管理"区块（显示当前订阅状态、管理订阅按钮）
- 免责声明重写：去掉"命理分析"、"玄学报告"等措辞，改为"本 App 所提供的鼓励内容为算法或AI生成，仅供娱乐参考"
- "关于"区块更新版本号和引擎名称

## 10. 本地化策略

- V1 优先中文，英文作为次优先
- 维度模板在 `DimensionPool.swift` 中同时定义中英文版本（`templates` / `templatesEN`）
- UI 字符串使用 SwiftUI String Catalog（`.xcstrings`）做国际化
- App 通过 `Locale.current` 检测语言，自动选择对应模板
- LLM 订阅版：prompt 中指定语言，由模型自动生成对应语言内容
- V1 最低要求：中文 30 维度完整模板，英文可先覆盖 15 个高质量维度

## 11. 内容管理

- 模板存储在 `DimensionPool.swift` 中，结构化为 `[Dimension]` 数组
- V1 目标：30 个维度 x 10 条模板 = 300 条中文模板（最小可行内容量）
- 模板可后续迁移到 JSON 资源文件以便热更新，但 V1 硬编码即可
- 模板编写可借助 LLM 批量生成初稿，人工审核调整

## 12. 边界情况处理

- **输入过长**：限制输入框最大 50 字符
- **输入为空**：按钮禁用，不可提交
- **输入含特殊字符/纯 emoji**：正常处理，`{wish}` 原样替换
- **模板语法不通顺**：部分模板使用"你想{wish}"而非直接替换，确保语法自然
- **离线场景**：免费版完全离线可用（本地模板）；订阅版 LLM 不可用时 fallback 到本地模板并提示用户
- **Supabase 不可达**：App 正常运行，勇气档案暂存本地，恢复后同步

## 13. 分享技术实现

- `PosterService.swift` 重构为金句卡渲染器，内部使用 `ShareCardView` 作为渲染模板
- `ShareCardView.swift` 是一个 SwiftUI View，定义金句卡布局（用户问题 + 单维度鼓励 + 维度标签 + 日期 + 水印）
- `PosterService` 将 `ShareCardView` 渲染为 `UIImage`，调用 `UIActivityViewController` / `ShareLink` 分享
- 不再生成 9:16 大海报，改为紧凑卡片比例

## 14. 购买模式迁移

- 完全移除现有一次性买断逻辑（`isPaid: Bool`）
- 新增 `SubscriptionManager.swift`，基于 StoreKit 2 实现
- 产品 ID：`monthly_premium`、`yearly_premium`
- `PaywallView.swift` 重写：展示订阅价格、免费 vs 订阅对比、订阅/恢复购买按钮
- 无需处理老用户 grandfathering（产品尚未上线）

## 15. 代码改动总览

### 15.1 保留的代码

| 文件 | 说明 |
|------|------|
| `ZenChoiceApp.swift` | 入口，微调 |
| `ZenViewModel.swift` | 状态管理骨架保留，内部逻辑重写 |
| `MainContentView.swift` | 输入+动画+结果展示，UI调整 |
| `PosterService.swift` | 改为金句卡生成 |
| `SupabaseManager.swift` | 保留，字段微调 |
| `SupabaseConfig.swift` | 保留 |
| `ZenTheme.swift` | 保留禅意美学 |
| `HapticManager.swift` | 保留 |

### 15.2 大幅重写的代码

| 文件 | 说明 |
|------|------|
| `ZenDecisionEngine.swift` | 核心引擎，玄学维度全部替换为新维度池+模板系统 |
| `Models.swift` | 去掉 verdict 评级、八字模型，新增维度池数据结构 |
| `ResultCardView.swift` | 重写为新的多维度鼓励展示 |
| `PaywallView.swift` | 从"玄学深度报告"改为订阅制解锁 |

### 15.3 删除的代码

- 所有八字/天干地支/五行/纳音相关内容
- `bestDay` 择日模式
- `DivinationMode` 双模式切换
- premium 玄学报告生成逻辑

### 15.4 新增的代码

| 文件 | 说明 |
|------|------|
| `DimensionPool.swift` | 维度池定义（30+ 维度 x 10-20 模板） |
| `LLMService.swift` | 通用 LLM 接口层（预留） |
| `SubscriptionManager.swift` | StoreKit 2 订阅管理 |
| `CourageArchiveView.swift` | 勇气档案页面 |
| `ShareCardView.swift` | 金句卡生成与分享 |

### 15.5 LLM 接口层设计

```swift
protocol LLMProvider {
    func generate(wish: String, dimensions: [String], tone: String) async throws -> [DimensionResult]
}
```

通用 protocol，开发者可后续实现任意模型的 provider（Claude、GPT、DeepSeek、通义千问等），插入即用。具体 LLM 对接暂不实现，预留接口。

## 16. 品牌

App 名称待定。候选方向：
- 行动感：去做 / JustGo
- 产品感：勇气签 / DareCard
- 叛逆感：怂什么 / SoWhat
- 国际化：NudgeMe
- 极简：敢 / Dare

最终名称在开发阶段确定。

## 17. 竞品参考

| 竞品 | 定位 | 月收入 | 参考点 |
|------|------|--------|--------|
| I am - Daily Affirmations | 每日正念肯定句 | ~$60万 | 订阅定价、Widget |
| Finch: Self-Care Pet | 虚拟宠物自我关怀 | ~$290万 | 游戏化留存（后续版本参考） |
| 测测 App | 心理情感AI问答社区 | ~$100万 | 维度化内容、社区（后续版本参考） |
| SocialAI | 定制AI粉丝回应 | 380万用户 | 情绪价值定位 |

## 18. 关键指标与埋点

- **北极星指标**：金句卡分享率（分享次数 / 生成次数）
- **留存指标**：7日留存率
- **变现指标**：免费→订阅转化率（目标 3-5%）
- **内容指标**：模板覆盖率（用户输入命中模板的比例）

**埋点方案：** V1 使用 Supabase 自身记录（`courage_records` 表的 `is_shared` 字段可统计分享率，记录数可统计使用频次）。无需引入第三方 analytics SDK。后续如需更细粒度的漏斗分析，可接入 Mixpanel 或 PostHog。
