# ZenChoice Pivot Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Transform ZenChoice from a mystical divination app into a social-viral encouragement tool with multi-dimension absurd perspectives.

**Architecture:** Rewrite core engine and models while preserving the SwiftUI shell (theme, animations, haptics, Supabase auth). Replace all mystical content with a dimension pool template system. Add StoreKit 2 subscriptions and a placeholder LLM service protocol.

**Tech Stack:** Swift/SwiftUI, Supabase (auth + Postgres), StoreKit 2, ImageRenderer (share cards)

**Spec:** `docs/superpowers/specs/2026-03-15-zenchoice-pivot-design.md`

**V1 Scope Notes — Intentionally Deferred Features:**
- Annual courage report (spec Section 5) — deferred to V2
- Custom share card styles/fonts/backgrounds (spec Section 6.2) — deferred to V2
- `.xcstrings` String Catalog localization (spec Section 10) — deferred; V1 uses hardcoded Chinese UI strings with English dimension templates
- Supabase migration SQL — handled separately in Supabase dashboard, not in app code
- Wiring `SubscriptionManager` into `PaywallView` — Task 16 creates the StoreKit 2 manager but it is not wired into the UI until App Store Connect products are configured; `PaywallView` uses a mock toggle for development
- Subscriber tone selector UI — the `selectedTone` property exists in ViewModel but no picker UI is built in V1; the LLM provider placeholder ignores tone anyway

---

## Chunk 1: Data Layer (Models + Engine + DimensionPool)

### Task 1: Rewrite Models.swift

**Files:**
- Modify: `ZenChoice/Models.swift`

- [ ] **Step 1: Replace Models.swift with new data structures**

Delete all existing content and write:

```swift
import Foundation

// MARK: - Dimension Definition

struct Dimension: Identifiable, Codable {
    let id: String
    let category: String
    let emoji: String
    let title: String
    let titleEN: String
    let templates: [String]
    let templatesEN: [String]
}

// MARK: - Dimension Result

struct DimensionResult: Codable, Identifiable, Sendable {
    let id: UUID
    let dimensionId: String
    let dimensionTitle: String
    let emoji: String
    let content: String
}

// MARK: - Encouragement Result

struct EncouragementResult: Sendable {
    let wish: String
    let dimensions: [DimensionResult]
    let generatedAt: Date
    let isLLMGenerated: Bool
}

// MARK: - Subscription Status

enum SubscriptionStatus: String, Codable, Sendable {
    case free
    case monthly
    case yearly
}

// MARK: - User Profile

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

// MARK: - Courage Record

struct CourageRecord: Codable, Identifiable, Sendable {
    let id: UUID
    var userId: UUID
    var wish: String
    var dimensions: [DimensionResult]
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

- [ ] **Step 2: Build to verify compilation**

Run: `cd /Users/pinan/Desktop/ZenChoice/ZenChoice && xcodebuild -scheme ZenChoice -destination 'platform=iOS Simulator,name=iPhone 16' build 2>&1 | tail -20`

Expected: Build will FAIL because other files still reference old types (`DivinationMode`, `DecisionRecord`, etc.). This is expected — we fix those files in subsequent tasks.

- [ ] **Step 3: Commit**

```bash
git add ZenChoice/Models.swift
git commit -m "refactor: replace divination models with encouragement data structures"
```

---

### Task 2: Create DimensionPool.swift (V1 — 10 dimensions x 3 templates each as starter)

**Files:**
- Create: `ZenChoice/DimensionPool.swift`

We start with 10 dimensions and 3 templates each (30 total) to unblock development. The remaining 20+ dimensions and additional templates will be added in a dedicated content task (Task 10).

- [ ] **Step 1: Create DimensionPool.swift**

```swift
import Foundation

enum DimensionPool {

