# ZenChoice v2 Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Transform ZenChoice from a decision-encouragement tool into a daily-use mystical entertainment app with three parallel features: Daily Fortune, Decision Encouragement (existing), and Personality Type Test.

**Architecture:** Add two new feature modules (Fortune, ZenType) alongside the existing encouragement flow. All three are accessed via a segmented control on the main screen. Data is local JSON bundles with bilingual CN/EN content. New engines handle fortune selection and type scoring. New card views enable social sharing.

**Tech Stack:** SwiftUI (iOS 18.0+), @Observable, Canvas/TimelineView animations, ImageRenderer for cards, local JSON data, UserDefaults persistence.

---

## File Structure

### New Files
| File | Responsibility |
|------|---------------|
| `FortuneData.json` | 30 bilingual fortune entries (bundle resource) |
| `ZenTypeData.json` | 16 star types + 8 test questions (bundle resource) |
| `FortuneEngine.swift` | Load fortunes, daily selection, history tracking |
| `ZenTypeEngine.swift` | Load types/questions, score answers, persist result |
| `DailyFortuneView.swift` | Fortune tab: animation → card display → share |
| `FortuneCardView.swift` | Shareable fortune card (ink wash style) |
| `ZenTypeView.swift` | Type tab: test entry or result display |
| `ZenTypeTestView.swift` | Quiz UI with animated transitions |
| `ZenTypeCardView.swift` | Shareable type result card |

### Modified Files
| File | Changes |
|------|---------|
| `Models.swift` | Add Fortune, ZenType, ZenTestQuestion structs |
| `ZenViewModel.swift` | Add tab state, fortune/type engines, daily limits |
| `MainContentView.swift` | Segmented control switching three tabs |
| `PosterService.swift` | Add fortune + type card rendering |
| `PaywallView.swift` | Update feature list for v2 |

---

## Chunk 1: Data Models & JSON Content

### Task 1: Add Data Models to Models.swift

**Files:**
- Modify: `ZenChoice/Models.swift`

- [ ] **Step 1: Add Fortune model**

Add at end of `Models.swift`:

```swift
// MARK: - Daily Fortune

struct Fortune: Codable, Identifiable {
    let id: String
    let category: String
    let should: String
    let shouldEN: String
    let shouldNot: String
    let shouldNotEN: String
    let luckyDecision: String
    let luckyDecisionEN: String
    let zenQuote: String
    let zenQuoteEN: String

    enum CodingKeys: String, CodingKey {
        case id, category
        case should, shouldNot = "should_not"
        case shouldEN = "should_en", shouldNotEN = "should_not_en"
        case luckyDecision = "lucky_decision", luckyDecisionEN = "lucky_decision_en"
        case zenQuote = "zen_quote", zenQuoteEN = "zen_quote_en"
    }
}

// MARK: - ZenType (Decision Personality)

struct ZenType: Codable, Identifiable {
    let id: String
    let codeCN: String
    let codeEN: String
    let starCN: String
    let starEN: String
    let taglineCN: String
    let taglineEN: String
    let dimensions: ZenTypeDimensions
    let labelsCN: [String]
    let labelsEN: [String]
    let detailCN: String
    let detailEN: String

    enum CodingKeys: String, CodingKey {
        case id, dimensions
        case codeCN = "code_cn", codeEN = "code_en"
        case starCN = "star_cn", starEN = "star_en"
        case taglineCN = "tagline_cn", taglineEN = "tagline_en"
        case labelsCN = "labels_cn", labelsEN = "labels_en"
        case detailCN = "detail_cn", detailEN = "detail_en"
    }
}

struct ZenTypeDimensions: Codable {
    let tempo: String   // "wind" or "mountain"
    let drive: String   // "fire" or "water"
    let risk: String    // "dragon" or "turtle"
    let after: String   // "sword" or "mirror"
}

struct ZenTestQuestion: Codable, Identifiable {
    let id: Int
    let questionCN: String
    let questionEN: String
    let optionACN: String
    let optionAEN: String
    let optionBCN: String
    let optionBEN: String
    let dimension: String
    let optionAPole: String
    let optionBPole: String

    enum CodingKeys: String, CodingKey {
        case id, dimension
        case questionCN = "question_cn", questionEN = "question_en"
        case optionACN = "option_a_cn", optionAEN = "option_a_en"
        case optionBCN = "option_b_cn", optionBEN = "option_b_en"
        case optionAPole = "option_a_pole", optionBPole = "option_b_pole"
    }
}

// MARK: - App Tab

enum AppTab: String, CaseIterable {
    case fortune
    case encourage
    case zenType
}
```

- [ ] **Step 2: Build to verify**

Run: `cd /Users/pinan/Desktop/ZenChoice/ZenChoice && xcodebuild -scheme ZenChoice -destination 'platform=iOS Simulator,name=iPhone 16 Pro' build 2>&1 | tail -5`
Expected: BUILD SUCCEEDED

- [ ] **Step 3: Commit**

```bash
git add ZenChoice/Models.swift
git commit -m "feat: add Fortune, ZenType, ZenTestQuestion models and AppTab enum"
```

---

### Task 2: Create Fortune JSON Data

**Files:**
- Create: `ZenChoice/FortuneData.json`

- [ ] **Step 1: Create FortuneData.json with 30 bilingual entries**

Create `ZenChoice/FortuneData.json`. The file must be added to the Xcode project's bundle resources. Each entry has bilingual content — 宜 is serious/guiding, 忌 is humorous/ironic.

