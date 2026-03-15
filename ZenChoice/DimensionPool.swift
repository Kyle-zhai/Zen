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