    static let all: [Dimension] = [
        // MARK: - 荒诞科学
        Dimension(
            id: "evolution",
            category: "荒诞科学",
            emoji: "🦕",
            title: "进化论视角",
            titleEN: "Evolution",
            templates: [
                "38亿年前，一个单细胞生物决定不再躺平，拼了命地分裂。它的后代爬上了岸，长出了腿，扛过了五次物种大灭绝，学会了直立行走，发明了外卖和Wi-Fi。这一切，就是为了让你——它最新的版本——坐在这里纠结要不要{wish}？你对得起那个单细胞吗？去，别让38亿年的努力白费。",
                "达尔文说适者生存。你知道什么样的人最先被自然淘汰吗？不是最弱的，是最犹豫的。羚羊看见狮子犹豫三秒就没了。你现在想{wish}，犹豫的每一秒都在降低你的生存适应度。进化论不骗人。",
                "从鱼到两栖动物，那条鱼第一次把鳍伸上岸的时候，旁边的鱼一定觉得它疯了。四亿年后回头看，那是整个物种的高光时刻。你想{wish}，这就是你的「鳍伸上岸」时刻。别怂。",
            ],
            templatesEN: [
                "3.8 billion years ago, a single-celled organism decided to stop lounging around and started dividing like crazy. Its descendants crawled onto land, survived five mass extinctions, invented pizza delivery and Wi-Fi. All of that — just so you could sit here wondering whether to {wish}? Do right by that cell. Go.",
                "Darwin said survival of the fittest. You know who gets eliminated first? Not the weakest — the most indecisive. An antelope that hesitates for three seconds becomes lunch. You want to {wish}? Every second you hesitate, your evolutionary fitness drops. Science doesn't lie.",
                "When the first fish dragged itself onto land, every other fish thought it was insane. 400 million years later, that was the highlight of the entire species. You wanting to {wish}? This is your 'fins on land' moment. Don't chicken out.",
            ]
        ),
        Dimension(
            id: "nasa_intern",
            category: "荒诞科学",
            emoji: "🔭",
            title: "NASA临时工视角",
            titleEN: "NASA Intern",
            templates: [
                "我刚查了一下，今天地球的自转速度是每小时1670公里，公转速度是每秒29.8公里，同时整个太阳系正以每秒220公里的速度绕银河系中心旋转。也就是说你在读这段话的时候已经在宇宙中移动了上千公里。宇宙都这么拼命在动了，你还好意思不去{wish}？",
                "哈勃望远镜拍到的最远的星光走了134亿年才到你眼睛里。134亿年的光只为了照亮你此刻的屏幕。宇宙花了这么大力气让你看到这段话，你要是不去{wish}，那光白跑了。",
                "国际空间站每天绕地球16圈，上面的宇航员一天能看16次日出。你连{wish}都不敢做一次？人家在太空都比你卷。",
            ],
            templatesEN: [
                "Quick check: Earth spins at 1,670 km/h, orbits the sun at 29.8 km/s, and the entire solar system flies around the Milky Way at 220 km/s. While you read this, you've traveled thousands of kilometers through space. The universe is hustling that hard, and you won't even {wish}?",
                "The farthest starlight Hubble captured traveled 13.4 billion years just to reach your eyes. The universe spent 13.4 billion years getting light to your screen right now. If you don't {wish}, that light traveled for nothing.",
                "The ISS orbits Earth 16 times a day — astronauts up there see 16 sunrises daily. You can't even {wish} once? People in space are literally outperforming you.",
            ]
        ),

        // MARK: - 社会角色
        Dimension(
            id: "aunt_wang",
            category: "社会角色",
            emoji: "👵",
            title: "隔壁王阿姨视角",
            titleEN: "Neighbor Auntie Wang",
            templates: [
                "哎哟我跟你说，我们楼下老张的儿子，去年也是犹豫要不要{wish}，犹豫了一整年，你猜怎么着？今年还在犹豫。人家隔壁单元那个小李，想都没想就去了，现在人家过得多好。我虽然不认识小李，也不知道他过得好不好，但是这不重要，重要的是你别当老张的儿子。",
                "我跟你说个事儿啊，楼下超市的王姐，她闺女之前也想{wish}，家里人拦着不让。后来她偷偷去了，你猜怎么着？王姐现在逢人就吹她闺女多有主见。所以你看，你现在去{wish}，等你成了，你妈比你还骄傲。",
                "你要是不去{wish}，你就跟我们小区那个天天坐门口叹气的老李一样了。人家问他年轻时候最后悔什么，他说「什么都没做」。你还年轻，别等坐门口叹气的时候再后悔。",
            ],
            templatesEN: [
                "Let me tell you, Old Zhang's son downstairs wanted to {wish} last year. He hesitated for a whole year, and guess what? Still hesitating this year. But Little Li next door just went and did it — doing great now. I don't actually know Li, but that's not the point. The point is: don't be Zhang's son.",
                "You know Mrs. Wang from the corner store? Her daughter wanted to {wish} and the whole family said no. She went anyway. Now Mrs. Wang brags about her daughter's initiative to everyone. So go {wish} — once you succeed, your mom will be prouder than you.",
                "If you don't {wish}, you'll end up like Old Li who sits by the gate sighing every day. Someone asked what he regrets most. He said 'doing nothing.' You're still young. Don't wait until you're the one sighing.",
            ]
        ),
        Dimension(
            id: "taxi_driver",
            category: "社会角色",
            emoji: "🚕",
            title: "出租车司机视角",
            titleEN: "Taxi Driver",
            templates: [
                "我开了二十年出租，什么人没拉过。凡是上车说「师傅，去机场」的，没一个后悔的。凡是上了车又说「算了师傅掉头回去」的，十个有八个后来又打车去了一趟。你想{wish}？直接去。别让我多跑一趟。",
                "我见过凌晨三点从酒吧出来哭着说要辞职的，见过早上六点去面试笑得跟花一样的。区别是什么你知道吗？就是一个「去」字。你想{wish}，别坐在原地空想，先动起来。",
                "跟你说啊我这行有句话：路堵不堵你得先上路才知道。你想{wish}，你不迈出第一步，永远不知道前面堵不堵。万一一路绿灯呢？",
            ],
            templatesEN: [
                "Twenty years driving cabs, I've seen it all. Everyone who says 'Airport, please' never regrets it. Everyone who says 'Actually, turn back' — eight out of ten end up calling another cab later anyway. You want to {wish}? Just go. Don't make me drive twice.",
                "I've picked up people crying outside bars at 3 AM saying they want to quit, and people beaming at 6 AM heading to interviews. The difference? One word: 'go.' You want to {wish}? Stop sitting there. Move.",
                "We have a saying in my trade: you won't know if the road's jammed until you're on it. You want to {wish}? Take that first step. What if it's green lights all the way?",
            ]
        ),

        // MARK: - 职业视角
        Dimension(
            id: "screenwriter",
            category: "职业视角",
            emoji: "🎬",
            title: "电影编剧视角",
            titleEN: "Screenwriter",
            templates: [
                "我写过387个剧本，凡是主角在关键时刻说「算了还是别了」的，全都扑街了，豆瓣3.2分，评论区骂声一片。凡是主角深吸一口气说「老子去了」的，最低也是7.8分起步。你现在想{wish}，这是你人生电影的转折点。拜托，给观众一个值回票价的故事。",
                "好莱坞有个公式叫「英雄之旅」：主角遇到挑战→犹豫→跨出舒适区→经历考验→蜕变。你现在正卡在「犹豫」这个节点上。如果你选择不{wish}，这部电影第二幕就结束了，你的角色弧光直接拍扁。导演会炒你鱿鱼的。",
                "每个经典角色都有一句定义他人生的台词。安迪·杜弗兰说「要么忙着活，要么忙着死」。阿甘说「跑」。你的台词应该是「我要{wish}」。说出来。这是你的剧本，没人能替你念台词。",
            ],
            templatesEN: [
                "I've written 387 scripts. Every protagonist who said 'never mind, forget it' at the crucial moment — box office bomb, 3.2 on IMDB, roasted in reviews. Every one who took a deep breath and said 'let's do this' — 7.8 minimum. You want to {wish}? This is your movie's turning point. Give the audience their money's worth.",
                "Hollywood has a formula called the Hero's Journey: challenge → hesitation → leap → ordeal → transformation. You're stuck at 'hesitation.' If you don't {wish}, your character arc flatlines in Act 2. The director will fire you.",
                "Every iconic character has one line that defines them. Andy Dufresne: 'Get busy living or get busy dying.' Forrest: 'Run.' Yours should be 'I'm going to {wish}.' Say it. This is your script — nobody else can deliver your lines.",
            ]
        ),
        Dimension(
            id: "standup_comedian",
            category: "职业视角",
            emoji: "🎤",
            title: "脱口秀演员视角",
            titleEN: "Stand-up Comedian",
            templates: [
                "你知道最好笑的是什么吗？不是你想{wish}，是你想了半天还没行动这件事本身。如果我把这段写进段子，观众笑点在「他居然用一个app来决定要不要做」。你正在成为别人的笑料。去做吧，至少当个让人佩服的笑料。",
                "我上台前每次都紧张得要死。但你知道脱口秀演员的秘诀是什么吗？上去再说。段子好不好你得说了才知道，人生好不好你得活了才知道。你想{wish}？先上台。炸不炸场，那是之后的事。",
                "我做脱口秀最大的领悟就是：生活本身就是个巨大的即兴表演。没有人给你写好台词，没有人给你彩排机会。你想{wish}？接住这个梗，往下演。最差最差，也是一个好段子。",
            ],
            templatesEN: [
                "You know what's actually funny? Not that you want to {wish} — it's that you've been thinking about it this long without doing anything. If I wrote this into a bit, the punchline would be 'he used an app to decide.' You're becoming someone else's joke. Go do it — at least be an impressive joke.",
                "I'm terrified before every set. But you know the comedian's secret? Just get on stage. You won't know if the bit lands until you try it. You want to {wish}? Get on stage first. Whether you kill or bomb — that comes after.",
                "The biggest thing comedy taught me: life is one giant improv show. Nobody writes your lines. No rehearsals. You want to {wish}? Accept the prompt and go with it. Worst case? Great material for later.",
            ]
        ),

        // MARK: - 时间维度
        Dimension(
            id: "ten_year_old_you",
            category: "时间维度",
            emoji: "🧒",
            title: "10岁的你视角",
            titleEN: "10-Year-Old You",
            templates: [
                "你10岁的时候，计划是当宇航员、开跑车、养一只恐龙。现在你长大了，想{wish}而已，居然还要犹豫？10岁的你如果知道了会非常失望的——不是对这个决定失望，是对你居然需要一个app来鼓励你这件事感到失望。所以快去吧，别让那个小孩看扁了你。",
                "10岁的你可不管什么风险评估、成本收益、可行性分析。10岁的你只知道一件事：想做就做。你想{wish}？用10岁时候那个不知天高地厚的劲儿去做。那才是最真实的你。",
                "给你出道数学题：你现在的年龄减去10等于你浪费在犹豫上的年数。你已经比10岁的自己多活了这么多年，怎么反而越活越怂了？10岁的你想{wish}就直接去了。学学他。",
            ],
            templatesEN: [
                "When you were 10, your plan was to be an astronaut, drive a sports car, and own a dinosaur. Now you're grown up, and you're hesitating about {wish}? 10-year-old you would be so disappointed — not about the decision, but about needing an app to push you. Go. Don't let that kid down.",
                "10-year-old you didn't do risk assessments or cost-benefit analyses. 10-year-old you only knew one thing: want it, do it. You want to {wish}? Channel that fearless kid. That's the real you.",
                "Math problem: your current age minus 10 equals years wasted on hesitation. You've lived this many more years than 10-year-old you, and somehow you've gotten more timid? That kid would've just gone and done {wish}. Learn from them.",
            ]
        ),
        Dimension(
            id: "eighty_year_old_you",
            category: "时间维度",
            emoji: "👴",
            title: "80岁的你视角",
            titleEN: "80-Year-Old You",
            templates: [
                "80岁的你坐在摇椅上，回忆这一生。你觉得他会后悔哪个：「那年我去{wish}了，虽然结果一般」还是「那年我想{wish}，但是没去」？研究表明，人在临终时最后悔的永远是没做的事，而不是做过的事。别让80岁的你骂你。",
                "80岁的你给你发来一条语音：「年轻人，别磨叽了，去{wish}。我这把年纪最大的遗憾不是做错了什么，是什么都没做。你现在犹豫的每一分钟，将来都会变成我叹气的每一声。」已读不回可以，但你得去。",
                "想象一下80岁的你在写回忆录。你希望这一章写的是「第X章：那次勇敢的{wish}」还是「第X章：空白页」？好的回忆录需要好的故事。去给自己写一个。",
            ],
            templatesEN: [
                "80-year-old you is in a rocking chair, looking back. Which regret hits harder: 'I tried to {wish} and it was just okay' or 'I wanted to {wish} but never did'? Studies show people on their deathbeds regret what they didn't do, not what they did. Don't give 80-year-old you a reason to curse.",
                "80-year-old you just sent a voice message: 'Kid, stop dawdling. Go {wish}. At my age, the biggest regret isn't mistakes — it's inaction. Every minute you hesitate now becomes a sigh I'll breathe later.' You can leave it on read, but you gotta go.",
                "Imagine 80-year-old you writing a memoir. Do you want this chapter to read 'Chapter X: The Time I Bravely Did {wish}' or 'Chapter X: Blank Page'? Good memoirs need good stories. Go write one.",
            ]
        ),

        // MARK: - 互联网
        Dimension(
            id: "weibo_comments",
            category: "互联网",
            emoji: "📱",
            title: "微博热评区视角",
            titleEN: "Social Media Comments",
            templates: [
                "这条「我今天要不要{wish}」如果发到微博上，热评第一一定是「去啊！犹豫什么！」，第二条是「我去年也这样纠结，后来去了，真香」，第三条是一个跟话题完全无关的人在吵架。但前两条是对的。听热评的。",
                "如果你把「我要不要{wish}」发到小红书上，评论区画风大概是：「姐妹冲！」「支持！」「我上个月也这样，去了以后完全不后悔」「在哪里？求攻略」「已经在路上了」。六百条评论没有一个说「别去」的。你看，互联网已经帮你做了决定。",
                "把「要不要{wish}」发到知乎上，会有一个三千字长文从经济学、心理学和社会学三个角度论证你应该去。末尾还附一句「以上，谢邀」。知乎er已经帮你分析完了，你还等什么？",
            ],
            templatesEN: [
                "If you posted 'Should I {wish}?' on Twitter, the top reply would be 'DO IT 🔥', the second would be 'I did this last year, best decision ever', and the third would be someone arguing about something completely unrelated. But the first two are right. Listen to the timeline.",
                "If you posted 'Should I {wish}?' on Reddit, the comments would be: 'This is the way.' 'Just did this, no regrets.' 'RemindMe! 1 month.' 'NTA, go for it.' 600 upvotes, zero people saying don't. The internet has already decided for you.",
                "If you asked 'Should I {wish}?' on Quora, someone would write a 3,000-word answer analyzing it from economics, psychology, and sociology — concluding you absolutely should. They'd end with 'Hope this helps.' It does. Now go.",
            ]
        ),

        // MARK: - 文化视角
        Dimension(
            id: "wuxia_narrator",
            category: "文化视角",
            emoji: "⚔️",
            title: "武侠小说旁白视角",
            titleEN: "Wuxia Narrator",
            templates: [
                "话说这日，少侠独坐案前，手持一方发光铁牌（注：手机），心中暗自思量：「{wish}一事，当行还是不行？」江湖路远，一步踏出便是另一番天地。犹豫不决者，终困于客栈一隅，虚度此生。少侠，提剑上路吧。江湖不等人。",
                "古语有云：「千里之行，始于足下。」少侠欲{wish}，却在原地踟蹰不前。须知江湖中人最忌一个「怕」字。你怕什么？怕输？输了不过从头再来。怕赢？赢了自然前路更宽。少侠，拔剑吧。",
                "且说天下武功，唯快不破。少侠欲{wish}，最怕的不是功力不够，而是出手太慢。机缘稍纵即逝，等你把这段话看完，已经错过了三个出招的窗口。别看了，出手！",
            ],
            templatesEN: [
                "On this day, our young hero sat alone, holding a glowing iron tablet (note: a phone), pondering: 'To {wish} or not?' The path of the wanderer stretches far — one step forward, and a new world unfolds. Those who hesitate are doomed to waste their days at the inn. Draw your sword, hero. The world won't wait.",
                "The ancients said: 'A journey of a thousand miles begins with a single step.' Our hero wants to {wish} but stands frozen. In the martial world, fear is the greatest enemy. Afraid of losing? You just start over. Afraid of winning? Then the path widens. Draw your blade, hero.",
                "In all of martial arts, speed beats everything. Our hero wants to {wish}, but the danger isn't lack of skill — it's moving too slow. Opportunity vanishes in a blink. By the time you finish reading this, three openings have passed. Stop reading. Strike!",
            ]
        ),
    ]