```json
[
  {
    "id": "f001",
    "category": "interpersonal",
    "should": "对在意的人说一句真心话",
    "should_en": "Say something honest to someone you care about",
    "should_not": "在工作群里发"收到"之后偷偷翻白眼——今天会被截图",
    "should_not_en": "Rolling your eyes after typing 'noted' in the group chat — someone will screenshot it today",
    "lucky_decision": "一件你拖了超过三天的事",
    "lucky_decision_en": "Something you have been putting off for three days",
    "zen_quote": "千里之行，始于不再躺平",
    "zen_quote_en": "A thousand miles begins with getting off the couch"
  },
  {
    "id": "f002",
    "category": "self",
    "should": "接受一个不完美但足够好的选项",
    "should_en": "Accept an imperfect but good-enough option",
    "should_not": "深夜网购——你清醒时不会想要一个充气恐龙",
    "should_not_en": "Late-night online shopping — sober you does not want an inflatable dinosaur",
    "lucky_decision": "一个你一直在"再想想"的计划",
    "lucky_decision_en": "A plan you keep saying you will think about later",
    "zen_quote": "水不试，不知深浅；人不试，不知能耐",
    "zen_quote_en": "You never know how deep the water is until you step in"
  },
  {
    "id": "f003",
    "category": "career",
    "should": "把一个"也许有一天"变成"就今天"",
    "should_en": "Turn one 'someday' into 'today'",
    "should_not": "已读不回超过三个人——因果循环，下周轮到你",
    "should_not_en": "Leaving three people on read — karma is circular, next week it is your turn",
    "lucky_decision": "和钱有关的那个犹豫",
    "lucky_decision_en": "That money-related hesitation",
    "zen_quote": "山不向你走来，你便向山走去",
    "zen_quote_en": "If the mountain will not come to you, walk toward the mountain"
  },
  {
    "id": "f004",
    "category": "self",
    "should": "允许自己改变主意，这不是软弱",
    "should_en": "Allow yourself to change your mind — that is not weakness",
    "should_not": "在朋友面前假装很淡定——他们早看出来了",
    "should_not_en": "Pretending to be chill in front of friends — they figured you out ages ago",
    "lucky_decision": "一段你想修复的关系",
    "lucky_decision_en": "A relationship you have been meaning to mend",
    "zen_quote": "执念松手的那一刻，路就宽了",
    "zen_quote_en": "The moment you release the grip, the path widens"
  },
  {
    "id": "f005",
    "category": "interpersonal",
    "should": "主动约一个很久没联系的朋友",
    "should_en": "Reach out to a friend you have not talked to in a while",
    "should_not": "在点外卖时纠结超过十分钟——你最后还是会点那个",
    "should_not_en": "Spending ten minutes choosing what to order — you will pick the usual anyway",
    "lucky_decision": "一个需要开口才能实现的愿望",
    "lucky_decision_en": "A wish that requires you to speak up",
    "zen_quote": "缘来不拒，缘去不追",
    "zen_quote_en": "Welcome what arrives, release what departs"
  },
  {
    "id": "f006",
    "category": "career",
    "should": "完成那个只差最后一步的事情",
    "should_en": "Finish that thing that is only one step away from done",
    "should_not": "把闹钟设成五分钟后再响——你知道你会按七次",
    "should_not_en": "Setting a five-minute snooze — you know you will hit it seven times",
    "lucky_decision": "一个你嘴上说不行但心里想试的事",
    "lucky_decision_en": "Something you say is impossible but secretly want to try",
    "zen_quote": "行到水穷处，坐看云起时",
    "zen_quote_en": "Where the path ends, sit and watch the clouds rise"
  },
  {
    "id": "f007",
    "category": "money",
    "should": "为自己花一笔不用解释的钱",
    "should_en": "Spend money on yourself without needing to justify it",
    "should_not": "查看前任的社交媒体——你会把正常的晚餐解读成暗示",
    "should_not_en": "Checking your ex's social media — you will read hidden messages into a normal dinner photo",
    "lucky_decision": "那个你觉得太奢侈的投资",
    "lucky_decision_en": "The investment you think is too extravagant",
    "zen_quote": "舍得舍得，有舍才有得",
    "zen_quote_en": "To gain, first learn to let go"
  },
  {
    "id": "f008",
    "category": "health",
    "should": "今天早睡一小时，不看手机",
    "should_en": "Sleep one hour earlier tonight, no phone",
    "should_not": "跟AI争论谁更聪明——你们都会输",
    "should_not_en": "Arguing with AI about who is smarter — you will both lose",
    "lucky_decision": "一个关于你身体健康的选择",
    "lucky_decision_en": "A choice about your physical health",
    "zen_quote": "身体是灵魂的神庙，别把它当仓库",
    "zen_quote_en": "Your body is a temple for the soul, not a storage unit"
  },
  {
    "id": "f009",
    "category": "self",
    "should": "写下三件你今天感恩的事",
    "should_en": "Write down three things you are grateful for today",
    "should_not": "用"我再研究研究"来回避需要做的决定",
    "should_not_en": "Using 'let me do more research' to avoid a decision you already know the answer to",
    "lucky_decision": "一件你害怕失败所以不敢开始的事",
    "lucky_decision_en": "Something you have not started because you fear failure",
    "zen_quote": "不怕慢，只怕站",
    "zen_quote_en": "Fear not the slow pace, fear only standing still"
  },
  {
    "id": "f010",
    "category": "interpersonal",
    "should": "认真地夸一个人，不带任何目的",
    "should_en": "Give someone a genuine compliment with no agenda",
    "should_not": "在朋友圈精修照片超过二十分钟——大家在刷的时候只看半秒",
    "should_not_en": "Editing a selfie for twenty minutes — everyone scrolls past it in half a second",
    "lucky_decision": "一个需要信任别人才能完成的事",
    "lucky_decision_en": "Something that requires trusting another person",
    "zen_quote": "以诚待人，人亦以诚待你",
    "zen_quote_en": "Meet others with sincerity, and sincerity returns"
  },
  {
    "id": "f011",
    "category": "career",
    "should": "向一个你佩服的人请教一件事",
    "should_en": "Ask someone you admire for one piece of advice",
    "should_not": "在工位上偷吃零食然后假装在思考人生——监控看得见",
    "should_not_en": "Sneaking snacks at your desk while pretending to contemplate life — the camera sees you",
    "lucky_decision": "那个你想提但怕被拒绝的建议",
    "lucky_decision_en": "The suggestion you want to make but fear will be rejected",
    "zen_quote": "敢问路在何方，路在脚下",
    "zen_quote_en": "Ask where the road leads — it is right beneath your feet"
  },
  {
    "id": "f012",
    "category": "self",
    "should": "花十分钟做一件纯粹让自己开心的事",
    "should_en": "Spend ten minutes doing something purely for your own joy",
    "should_not": "把"随便"当作真正的选择——你心里明明有答案",
    "should_not_en": "Saying 'whatever' as if it is an actual choice — you already know what you want",
    "lucky_decision": "一个让你兴奋但觉得不够现实的想法",
    "lucky_decision_en": "An exciting idea you dismissed as unrealistic",
    "zen_quote": "心若自在，处处皆是风景",
    "zen_quote_en": "When the heart is free, everywhere is a view"
  },
  {
    "id": "f013",
    "category": "money",
    "should": "检查一项你忘了取消的订阅",
    "should_en": "Check for a subscription you forgot to cancel",
    "should_not": "跟出租车司机争最佳路线——他开了三万公里你开了三百",
    "should_not_en": "Arguing the best route with a taxi driver — they have driven thirty thousand km, you have driven three hundred",
    "lucky_decision": "一个你觉得时机不对所以一直等的事",
    "lucky_decision_en": "Something you keep waiting for the right time to do",
    "zen_quote": "时机不会完美，但你可以",
    "zen_quote_en": "The timing will never be perfect, but you can be"
  },
  {
    "id": "f014",
    "category": "health",
    "should": "出门走走，哪怕只是绕小区一圈",
    "should_en": "Go for a walk, even just around the block",
    "should_not": "用"明天开始"来安慰今天的自己——明天的你也会说同样的话",
    "should_not_en": "Telling yourself 'starting tomorrow' — tomorrow-you will say the same thing",
    "lucky_decision": "一个跟改变习惯有关的决定",
    "lucky_decision_en": "A decision about changing a habit",
    "zen_quote": "静坐常思己过，闲谈莫论人非",
    "zen_quote_en": "In silence, reflect on yourself; in conversation, speak no ill of others"
  },
  {
    "id": "f015",
    "category": "interpersonal",
    "should": "对一个一直帮你的人说声谢谢",
    "should_en": "Say thank you to someone who has been helping you quietly",
    "should_not": "群发节日祝福——收到的人会以为是AI写的（虽然确实是）",
    "should_not_en": "Mass-sending holiday greetings — recipients will assume AI wrote it (and they would be right)",
    "lucky_decision": "一个关于道歉的犹豫",
    "lucky_decision_en": "A hesitation about apologizing",
    "zen_quote": "一句温柔的话，胜过千言万语",
    "zen_quote_en": "One gentle word outweighs a thousand arguments"
  },
  {
    "id": "f016",
    "category": "career",
    "should": "给自己设一个小小的、今天就能完成的目标",
    "should_en": "Set one small goal you can finish today",
    "should_not": "在开会时假装网络不好来逃避发言——你的Wi-Fi信号满格",
    "should_not_en": "Pretending your internet is lagging to avoid speaking up — your Wi-Fi is at full bars",
    "lucky_decision": "那件你觉得准备好了但还在等"更准备好"的事",
    "lucky_decision_en": "The thing you are ready for but keep waiting to feel more ready",
    "zen_quote": "千里马常有，敢跑的不常有",
    "zen_quote_en": "Talent is common; the courage to run is rare"
  },
  {
    "id": "f017",
    "category": "self",
    "should": "放下手机，和自己的想法独处五分钟",
    "should_en": "Put down your phone and sit alone with your thoughts for five minutes",
    "should_not": "在选择困难时抛硬币然后"三局两胜""五局三胜"……",
    "should_not_en": "Flipping a coin to decide, then going best of three, then best of five...",
    "lucky_decision": "一个你内心已经有答案的问题",
    "lucky_decision_en": "A question you already know the answer to deep down",
    "zen_quote": "答案不在远方，就在你心里",
    "zen_quote_en": "The answer is not far away — it is already within you"
  },
  {
    "id": "f018",
    "category": "money",
    "should": "把你一直犹豫要不要买的东西列出来，只留一个",
    "should_en": "List everything you have been wanting to buy — keep only one",
    "should_not": "计算自己时薪然后用它换算一切——一杯奶茶不值得你算那么久",
    "should_not_en": "Converting everything to your hourly wage — a cup of boba is not worth that much math",
    "lucky_decision": "一次你想投资自己的机会",
    "lucky_decision_en": "A chance to invest in yourself",
    "zen_quote": "金钱是工具，不是目的",
    "zen_quote_en": "Money is a tool, not the destination"
  },
  {
    "id": "f019",
    "category": "interpersonal",
    "should": "原谅一个无心冒犯你的人",
    "should_en": "Forgive someone who offended you unintentionally",
    "should_not": "用表情包代替真正想说的话——对方猜不到那个狗头是什么意思",
    "should_not_en": "Replacing real words with memes — the other person cannot decode what that dog emoji means",
    "lucky_decision": "一个关于放手的决定",
    "lucky_decision_en": "A decision about letting go",
    "zen_quote": "宽恕别人，就是释放自己",
    "zen_quote_en": "Forgiving others is freeing yourself"
  },
  {
    "id": "f020",
    "category": "health",
    "should": "喝够八杯水，从现在这杯开始",
    "should_en": "Drink eight glasses of water today, starting with this one",
    "should_not": "躺在床上用手机搜"怎么早睡"——讽刺的是你搜到凌晨两点",
    "should_not_en": "Lying in bed googling 'how to sleep early' — the irony peaks at 2 AM",
    "lucky_decision": "一个关于对自己好一点的选择",
    "lucky_decision_en": "A choice about being a little kinder to yourself",
    "zen_quote": "善待自己，才能善待世界",
    "zen_quote_en": "Be kind to yourself before you try to be kind to the world"
  },
  {
    "id": "f021",
    "category": "career",
    "should": "删除一个消耗你但没有价值的习惯",
    "should_en": "Drop one habit that drains you but adds no value",
    "should_not": "在简历上把"看过几篇文章"写成"深入研究"——面试官也这样写过",
    "should_not_en": "Listing 'read a few articles' as 'extensive research' on your resume — interviewers did the same thing",
    "lucky_decision": "一个关于效率的小改变",
    "lucky_decision_en": "A small change about productivity",
    "zen_quote": "大道至简，繁华落尽见真章",
    "zen_quote_en": "The greatest truth is simplicity — strip away the noise to see clearly"
  },
  {
    "id": "f022",
    "category": "self",
    "should": "承认一件你一直在逃避的事，哪怕只是对自己承认",
    "should_en": "Admit one thing you have been avoiding, even if only to yourself",
    "should_not": "用"我是完美主义者"来解释为什么什么都没开始",
    "should_not_en": "Using 'I am a perfectionist' to explain why you have not started anything",
    "lucky_decision": "那件你假装看不见的事",
    "lucky_decision_en": "The thing you have been pretending not to see",
    "zen_quote": "直面真相的勇气，是一切改变的起点",
    "zen_quote_en": "The courage to face the truth is where all change begins"
  },
  {
    "id": "f023",
    "category": "interpersonal",
    "should": "回复那条你看了很久但一直没回的消息",
    "should_en": "Reply to that message you have read but never responded to",
    "should_not": "在朋友求助时说"我也是"然后开始讲自己的事——今天请专心听",
    "should_not_en": "Saying 'same here' when a friend asks for help then talking about yourself — today, just listen",
    "lucky_decision": "一个需要主动迈出第一步的事",
    "lucky_decision_en": "Something that needs you to take the first step",
    "zen_quote": "你等的人，也许也在等你",
    "zen_quote_en": "The person you are waiting for might be waiting for you too"
  },
  {
    "id": "f024",
    "category": "money",
    "should": "把一个"等打折再买"的东西现在就买",
    "should_en": "Buy that thing you have been waiting for a sale to get",
    "should_not": "在超市里比较两个品牌的单价差了三毛钱——你的时间比三毛钱贵",
    "should_not_en": "Comparing unit prices at the supermarket over a three-cent difference — your time is worth more than three cents",
    "lucky_decision": "一个关于"值不值得"的判断",
    "lucky_decision_en": "A judgment about whether something is worth it",
    "zen_quote": "值不值得，问心即知",
    "zen_quote_en": "Ask your heart — it already knows what is worthwhile"
  },
  {
    "id": "f025",
    "category": "self",
    "should": "学一个五分钟就能学会的新技能",
    "should_en": "Learn one new skill that takes only five minutes",
    "should_not": "收藏了一百个教程但一个都没看——你的收藏夹是知识的坟场",
    "should_not_en": "Bookmarking a hundred tutorials without opening one — your saved folder is where knowledge goes to die",
    "lucky_decision": "一个关于学习新东西的想法",
    "lucky_decision_en": "An idea about learning something new",
    "zen_quote": "学而不思则罔，思而不学则殆",
    "zen_quote_en": "Learning without thinking is lost labor; thinking without learning is perilous"
  },
  {
    "id": "f026",
    "category": "health",
    "should": "今天做三次深呼吸，认真地",
    "should_en": "Take three deep breaths today — and actually mean it",
    "should_not": "一边说"我不care"一边刷了对方朋友圈三十条——你很care",
    "should_not_en": "Saying 'I don't care' while scrolling thirty posts deep into their feed — you very much care",
    "lucky_decision": "一个关于放松的选择",
    "lucky_decision_en": "A choice about relaxation",
    "zen_quote": "呼吸之间，万物归一",
    "zen_quote_en": "Between breaths, all things return to one"
  },
  {
    "id": "f027",
    "category": "career",
    "should": "把拖延清单上排第一的事做掉",
    "should_en": "Do the number-one item on your procrastination list",
    "should_not": "把"待办事项"从一个App搬到另一个App然后觉得自己很高效",
    "should_not_en": "Moving your to-do list from one app to another and calling it productivity",
    "lucky_decision": "一个你已经知道答案但在等别人确认的决定",
    "lucky_decision_en": "A decision you already know the answer to but are waiting for someone to confirm",
    "zen_quote": "做一件事的最好时机是昨天，其次是现在",
    "zen_quote_en": "The best time was yesterday; the second best time is now"
  },
  {
    "id": "f028",
    "category": "interpersonal",
    "should": "对今天帮过你的人微笑",
    "should_en": "Smile at someone who helped you today",
    "should_not": "在群聊里发了一段话然后紧盯着屏幕等人回复——他们在午睡",
    "should_not_en": "Sending a message to the group chat and staring at the screen for replies — they are all napping",
    "lucky_decision": "一个关于表达善意的机会",
    "lucky_decision_en": "A chance to express goodwill",
    "zen_quote": "予人玫瑰，手有余香",
    "zen_quote_en": "Give a rose, and the fragrance lingers on your hand"
  },
  {
    "id": "f029",
    "category": "self",
    "should": "今天不跟任何人比较，只跟昨天的自己比",
    "should_en": "Compare yourself to no one today except who you were yesterday",
    "should_not": "看到别人的成就就觉得自己的努力不够——你只看到了他们的高光",
    "should_not_en": "Feeling inadequate seeing others succeed — you are comparing your behind-the-scenes to their highlight reel",
    "lucky_decision": "一个关于自我接纳的选择",
    "lucky_decision_en": "A choice about self-acceptance",
    "zen_quote": "你不必成为别人，做自己已足够精彩",
    "zen_quote_en": "You do not need to be anyone else — being you is already enough"
  },
  {
    "id": "f030",
    "category": "career",
    "should": "勇敢地说出你的真实想法，即使可能被反对",
    "should_en": "Speak your real opinion bravely, even if it might be opposed",
    "should_not": "在心里排练了一百遍要说的话然后说了句"没事"——今天请说真话",
    "should_not_en": "Rehearsing what to say a hundred times in your head then saying 'never mind' — today, say the real thing",
    "lucky_decision": "一个需要勇气开口的决定",
    "lucky_decision_en": "A decision that takes courage to voice",
    "zen_quote": "真话不一定动听，但一定有力量",
    "zen_quote_en": "The truth may not be pretty, but it always carries power"
  }
]
```