    /// Returns a random subset of dimensions for free-tier users.
    static func randomSubset(count: Int = 4) -> [Dimension] {
        Array(all.shuffled().prefix(count))
    }

    /// Returns dimensions matching the given IDs (for subscriber custom selection).
    static func dimensions(for ids: [String]) -> [Dimension] {
        ids.compactMap { id in all.first { $0.id == id } }
    }
}
```

- [ ] **Step 2: Commit**

```bash
git add ZenChoice/DimensionPool.swift
git commit -m "feat: add DimensionPool with 10 starter dimensions (30 CN + 30 EN templates)"
```

---

### Task 3: Rewrite ZenDecisionEngine.swift as EncouragementEngine

**Files:**
- Modify: `ZenChoice/ZenDecisionEngine.swift`

- [ ] **Step 1: Replace ZenDecisionEngine with EncouragementEngine**

Delete all existing content and write:

```swift
import Foundation

enum EncouragementEngine {

    /// Generate encouragement from local templates (free tier).
    static func generate(
        wish: String,
        dimensionCount: Int = 4,
        specificDimensionIds: [String]? = nil
    ) -> EncouragementResult {
        let dimensions: [Dimension]
        if let ids = specificDimensionIds {
            dimensions = DimensionPool.dimensions(for: ids)
        } else {
            dimensions = DimensionPool.randomSubset(count: dimensionCount)
        }

        let isChineseLocale = Locale.current.language.languageCode?.identifier == "zh"
        let results = dimensions.map { dim -> DimensionResult in
            let pool = isChineseLocale ? dim.templates : dim.templatesEN
            let template = pool.randomElement() ?? "{wish}"
            let content = template.replacingOccurrences(of: "{wish}", with: wish)
            return DimensionResult(
                id: UUID(),
                dimensionId: dim.id,
                dimensionTitle: isChineseLocale ? dim.title : dim.titleEN,
                emoji: dim.emoji,
                content: content
            )
        }

        return EncouragementResult(
            wish: wish,
            dimensions: results,
            generatedAt: Date(),
            isLLMGenerated: false
        )
    }
}
```

- [ ] **Step 2: Commit**

```bash
git add ZenChoice/ZenDecisionEngine.swift
git commit -m "refactor: replace ZenDecisionEngine with EncouragementEngine"
```

---

### Task 4: Create LLMService.swift (protocol placeholder)

**Files:**
- Create: `ZenChoice/LLMService.swift`

- [ ] **Step 1: Create LLMService.swift**

```swift
import Foundation

/// Protocol for LLM-based encouragement generation (subscriber tier).
/// Implement with any model provider (Claude, GPT, DeepSeek, etc.).
protocol LLMProvider {
    func generate(
        wish: String,
        dimensions: [String],
        tone: String
    ) async throws -> [DimensionResult]
}

/// Placeholder implementation that falls back to local templates.
/// Replace with actual API integration when ready.
struct PlaceholderLLMProvider: LLMProvider {
    func generate(
        wish: String,
        dimensions: [String],
        tone: String
    ) async throws -> [DimensionResult] {
        // Fallback: use local engine with specified dimensions
        let result = EncouragementEngine.generate(
            wish: wish,
            dimensionCount: dimensions.count,
            specificDimensionIds: dimensions.isEmpty ? nil : dimensions
        )
        return result.dimensions
    }
}
```

- [ ] **Step 2: Commit**

```bash
git add ZenChoice/LLMService.swift
git commit -m "feat: add LLMProvider protocol with placeholder implementation"
```

---

## Chunk 2: ViewModel + Backend

### Task 5: Rewrite ZenViewModel.swift

**Files:**
- Modify: `ZenChoice/ZenViewModel.swift`

- [ ] **Step 1: Replace ZenViewModel with new logic**

Delete all existing content and write:

```swift
import SwiftUI

@Observable
class ZenViewModel {

    // MARK: - User State

    var userName: String = ""
    var subscriptionStatus: SubscriptionStatus = .free
    var currentUserId: UUID?

    var isSubscribed: Bool {
        subscriptionStatus != .free
    }

    // MARK: - Input

    var wish: String = ""

    // MARK: - Encouragement State

    var isLoading: Bool = false
    var showInkAnimation: Bool = false
    var showResult: Bool = false
    var currentResult: EncouragementResult?

    // MARK: - Subscriber Customization

    var selectedDimensionIds: [String]? = nil
    var selectedTone: String? = nil

    // MARK: - Archive

    var archiveRecords: [CourageRecord] = []

    // MARK: - Sheets

    var showPaywall: Bool = false
    var showSettings: Bool = false
    var showArchive: Bool = false

    // MARK: - Error

    var errorMessage: String?
    var showError: Bool = false

    // MARK: - Share

    #if os(iOS)
    var shareCardImage: UIImage?
    #endif
    var showShareSheet: Bool = false

    // MARK: - Private

    private let supabaseManager = SupabaseManager()
    private let llmProvider: LLMProvider = PlaceholderLLMProvider()

    // MARK: - Lifecycle

    func initialize() async {
        do {
            currentUserId = try await supabaseManager.signInAnonymously()
            await loadArchive()
        } catch {
            // App works offline for free tier (local templates)
            print("[ZenChoice] Init failed, continuing offline: \(error)")
        }
    }

    // MARK: - Core: Generate Encouragement

    @MainActor
    func generateEncouragement() async {
        let trimmed = wish.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            errorMessage = "请输入你想做的事"
            showError = true
            HapticManager.error()
            return
        }

        isLoading = true
        showResult = false

        withAnimation(.easeOut(duration: 0.4)) {
            showInkAnimation = true
        }
        HapticManager.impact()

        try? await Task.sleep(for: .seconds(2.2))

        let dimensionCount = isSubscribed ? 5 : Int.random(in: 3...4)

        if isSubscribed, let tone = selectedTone {
            // Subscriber: use LLM
            do {
                let dims = selectedDimensionIds ?? []
                let results = try await llmProvider.generate(
                    wish: trimmed,
                    dimensions: dims,
                    tone: tone
                )
                currentResult = EncouragementResult(
                    wish: trimmed,
                    dimensions: results,
                    generatedAt: Date(),
                    isLLMGenerated: true
                )
            } catch {
                // Fallback to local on LLM failure
                currentResult = EncouragementEngine.generate(
                    wish: trimmed,
                    dimensionCount: dimensionCount,
                    specificDimensionIds: selectedDimensionIds
                )
            }
        } else {
            // Free tier: local templates
            currentResult = EncouragementEngine.generate(
                wish: trimmed,
                dimensionCount: dimensionCount,
                specificDimensionIds: isSubscribed ? selectedDimensionIds : nil
            )
        }

        // Save to archive
        if let result = currentResult {
            let record = CourageRecord(
                id: UUID(),
                userId: currentUserId ?? UUID(),
                wish: trimmed,
                dimensions: result.dimensions,
                isShared: false,
                isLLMGenerated: result.isLLMGenerated,
                createdAt: .now
            )
            Task { try? await supabaseManager.saveRecord(record) }
        }

        withAnimation(.easeInOut(duration: 0.8)) {
            showInkAnimation = false
            showResult = true
        }

        isLoading = false
        HapticManager.success()
    }

    // MARK: - Archive

    func loadArchive() async {
        guard let uid = currentUserId else { return }
        do {
            archiveRecords = try await supabaseManager.fetchArchive(userId: uid)
        } catch {
            print("[ZenChoice] Load archive failed: \(error)")
        }
    }

    // MARK: - Profile Sync

    func syncProfile() async {
        guard let uid = currentUserId else { return }
        do {
            try await supabaseManager.syncProfile(
                name: userName, userId: uid
            )
        } catch {
            print("[ZenChoice] Sync profile failed: \(error)")
        }
    }

    // MARK: - Share Card

    func generateShareCard(dimensionResult: DimensionResult) {
        #if os(iOS)
        guard let result = currentResult else { return }
        shareCardImage = PosterService.renderShareCard(
            wish: result.wish,
            dimensionResult: dimensionResult
        )
        showShareSheet = shareCardImage != nil
        if shareCardImage != nil { HapticManager.success() }
        #endif
    }

    // MARK: - Reset

    func reset() {
        wish = ""
        showResult = false
        currentResult = nil
        #if os(iOS)
        shareCardImage = nil
        #endif
    }
}
```

- [ ] **Step 2: Commit**

```bash
git add ZenChoice/ZenViewModel.swift
git commit -m "refactor: rewrite ZenViewModel for encouragement flow"
```

---

### Task 6: Update SupabaseManager.swift

**Files:**
- Modify: `ZenChoice/SupabaseManager.swift`

- [ ] **Step 1: Replace SupabaseManager with new table/model references**

Delete all existing content and write:

```swift
import Foundation
import Supabase

class SupabaseManager {

    func signInAnonymously() async throws -> UUID {
        do {
            let session = try await supabase.auth.session
            return session.user.id
        } catch {
            let session = try await supabase.auth.signInAnonymously()
            return session.user.id
        }
    }

    func syncProfile(name: String, userId: UUID) async throws {
        let profile = UserProfile(
            id: userId,
            name: name,
            subscriptionStatus: .free,
            createdAt: nil
        )
        try await supabase.from("profiles").upsert(profile).execute()
    }

    func saveRecord(_ record: CourageRecord) async throws {
        try await supabase.from("courage_records").insert(record).execute()
    }

    func fetchArchive(userId: UUID) async throws -> [CourageRecord] {
        let records: [CourageRecord] = try await supabase
            .from("courage_records")
            .select()
            .eq("user_id", value: userId.uuidString)
            .order("created_at", ascending: false)
            .execute()
            .value
        return records
    }
}
```

- [ ] **Step 2: Commit**

```bash
git add ZenChoice/SupabaseManager.swift
git commit -m "refactor: update SupabaseManager for courage_records and new UserProfile"
```

---

## Chunk 3: UI Layer

### Task 7: Update ZenTheme.swift (remove ReasonDimension enum)

**Files:**
- Modify: `ZenChoice/ZenTheme.swift`

- [ ] **Step 1: Remove the ReasonDimension enum**

Delete lines 88-113 (the `// MARK: - Dimension Icon Mapping` comment and the entire `ReasonDimension` enum). Keep everything else unchanged (`ZenTheme`, `Color` hex init, `ZenBackground`).

- [ ] **Step 2: Commit**

```bash
git add ZenChoice/ZenTheme.swift
git commit -m "refactor: remove ReasonDimension enum from ZenTheme"
```

---

### Task 8: Rewrite ResultCardView.swift

**Files:**
- Modify: `ZenChoice/ResultCardView.swift`

- [ ] **Step 1: Replace ResultCardView with new dimension-based card**

Delete all existing content and write:

```swift
import SwiftUI

struct ResultCardView: View {
    let dimensionResult: DimensionResult
    let delay: Double
    let onShare: () -> Void

    @State private var appeared = false
    @State private var breathing = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                Text(dimensionResult.emoji)
                    .font(.title2)

                Text(dimensionResult.dimensionTitle)
                    .font(ZenTheme.calligraphy(15))
                    .foregroundStyle(ZenTheme.inkBlack)

                Spacer()

                Button {
                    onShare()
                    HapticManager.selection()
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .font(.caption)
                        .foregroundStyle(ZenTheme.distantMountain.opacity(0.4))
                }
            }

            Text(dimensionResult.content)
                .font(ZenTheme.bodyFont(14))
                .foregroundStyle(ZenTheme.distantMountain.opacity(0.85))
                .lineSpacing(6)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(.white)
                .shadow(color: ZenTheme.inkBlack.opacity(0.04), radius: 8, y: 3)
        )
        .opacity(appeared ? (breathing ? 1.0 : 0.94) : 0)
        .offset(y: appeared ? 0 : 20)
        .onAppear {
            withAnimation(.easeOut(duration: 0.6).delay(delay)) {
                appeared = true
            }
            withAnimation(
                .easeInOut(duration: 3)
                    .repeatForever(autoreverses: true)
                    .delay(delay + 0.6)
            ) {
                breathing = true
            }
        }
    }
}

#Preview {
    VStack(spacing: 12) {
        ResultCardView(
            dimensionResult: DimensionResult(
                id: UUID(),
                dimensionId: "evolution",
                dimensionTitle: "进化论视角",
                emoji: "🦕",
                content: "38亿年前，一个单细胞生物决定不再躺平……"
            ),
            delay: 0,
            onShare: {}
        )
    }
    .padding()
    .background(ZenTheme.ivory)
}
```

- [ ] **Step 2: Commit**

```bash
git add ZenChoice/ResultCardView.swift
git commit -m "refactor: rewrite ResultCardView for dimension-based encouragement"
```

---

### Task 9: Rewrite MainContentView.swift

**Files:**
- Modify: `ZenChoice/MainContentView.swift`

- [ ] **Step 1: Replace MainContentView with new single-mode encouragement UI**

Delete all existing content and write:

```swift
import SwiftUI

struct MainContentView: View {
    @Environment(ZenViewModel.self) private var viewModel

    var body: some View {
        @Bindable var vm = viewModel

        ZStack {
            ZenBackground()

            VStack(spacing: 0) {
                headerBar

                ScrollViewReader { proxy in
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 32) {
                            Spacer().frame(height: 24)

                            inputArea(wish: $vm.wish)

                            if vm.showInkAnimation {
                                InkAnimationView()
                            }

                            if vm.showResult, let result = vm.currentResult {
                                resultSection(result)
                                    .id("result")
                            }

                            Spacer().frame(height: 80)
                        }
                        .padding(.horizontal, 20)
                    }
                    #if os(iOS)
                    .scrollDismissesKeyboard(.interactively)
                    #endif
                    .onChange(of: vm.showResult) { _, show in
                        guard show else { return }
                        withAnimation(.easeOut(duration: 0.5)) {
                            proxy.scrollTo("result", anchor: .top)
                        }
                    }
                }
            }
        }
        .task { await viewModel.initialize() }
        .sheet(isPresented: $vm.showSettings) {
            SettingsView().environment(viewModel)
        }
        .sheet(isPresented: $vm.showPaywall) {
            PaywallView().environment(viewModel)
        }
        .sheet(isPresented: $vm.showArchive) {
            CourageArchiveView().environment(viewModel)
        }
        #if os(iOS)
        .sheet(isPresented: $vm.showShareSheet) {
            if let img = vm.shareCardImage {
                ShareSheetView(image: img)
            }
        }
        #endif
        .alert("提示", isPresented: $vm.showError) {
            Button("知道了") {}
        } message: {
            Text(vm.errorMessage ?? "")
        }
    }

    // MARK: - Header

    private var headerBar: some View {
        HStack {
            Button { viewModel.showArchive = true } label: {
                Image(systemName: "book.closed")
                    .font(.title3)
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.6))
            }

            Spacer()

            VStack(spacing: 2) {
                Text("禅择")
                    .font(ZenTheme.calligraphy(28))
                    .foregroundStyle(ZenTheme.inkBlack)
                Text("ZENCHOICE")
                    .font(ZenTheme.caption(10))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.5))
                    .tracking(4)
            }

            Spacer()

            Button { viewModel.showSettings = true } label: {
                Image(systemName: "gearshape")
                    .font(.title3)
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.6))
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
    }

    // MARK: - Input Area

    @ViewBuilder
    private func inputArea(wish: Binding<String>) -> some View {
        VStack(spacing: 20) {
            HStack(spacing: 8) {
                dot
                Text("今日何所想")
                    .font(ZenTheme.caption(12))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.4))
                    .tracking(6)
                dot
            }

            VStack(spacing: 8) {
                TextField("今天想做什么…", text: wish, axis: .vertical)
                    .font(ZenTheme.bodyFont(17))
                    .foregroundStyle(ZenTheme.distantMountain)
                    .multilineTextAlignment(.center)
                    .lineLimit(1...3)
                    .tint(ZenTheme.gooseYellow)
                    .onChange(of: wish.wrappedValue) { _, newValue in
                        if newValue.count > 50 {
                            wish.wrappedValue = String(newValue.prefix(50))
                        }
                    }

                DottedLine()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [4, 4]))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.2))
                    .frame(height: 1)
            }
            .padding(.horizontal, 20)

            goButton
        }
    }

    // MARK: - Go Button

    private var goButton: some View {
        Button {
            Task { await viewModel.generateEncouragement() }
        } label: {
            HStack(spacing: 8) {
                if viewModel.isLoading {
                    ProgressView().tint(ZenTheme.gooseYellow)
                } else {
                    Image(systemName: "sparkles")
                    Text("去吧")
                }
            }
            .font(ZenTheme.calligraphy(18))
            .foregroundStyle(ZenTheme.gooseYellow)
            .padding(.horizontal, 44)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(ZenTheme.inkBlack)
                    .shadow(color: ZenTheme.inkBlack.opacity(0.3), radius: 12, y: 6)
            )
        }
        .disabled(viewModel.isLoading || viewModel.wish.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        .padding(.top, 8)
    }

    // MARK: - Result Section

    private func resultSection(_ result: EncouragementResult) -> some View {
        VStack(spacing: 20) {
            // Wish echo
            Text("「\(result.wish)」")
                .font(ZenTheme.bodyFont(15))
                .foregroundStyle(ZenTheme.inkBlack)
                .padding(.top, 8)

            dividerDecoration

            // Dimension cards
            ForEach(Array(result.dimensions.enumerated()), id: \.element.id) { index, dim in
                ResultCardView(
                    dimensionResult: dim,
                    delay: Double(index) * 0.12,
                    onShare: { viewModel.generateShareCard(dimensionResult: dim) }
                )
            }

            // Subscriber upsell (if free)
            if !viewModel.isSubscribed {
                subscriberUpsell
            }

            actionButtons
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }

    // MARK: - Subscriber Upsell

    private var subscriberUpsell: some View {
        Button {
            viewModel.showPaywall = true
            HapticManager.selection()
        } label: {
            HStack(spacing: 10) {
                Image(systemName: "sparkle")
                    .foregroundStyle(ZenTheme.gooseYellow)
                VStack(alignment: .leading, spacing: 2) {
                    Text("解锁更多视角")
                        .font(ZenTheme.bodyFont(14))
                        .foregroundStyle(ZenTheme.inkBlack)
                    Text("自选维度 · 自选语气 · AI个性化生成")
                        .font(ZenTheme.caption(11))
                        .foregroundStyle(ZenTheme.distantMountain.opacity(0.5))
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.3))
            }
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(ZenTheme.gooseYellow.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(ZenTheme.gooseYellow.opacity(0.3), lineWidth: 1)
                    )
            )
        }
    }

    // MARK: - Action Buttons

    private var actionButtons: some View {
        HStack(spacing: 16) {
            Button {
                withAnimation(.easeInOut(duration: 0.5)) { viewModel.reset() }
                HapticManager.selection()
            } label: {
                Label("再来一次", systemImage: "arrow.counterclockwise")
                    .font(ZenTheme.bodyFont(14))
                    .foregroundStyle(ZenTheme.distantMountain)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(
                        Capsule().stroke(ZenTheme.distantMountain.opacity(0.3), lineWidth: 1)
                    )
            }
        }
    }

    // MARK: - Decorations

    private var dividerDecoration: some View {
        HStack(spacing: 6) {
            Rectangle().fill(ZenTheme.gooseYellow).frame(width: 30, height: 2)
            Circle().fill(ZenTheme.gooseYellow).frame(width: 5, height: 5)
            Rectangle().fill(ZenTheme.gooseYellow).frame(width: 30, height: 2)
        }
    }

    private var dot: some View {
        Circle()
            .fill(ZenTheme.distantMountain.opacity(0.15))
            .frame(width: 4, height: 4)
    }
}

// MARK: - Ink Animation

private struct InkAnimationView: View {
    @State private var pulse = false

    var body: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            ZenTheme.inkBlack.opacity(0.5),
                            ZenTheme.inkBlack.opacity(0.15),
                            .clear,
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: 120
                    )
                )
                .frame(width: 250, height: 250)
                .scaleEffect(pulse ? 1.08 : 0.92)
                .blur(radius: 25)

            ForEach(0..<3, id: \.self) { i in
                Circle()
                    .fill(ZenTheme.inkBlack.opacity(0.2))
                    .frame(width: 50, height: 50)
                    .offset(
                        x: CGFloat([-30, 25, -10][i]),
                        y: CGFloat([20, -15, 30][i])
                    )
                    .scaleEffect(pulse ? 1.1 : 0.85)
                    .blur(radius: 12)
            }

            VStack(spacing: 6) {
                ProgressView()
                    .tint(ZenTheme.distantMountain.opacity(0.5))
                Text("正在召唤勇气…")
                    .font(ZenTheme.caption(13))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.5))
            }
        }
        .frame(height: 200)
        .onAppear {
            withAnimation(
                .easeInOut(duration: 1.4).repeatForever(autoreverses: true)
            ) {
                pulse = true
            }
        }
        .transition(
            .asymmetric(
                insertion: .scale(scale: 0.01).combined(with: .opacity),
                removal: .opacity
            )
        )
    }
}

// MARK: - Dotted Line

struct DottedLine: Shape {
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: CGPoint(x: 0, y: rect.midY))
            p.addLine(to: CGPoint(x: rect.width, y: rect.midY))
        }
    }
}

// MARK: - Share Sheet (iOS)

#if os(iOS)
struct ShareSheetView: UIViewControllerRepresentable {
    let image: UIImage

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: [image], applicationActivities: nil)
    }

    func updateUIViewController(_: UIActivityViewController, context: Context) {}
}
#endif

#Preview {
    MainContentView()
        .environment(ZenViewModel())
}
```