- [ ] **Step 2: Add FortuneData.json to Xcode project bundle**

Open Xcode → File → Add Files to "ZenChoice" → select `FortuneData.json` → ensure "Add to target: ZenChoice" is checked.

Or verify via build: the file must be in Copy Bundle Resources.

- [ ] **Step 3: Commit**

```bash
git add ZenChoice/FortuneData.json
git commit -m "feat: add 30 bilingual fortune entries"
```

---

### Task 3: Create ZenType JSON Data

**Files:**
- Create: `ZenChoice/ZenTypeData.json`

- [ ] **Step 1: Create ZenTypeData.json with 16 types and 8 test questions**

```json
{
  "types": [
    {
      "id": "wildfire",
      "code_cn": "疾风烈焰", "code_en": "Wildfire",
      "star_cn": "破晓星", "star_en": "Dawnstar",
      "tagline_cn": "三秒决定，绝不回头看爆炸",
      "tagline_en": "Decides in three seconds, never looks back",
      "dimensions": { "tempo": "wind", "drive": "fire", "risk": "dragon", "after": "sword" },
      "labels_cn": ["疾行", "炽感", "敢破", "不回"],
      "labels_en": ["Swift", "Blaze", "Brave", "Forge"],
      "detail_cn": "你是决策宇宙中的流星——来得快，去得也快，但每次划过都让人难忘。你的决定像呼吸一样自然，靠的是直觉和一腔热血。别人还在列利弊清单的时候，你已经在执行了。你不害怕犯错，因为你知道速度本身就是一种优势。你的座右铭是：做了再说，错了再改。世界属于行动派，而你就是行动派中的战斗机。",
      "detail_en": "You are a meteor in the decision universe — fast, bright, and unforgettable. Your choices come as naturally as breathing, fueled by instinct and passion. While others are still making pro-con lists, you are already halfway there. You do not fear mistakes because you know speed itself is an advantage. Your motto: act first, adjust later. The world belongs to those who move, and you are a fighter jet among movers."
    },
    {
      "id": "flaretide",
      "code_cn": "焰起潮生", "code_en": "Flaretide",
      "star_cn": "流焰星", "star_en": "Flamestar",
      "tagline_cn": "热血上头就冲了，冲完写检讨",
      "tagline_en": "Charges in headfirst, journals about it after",
      "dimensions": { "tempo": "wind", "drive": "fire", "risk": "dragon", "after": "mirror" },
      "labels_cn": ["疾行", "炽感", "敢破", "常省"],
      "labels_en": ["Swift", "Blaze", "Brave", "Gaze"],
      "detail_cn": "你是冲动与反思的矛盾体——先干为敬，然后在日记里写三千字复盘。你的热情让你永远不缺勇气，但你的敏感也让你无法对结果视而不见。你的成长速度比谁都快，因为你既敢做又敢想。别人觉得你莽撞，但只有你知道，每一次反思都让下一次冲锋更精准。",
      "detail_en": "You are a beautiful contradiction — all impulse and all reflection. You charge first and journal three thousand words about it later. Your passion means you never lack courage, but your sensitivity means you cannot ignore consequences. You grow faster than anyone because you both dare and reflect. Others call you reckless; only you know each reflection sharpens the next charge."
    },
    {
      "id": "hearthwind",
      "code_cn": "暖风不散", "code_en": "Hearthwind",
      "star_cn": "守焰星", "star_en": "Embstar",
      "tagline_cn": "感觉到位就选最稳的，安心入睡",
      "tagline_en": "Follows the heart to the safest shore",
      "dimensions": { "tempo": "wind", "drive": "fire", "risk": "turtle", "after": "sword" },
      "labels_cn": ["疾行", "炽感", "善守", "不回"],
      "labels_en": ["Swift", "Blaze", "Guard", "Forge"],
      "detail_cn": "你像一阵暖风——来得快，但总是落在最安全的地方。你的决策靠感觉，但你的感觉出奇地稳。选了就不纠结，睡觉比谁都香。你是那种朋友都想要的决策顾问：果断、温暖、不冒险。你的超能力是「快速找到心安的选择」。",
      "detail_en": "You are a warm breeze — quick to arrive, but always landing in the safest place. You decide by feeling, yet your feelings are remarkably stable. Once chosen, you never second-guess, and you sleep better than anyone. You are the decision advisor every friend wants: decisive, warm, and risk-free. Your superpower is quickly finding the choice that brings peace of mind."
    },
    {
      "id": "candleglow",
      "code_cn": "烛照四壁", "code_en": "Candleglow",
      "star_cn": "残烛星", "star_en": "Wickstar",
      "tagline_cn": "选了安全的路，总觉得错过烟火",
      "tagline_en": "Takes the safe road, dreams of fireworks",
      "dimensions": { "tempo": "wind", "drive": "fire", "risk": "turtle", "after": "mirror" },
      "labels_cn": ["疾行", "炽感", "善守", "常省"],
      "labels_en": ["Swift", "Blaze", "Guard", "Gaze"],
      "detail_cn": "你的心里有一团火，但你的手总是选择最安全的灯笼。决定做得快，选的永远稳，但夜深人静时你会想：如果当初选了那条更疯狂的路呢？你不是优柔寡断，你是在安全和精彩之间做了无数次无声的拉锯。好消息是——你的反思让你越来越懂自己。",
      "detail_en": "There is a fire in your heart, but your hands always reach for the safest lantern. Decisions come fast, choices stay safe, yet late at night you wonder: what if you had taken the wilder road? You are not indecisive — you are in a silent tug-of-war between safety and adventure. The good news: each reflection teaches you more about who you truly are."
    },
    {
      "id": "icebreak",
      "code_cn": "冰河破晓", "code_en": "Icebreak",
      "star_cn": "凌霄星", "star_en": "Peakstar",
      "tagline_cn": "半秒算完最优解，直接梭哈",
      "tagline_en": "Calculates the odds, then goes all in",
      "dimensions": { "tempo": "wind", "drive": "water", "risk": "dragon", "after": "sword" },
      "labels_cn": ["疾行", "冷观", "敢破", "不回"],
      "labels_en": ["Swift", "Frost", "Brave", "Forge"],
      "detail_cn": "你是决策界的超级计算机——分析速度快，胆子还大。别人还在感受氛围的时候，你已经算完了概率直接下注。你的冷静让人觉得你无情，但其实你只是效率高。你不后悔，不是因为你不在乎，而是因为你相信自己当时的判断。钢铁意志，冰雪聪明。",
      "detail_en": "You are a supercomputer of decision-making — fast analysis, bold execution. While others are still feeling the mood, you have calculated the odds and placed your bet. Your composure seems cold, but you are simply efficient. You do not regret — not because you do not care, but because you trust your judgment. Steel will, razor mind."
    },
    {
      "id": "moonpool",
      "code_cn": "寒潭映月", "code_en": "Moonpool",
      "star_cn": "弈枰星", "star_en": "Gamestar",
      "tagline_cn": "秒算最优解后冒险，赢了还要复盘",
      "tagline_en": "Bets smart, wins big, still reviews the tape",
      "dimensions": { "tempo": "wind", "drive": "water", "risk": "dragon", "after": "mirror" },
      "labels_cn": ["疾行", "冷观", "敢破", "常省"],
      "labels_en": ["Swift", "Frost", "Brave", "Gaze"],
      "detail_cn": "你是棋手中的棋手——算得快，下得准，赢了还要复盘三遍。你的理性让你在高风险中游刃有余，你的反思让你每次都比上次更强。你不是完美主义者，你是进化主义者。唯一的烦恼？你太知道自己本可以做得更好了。",
      "detail_en": "You are the chess player among chess players — fast calculations, precise moves, and you still review the game three times after winning. Your rationality lets you navigate high-risk situations with ease. Your reflection makes you stronger every time. You are not a perfectionist — you are an evolutionist. Your only trouble? You always know you could have done even better."
    },
    {
      "id": "silentfrost",
      "code_cn": "霜落无声", "code_en": "Silentfrost",
      "star_cn": "青磐星", "star_en": "Ironstar",
      "tagline_cn": "算出最稳方案，闭眼执行",
      "tagline_en": "Finds the safest plan and never looks back",
      "dimensions": { "tempo": "wind", "drive": "water", "risk": "turtle", "after": "sword" },
      "labels_cn": ["疾行", "冷观", "善守", "不回"],
      "labels_en": ["Swift", "Frost", "Guard", "Forge"],
      "detail_cn": "你像霜降一样——悄无声息，但覆盖一切。你用最短的时间找到最稳的答案，然后毫不犹豫地执行。你是团队里最让人安心的存在：不炫耀、不焦虑、不反悔。你的力量不在于冒险，而在于稳如磐石的确定感。",
      "detail_en": "You are like frost falling — silent, yet covering everything. You find the safest answer in the shortest time, then execute without hesitation. You are the most reassuring presence on any team: no showboating, no anxiety, no regrets. Your strength lies not in risk-taking but in the rock-solid certainty you bring to every choice."
    },
    {
      "id": "ripplecalm",
      "code_cn": "水纹未定", "code_en": "Ripplecalm",
      "star_cn": "玑衡星", "star_en": "Polestar",
      "tagline_cn": "找到安全路线，但总想再优化",
      "tagline_en": "Finds the answer, keeps solving anyway",
      "dimensions": { "tempo": "wind", "drive": "water", "risk": "turtle", "after": "mirror" },
      "labels_cn": ["疾行", "冷观", "善守", "常省"],
      "labels_en": ["Swift", "Frost", "Guard", "Gaze"],
      "detail_cn": "你的大脑是一台永不停机的优化引擎。找到安全答案？太好了，但能不能再优化1%？你的决策快且稳，但你的内心永远在微调。你不是纠结，你是追求极致。这让你成为最可靠的执行者，也让你偶尔需要提醒自己：够好了，真的够好了。",
      "detail_en": "Your brain is an optimization engine that never shuts down. Found a safe answer? Great, but can you improve it by one percent? Your decisions are fast and safe, but your mind is always fine-tuning. You are not indecisive — you are pursuing excellence. This makes you the most reliable executor, though you occasionally need to remind yourself: good enough really is good enough."
    },
    {
      "id": "dormthunder",
      "code_cn": "蛰雷将发", "code_en": "Dormthunder",
      "star_cn": "伏龙星", "star_en": "Wyrmstar",
      "tagline_cn": "沉默三天，突然爆发，一骑绝尘",
      "tagline_en": "Silent for days, then strikes like lightning",
      "dimensions": { "tempo": "mountain", "drive": "fire", "risk": "dragon", "after": "sword" },
      "labels_cn": ["缓行", "炽感", "敢破", "不回"],
      "labels_en": ["Still", "Blaze", "Brave", "Forge"],
      "detail_cn": "你是沉睡的火山——表面平静，内心翻涌。你需要时间来感受、酝酿、积蓄能量，但一旦决定，那股爆发力让所有人目瞪口呆。你不回头，不是因为冷血，而是因为你在沉默中已经把所有退路都想过了。你的字典里没有「犹豫」，只有「时候未到」和「现在就走」。",
      "detail_en": "You are a dormant volcano — calm on the surface, churning within. You need time to feel, to brew, to gather energy. But once decided, your eruption stuns everyone. You never look back — not from coldness, but because you already considered every retreat in your silence. Your vocabulary has no 'hesitation,' only 'not yet' and 'let us go now.'"
    },
    {
      "id": "stormbrewing",
      "code_cn": "山雨欲来", "code_en": "Stormbrewing",
      "star_cn": "踟蹰星", "star_en": "Miststar",
      "tagline_cn": "鼓了很久勇气冲了，然后后悔",
      "tagline_en": "Gathers courage for weeks, regrets in minutes",
      "dimensions": { "tempo": "mountain", "drive": "fire", "risk": "dragon", "after": "mirror" },
      "labels_cn": ["缓行", "炽感", "敢破", "常省"],
      "labels_en": ["Still", "Blaze", "Brave", "Gaze"],
      "detail_cn": "你是最典型的「纠结星人」——感受丰富，行动大胆，但事后反思能力拉满。你的勇气需要酝酿，但一旦出手就是大手笔。然后呢？然后你开始想这个大手笔是不是有点太大了。别担心，这说明你有深度。你的纠结不是弱点，是你对生活认真的证据。",
      "detail_en": "You are the classic overthinker — rich in feeling, bold in action, and maxed out on post-decision reflection. Your courage needs time to brew, but when you act, you go big. And then? Then you wonder if big was a bit too big. Do not worry — this shows depth. Your overthinking is not a flaw; it is proof you take life seriously."
    },
    {
      "id": "springmount",
      "code_cn": "春山如故", "code_en": "Springmount",
      "star_cn": "温玉星", "star_en": "Jadestar",
      "tagline_cn": "慢慢感受，温柔选了最稳的路",
      "tagline_en": "Feels deeply, chooses gently, sleeps soundly",
      "dimensions": { "tempo": "mountain", "drive": "fire", "risk": "turtle", "after": "sword" },
      "labels_cn": ["缓行", "炽感", "善守", "不回"],
      "labels_en": ["Still", "Blaze", "Guard", "Forge"],
      "detail_cn": "你像春天的山——温暖、稳固、不急不躁。你用感觉做选择，但你的感觉总是指向最安全的方向。选完之后，你内心平静如水。你是朋友中最好的倾听者，也是最让人安心的陪伴者。你的温柔不是软弱，是经过深思熟虑后的坚定。",
      "detail_en": "You are like a mountain in spring — warm, steady, unhurried. You choose by feeling, but your feelings always point toward safety. After choosing, your heart is calm as still water. You are the best listener among your friends and the most comforting presence. Your gentleness is not weakness — it is firmness born from deep consideration."
    },
    {
      "id": "halfmoon",
      "code_cn": "月落两端", "code_en": "Halfmoon",
      "star_cn": "怀萤星", "star_en": "Glowstar",
      "tagline_cn": "什么都想兼顾，惦记着远方",
      "tagline_en": "Holds both sides, gazes at the horizon",
      "dimensions": { "tempo": "mountain", "drive": "fire", "risk": "turtle", "after": "mirror" },
      "labels_cn": ["缓行", "炽感", "善守", "常省"],
      "labels_en": ["Still", "Blaze", "Guard", "Gaze"],
      "detail_cn": "你是半轮月亮——一半照着脚下的路，一半望着远方的海。你的心很热，但手很稳；你选了安全的路，但总忍不住回头看那条没走的。你不是优柔寡断，你是对生活怀有太多期待。好消息：你的每一次回望，都在为下一次选择积累智慧。",
      "detail_en": "You are a half moon — one half illuminating the path beneath your feet, the other gazing at the distant sea. Your heart runs hot, but your hands stay steady. You chose the safe road, yet cannot help glancing at the one not taken. You are not indecisive — you simply expect too much from life. Good news: every backward glance builds wisdom for the next choice."
    },
    {
      "id": "depthecho",
      "code_cn": "深渊回响", "code_en": "Depthecho",
      "star_cn": "伏虎星", "star_en": "Graspstar",
      "tagline_cn": "深谋远虑后出手，谁劝都没用",
      "tagline_en": "Plans for weeks, strikes once, never wavers",
      "dimensions": { "tempo": "mountain", "drive": "water", "risk": "dragon", "after": "sword" },
      "labels_cn": ["缓行", "冷观", "敢破", "不回"],
      "labels_en": ["Still", "Frost", "Brave", "Forge"],
      "detail_cn": "你是深海中的巨兽——看不见你动，但一出手就是致命一击。你用理性分析一切，用时间验证一切，然后在所有人都以为你放弃的时候，突然出手。你的决定无法动摇，因为它经过了你最严格的审判。你是最可怕的对手，也是最可靠的盟友。",
      "detail_en": "You are a leviathan in the deep — unseen in motion, but lethal when you strike. You analyze everything with reason, verify everything with time, then move when everyone assumes you have given up. Your decisions cannot be shaken because they have passed your strictest tribunal. You are the most formidable opponent and the most reliable ally."
    },
    {
      "id": "riverlong",
      "code_cn": "长河未央", "code_en": "Riverlong",
      "star_cn": "问渠星", "star_en": "Seekstar",
      "tagline_cn": "做完分析才冒险，每晚重新分析",
      "tagline_en": "Analyzes before the leap, re-analyzes after",
      "dimensions": { "tempo": "mountain", "drive": "water", "risk": "dragon", "after": "mirror" },
      "labels_cn": ["缓行", "冷观", "敢破", "常省"],
      "labels_en": ["Still", "Frost", "Brave", "Gaze"],
      "detail_cn": "你是一条永远在流的河——看起来平静，其实一直在前进和自我修正。你在冒险前做足功课，冒险后做足反思。你的人生是一场永恒的迭代实验，每一版都比上一版更好。唯一的问题：你有时候会忘记庆祝已经取得的成就。",
      "detail_en": "You are a river that never stops flowing — calm on the surface, always advancing and self-correcting beneath. You do your homework before taking risks and your reflection after. Your life is an eternal iterative experiment, each version better than the last. The only issue: you sometimes forget to celebrate what you have already achieved."
    },
    {
      "id": "stillwater",
      "code_cn": "止水无波", "code_en": "Stillwater",
      "star_cn": "太素星", "star_en": "Calmstar",
      "tagline_cn": "想清楚了稳稳落子，波澜不惊",
      "tagline_en": "Thinks it through, places the stone, breathes",
      "dimensions": { "tempo": "mountain", "drive": "water", "risk": "turtle", "after": "sword" },
      "labels_cn": ["缓行", "冷观", "善守", "不回"],
      "labels_en": ["Still", "Frost", "Guard", "Forge"],
      "detail_cn": "你是围棋高手——每一步都经过深思熟虑，每一个选择都指向最安全的结局。你不焦虑、不后悔、不被情绪左右。你的内心平静不是因为你没有感受，而是因为你已经想清楚了一切。你是人群中最「人间清醒」的存在，也是最让人安心的决策者。",
      "detail_en": "You are a Go master — every move deeply considered, every choice pointing toward the safest outcome. You feel no anxiety, no regret, no emotional interference. Your inner calm is not from lack of feeling but from having thought everything through. You are the most clear-headed person in the room and the most reassuring decision-maker anyone could ask for."
    },
    {
      "id": "fogchain",
      "code_cn": "雾锁连环", "code_en": "Fogchain",
      "star_cn": "永漏星", "star_en": "Loopstar",
      "tagline_cn": "分析→犹豫→再分析→循环中",
      "tagline_en": "Thinks, doubts, rethinks — forever loading",
      "dimensions": { "tempo": "mountain", "drive": "water", "risk": "turtle", "after": "mirror" },
      "labels_cn": ["缓行", "冷观", "善守", "常省"],
      "labels_en": ["Still", "Frost", "Guard", "Gaze"],
      "detail_cn": "你是一个无限循环的思考者——分析、犹豫、再分析、再犹豫。你的大脑像一台精密仪器，永远在寻找更优解。你的谨慎让你很少犯错，但也让你常常错过「差不多就行」的快乐。其实你心里知道：很多选择没有最优解，选了就是最优解。给自己设个截止日期吧，然后相信自己的判断。",
      "detail_en": "You are an infinite loop of thinking — analyze, hesitate, re-analyze, re-hesitate. Your brain is a precision instrument forever searching for a better answer. Your caution means you rarely make mistakes, but you also miss the joy of 'good enough.' Deep down you know: many choices have no optimal answer — choosing makes it optimal. Set yourself a deadline, then trust your own judgment."
    }
  ],
  "questions": [
    {
      "id": 1,
      "question_cn": "朋友突然问你"周末去露营吗"——",
      "question_en": "A friend suddenly asks 'Wanna go camping this weekend?' —",
      "option_a_cn": "去啊！边说边查天气",
      "option_a_en": "Sure! Already checking the weather",
      "option_b_cn": "我看看日程……回头跟你说",
      "option_b_en": "Let me check my calendar… I will get back to you",
      "dimension": "tempo",
      "option_a_pole": "wind",
      "option_b_pole": "mountain"
    },
    {
      "id": 2,
      "question_cn": "面前有两家餐厅，一家你吃过很多次，一家全新——",
      "question_en": "Two restaurants ahead — one you know well, one brand new —",
      "option_a_cn": "试新的！万一发现宝藏呢",
      "option_a_en": "Try the new one! Could be a hidden gem",
      "option_b_cn": "去老地方，至少不会踩雷",
      "option_b_en": "Go to the usual — at least it will not disappoint",
      "dimension": "risk",
      "option_a_pole": "dragon",
      "option_b_pole": "turtle"
    },
    {
      "id": 3,
      "question_cn": "决定辞职时，你更在意的是——",
      "question_en": "When deciding to quit your job, you care more about —",
      "option_a_cn": "我的感觉，干得不开心就该走",
      "option_a_en": "My feelings — if it does not feel right, I should go",
      "option_b_cn": "数据，存款够不够、市场好不好",
      "option_b_en": "The data — savings, market conditions, backup plans",
      "dimension": "drive",
      "option_a_pole": "fire",
      "option_b_pole": "water"
    },
    {
      "id": 4,
      "question_cn": "菜单上两道菜都想吃，服务员站在旁边了——",
      "question_en": "Two dishes on the menu look great, the waiter is waiting —",
      "option_a_cn": "「就这个吧」指了最近的那道",
      "option_a_en": "'This one' — you point at the closer dish",
      "option_b_cn": "再看一遍菜单，让服务员先去忙",
      "option_b_en": "Read the menu again, ask the waiter to come back later",
      "dimension": "tempo",
      "option_a_pole": "wind",
      "option_b_pole": "mountain"
    },
    {
      "id": 5,
      "question_cn": "买东西犹豫时，你更倾向于——",
      "question_en": "When hesitating over a purchase, you tend to —",
      "option_a_cn": "喜欢就买，人生苦短",
      "option_a_en": "Buy it if you like it — life is short",
      "option_b_cn": "先加购物车，比完价再说",
      "option_b_en": "Add to cart first, compare prices later",
      "dimension": "risk",
      "option_a_pole": "dragon",
      "option_b_pole": "turtle"
    },
    {
      "id": 6,
      "question_cn": "你在选旅行目的地的时候——",
      "question_en": "When choosing a travel destination —",
      "option_a_cn": "看哪张照片最让我心动就去哪",
      "option_a_en": "Whichever photo excites me the most, I go there",
      "option_b_cn": "看评分、攻略、性价比综合考虑",
      "option_b_en": "Check ratings, guides, and value — then decide",
      "dimension": "drive",
      "option_a_pole": "fire",
      "option_b_pole": "water"
    },
    {
      "id": 7,
      "question_cn": "你做了一个大决定。第二天醒来——",
      "question_en": "You made a big decision. The next morning —",
      "option_a_cn": "已经在执行了，想那么多干嘛",
      "option_a_en": "Already executing — why overthink it",
      "option_b_cn": "在被窝里把昨天的决定又想了三遍",
      "option_b_en": "In bed, replaying yesterday's decision three more times",
      "dimension": "after",
      "option_a_pole": "sword",
      "option_b_pole": "mirror"
    },
    {
      "id": 8,
      "question_cn": "朋友说"你上次那个选择其实不太好"——",
      "question_en": "A friend says 'that choice you made was not great' —",
      "option_a_cn": "已经过去了，我不后悔",
      "option_a_en": "It is done — I have no regrets",
      "option_b_cn": "认真想想，也许ta说得对",
      "option_b_en": "I should think about it — maybe they have a point",
      "dimension": "after",
      "option_a_pole": "sword",
      "option_b_pole": "mirror"
    }
  ]
}
```