- [ ] **Step 2: Commit**

```bash
git add ZenChoice/MainContentView.swift
git commit -m "refactor: rewrite MainContentView for single-mode encouragement UI"
```

---

**Note:** After Task 9, the build will fail because `CourageArchiveView` is referenced but not yet created. This is expected and resolved by Task 11. Tasks 10-13 can be implemented in any order; the build will succeed after all four are complete.

## Chunk 4: Share, Archive, Paywall, Settings

### Task 10: Create ShareCardView.swift and update PosterService.swift

**Files:**
- Create: `ZenChoice/ShareCardView.swift`
- Modify: `ZenChoice/PosterService.swift`

- [ ] **Step 1: Create ShareCardView.swift**

```swift
import SwiftUI

struct ShareCardView: View {
    let wish: String
    let dimensionResult: DimensionResult
    let date: Date

    private var formattedDate: String {
        let f = DateFormatter()
        f.dateFormat = "yyyy.M.d"
        return f.string(from: date)
    }

    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 32)

            // User's wish
            Text("「\(wish)」")
                .font(.system(size: 15, weight: .medium, design: .serif))
                .foregroundStyle(ZenTheme.distantMountain)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)

            Spacer().frame(height: 24)

            // Encouragement content
            Text(dimensionResult.content)
                .font(.system(size: 14, weight: .regular, design: .serif))
                .foregroundStyle(ZenTheme.inkBlack.opacity(0.85))
                .multilineTextAlignment(.leading)
                .lineSpacing(6)
                .padding(.horizontal, 24)

            Spacer().frame(height: 20)

            // Dimension attribution
            HStack(spacing: 4) {
                Spacer()
                Text("──")
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.3))
                Text("\(dimensionResult.dimensionTitle) \(dimensionResult.emoji)")
                    .font(.system(size: 12, weight: .light))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.6))
            }
            .padding(.horizontal, 24)

            Spacer()

            // Footer: app name + date
            HStack {
                Text("·")
                Text("禅择 ZenChoice")
                    .font(.system(size: 10, weight: .light))
                Text("·")
                Text(formattedDate)
                    .font(.system(size: 10, weight: .light))
                Text("·")
            }
            .foregroundStyle(ZenTheme.distantMountain.opacity(0.35))

            Spacer().frame(height: 20)
        }
        .frame(width: 340, height: 460)
        .background(ZenTheme.ivory)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(ZenTheme.distantMountain.opacity(0.08), lineWidth: 1)
        )
    }
}

#Preview {
    ShareCardView(
        wish: "辞职",
        dimensionResult: DimensionResult(
            id: UUID(),
            dimensionId: "evolution",
            dimensionTitle: "进化论视角",
            emoji: "🦕",
            content: "38亿年前，一个单细胞生物决定不再躺平，拼了命地分裂。它的后代爬上了岸，长出了腿，扛过了五次物种大灭绝，学会了直立行走，发明了外卖和Wi-Fi。这一切，就是为了让你——它最新的版本——坐在这里纠结要不要辞职？你对得起那个单细胞吗？去，别让38亿年的努力白费。"
        ),
        date: Date()
    )
    .padding()
    .background(Color.gray.opacity(0.2))
}
```

- [ ] **Step 2: Update PosterService.swift**

Delete all existing content and write:

```swift
import SwiftUI

#if os(iOS)
enum PosterService {

    @MainActor
    static func renderShareCard(
        wish: String,
        dimensionResult: DimensionResult
    ) -> UIImage? {
        let view = ShareCardView(
            wish: wish,
            dimensionResult: dimensionResult,
            date: Date()
        )
        let renderer = ImageRenderer(content: view)
        renderer.scale = 3.0
        return renderer.uiImage
    }
}
#endif
```

- [ ] **Step 3: Commit**

```bash
git add ZenChoice/ShareCardView.swift ZenChoice/PosterService.swift
git commit -m "feat: add ShareCardView and rewrite PosterService for quote card sharing"
```

---

### Task 11: Create CourageArchiveView.swift

**Files:**
- Create: `ZenChoice/CourageArchiveView.swift`

- [ ] **Step 1: Create CourageArchiveView.swift**

```swift
import SwiftUI

struct CourageArchiveView: View {
    @Environment(ZenViewModel.self) private var viewModel

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.archiveRecords.isEmpty {
                    ContentUnavailableView(
                        "尚无记录",
                        systemImage: "book.closed",
                        description: Text("你的勇气档案将在此显示")
                    )
                } else {
                    List(viewModel.archiveRecords) { record in
                        VStack(alignment: .leading, spacing: 8) {
                            Text("「\(record.wish)」")
                                .font(ZenTheme.bodyFont(15))
                                .foregroundStyle(ZenTheme.inkBlack)

                            HStack(spacing: 6) {
                                ForEach(record.dimensions) { dim in
                                    Text(dim.emoji)
                                        .font(.caption)
                                }
                            }

                            HStack {
                                if let date = record.createdAt {
                                    Text(date, style: .date)
                                        .font(ZenTheme.caption(12))
                                        .foregroundStyle(ZenTheme.distantMountain.opacity(0.5))
                                }

                                Spacer()

                                if record.isShared {
                                    Label("已分享", systemImage: "checkmark.circle.fill")
                                        .font(ZenTheme.caption(11))
                                        .foregroundStyle(.green.opacity(0.6))
                                }
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("勇气档案")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .task {
                await viewModel.loadArchive()
            }
        }
    }
}

#Preview {
    CourageArchiveView()
        .environment(ZenViewModel())
}
```

- [ ] **Step 2: Commit**

```bash
git add ZenChoice/CourageArchiveView.swift
git commit -m "feat: add CourageArchiveView for courage archive timeline"
```

---

### Task 12: Rewrite PaywallView.swift for subscriptions

**Files:**
- Modify: `ZenChoice/PaywallView.swift`

- [ ] **Step 1: Replace PaywallView with subscription-based paywall**

Delete all existing content and write:

```swift
import SwiftUI

struct PaywallView: View {
    @Environment(ZenViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss
    @State private var selectedPlan: Plan = .yearly

    enum Plan: String, CaseIterable {
        case monthly, yearly

        var title: String {
            switch self {
            case .monthly: return "月度订阅"
            case .yearly: return "年度订阅"
            }
        }

        var price: String {
            switch self {
            case .monthly: return "¥18/月"
            case .yearly: return "¥128/年"
            }
        }

        var priceSubtitle: String? {
            switch self {
            case .monthly: return nil
            case .yearly: return "约¥10.7/月，省41%"
            }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ZenBackground()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        Spacer().frame(height: 20)

                        Image(systemName: "sparkles")
                            .font(.system(size: 48))
                            .foregroundStyle(ZenTheme.gooseYellow)
                            .shadow(
                                color: ZenTheme.gooseYellow.opacity(0.4),
                                radius: 20
                            )

                        VStack(spacing: 6) {
                            Text("解锁完整体验")
                                .font(ZenTheme.calligraphy(24))
                                .foregroundStyle(ZenTheme.inkBlack)
                            Text("让每次鼓励都独一无二")
                                .font(ZenTheme.bodyFont(15))
                                .foregroundStyle(
                                    ZenTheme.distantMountain.opacity(0.6)
                                )
                        }

                        // Feature comparison
                        VStack(alignment: .leading, spacing: 16) {
                            featureRow(
                                icon: "brain.head.profile",
                                title: "AI个性化生成",
                                desc: "每次生成独一无二的鼓励，永不重复"
                            )
                            featureRow(
                                icon: "slider.horizontal.3",
                                title: "自选维度与语气",
                                desc: "选择你喜欢的视角和表达风格"
                            )
                            featureRow(
                                icon: "plus.circle",
                                title: "更多维度",
                                desc: "每次获得5+个维度的鼓励（免费版3-4个）"
                            )
                            featureRow(
                                icon: "book.closed",
                                title: "勇气档案 + 年度报告",
                                desc: "回顾你的每一次勇敢，生成年度勇气卡片"
                            )
                            featureRow(
                                icon: "paintbrush",
                                title: "自定义金句卡",
                                desc: "个性化字体与背景样式"
                            )
                        }
                        .padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.white.opacity(0.7))
                        )
                        .padding(.horizontal)

                        // Plan picker
                        VStack(spacing: 12) {
                            ForEach(Plan.allCases, id: \.self) { plan in
                                planButton(plan)
                            }
                        }
                        .padding(.horizontal)

                        // Subscribe button
                        Button {
                            // TODO: Integrate StoreKit 2 purchase
                            viewModel.subscriptionStatus = selectedPlan == .monthly ? .monthly : .yearly
                            HapticManager.success()
                            dismiss()
                        } label: {
                            Text("订阅")
                                .font(ZenTheme.calligraphy(18))
                                .foregroundStyle(ZenTheme.inkBlack)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(ZenTheme.gooseYellow)
                                        .shadow(
                                            color: ZenTheme.gooseYellow.opacity(0.4),
                                            radius: 12, y: 6
                                        )
                                )
                        }
                        .padding(.horizontal, 30)

                        Button("恢复购买") {
                            // TODO: Restore StoreKit 2 purchases
                            HapticManager.selection()
                        }
                        .font(ZenTheme.caption(13))
                        .foregroundStyle(
                            ZenTheme.distantMountain.opacity(0.5)
                        )

                        Text("本功能为娱乐性质，仅供参考\n订阅可随时在系统设置中取消")
                            .font(ZenTheme.caption(11))
                            .foregroundStyle(
                                ZenTheme.distantMountain.opacity(0.3)
                            )
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 30)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(
                                ZenTheme.distantMountain.opacity(0.4)
                            )
                    }
                }
            }
        }
    }

    private func planButton(_ plan: Plan) -> some View {
        Button {
            withAnimation { selectedPlan = plan }
            HapticManager.selection()
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(plan.title)
                        .font(ZenTheme.bodyFont(15))
                        .foregroundStyle(ZenTheme.inkBlack)
                    if let sub = plan.priceSubtitle {
                        Text(sub)
                            .font(ZenTheme.caption(11))
                            .foregroundStyle(ZenTheme.gooseYellow)
                    }
                }
                Spacer()
                Text(plan.price)
                    .font(ZenTheme.calligraphy(16))
                    .foregroundStyle(ZenTheme.inkBlack)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(selectedPlan == plan ? ZenTheme.gooseYellow.opacity(0.15) : .white.opacity(0.5))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                selectedPlan == plan ? ZenTheme.gooseYellow : ZenTheme.distantMountain.opacity(0.1),
                                lineWidth: selectedPlan == plan ? 2 : 1
                            )
                    )
            )
        }
    }

    private func featureRow(
        icon: String, title: String, desc: String
    ) -> some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(ZenTheme.gooseYellow)
                .frame(width: 32)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(ZenTheme.bodyFont(15))
                    .foregroundStyle(ZenTheme.inkBlack)
                Text(desc)
                    .font(ZenTheme.caption(12))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.6))
            }
        }
    }
}

#Preview {
    PaywallView()
        .environment(ZenViewModel())
}
```

- [ ] **Step 2: Commit**

```bash
git add ZenChoice/PaywallView.swift
git commit -m "refactor: rewrite PaywallView for subscription model"
```

---

### Task 13: Update SettingsView.swift

**Files:**
- Modify: `ZenChoice/SettingsView.swift`

- [ ] **Step 1: Replace SettingsView with updated content**

Delete all existing content and write:

```swift
import SwiftUI

struct SettingsView: View {
    @Environment(ZenViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss
    @State private var localShowPaywall = false

    var body: some View {
        @Bindable var vm = viewModel

        NavigationStack {
            Form {
                Section("个人信息") {
                    TextField("你的名字", text: $vm.userName)
                }

                Section {
                    Button {
                        Task {
                            await viewModel.syncProfile()
                            HapticManager.success()
                        }
                    } label: {
                        Label("同步资料到云端", systemImage: "icloud.and.arrow.up")
                    }
                }

                Section("订阅") {
                    HStack {
                        Label("订阅状态", systemImage: "sparkle")
                        Spacer()
                        Text(subscriptionLabel)
                            .foregroundStyle(viewModel.isSubscribed ? .green : .secondary)
                    }

                    if !viewModel.isSubscribed {
                        Button("升级订阅") {
                            localShowPaywall = true
                        }
                    }
                }

                Section("免责声明") {
                    VStack(alignment: .leading, spacing: 8) {
                        Label("娱乐性质说明", systemImage: "info.circle")
                            .font(.headline)

                        Text("""
                        「禅择 ZenChoice」是一款以娱乐为目的的趣味鼓励应用。\
                        本 App 所提供的所有鼓励内容为算法或AI生成，\
                        仅供娱乐参考，不构成任何专业建议。

                        请勿将本 App 的结果作为实际决策的唯一依据。\
                        对于因使用本 App 产生的任何后果，开发者不承担任何责任。

                        如有心理健康方面的困扰，请寻求专业人士帮助。
                        """)
                        .font(ZenTheme.caption(12))
                        .foregroundStyle(.secondary)
                        .lineSpacing(3)
                    }
                    .padding(.vertical, 4)
                }

                Section("关于") {
                    LabeledContent("版本", value: "2.0.0")
                    LabeledContent("开发者", value: "Kyle")
                }
            }
            .navigationTitle("设置")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("完成") { dismiss() }
                }
            }
            .sheet(isPresented: $localShowPaywall) {
                PaywallView().environment(viewModel)
            }
        }
    }

    private var subscriptionLabel: String {
        switch viewModel.subscriptionStatus {
        case .free: return "免费版"
        case .monthly: return "月度订阅"
        case .yearly: return "年度订阅"
        }
    }
}

#Preview {
    SettingsView()
        .environment(ZenViewModel())
}
```