- [ ] **Step 2: Add ZenTypeData.json to Xcode project bundle**

Same as FortuneData.json — add to target via Xcode.

- [ ] **Step 3: Commit**

```bash
git add ZenChoice/ZenTypeData.json
git commit -m "feat: add 16 zen types and 8 test questions (bilingual)"
```

---

### Task 4: FortuneEngine

**Files:**
- Create: `ZenChoice/FortuneEngine.swift`

- [ ] **Step 1: Create FortuneEngine.swift**

```swift
import Foundation

@MainActor
@Observable
class FortuneEngine {

    private(set) var allFortunes: [Fortune] = []
    private(set) var todayFortune: Fortune?
    private(set) var hasDrawnToday: Bool = false

    private static let historyKey = "fortuneHistory"
    private static let lastDrawDateKey = "lastFortuneDrawDate"

    // MARK: - Load

    func loadFortunes() {
        guard let url = Bundle.main.url(forResource: "FortuneData", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let fortunes = try? JSONDecoder().decode([Fortune].self, from: data) else {
            return
        }
        allFortunes = fortunes
        checkTodayDraw()
    }

    // MARK: - Daily Draw

    func drawFortune() -> Fortune? {
        guard !allFortunes.isEmpty else { return nil }

        // Check if already drawn today
        if hasDrawnToday, let today = todayFortune { return today }

        // Get recent history to avoid repeats
        let history = recentHistory(days: 7)

        // Pick from non-recent fortunes
        let available = allFortunes.filter { f in !history.contains(f.id) }
        let pool = available.isEmpty ? allFortunes : available

        let fortune = pool.randomElement()!
        todayFortune = fortune
        hasDrawnToday = true

        // Save to history
        saveToHistory(fortuneId: fortune.id)
        saveTodayDate()

        return fortune
    }

    // MARK: - Daily Fortune Count (for paywall)

    private static let dailyFortuneCountKey = "dailyFortuneCount"

    var dailyFortuneCount: Int {
        let today = Calendar.current.startOfDay(for: Date())
        let saved = UserDefaults.standard.object(forKey: Self.lastDrawDateKey) as? Date ?? .distantPast
        if Calendar.current.isDate(today, inSameDayAs: saved) {
            return UserDefaults.standard.integer(forKey: Self.dailyFortuneCountKey)
        }
        return 0
    }

    func incrementFortuneCount() {
        let count = dailyFortuneCount + 1
        UserDefaults.standard.set(count, forKey: Self.dailyFortuneCountKey)
    }

    // MARK: - Private

    private func checkTodayDraw() {
        let today = Calendar.current.startOfDay(for: Date())
        let saved = UserDefaults.standard.object(forKey: Self.lastDrawDateKey) as? Date ?? .distantPast
        if Calendar.current.isDate(today, inSameDayAs: saved) {
            hasDrawnToday = true
            // Restore today's fortune from history
            if let lastId = recentHistory(days: 1).first,
               let fortune = allFortunes.first(where: { $0.id == lastId }) {
                todayFortune = fortune
            }
        } else {
            hasDrawnToday = false
            todayFortune = nil
        }
    }

    private func recentHistory(days: Int) -> [String] {
        guard let data = UserDefaults.standard.data(forKey: Self.historyKey),
              let history = try? JSONDecoder().decode([[String: String]].self, from: data) else {
            return []
        }
        let cutoff = Calendar.current.date(byAdding: .day, value: -days, to: Date()) ?? .distantPast
        return history.compactMap { entry in
            guard let dateStr = entry["date"],
                  let id = entry["id"],
                  let date = ISO8601DateFormatter().date(from: dateStr),
                  date > cutoff else { return nil }
            return id
        }
    }

    private func saveToHistory(fortuneId: String) {
        var history: [[String: String]] = []
        if let data = UserDefaults.standard.data(forKey: Self.historyKey),
           let existing = try? JSONDecoder().decode([[String: String]].self, from: data) {
            history = existing
        }
        let entry = ["id": fortuneId, "date": ISO8601DateFormatter().string(from: Date())]
        history.append(entry)
        // Keep last 30 entries
        if history.count > 30 { history = Array(history.suffix(30)) }
        if let data = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(data, forKey: Self.historyKey)
        }
    }

    private func saveTodayDate() {
        let today = Calendar.current.startOfDay(for: Date())
        UserDefaults.standard.set(today, forKey: Self.lastDrawDateKey)
    }
}
```