- [ ] **Step 2: Commit**

```bash
git add ZenChoice/SettingsView.swift
git commit -m "refactor: update SettingsView - remove mystical content, add subscription management"
```

---

## Chunk 5: Build Verification + Content Expansion

### Task 14: Build and fix any compilation errors

**Files:**
- Possibly touch any file to fix compilation issues

- [ ] **Step 1: Attempt full build**

Run: `cd /Users/pinan/Desktop/ZenChoice/ZenChoice && xcodebuild -scheme ZenChoice -destination 'platform=iOS Simulator,name=iPhone 16' build 2>&1 | tail -40`

- [ ] **Step 2: Fix any compilation errors**

Common expected issues:
- `ContentView.swift` should still work (it just wraps `MainContentView`)
- `ZenChoiceApp.swift` should still work (it just creates `ZenViewModel`)
- Any leftover references to old types in files not yet modified

Fix each error and verify build passes.

- [ ] **Step 3: Commit fixes**

```bash
git add -A
git commit -m "fix: resolve compilation errors after pivot refactor"
```

---

### Task 15: Expand DimensionPool to 30 dimensions

**Files:**
- Modify: `ZenChoice/DimensionPool.swift`

- [ ] **Step 1: Add 20 more dimensions to DimensionPool.all**

Add dimensions for these 20 additional perspectives, each with 3 CN + 3 EN templates following the established style (80-150 chars, absurd premise → twisted logic → "go do it"):

**荒诞科学 (add 2):**
- `quantum_physicist` 量子物理学家 — Schrödinger's cat / observer effect
- `meteorologist` 气象学家 — butterfly effect / atmospheric pressure

**社会角色 (add 3):**
- `bar_owner` 酒吧老板 — drunk wisdom / liquid courage
- `kindergartener` 幼儿园小朋友 — childlike simplicity
- `delivery_driver` 外卖骑手 — always on the move

**职业视角 (add 3):**
- `lawyer` 律师 — legal arguments for doing it
- `food_critic` 美食评论家 — life is a dish
- `therapist` 心理咨询师 — therapeutic encouragement

**时间维度 (add 2):**
- `parallel_universe_you` 平行宇宙的你 — multiverse theory
- `future_historian` 100年后的历史学家 — historical significance

**文化视角 (add 4):**
- `greek_philosopher` 古希腊哲学家 — Socrates / Aristotle style
- `british_butler` 英国管家 — dry wit formality
- `anime_narrator` 日本热血动漫旁白 — shonen energy
- `rap_battle_mc` 说唱MC — rap battle style

**互联网 (add 4):**
- `douban_group_leader` 豆瓣小组组长 — group discussion style
- `zhihu_top_answer` 知乎高赞回答 — analytical essay
- `reddit_top_post` Reddit热帖 — Reddit culture
- `tiktok_creator` TikTok博主 — viral video energy

Each dimension follows the same `Dimension` struct pattern established in Task 2. Use the coding agent's LLM capabilities to draft templates in bulk, following the style guide from spec Section 3.2 (80-150 chars, absurd premise → twisted logic → "go do it").

- [ ] **Step 2: Build to verify compilation**

Run: `cd /Users/pinan/Desktop/ZenChoice/ZenChoice && xcodebuild -scheme ZenChoice -destination 'platform=iOS Simulator,name=iPhone 16' build 2>&1 | tail -20`

Expected: BUILD SUCCEEDED

- [ ] **Step 3: Commit**

```bash
git add ZenChoice/DimensionPool.swift
git commit -m "content: expand DimensionPool to 30 dimensions with full CN+EN templates"
```

---

### Task 16: Create SubscriptionManager.swift (StoreKit 2 stub)

**Files:**
- Create: `ZenChoice/SubscriptionManager.swift`

- [ ] **Step 1: Create SubscriptionManager.swift**

```swift
import Foundation
import StoreKit

@Observable
class SubscriptionManager {

    static let monthlyProductId = "monthly_premium"
    static let yearlyProductId = "yearly_premium"

    private(set) var products: [Product] = []
    private(set) var purchasedProductIds: Set<String> = []

    var currentStatus: SubscriptionStatus {
        if purchasedProductIds.contains(Self.yearlyProductId) { return .yearly }
        if purchasedProductIds.contains(Self.monthlyProductId) { return .monthly }
        return .free
    }

    func loadProducts() async {
        do {
            products = try await Product.products(for: [
                Self.monthlyProductId,
                Self.yearlyProductId,
            ])
        } catch {
            print("[ZenChoice] Failed to load products: \(error)")
        }
    }

    func purchase(_ product: Product) async throws -> Bool {
        let result = try await product.purchase()
        switch result {
        case .success(let verification):
            let transaction = try checkVerified(verification)
            purchasedProductIds.insert(transaction.productID)
            await transaction.finish()
            return true
        case .userCancelled, .pending:
            return false
        @unknown default:
            return false
        }
    }

    func restorePurchases() async {
        for await result in Transaction.currentEntitlements {
            if let transaction = try? checkVerified(result) {
                purchasedProductIds.insert(transaction.productID)
            }
        }
    }

    func listenForTransactions() async {
        for await result in Transaction.updates {
            if let transaction = try? checkVerified(result) {
                purchasedProductIds.insert(transaction.productID)
                await transaction.finish()
            }
        }
    }

    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }

    enum StoreError: Error {
        case failedVerification
    }
}
```

Note: This is a real StoreKit 2 implementation but requires App Store Connect product configuration to function. The mock purchase in `PaywallView` remains as a development fallback until products are configured.

- [ ] **Step 2: Build to verify compilation**

Run: `cd /Users/pinan/Desktop/ZenChoice/ZenChoice && xcodebuild -scheme ZenChoice -destination 'platform=iOS Simulator,name=iPhone 16' build 2>&1 | tail -20`

Expected: BUILD SUCCEEDED

- [ ] **Step 3: Commit**

```bash
git add ZenChoice/SubscriptionManager.swift
git commit -m "feat: add SubscriptionManager with StoreKit 2 implementation"
```

---

### Task 17: Final build verification and cleanup

**Files:**
- Possibly any file for cleanup

- [ ] **Step 1: Full clean build**

Run: `cd /Users/pinan/Desktop/ZenChoice/ZenChoice && xcodebuild clean build -scheme ZenChoice -destination 'platform=iOS Simulator,name=iPhone 16' 2>&1 | tail -30`

Expected: BUILD SUCCEEDED

- [ ] **Step 2: Verify no references to old mystical content remain**

Search for leftover references:
```bash
grep -r "八字\|天干\|地支\|五行\|纳音\|玄学\|命理\|DivinationMode\|DecisionRecord\|DivinationResult\|bestDay\|findBestDay\|todayAuspice\|evaluateToday\|generatePremiumReport\|赛博频率\|群体心理\|生物节律\|数字符号\|ReasonDimension" ZenChoice/ --include="*.swift" || echo "All clear — no mystical references remain"
```

Expected: "All clear — no mystical references remain"

- [ ] **Step 3: Fix any remaining references found**

If any old references are found, update those files accordingly.

- [ ] **Step 4: Final commit**

```bash
git add -A
git commit -m "chore: final cleanup - verify no mystical content remains"
```