- [ ] **Step 2: Build to verify**

- [ ] **Step 3: Commit**

```bash
git add ZenChoice/FortuneEngine.swift
git commit -m "feat: add FortuneEngine with daily draw logic and history tracking"
```

---

### Task 5: ZenTypeEngine

**Files:**
- Create: `ZenChoice/ZenTypeEngine.swift`

- [ ] **Step 1: Create ZenTypeEngine.swift**

```swift
import Foundation

@MainActor
@Observable
class ZenTypeEngine {

    private(set) var allTypes: [ZenType] = []
    private(set) var questions: [ZenTestQuestion] = []
    private(set) var userResult: ZenType?
    private(set) var userAnswers: [Int: String] = [:]  // questionId -> chosen pole

    private static let resultKey = "zenTypeResult"
    private static let answersKey = "zenTypeAnswers"

    var hasResult: Bool { userResult != nil }

    // MARK: - Load

    func loadData() {
        guard let url = Bundle.main.url(forResource: "ZenTypeData", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return }

        struct ZenTypeFile: Codable {
            let types: [ZenType]
            let questions: [ZenTestQuestion]
        }

        guard let file = try? JSONDecoder().decode(ZenTypeFile.self, from: data) else { return }
        allTypes = file.types
        questions = file.questions

        // Restore saved result
        if let savedId = UserDefaults.standard.string(forKey: Self.resultKey),
           let saved = allTypes.first(where: { $0.id == savedId }) {
            userResult = saved
        }
        if let answersData = UserDefaults.standard.data(forKey: Self.answersKey),
           let saved = try? JSONDecoder().decode([Int: String].self, from: answersData) {
            userAnswers = saved
        }
    }

    // MARK: - Answer & Score

    func recordAnswer(questionId: Int, pole: String) {
        userAnswers[questionId] = pole
    }

    func calculateResult() -> ZenType? {
        // Count poles for each dimension
        var scores: [String: [String: Int]] = [
            "tempo": ["wind": 0, "mountain": 0],
            "drive": ["fire": 0, "water": 0],
            "risk":  ["dragon": 0, "turtle": 0],
            "after": ["sword": 0, "mirror": 0]
        ]

        for q in questions {
            guard let chosen = userAnswers[q.id] else { continue }
            scores[q.dimension]?[chosen, default: 0] += 1
        }

        // Determine winning pole per dimension
        let tempo = (scores["tempo"]?["wind"] ?? 0) >= (scores["tempo"]?["mountain"] ?? 0) ? "wind" : "mountain"
        let drive = (scores["drive"]?["fire"] ?? 0) >= (scores["drive"]?["water"] ?? 0) ? "fire" : "water"
        let risk  = (scores["risk"]?["dragon"] ?? 0) >= (scores["risk"]?["turtle"] ?? 0) ? "dragon" : "turtle"
        let after = (scores["after"]?["sword"] ?? 0) >= (scores["after"]?["mirror"] ?? 0) ? "sword" : "mirror"

        // Find matching type
        let result = allTypes.first { t in
            t.dimensions.tempo == tempo &&
            t.dimensions.drive == drive &&
            t.dimensions.risk == risk &&
            t.dimensions.after == after
        }

        if let result {
            userResult = result
            UserDefaults.standard.set(result.id, forKey: Self.resultKey)
            if let data = try? JSONEncoder().encode(userAnswers) {
                UserDefaults.standard.set(data, forKey: Self.answersKey)
            }
        }

        return result
    }

    // MARK: - Retake

    func resetTest() {
        userResult = nil
        userAnswers = [:]
        UserDefaults.standard.removeObject(forKey: Self.resultKey)
        UserDefaults.standard.removeObject(forKey: Self.answersKey)
    }
}
```

- [ ] **Step 2: Build to verify**

- [ ] **Step 3: Commit**

```bash
git add ZenChoice/ZenTypeEngine.swift
git commit -m "feat: add ZenTypeEngine with scoring and persistence"
```

---

## Chunk 2: Fortune UI — View, Animation, Card

### Task 6: FortuneCardView (shareable card)

**Files:**
- Create: `ZenChoice/FortuneCardView.swift`

- [ ] **Step 1: Create FortuneCardView.swift**

```swift
import SwiftUI

struct FortuneCardView: View {
    let fortune: Fortune
    let isChinese: Bool

    private var cn: Bool { isChinese }

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                // Warm paper background
                LinearGradient(
                    colors: [Color(hex: 0xFAF6F0), Color(hex: 0xF0E8D8)],
                    startPoint: .top,
                    endPoint: .bottom
                )

                // Ink wash mist
                RadialGradient(
                    colors: [ZenTheme.inkBlack.opacity(0.04), .clear],
                    center: UnitPoint(x: 0.2, y: 0.1),
                    startRadius: 10,
                    endRadius: 200
                )

                // Mountain silhouette at bottom
                VStack {
                    Spacer()
                    MountainShape(peaks: [0.25, 0.4, 0.3, 0.5, 0.2])
                        .fill(ZenTheme.inkBlack.opacity(0.05))
                        .frame(height: 80)
                }

                VStack(spacing: 0) {
                    Spacer().frame(height: 28)

                    // Seal stamp
                    SealStamp(text: cn ? "签" : "✦", size: 36)

                    Spacer().frame(height: 16)

                    // Title
                    Text(cn ? "今 日 签" : "DAILY FORTUNE")
                        .font(.system(size: cn ? 20 : 14, weight: .bold, design: .serif))
                        .foregroundStyle(ZenTheme.inkBlack)
                        .tracking(cn ? 8 : 4)

                    Spacer().frame(height: 4)

                    Text(formattedDate)
                        .font(.system(size: 10, weight: .light, design: .serif))
                        .foregroundStyle(ZenTheme.distantMountain.opacity(0.4))

                    Spacer().frame(height: 20)

                    // Fortune content
                    VStack(alignment: .leading, spacing: 14) {
                        fortuneRow(
                            label: cn ? "宜" : "DO",
                            text: cn ? fortune.should : fortune.shouldEN,
                            color: ZenTheme.jade
                        )

                        fortuneRow(
                            label: cn ? "忌" : "SKIP",
                            text: cn ? fortune.shouldNot : fortune.shouldNotEN,
                            color: ZenTheme.cinnabar
                        )

                        // Divider
                        HStack(spacing: 6) {
                            Rectangle().fill(ZenTheme.gooseYellow.opacity(0.3)).frame(width: 20, height: 1)
                            Circle().fill(ZenTheme.gooseYellow.opacity(0.4)).frame(width: 3, height: 3)
                            Rectangle().fill(ZenTheme.gooseYellow.opacity(0.3)).frame(width: 20, height: 1)
                        }
                        .frame(maxWidth: .infinity)

                        fortuneRow(
                            label: cn ? "幸运决策" : "LUCKY PICK",
                            text: cn ? fortune.luckyDecision : fortune.luckyDecisionEN,
                            color: ZenTheme.gooseYellow
                        )
                    }
                    .padding(.horizontal, 24)

                    Spacer().frame(height: 20)

                    // Zen quote
                    Text("「\(cn ? fortune.zenQuote : fortune.zenQuoteEN)」")
                        .font(.system(size: 13, weight: .medium, design: .serif))
                        .foregroundStyle(ZenTheme.inkBlack.opacity(0.6))
                        .multilineTextAlignment(.center)
                        .lineSpacing(3)
                        .padding(.horizontal, 28)

                    Spacer()

                    // Footer
                    HStack {
                        HStack(spacing: 6) {
                            SealStamp(text: "禅", size: 18)
                            VStack(alignment: .leading, spacing: 1) {
                                Text(cn ? "禅意" : "ZenChoice")
                                    .font(.system(size: 9, weight: .bold, design: .rounded))
                                    .foregroundStyle(ZenTheme.inkBlack.opacity(0.35))
                                Text(cn ? "每天一签，做个果断的人" : "One fortune a day, be decisive")
                                    .font(.system(size: 8, weight: .light))
                                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.3))
                            }
                        }
                        Spacer()
                        Text(cn ? "✦ 你也来抽" : "✦ Try yours")
                            .font(.system(size: 9, weight: .semibold, design: .rounded))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Capsule().fill(ZenTheme.inkBlack.opacity(0.7)))
                    }
                    .padding(.horizontal, 18)

                    Spacer().frame(height: 16)
                }
            }
        }
        .frame(width: 340, height: 520)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(ZenTheme.gooseYellow.opacity(0.15), lineWidth: 1)
        )
        .shadow(color: ZenTheme.inkBlack.opacity(0.15), radius: 20, y: 10)
    }

    private func fortuneRow(label: String, text: String, color: Color) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Text(label)
                .font(.system(size: 11, weight: .bold, design: .serif))
                .foregroundStyle(color)
                .frame(width: cn ? 28 : 60, alignment: .leading)

            Text(text)
                .font(.system(size: 13, weight: .regular, design: .serif))
                .foregroundStyle(ZenTheme.inkBlack.opacity(0.75))
                .lineSpacing(3)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private var formattedDate: String {
        let f = DateFormatter()
        f.dateFormat = "yyyy.M.d · EEEE"
        f.locale = Locale(identifier: isChinese ? "zh_CN" : "en_US")
        return f.string(from: Date())
    }
}
```

- [ ] **Step 2: Build to verify**

- [ ] **Step 3: Commit**

```bash
git add ZenChoice/FortuneCardView.swift
git commit -m "feat: add FortuneCardView for shareable fortune cards"
```

---

### Task 7: DailyFortuneView (fortune tab)

**Files:**
- Create: `ZenChoice/DailyFortuneView.swift`

- [ ] **Step 1: Create DailyFortuneView.swift**

This is the main fortune tab view with a drawing animation and result display.

```swift
import SwiftUI

struct DailyFortuneView: View {
    @Environment(ZenViewModel.self) private var viewModel
    let fortuneEngine: FortuneEngine

    private var cn: Bool { viewModel.L.isChinese }

    @State private var phase: FortunePhase = .idle
    @State private var inkSpread = false
    @State private var signReveal = false
    @State private var stampHit = false

    enum FortunePhase {
        case idle       // Show draw button
        case drawing    // Animation playing
        case revealed   // Fortune card shown
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                Spacer().frame(height: 8)

                switch phase {
                case .idle:
                    idleView
                case .drawing:
                    drawingAnimation
                case .revealed:
                    if let fortune = fortuneEngine.todayFortune {
                        revealedView(fortune)
                    }
                }

                Spacer().frame(height: 80)
            }
            .padding(.horizontal, 20)
        }
        .onAppear {
            if fortuneEngine.hasDrawnToday, fortuneEngine.todayFortune != nil {
                phase = .revealed
            }
        }
    }

    // MARK: - Idle

    private var idleView: some View {
        VStack(spacing: 32) {
            Spacer().frame(height: 40)

            // Mystic icon
            ZStack {
                Circle()
                    .fill(ZenTheme.gooseYellow.opacity(0.08))
                    .frame(width: 120, height: 120)

                Circle()
                    .stroke(ZenTheme.gooseYellow.opacity(0.2), lineWidth: 1)
                    .frame(width: 100, height: 100)

                Image(systemName: "sparkles")
                    .font(.system(size: 36))
                    .foregroundStyle(ZenTheme.gooseYellow)
            }

            VStack(spacing: 8) {
                Text(cn ? "今日签" : "Daily Fortune")
                    .font(ZenTheme.calligraphy(24))
                    .foregroundStyle(ZenTheme.inkBlack)

                Text(cn ? "每天一签，做个果断的人" : "One fortune a day, be decisive")
                    .font(ZenTheme.caption(13))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.5))
            }

            Button {
                startDraw()
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "hand.tap")
                    Text(cn ? "抽 签" : "Draw")
                }
                .font(ZenTheme.calligraphy(18))
                .foregroundStyle(ZenTheme.gooseYellow)
                .padding(.horizontal, 48)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(ZenTheme.inkBlack)
                        .shadow(color: ZenTheme.inkBlack.opacity(0.3), radius: 12, y: 6)
                )
            }

            // Usage hint
            let count = fortuneEngine.dailyFortuneCount
            let limit = viewModel.isSubscribed ? 999 : 1
            if count >= limit {
                Text(cn ? "今日签已抽，明天再来" : "Today's fortune drawn, come back tomorrow")
                    .font(ZenTheme.caption(11))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.4))
            }
        }
    }

    // MARK: - Drawing Animation

    private var drawingAnimation: some View {
        ZStack {
            // Ink spread circles
            ForEach(0..<3, id: \.self) { i in
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [ZenTheme.inkBlack.opacity(0.3), .clear],
                            center: .center,
                            startRadius: 0,
                            endRadius: inkSpread ? 140 : 20
                        )
                    )
                    .frame(width: 280, height: 280)
                    .scaleEffect(inkSpread ? 1.0 : 0.3)
                    .opacity(inkSpread ? 0.6 : 0)
                    .offset(
                        x: CGFloat([-10, 15, -5][i]),
                        y: CGFloat([10, -8, 20][i])
                    )
                    .blur(radius: 20)
            }

            VStack(spacing: 12) {
                // Golden sparkle rising
                Image(systemName: "sparkle")
                    .font(.system(size: 28))
                    .foregroundStyle(ZenTheme.gooseYellow)
                    .scaleEffect(signReveal ? 1.2 : 0.5)
                    .opacity(signReveal ? 1 : 0.3)

                Text(cn ? "签筒开启…" : "Drawing fortune…")
                    .font(ZenTheme.caption(14))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.6))
                    .opacity(signReveal ? 1 : 0)
            }
        }
        .frame(height: 300)
        .onAppear {
            withAnimation(.easeOut(duration: 1.5)) { inkSpread = true }
            withAnimation(.easeInOut(duration: 1.0).delay(0.5)) { signReveal = true }
        }
    }

    // MARK: - Revealed

    private func revealedView(_ fortune: Fortune) -> some View {
        VStack(spacing: 20) {
            // The card itself
            FortuneCardView(fortune: fortune, isChinese: cn)
                .scaleEffect(stampHit ? 1.0 : 0.9)
                .opacity(stampHit ? 1.0 : 0)
                .onAppear {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                        stampHit = true
                    }
                    HapticManager.heavyImpact()
                }

            // Action buttons
            HStack(spacing: 16) {
                // Share
                Button {
                    viewModel.generateFortuneCard(fortune: fortune)
                } label: {
                    Label(cn ? "分享" : "Share", systemImage: "square.and.arrow.up")
                        .font(ZenTheme.bodyFont(14))
                        .foregroundStyle(ZenTheme.gooseYellow)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(
                            Capsule()
                                .fill(ZenTheme.inkBlack)
                        )
                }

                // Jump to decision
                Button {
                    viewModel.selectedTab = .encourage
                } label: {
                    Label(cn ? "今天做决定" : "Decide today", systemImage: "sparkles")
                        .font(ZenTheme.bodyFont(14))
                        .foregroundStyle(ZenTheme.inkBlack)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(
                            Capsule()
                                .stroke(ZenTheme.inkBlack.opacity(0.2), lineWidth: 1)
                        )
                }
            }
        }
    }

    // MARK: - Actions

    private func startDraw() {
        let count = fortuneEngine.dailyFortuneCount
        let limit = viewModel.isSubscribed ? 999 : 1
        guard count < limit else {
            viewModel.showPaywall = true
            return
        }

        phase = .drawing
        HapticManager.impact()

        // Reset animation states
        inkSpread = false
        signReveal = false
        stampHit = false

        Task {
            try? await Task.sleep(for: .seconds(2.5))
            _ = fortuneEngine.drawFortune()
            fortuneEngine.incrementFortuneCount()
            withAnimation(.easeInOut(duration: 0.5)) {
                phase = .revealed
            }
        }
    }
}
```

- [ ] **Step 2: Build to verify**

- [ ] **Step 3: Commit**

```bash
git add ZenChoice/DailyFortuneView.swift
git commit -m "feat: add DailyFortuneView with draw animation and card display"
```

---

## Chunk 3: ZenType UI — Test, Result, Card

### Task 8: ZenTypeCardView (shareable card)

**Files:**
- Create: `ZenChoice/ZenTypeCardView.swift`

- [ ] **Step 1: Create ZenTypeCardView.swift**

```swift
import SwiftUI

struct ZenTypeCardView: View {
    let zenType: ZenType
    let isChinese: Bool

    private var cn: Bool { isChinese }

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                // Dark starry background
                LinearGradient(
                    colors: [Color(hex: 0x1A1A2E), Color(hex: 0x0F0F23)],
                    startPoint: .top,
                    endPoint: .bottom
                )

                // Golden nebula glow
                RadialGradient(
                    colors: [ZenTheme.gooseYellow.opacity(0.12), .clear],
                    center: UnitPoint(x: 0.5, y: 0.3),
                    startRadius: 10,
                    endRadius: 200
                )

                // Cinnabar accent glow
                RadialGradient(
                    colors: [ZenTheme.cinnabar.opacity(0.06), .clear],
                    center: UnitPoint(x: 0.8, y: 0.7),
                    startRadius: 10,
                    endRadius: 150
                )

                // Mountain
                VStack {
                    Spacer()
                    MountainShape(peaks: [0.2, 0.35, 0.25, 0.4, 0.15])
                        .fill(.white.opacity(0.03))
                        .frame(height: 80)
                }

                VStack(spacing: 0) {
                    Spacer().frame(height: 28)

                    // Header
                    Text(cn ? "✦ 决策星盘 ✦" : "✦ ZENTYPE ✦")
                        .font(.system(size: 10, weight: .semibold, design: .serif))
                        .foregroundStyle(ZenTheme.gooseYellow.opacity(0.6))
                        .tracking(4)

                    Spacer().frame(height: 8)

                    Text(cn ? "你的命格是" : "Your type is")
                        .font(.system(size: 12, weight: .light, design: .serif))
                        .foregroundStyle(.white.opacity(0.4))

                    Spacer().frame(height: 16)

                    // Code name — large
                    Text(cn ? zenType.codeCN : zenType.codeEN)
                        .font(.system(size: cn ? 32 : 24, weight: .heavy, design: .serif))
                        .foregroundStyle(.white)
                        .tracking(cn ? 6 : 2)

                    Spacer().frame(height: 8)

                    // Star name
                    HStack(spacing: 6) {
                        Rectangle().fill(ZenTheme.gooseYellow.opacity(0.4)).frame(width: 20, height: 1)
                        Text(cn ? zenType.starCN : zenType.starEN)
                            .font(.system(size: 13, weight: .semibold, design: .serif))
                            .foregroundStyle(ZenTheme.gooseYellow)
                        Rectangle().fill(ZenTheme.gooseYellow.opacity(0.4)).frame(width: 20, height: 1)
                    }

                    Spacer().frame(height: 16)

                    // Tagline
                    Text(cn ? zenType.taglineCN : zenType.taglineEN)
                        .font(.system(size: 14, weight: .medium, design: .serif))
                        .foregroundStyle(.white.opacity(0.75))
                        .multilineTextAlignment(.center)
                        .lineSpacing(3)
                        .padding(.horizontal, 28)

                    Spacer().frame(height: 20)

                    // Dimension labels
                    let labels = cn ? zenType.labelsCN : zenType.labelsEN
                    Text(labels.joined(separator: " · "))
                        .font(.system(size: 12, weight: .regular, design: .serif))
                        .foregroundStyle(ZenTheme.gooseYellow.opacity(0.6))
                        .tracking(2)

                    Spacer()

                    // Footer
                    HStack {
                        HStack(spacing: 6) {
                            SealStamp(text: "禅", size: 18)
                            VStack(alignment: .leading, spacing: 1) {
                                Text(cn ? "禅意" : "ZenChoice")
                                    .font(.system(size: 9, weight: .bold, design: .rounded))
                                    .foregroundStyle(.white.opacity(0.35))
                                Text(cn ? "决策星盘" : "ZenType")
                                    .font(.system(size: 8, weight: .light))
                                    .foregroundStyle(.white.opacity(0.2))
                            }
                        }
                        Spacer()
                        Text(cn ? "✦ 测测你是哪颗星" : "✦ Find your star")
                            .font(.system(size: 9, weight: .semibold, design: .rounded))
                            .foregroundStyle(ZenTheme.inkBlack)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Capsule().fill(ZenTheme.gooseYellow.opacity(0.85)))
                    }
                    .padding(.horizontal, 18)

                    Spacer().frame(height: 18)
                }
            }
        }
        .frame(width: 340, height: 480)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: ZenTheme.gooseYellow.opacity(0.15), radius: 20, y: 10)
    }
}
```

- [ ] **Step 2: Commit**

```bash
git add ZenChoice/ZenTypeCardView.swift
git commit -m "feat: add ZenTypeCardView for shareable type result cards"
```

---

### Task 9: ZenTypeTestView (quiz UI)

**Files:**
- Create: `ZenChoice/ZenTypeTestView.swift`

- [ ] **Step 1: Create ZenTypeTestView.swift**

```swift
import SwiftUI

struct ZenTypeTestView: View {
    @Environment(ZenViewModel.self) private var viewModel
    let engine: ZenTypeEngine
    let onComplete: (ZenType) -> Void

    private var cn: Bool { viewModel.L.isChinese }

    @State private var currentIndex = 0
    @State private var slideDirection: Edge = .trailing

    var body: some View {
        let questions = engine.questions
        guard !questions.isEmpty else { return AnyView(EmptyView()) }

        let question = questions[currentIndex]
        let progress = Double(currentIndex) / Double(questions.count)

        return AnyView(
            VStack(spacing: 0) {
                // Progress bar
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(ZenTheme.inkBlack.opacity(0.06))
                            .frame(height: 3)
                        Rectangle()
                            .fill(ZenTheme.gooseYellow)
                            .frame(width: geo.size.width * progress, height: 3)
                            .animation(.easeInOut(duration: 0.3), value: progress)
                    }
                }
                .frame(height: 3)

                Spacer().frame(height: 40)

                // Question number
                Text("\(currentIndex + 1) / \(questions.count)")
                    .font(ZenTheme.caption(12))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.4))

                Spacer().frame(height: 20)

                // Question text
                Text(cn ? question.questionCN : question.questionEN)
                    .font(ZenTheme.calligraphy(20))
                    .foregroundStyle(ZenTheme.inkBlack)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, 24)
                    .id(question.id)
                    .transition(.asymmetric(
                        insertion: .move(edge: slideDirection).combined(with: .opacity),
                        removal: .move(edge: slideDirection == .trailing ? .leading : .trailing).combined(with: .opacity)
                    ))

                Spacer().frame(height: 40)

                // Options
                VStack(spacing: 12) {
                    optionButton(
                        text: cn ? question.optionACN : question.optionAEN,
                        pole: question.optionAPole,
                        questionId: question.id
                    )
                    optionButton(
                        text: cn ? question.optionBCN : question.optionBEN,
                        pole: question.optionBPole,
                        questionId: question.id
                    )
                }
                .padding(.horizontal, 24)

                Spacer()
            }
        )
    }

    private func optionButton(text: String, pole: String, questionId: Int) -> some View {
        Button {
            HapticManager.selection()
            engine.recordAnswer(questionId: questionId, pole: pole)

            if currentIndex < engine.questions.count - 1 {
                slideDirection = .trailing
                withAnimation(.easeInOut(duration: 0.3)) {
                    currentIndex += 1
                }
            } else {
                // Final question — calculate
                if let result = engine.calculateResult() {
                    HapticManager.success()
                    onComplete(result)
                }
            }
        } label: {
            Text(text)
                .font(ZenTheme.bodyFont(15))
                .foregroundStyle(ZenTheme.inkBlack)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(.white)
                        .shadow(color: ZenTheme.inkBlack.opacity(0.04), radius: 8, y: 3)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(ZenTheme.gooseYellow.opacity(0.15), lineWidth: 1)
                )
        }
    }
}
```

- [ ] **Step 2: Commit**

```bash
git add ZenChoice/ZenTypeTestView.swift
git commit -m "feat: add ZenTypeTestView with animated question transitions"
```

---

### Task 10: ZenTypeView (main type tab)

**Files:**
- Create: `ZenChoice/ZenTypeView.swift`

- [ ] **Step 1: Create ZenTypeView.swift**

```swift
import SwiftUI

struct ZenTypeView: View {
    @Environment(ZenViewModel.self) private var viewModel
    let engine: ZenTypeEngine

    private var cn: Bool { viewModel.L.isChinese }

    @State private var showTest = false
    @State private var resultAppear = false

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                Spacer().frame(height: 8)

                if let result = engine.userResult, !showTest {
                    resultView(result)
                } else if showTest {
                    ZenTypeTestView(engine: engine) { result in
                        showTest = false
                        resultAppear = false
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.2)) {
                            resultAppear = true
                        }
                    }
                } else {
                    entryView
                }

                Spacer().frame(height: 80)
            }
            .padding(.horizontal, 20)
        }
    }

    // MARK: - Entry (no result yet)

    private var entryView: some View {
        VStack(spacing: 32) {
            Spacer().frame(height: 40)

            // Mystical icon
            ZStack {
                Circle()
                    .fill(ZenTheme.gooseYellow.opacity(0.08))
                    .frame(width: 120, height: 120)

                Circle()
                    .stroke(ZenTheme.cinnabar.opacity(0.2), lineWidth: 1)
                    .frame(width: 100, height: 100)

                Image(systemName: "star.circle")
                    .font(.system(size: 36))
                    .foregroundStyle(ZenTheme.gooseYellow)
            }

            VStack(spacing: 8) {
                Text(cn ? "决策星盘" : "ZenType")
                    .font(ZenTheme.calligraphy(24))
                    .foregroundStyle(ZenTheme.inkBlack)

                Text(cn ? "测测你是哪颗纠结星" : "Discover your decision-making star")
                    .font(ZenTheme.caption(13))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.5))
            }

            Button {
                withAnimation { showTest = true }
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "sparkle")
                    Text(cn ? "开始测试" : "Start Test")
                }
                .font(ZenTheme.calligraphy(18))
                .foregroundStyle(ZenTheme.gooseYellow)
                .padding(.horizontal, 44)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(ZenTheme.inkBlack)
                        .shadow(color: ZenTheme.inkBlack.opacity(0.3), radius: 12, y: 6)
                )
            }

            Text(cn ? "8道题，1分钟" : "8 questions, 1 minute")
                .font(ZenTheme.caption(11))
                .foregroundStyle(ZenTheme.distantMountain.opacity(0.4))
        }
    }

    // MARK: - Result

    private func resultView(_ result: ZenType) -> some View {
        VStack(spacing: 20) {
            ZenTypeCardView(zenType: result, isChinese: cn)
                .scaleEffect(resultAppear ? 1.0 : 0.9)
                .opacity(resultAppear ? 1.0 : 0)
                .onAppear {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                        resultAppear = true
                    }
                }

            // Paid detail teaser
            if !viewModel.isSubscribed {
                Button {
                    viewModel.showPaywall = true
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "lock.fill")
                            .font(.caption)
                        Text(cn ? "解锁详细命格解读" : "Unlock detailed reading")
                            .font(ZenTheme.bodyFont(13))
                    }
                    .foregroundStyle(ZenTheme.gooseYellow)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(
                        Capsule()
                            .fill(ZenTheme.gooseYellow.opacity(0.1))
                            .overlay(Capsule().stroke(ZenTheme.gooseYellow.opacity(0.3), lineWidth: 1))
                    )
                }
            } else {
                // Show detail for subscribers
                VStack(alignment: .leading, spacing: 12) {
                    Text(cn ? "命格详解" : "Detailed Reading")
                        .font(ZenTheme.calligraphy(16))
                        .foregroundStyle(ZenTheme.inkBlack)

                    Text(cn ? result.detailCN : result.detailEN)
                        .font(ZenTheme.bodyFont(14))
                        .foregroundStyle(ZenTheme.distantMountain.opacity(0.8))
                        .lineSpacing(6)
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(.white)
                        .shadow(color: ZenTheme.inkBlack.opacity(0.04), radius: 8, y: 3)
                )
            }

            // Action buttons
            HStack(spacing: 16) {
                Button {
                    viewModel.generateZenTypeCard(zenType: result)
                } label: {
                    Label(cn ? "分享" : "Share", systemImage: "square.and.arrow.up")
                        .font(ZenTheme.bodyFont(14))
                        .foregroundStyle(ZenTheme.gooseYellow)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(Capsule().fill(ZenTheme.inkBlack))
                }

                Button {
                    engine.resetTest()
                    showTest = false
                    resultAppear = false
                } label: {
                    Label(cn ? "重测" : "Retake", systemImage: "arrow.counterclockwise")
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
    }
}
```

- [ ] **Step 2: Commit**

```bash
git add ZenChoice/ZenTypeView.swift
git commit -m "feat: add ZenTypeView with test entry, quiz, and result display"
```

---

## Chunk 4: Integration — ViewModel, MainContentView, PosterService, Paywall

### Task 11: Update ZenViewModel

**Files:**
- Modify: `ZenChoice/ZenViewModel.swift`

- [ ] **Step 1: Add fortune/type engines and tab state**

Add these properties after `let socialManager = SocialManager()` (around line 143):

```swift
// MARK: - Tab Navigation

var selectedTab: AppTab = .fortune

// MARK: - Fortune & ZenType Engines

let fortuneEngine = FortuneEngine()
let zenTypeEngine = ZenTypeEngine()
```

- [ ] **Step 2: Add fortune/type card generation methods**

Add after the existing `generateShareCard` method (around line 470):

```swift
// MARK: - Fortune Card

func generateFortuneCard(fortune: Fortune) {
    #if os(iOS)
    shareCardImage = PosterService.renderFortuneCard(
        fortune: fortune,
        isChinese: L.isChinese
    )
    showShareSheet = shareCardImage != nil
    if shareCardImage != nil { HapticManager.success() }
    #endif
}

// MARK: - ZenType Card

func generateZenTypeCard(zenType: ZenType) {
    #if os(iOS)
    shareCardImage = PosterService.renderZenTypeCard(
        zenType: zenType,
        isChinese: L.isChinese
    )
    showShareSheet = shareCardImage != nil
    if shareCardImage != nil { HapticManager.success() }
    #endif
}
```

- [ ] **Step 3: Load engines in initialize()**

In `initialize()`, add after `loadSocialUsage()` (around line 269):

```swift
fortuneEngine.loadFortunes()
zenTypeEngine.loadData()
```

- [ ] **Step 4: Build to verify**

- [ ] **Step 5: Commit**

```bash
git add ZenChoice/ZenViewModel.swift
git commit -m "feat: add tab navigation, fortune/type engines to ZenViewModel"
```

---

### Task 12: Update PosterService

**Files:**
- Modify: `ZenChoice/PosterService.swift`

- [ ] **Step 1: Add fortune and type card rendering**

Add before the closing `}` of the enum (before `#endif`):

```swift
@MainActor
static func renderFortuneCard(fortune: Fortune, isChinese: Bool) -> UIImage? {
    let view = FortuneCardView(fortune: fortune, isChinese: isChinese)
    let renderer = ImageRenderer(content: view)
    renderer.scale = 3.0
    return renderer.uiImage
}

@MainActor
static func renderZenTypeCard(zenType: ZenType, isChinese: Bool) -> UIImage? {
    let view = ZenTypeCardView(zenType: zenType, isChinese: isChinese)
    let renderer = ImageRenderer(content: view)
    renderer.scale = 3.0
    return renderer.uiImage
}
```

- [ ] **Step 2: Build to verify**

- [ ] **Step 3: Commit**

```bash
git add ZenChoice/PosterService.swift
git commit -m "feat: add fortune and zentype card rendering to PosterService"
```

---

### Task 13: Restructure MainContentView

**Files:**
- Modify: `ZenChoice/MainContentView.swift`

- [ ] **Step 1: Replace the body with segmented control layout**

Replace the entire `body` computed property (lines 8-107) with:

```swift
var body: some View {
    @Bindable var vm = viewModel

    ZStack {
        ZenBackground()

        VStack(spacing: 0) {
            headerBar

            // Segmented control
            tabSelector

            // Tab content
            switch viewModel.selectedTab {
            case .fortune:
                DailyFortuneView(fortuneEngine: viewModel.fortuneEngine)
                    .environment(viewModel)
            case .encourage:
                encourageContent
            case .zenType:
                ZenTypeView(engine: viewModel.zenTypeEngine)
                    .environment(viewModel)
            }
        }
    }
    .task { await viewModel.initialize() }
    .sheet(isPresented: $vm.showSettings) {
        SettingsView().environment(viewModel)
    }
    .sheet(isPresented: $vm.showPaywall, onDismiss: {
        viewModel.syncSubscriptionStatus()
    }) {
        PaywallView().environment(viewModel)
    }
    .sheet(isPresented: $vm.showArchive) {
        CourageArchiveView().environment(viewModel)
    }
    .sheet(isPresented: $vm.showInbox) {
        InboxView().environment(viewModel)
    }
    .sheet(isPresented: $vm.showEncourageRequest) {
        if let result = vm.currentResult {
            EncourageRequestView(
                wish: result.wish,
                socialManager: viewModel.socialManager,
                isChinese: cn,
                isSubscribed: viewModel.isSubscribed
            )
        }
    }
    .sheet(isPresented: $vm.showWitnessRequest) {
        if let result = vm.currentResult {
            WitnessRequestView(
                wish: result.wish,
                aiSummary: viewModel.generateAISummary(),
                socialManager: viewModel.socialManager,
                isChinese: cn,
                maxSignatures: viewModel.isSubscribed ? 3 : 1
            )
        }
    }
    .sheet(isPresented: $vm.showRespondSheet) {
        if let request = vm.deepLinkRequest {
            RespondView(
                request: request,
                socialManager: viewModel.socialManager,
                isChinese: cn
            )
        }
    }
    #if os(iOS)
    .sheet(isPresented: $vm.showShareSheet) {
        if let img = vm.shareCardImage {
            ShareSheetView(image: img)
        }
    }
    #endif
    .alert(cn ? "提示" : "Notice", isPresented: $vm.showError) {
        Button(cn ? "知道了" : "OK") {}
    } message: {
        Text(vm.errorMessage ?? "")
    }
}
```

- [ ] **Step 2: Add tabSelector view**

Add after `headerBar` (around line 163):

```swift
// MARK: - Tab Selector

private var tabSelector: some View {
    HStack(spacing: 0) {
        tabButton(.fortune, icon: "sparkle", label: cn ? "今日签" : "Fortune")
        tabButton(.encourage, icon: "sparkles", label: cn ? "决策鼓励" : "Courage")
        tabButton(.zenType, icon: "star.circle", label: cn ? "我的命格" : "ZenType")
    }
    .padding(3)
    .background(
        RoundedRectangle(cornerRadius: 12)
            .fill(ZenTheme.inkBlack.opacity(0.04))
    )
    .padding(.horizontal, 20)
    .padding(.vertical, 8)
}

private func tabButton(_ tab: AppTab, icon: String, label: String) -> some View {
    Button {
        withAnimation(.easeInOut(duration: 0.25)) {
            viewModel.selectedTab = tab
        }
        HapticManager.selection()
    } label: {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 11))
            Text(label)
                .font(ZenTheme.bodyFont(12))
        }
        .foregroundStyle(viewModel.selectedTab == tab ? ZenTheme.gooseYellow : ZenTheme.distantMountain.opacity(0.5))
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(
            Group {
                if viewModel.selectedTab == tab {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(ZenTheme.inkBlack)
                }
            }
        )
    }
}
```

- [ ] **Step 3: Extract existing encourage content**

Wrap the existing ScrollView content (input + animation + result) into a private computed property:

```swift
// MARK: - Encourage Content (existing functionality)

private var encourageContent: some View {
    @Bindable var vm = viewModel

    return ScrollViewReader { proxy in
        ScrollView(showsIndicators: false) {
            VStack(spacing: 32) {
                inputArea(wish: $vm.wish)

                if vm.showInkAnimation {
                    InkAnimationView(isChinese: cn)
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
```

- [ ] **Step 4: Build to verify**

Run: `cd /Users/pinan/Desktop/ZenChoice/ZenChoice && xcodebuild -scheme ZenChoice -destination 'platform=iOS Simulator,name=iPhone 16 Pro' build 2>&1 | tail -5`

- [ ] **Step 5: Commit**

```bash
git add ZenChoice/MainContentView.swift
git commit -m "feat: restructure MainContentView with three-tab segmented control"
```

---

### Task 14: Update PaywallView

**Files:**
- Modify: `ZenChoice/PaywallView.swift`

- [ ] **Step 1: Update feature list for v2**

Replace the feature list `VStack(alignment: .leading, spacing: 14)` section (around lines 57-82) with:

```swift
VStack(alignment: .leading, spacing: 14) {
    featureRow(icon: "sparkle",
               title: cn ? "无限每日签" : "Unlimited Daily Fortunes",
               desc: cn ? "每天多次抽签（免费版1次/天）" : "Draw multiple fortunes per day (free: 1/day)")
    featureRow(icon: "star.circle",
               title: cn ? "详细命格解读" : "Detailed ZenType Reading",
               desc: cn ? "解锁300-500字的命格深度分析" : "Unlock 300-500 word personality analysis")
    featureRow(icon: "flame",
               title: cn ? "更多鼓励次数" : "More Encouragement Uses",
               desc: cn ? "月度20次/天，年度30次/天（免费版15次/天）" : "Monthly: 20/day, Yearly: 30/day (free: 15/day)")
    featureRow(icon: "brain.head.profile",
               title: cn ? "3个AI专属视角" : "3 Custom AI Perspectives",
               desc: cn ? "自定义视角+语气，AI为你量身生成" : "Custom perspectives + tone, AI generates unique content")
    featureRow(icon: "sparkles",
               title: cn ? "每次6个维度" : "6 Dimensions Per Session",
               desc: cn ? "3个AI视角 + 3个随机模版（免费版4个）" : "3 AI + 3 templates (free: 4)")
    featureRow(icon: "hands.sparkles",
               title: cn ? "无限社交请求" : "Unlimited Social Requests",
               desc: cn ? "无限次邀请朋友加持和见证" : "Unlimited blessing and witness requests")
}
```

- [ ] **Step 2: Build to verify**

- [ ] **Step 3: Commit**

```bash
git add ZenChoice/PaywallView.swift
git commit -m "feat: update PaywallView feature list for v2"
```

---

## Chunk 5: Build Verification & Polish

### Task 15: Full Build & Fix

- [ ] **Step 1: Ensure all new files are added to Xcode target**

Check that these files are in the Xcode project:
- `FortuneData.json` (in Copy Bundle Resources)
- `ZenTypeData.json` (in Copy Bundle Resources)
- `FortuneEngine.swift`
- `ZenTypeEngine.swift`
- `DailyFortuneView.swift`
- `FortuneCardView.swift`
- `ZenTypeView.swift`
- `ZenTypeTestView.swift`
- `ZenTypeCardView.swift`

- [ ] **Step 2: Full build**

```bash
cd /Users/pinan/Desktop/ZenChoice/ZenChoice && xcodebuild -scheme ZenChoice -destination 'platform=iOS Simulator,name=iPhone 16 Pro' build 2>&1 | tail -20
```

- [ ] **Step 3: Fix any build errors**

Common issues to check:
- Missing `@Environment(ZenViewModel.self)` in new views
- JSON CodingKeys mismatches
- Missing imports

- [ ] **Step 4: Final commit**

```bash
git add -A
git commit -m "feat: ZenChoice v2 — daily fortune, zen type test, three-tab navigation"
```
