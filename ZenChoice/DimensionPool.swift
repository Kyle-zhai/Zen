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

        // MARK: - 荒诞科学 (续)
        Dimension(
            id: "quantum_physicist",
            category: "荒诞科学",
            emoji: "🔬",
            title: "量子物理学家视角",
            titleEN: "Quantum Physicist",
            templates: [
                "根据量子力学的叠加原理，在你做出决定之前，你同时处于「{wish}」和「没{wish}」的叠加态。但这里有个坏消息：薛定谔的猫已经被关了快一百年了，它非常不开心。不要像那只猫一样被困在盒子里。坍缩你的波函数，选择{wish}这个本征态。观测即存在，行动即现实。",
                "海森堡不确定性原理告诉我们，你越想精确地知道{wish}的结果，你就越无法确定开始的时机。反过来也一样——你越想等到完美时机，你越不知道结果会怎样。物理学已经从数学上证明了「想太多没用」。去{wish}吧，让宇宙替你计算剩下的变量。",
                "在量子退相干理论中，一个系统一旦与环境发生交互，叠加态就会崩溃成确定态。你现在的问题就是你一直把自己隔绝在真空态里，拒绝和现实发生交互。你想{wish}？走出你的量子真空，碰一碰现实。退相干没什么可怕的，确定性才是自由。",
            ],
            templatesEN: [
                "According to quantum superposition, until you decide, you exist in a superposition of '{wish}' and 'didn't {wish}.' Bad news: Schrödinger's cat has been stuck in that box for nearly a century and it's miserable. Don't be the cat. Collapse your wave function — choose the eigenstate of {wish}. Observation is existence. Action is reality.",
                "Heisenberg's uncertainty principle says the more precisely you try to know the outcome of {wish}, the less you can pin down the right moment to start. Physics has mathematically proven that overthinking is useless. Go {wish} and let the universe calculate the remaining variables.",
                "In quantum decoherence, a system's superposition collapses the moment it interacts with the environment. Your problem? You've been isolating yourself in a quantum vacuum, refusing to interact with reality. You want to {wish}? Step out of the vacuum. Touch reality. Certainty is freedom.",
            ]
        ),
        Dimension(
            id: "meteorologist",
            category: "荒诞科学",
            emoji: "🌪️",
            title: "气象学家视角",
            titleEN: "Meteorologist",
            templates: [
                "1972年，气象学家洛伦兹提出了一个著名的问题：一只蝴蝶在巴西扇动翅膀，能不能在德克萨斯引发一场龙卷风？答案是理论上可以。你现在想{wish}，这就是你的蝴蝶翅膀。你不扇一下，怎么知道不会在人生的另一端掀起一场美好的风暴？别小看一次微小的行动，混沌系统里，初始条件决定一切。",
                "我做了三十年天气预报，最大的领悟是：天气永远不会等你准备好了再变。冷锋说来就来，暴雨说下就下。你等着所有条件完美再去{wish}？不好意思，气象学告诉你，完美条件根本不存在。最好的天气就是你出门的那一刻。穿上雨衣就走。",
                "大气压强每时每刻都在变化，但你注意到了吗？没有。因为你的身体在不知不觉中已经适应了。你害怕{wish}以后环境会变、压力会大？你的身体和大脑比你想象的能抗多了。人类本身就是一台自适应气压计。去吧，你会自动调节的。",
            ],
            templatesEN: [
                "In 1972, meteorologist Lorenz asked: can a butterfly flapping its wings in Brazil cause a tornado in Texas? Theoretically, yes. You wanting to {wish} — that's your butterfly wing. How will you know it won't create a beautiful storm on the other side of your life? In chaotic systems, initial conditions determine everything. Flap.",
                "Thirty years of weather forecasting taught me one thing: weather never waits for you to be ready. Cold fronts arrive unannounced. Rain falls when it wants. You're waiting for perfect conditions to {wish}? Sorry, meteorology says perfect conditions don't exist. The best weather is the moment you step outside. Grab your raincoat and go.",
                "Atmospheric pressure changes every second, but do you notice? No. Your body adapts without you even knowing. Afraid that {wish} will bring pressure and change? Your body and brain can handle far more than you think. Humans are walking, self-adjusting barometers. Go — you'll recalibrate automatically.",
            ]
        ),

        // MARK: - 社会角色 (续)
        Dimension(
            id: "bar_owner",
            category: "社会角色",
            emoji: "🍺",
            title: "酒吧老板视角",
            titleEN: "Bar Owner",
            templates: [
                "我开了十五年酒吧，见过太多人在第三杯酒之后说「我明天一定要{wish}」，然后第二天酒醒了又怂了。兄弟，酒精给你的勇气是借来的，利息还特别高——叫宿醉。你现在清醒着就想{wish}，这勇气是你自己的，不用还。趁清醒，赶紧去。别等喝到第三杯才敢承认自己真正想要什么。",
                "我吧台后面挂了一块牌子写着「免费的啤酒——明天供应」。每天都有人问明天能不能来拿，但明天永远不会来。你想{wish}也是一样的道理——你说「等等再去」「下次再说」，那个「下次」就是我牌子上的「明天」。永远不会来的。今天就是免费啤酒日，去{wish}。",
                "酒吧里最安静的时刻不是打烊以后，是一个人独自坐在角落，盯着杯子里的酒，想着自己没做过的事。你知道那种眼神吗？我见过上千次。空的、遗憾的、「要是当初」的。你想{wish}？现在就去。别成为我吧台前又一双遗憾的眼睛。",
            ],
            templatesEN: [
                "Fifteen years behind the bar, I've watched too many people hit their third drink and announce 'Tomorrow I'm definitely going to {wish}.' Next day, sober, they chicken out. Buddy, liquid courage is borrowed — and the interest rate is called a hangover. You want to {wish} while sober? That courage is yours, no payback needed. Go now.",
                "I've got a sign behind my bar: 'Free Beer — Tomorrow.' People ask every day if they can come back for it. But tomorrow never comes. You saying 'I'll {wish} later' is the same sign. That 'later' will never arrive. Today is free beer day. Go {wish}.",
                "The quietest moment in a bar isn't after closing. It's when someone sits alone in the corner, staring into their glass, thinking about what they never did. I've seen those eyes a thousand times — empty, regretful, full of 'what if.' You want to {wish}? Go now. Don't become another pair of regretful eyes at my bar.",
            ]
        ),
        Dimension(
            id: "kindergartener",
            category: "社会角色",
            emoji: "🧒",
            title: "幼儿园小朋友视角",
            titleEN: "Kindergartener",
            templates: [
                "你为什么不去{wish}呀？你是不是害怕呀？我们老师说了，害怕的时候要深呼吸然后数到三就不怕了。一、二、三！好了你现在不怕了吧？那就去呀！我上次不敢从滑梯上滑下来，数到三就滑了，可好玩了。{wish}肯定比滑梯好玩一百倍！你是大人诶，大人还害怕，好奇怪哦。",
                "我妈妈说，想要什么就要大声说出来。你想{wish}对不对？那你大声说呀！一、二、三——「我要{wish}！」你看，说出来就没那么难了吧？我每次想吃冰淇淋都是这样做的，成功率百分之八十。你是大人，你的成功率肯定比我高。",
                "你知道吗，我们班的小明什么都不敢，不敢荡秋千不敢跳绳不敢举手回答问题。老师说小明将来会变成一个很无聊的大人。你是不是也要变成很无聊的大人呀？你想{wish}就去呀，幼儿园小朋友都知道的道理，你一个大人还不懂吗？",
            ],
            templatesEN: [
                "Why won't you {wish}? Are you scared? My teacher says when you're scared, take a deep breath and count to three. One, two, three! See? Not scary anymore! Go! Last time I was scared of the slide, I counted to three and went — it was SO fun. {wish} is probably a hundred times more fun than the slide! You're a grown-up — grown-ups being scared is so weird.",
                "My mommy says if you want something, say it loud. You want to {wish}, right? Then say it! One, two, three — 'I WANT TO {wish}!' See? Not so hard! I do this every time I want ice cream. Works 80% of the time. You're an adult — your success rate is definitely higher than mine.",
                "You know what, Xiao Ming in my class is scared of everything — scared of swings, jump rope, raising his hand. My teacher says Xiao Ming will grow up to be a very boring adult. Are you gonna be a boring adult too? You want to {wish}, so just go! Even kindergarteners know this. How does a grown-up not get it?",
            ]
        ),
        Dimension(
            id: "delivery_driver",
            category: "社会角色",
            emoji: "🛵",
            title: "外卖骑手视角",
            titleEN: "Delivery Driver",
            templates: [
                "兄弟我跟你说，我每天送四十单外卖，每一单都有倒计时。超时一分钟扣两块钱，超时五分钟差评，超时十分钟这单白跑。人生也一样啊，你想{wish}，犹豫一天就少赚一天的经验值，犹豫一个月就是一整个月的差评。别让你的人生超时。赶紧点「确认送达」吧。",
                "我导航用的是最短路线，从来不选「避开拥堵」。你知道为什么吗？因为所有路都堵，选来选去浪费的时间比堵着还多。你想{wish}，别再找最优解了，直接走最短路线。路上遇到堵的就硬闯，遇到红灯就等一下，但方向不要变。终点就在前面，骑就完了。",
                "这行最大的真理就是：订单不会等你。你不接，别人就接了。你想{wish}？这就是你人生的订单。它现在正在你屏幕上闪，再不按接单键，系统就自动派给别人了。你以为机会也有「重新分配」功能？没有的。按下去。现在。",
            ],
            templatesEN: [
                "Bro listen, I deliver forty orders a day, every one with a countdown. One minute late, docked two bucks. Five minutes, bad review. Ten minutes, the whole trip's wasted. Life works the same way. You want to {wish}? Every day you hesitate is a day of lost XP. A month of hesitation is a month of bad reviews. Don't let your life time out. Hit 'Delivery Confirmed.'",
                "My GPS always takes the shortest route — I never pick 'avoid traffic.' Why? Because every road is jammed, and the time wasted choosing a route is worse than the jam itself. You want to {wish}? Stop looking for the optimal path. Take the shortest route. Hit a jam? Push through. Red light? Wait briefly. But never change direction. The destination is ahead. Just ride.",
                "Biggest truth in this job: orders don't wait. You don't take it, someone else will. You want to {wish}? This is your life's order. It's flashing on your screen right now. If you don't hit 'Accept,' the system assigns it to someone else. You think opportunities have a 'reassign' button? They don't. Tap it. Now.",
            ]
        ),

        // MARK: - 职业视角 (续)
        Dimension(
            id: "lawyer",
            category: "职业视角",
            emoji: "⚖️",
            title: "律师视角",
            titleEN: "Lawyer",
            templates: [
                "本律师现就「当事人是否应当{wish}」一案发表最终陈述。证据如下：第一，当事人具有完全民事行为能力；第二，该行为不违反任何法律法规；第三，不做此事的唯一后果是终身遗憾，而「终身遗憾」在情感法庭上属于最高级别的精神损害赔偿。综上所述，本律师建议当事人立即执行{wish}。反对无效。退庭。",
                "我审查了你所有的顾虑，逐条驳回如下：「我怕失败」——驳回，失败不构成犯罪；「我没准备好」——驳回，世界上没有法律规定必须准备好才能行动；「别人会怎么看」——驳回，他人目光不具有法律效力。你想{wish}的所有阻碍均不成立。判决结果：立即执行。",
                "从法律角度看，你不{wish}属于「不作为」。在特定情况下，不作为和作为承担同等法律责任。你知道最可怕的不作为是什么吗？是明明知道自己想{wish}，有能力{wish}，却选择什么都不做。这在人生法庭上叫「过失性虚度」，量刑标准是余生的后悔。去{wish}吧，给自己判个无罪。",
            ],
            templatesEN: [
                "Counsel hereby delivers closing arguments on the matter of 'Whether the client should {wish}.' Evidence: First, the client possesses full legal capacity. Second, the act violates no laws. Third, the sole consequence of inaction is lifelong regret — classified as the highest tier of emotional damages. The court recommends immediate execution of {wish}. Objection overruled. Court adjourned.",
                "I've reviewed all your concerns and overruled them: 'I'm afraid of failure' — overruled, failure is not a crime. 'I'm not ready' — overruled, no law requires readiness before action. 'What will people think' — overruled, public opinion has no legal standing. All objections to {wish} are dismissed. Verdict: proceed immediately.",
                "Legally speaking, not doing {wish} constitutes 'failure to act.' In certain contexts, inaction carries the same liability as action. The worst kind of inaction? Knowing you want to {wish}, having the ability, and choosing to do nothing. In the court of life, this is 'negligent squandering,' sentenced to a lifetime of regret. Go {wish}. Acquit yourself.",
            ]
        ),
        Dimension(
            id: "food_critic",
            category: "职业视角",
            emoji: "🍽️",
            title: "美食评论家视角",
            titleEN: "Food Critic",
            templates: [
                "人生是一道限时供应的omakase，厨师今天给你端上来的这道菜叫「{wish}」。你可以选择品尝，也可以选择退回去。但我做了二十年美食评论，给你一个忠告：退回去的人永远不知道那道菜是什么味道，而且厨师不会再做第二次。咬一口吧。也许这就是你人生菜单上的米其林三星时刻。",
                "我尝过全世界四十七个国家的料理，踩过无数次雷，也遇到过让我当场落泪的美味。你知道我最大的经验是什么吗？从来没有一道菜是你「看看菜单就能评价」的。你必须亲口尝。你想{wish}？别光看菜单了，下单。嘴巴会告诉你一切，而不是你的脑子。",
                "最差的餐厅不是难吃的餐厅，是你路过了一百次但从来没进去过的餐厅。因为难吃你至少有了一个故事可以讲，但没进去你什么都没有。你想{wish}就是你路过了一百次的那家店。推门进去。就算难吃，你也赚了一个故事。",
            ],
            templatesEN: [
                "Life is a limited-time omakase, and the chef just served you a dish called '{wish}.' You can taste it or send it back. Twenty years as a food critic, here's my advice: people who send it back never know what it tasted like, and the chef won't make it again. Take a bite. This might be your Michelin three-star moment.",
                "I've tasted cuisine from 47 countries, had countless terrible meals, and cried tears of joy at some. My biggest lesson? No dish can be reviewed by reading the menu. You have to taste it. You want to {wish}? Stop reading the menu. Order. Your mouth will tell you everything — not your brain.",
                "The worst restaurant isn't the bad one — it's the one you've walked past a hundred times and never entered. A bad meal is at least a story. Walking past gives you nothing. {wish} is that restaurant you keep passing. Push open the door. Even if it's bad, you've earned a story.",
            ]
        ),
        Dimension(
            id: "therapist",
            category: "职业视角",
            emoji: "🛋️",
            title: "心理咨询师视角",
            titleEN: "Therapist",
            templates: [
                "我注意到你在谈到{wish}的时候，身体微微前倾了。你知道这意味着什么吗？你的潜意识已经做好了决定，只是你的意识还在用各种理由拽着它。在我十五年的执业经验里，身体永远比大脑诚实。你不是不知道该不该{wish}，你是不敢承认自己已经知道了。给自己一个许可吧。你被允许去做自己想做的事。",
                "你刚才列举了五个不去{wish}的理由，但有意思的是，你在说这些理由的时候语速越来越快，音调越来越高。在心理学里这叫「认知失调」——你的理性在编造理由，但你的情绪在抗议。你真正需要做的不是找更多理由，而是对自己说一句：「我想要，这就够了。」去{wish}吧。",
                "我们来做一个小练习。闭上眼睛，想象两个平行世界：在A世界里，你去{wish}了；在B世界里，你没去。现在告诉我，你在哪个世界里笑了？……你看，你甚至不需要我帮你分析。你的笑容已经替你做了选择。预约下次咨询的时候，希望你能告诉我你已经去做了。",
            ],
            templatesEN: [
                "I notice when you mention {wish}, you lean forward slightly. Know what that means? Your subconscious has already decided — your conscious mind is just dragging it back with excuses. In fifteen years of practice, the body is always more honest than the brain. You don't not know whether to {wish}. You're afraid to admit you already know. Give yourself permission. You're allowed to do what you want.",
                "You just listed five reasons not to {wish}, but interestingly, your speech sped up and your pitch rose with each one. In psychology, that's cognitive dissonance — your rational mind is fabricating excuses while your emotions protest. What you need isn't more reasons. It's to say: 'I want this. That's enough.' Go {wish}.",
                "Let's try an exercise. Close your eyes. Imagine two parallel worlds: in World A, you did {wish}. In World B, you didn't. Now tell me — in which world are you smiling? ... See? You don't even need me to analyze this. Your smile already chose. When you book your next session, I hope you'll tell me you've already done it.",
            ]
        ),

        // MARK: - 时间维度 (续)
        Dimension(
            id: "parallel_universe_you",
            category: "时间维度",
            emoji: "🌀",
            title: "平行宇宙的你视角",
            titleEN: "Parallel Universe You",
            templates: [
                "根据多世界诠释，在你做出决定的这一刻，宇宙会分裂成两个平行宇宙。在宇宙A里，你去{wish}了。在宇宙B里，你没去。宇宙A的你现在正在拍拍宇宙B的你的肩膀说：「兄弟，来这边，这边的风景好太多了。」你要当A还是当B？别让另一个你替你活了精彩的那一面。",
                "平行宇宙里有无数个你。有的你当了宇航员，有的你在喂鸽子，有的你正在纠结要不要{wish}——等等，那个就是你。你知道最惨的平行宇宙是哪个吗？就是那个「每次都想做但每次都没做」的宇宙。无限个平行宇宙里，别让你这个成为最无聊的那一个。去{wish}吧。",
                "我是平行宇宙里已经{wish}了的你。我穿越量子屏障来告诉你一件事：去做。具体结果我不能剧透，多元宇宙管理局不让说。但我能告诉你的是：我不后悔。而那个没做的平行宇宙版本的你，正在另一个app上问同样的问题。别当那个版本的自己。当我。",
            ],
            templatesEN: [
                "According to the Many-Worlds Interpretation, the moment you decide, the universe splits in two. In Universe A, you did {wish}. In Universe B, you didn't. Universe A you is tapping Universe B you on the shoulder: 'Hey, come over here. The view is way better.' Are you A or B? Don't let another you live the exciting version of your life.",
                "In parallel universes, there are infinite versions of you. Some became astronauts. Some feed pigeons. And one is sitting there wondering whether to {wish} — wait, that one's you. Know which parallel universe is the saddest? The one where you always wanted to but never did. Among infinite universes, don't let yours be the most boring. Go {wish}.",
                "I'm the you from a parallel universe who already did {wish}. I crossed the quantum barrier to tell you one thing: do it. Can't spoil the details — Multiverse Bureau regulations. But I can tell you this: I don't regret it. And the version of you who didn't? They're on another app asking the same question. Don't be that version. Be me.",
            ]
        ),
        Dimension(
            id: "future_historian",
            category: "时间维度",
            emoji: "📜",
            title: "100年后的历史学家视角",
            titleEN: "Future Historian",
            templates: [
                "各位观众大家好，欢迎收看《百年回望》第2126期。今天我们要讲的是一百年前的一个普通人，在一个普通的日子里做出了一个不普通的决定——{wish}。当时所有人都觉得这不过是一个微不足道的选择，但回头看，这正是改变一切的起点。历史总是这样，伟大的转折从来不会提前通知你。你的转折就在今天。去{wish}吧。",
                "作为2126年的历史学家，我在研究21世纪初期人类行为时发现了一个有趣的现象：那个时代的人花在「纠结要不要做」上的时间，平均是「实际做那件事」时间的三倍。你想{wish}，如果你把纠结的时间用来行动，你现在可能已经完成三次了。历史会记住行动者，不会记住纠结者。创造历史去吧。",
                "我翻遍了2026年的所有历史档案，发现了一条被遗忘的记录：「某人于此年此日决定{wish}。」这条记录在当时毫不起眼，但后来被史学界称为「蝴蝶事件」——因为它引发了一系列连锁反应。你不相信？说实话我也不确定——但重点是，你不去做就永远不会知道这条记录会不会出现在历史书上。去写你的历史。",
            ],
            templatesEN: [
                "Welcome to 'A Century in Review,' episode 2126. Today's story: a hundred years ago, an ordinary person on an ordinary day made an extraordinary decision — to {wish}. Everyone thought it was insignificant, but looking back, it was the turning point that changed everything. History works that way — great turning points never announce themselves. Yours is today. Go {wish}.",
                "As a historian in 2126, I've found a fascinating pattern in early 21st-century behavior: people spent three times longer agonizing over decisions than actually doing the thing. You want to {wish}? If you'd spent your hesitation time acting, you'd have finished three times over by now. History remembers doers, not deliberators. Go make history.",
                "I've searched every archive from 2026 and found one overlooked record: 'On this day, someone decided to {wish}.' It seemed trivial at the time but was later called 'The Butterfly Event' by historians — it triggered a chain reaction. Don't believe me? Honestly, I'm not sure either. But the point is: if you don't do it, you'll never know if this entry makes the history books. Go write your history.",
            ]
        ),

        // MARK: - 文化视角 (续)
        Dimension(
            id: "greek_philosopher",
            category: "文化视角",
            emoji: "🏛️",
            title: "古希腊哲学家视角",
            titleEN: "Greek Philosopher",
            templates: [
                "苏格拉底说「未经审视的人生不值得过」。好的，你已经审视了，你想{wish}。现在让我补充一句苏格拉底没说过但应该说的话：「审视完了还不行动的人生更不值得过。」你已经完成了哲学的第一步——认识你自己。现在完成第二步——行动。别让苏格拉底失望，他为了真理都喝毒药了，你连{wish}都不敢？",
                "亚里士多德认为人的最高善是「eudaimonia」——灵魂的繁荣。注意，是「繁荣」不是「安全」。你的灵魂不会因为你躲在舒适区里而繁荣，就像一棵树不会在密室里开花。你想{wish}？这就是你的灵魂在要求阳光和雨露。给它。让亚里士多德为你骄傲。",
                "柏拉图说世人都活在洞穴里，看到的不过是真实世界的影子。你现在纠结要不要{wish}，就是在洞穴里盯着影子犹豫。走出洞穴很刺眼，很不舒服，但外面才有真正的太阳。两千四百年前的哲学家都想明白了的道理，你还要在洞里坐多久？出去吧。",
            ],
            templatesEN: [
                "Socrates said 'The unexamined life is not worth living.' Great — you've examined, and you want to {wish}. Now let me add what Socrates didn't say but should have: 'The examined-but-unlived life is even less worth living.' You've completed philosophy's first step: know thyself. Now step two: act. Socrates drank hemlock for truth. You won't even {wish}?",
                "Aristotle believed the highest human good is 'eudaimonia' — the flourishing of the soul. Note: 'flourishing,' not 'safety.' Your soul won't flourish while you hide in your comfort zone, just as a tree won't bloom in a sealed room. You want to {wish}? That's your soul demanding sunlight and rain. Give it what it needs. Make Aristotle proud.",
                "Plato said we live in a cave, seeing only shadows of reality. You agonizing over {wish} is staring at shadows on the cave wall. Walking out is blinding and uncomfortable, but the real sun is outside. Philosophers figured this out 2,400 years ago. How much longer will you sit in the cave? Get out.",
            ]
        ),
        Dimension(
            id: "british_butler",
            category: "文化视角",
            emoji: "🎩",
            title: "英国管家视角",
            titleEN: "British Butler",
            templates: [
                "先生/女士，恕我直言，您在是否{wish}这个问题上犹豫不决的时间，已经足够我为您泡三壶伯爵茶、熨平十二件衬衫并将银器擦拭两遍了。以我服务贵族家庭三十年的经验来看，真正的上等人从不在该行动的时候犹豫。他们只是轻轻地说一句「请安排」。所以，先生/女士，我能否为您安排{wish}？",
                "如果我可以稍作僭越：在唐顿庄园的年代，一位绅士若在公开场合表现犹豫，那简直比用错餐叉还要失礼。您想{wish}，这是一个值得尊敬的意愿。犹豫才是不体面的。请允许我帮您拿外套。出发的马车已经在门口等候。行李我已经收拾好了。您只需要站起来。",
                "先生/女士，以我的专业意见，您目前最需要的既不是更多的信息，也不是更好的时机，而是——请恕我冒昧——一点点行动力。在我们这个行业有句老话：「最好的管家从不问主人要不要喝茶，他直接端上来。」请允许我将{wish}端到您面前。您只需要喝就好了。",
            ],
            templatesEN: [
                "Sir/Madam, if I may be so bold, the time you've spent deliberating over whether to {wish} would have sufficed for me to brew three pots of Earl Grey, press twelve shirts, and polish the silver twice. In thirty years serving distinguished households, I've observed that people of true caliber never hesitate when action is required. They simply say, 'Please arrange it.' Shall I arrange {wish} for you?",
                "If I may presume: in the Downton Abbey era, a gentleman showing indecision in public was considered more improper than using the wrong fork. You wish to {wish} — that is a respectable ambition. The hesitation, however, is unseemly. Permit me to fetch your coat. The carriage is waiting. Your bags are packed. You need only stand.",
                "Sir/Madam, in my professional estimation, what you require is neither more information nor better timing, but — forgive the impertinence — a modicum of initiative. In our profession there is a saying: 'The finest butler never asks if one wants tea; he simply serves it.' Allow me to serve {wish} before you. You need only drink.",
            ]
        ),
        Dimension(
            id: "anime_narrator",
            category: "文化视角",
            emoji: "⚡",
            title: "日本热血动漫旁白视角",
            titleEN: "Anime Narrator",
            templates: [
                "在那一瞬间，时间仿佛停止了。主角紧握双拳，眼中燃烧着前所未有的火焰。「{wish}……」他低声念道，声音虽小却震颤着不可阻挡的意志。体内沉睡已久的力量开始觉醒——心跳加速，热血沸腾，背景音乐渐渐高昂！这就是第二季第一集的名场面！觉醒吧少年，{wish}就是你的终极奥义！",
                "「不可能……这个人的力量居然还在上升！」反派目瞪口呆地看着仪器上不断跳动的数字。没错，就在主角决定{wish}的那一刻，他的战斗力突破了9000！——不，是突破了测量极限！因为一个真正下定决心的人，力量是无法被数字衡量的。这就是热血的真谛。现在，释放你的力量吧！",
                "「下集预告：少年终于做出了决定。当所有人都以为他会放弃的时候，他微微一笑，踏出了那一步。他说：『我要{wish}。就算全世界都阻止我，我也绝不回头。』敬请期待——《你的人生》第二季：觉醒篇。」别让观众等太久了。你的下一集，现在就开始。",
            ],
            templatesEN: [
                "In that instant, time itself seemed to freeze. The protagonist clenched their fists, eyes blazing with an unprecedented fire. '{wish}...' they whispered — quiet, yet trembling with unstoppable will. A long-dormant power began awakening — heartbeat accelerating, blood boiling, the soundtrack swelling! This is THE scene of Season 2, Episode 1! Awaken, hero — {wish} is your ultimate technique!",
                "'Impossible... this person's power level is still rising!' The villain stared in disbelief at the climbing numbers. Yes — the moment the protagonist decided to {wish}, their power level broke 9,000! No — it shattered the measurement limit! Because the power of true determination cannot be measured by numbers. This is the essence of shonen spirit. Now — unleash your power!",
                "'Next episode preview: The hero finally makes a decision. Just when everyone thought they'd give up, they smiled and took that step. They said: \"I will {wish}. Even if the whole world tries to stop me, I will never turn back.\" Stay tuned — Your Life, Season 2: The Awakening Arc.' Don't keep the audience waiting. Your next episode starts now.",
            ]
        ),
        Dimension(
            id: "rap_battle_mc",
            category: "文化视角",
            emoji: "🎵",
            title: "说唱MC视角",
            titleEN: "Rap Battle MC",
            templates: [
                "Yo check it，我说你站在原地不动像个雕塑，脑子里想着{wish}但脚像被灌了水泥。犹豫是最弱的flow，纠结是最差的beat。你在freestyle你的人生，但你一直在跑拍。兄弟pick up the mic，{wish}就是你的punchline——你不说出来，这个round你就输了。Drop the beat，开干。",
                "我来给你spit一段真实的verse：你的excuses比你的dreams多，你的fears比你的skills大，你的tomorrow比你的today忙——但那全是cap。你想{wish}？那就stop tripping，start flipping the script。人生没有take two，这是live performance。你要么上台slay，要么下台cry。选一个。我建议选前者。Peace。",
                "全场注意，battle开始了。一边是你想{wish}的梦想，另一边是你犹豫的借口。Dream说：「我有一百个理由让你行动。」借口说：「我有一百零一个理由让你别动。」但这是rap battle不是辩论赛——不是谁理由多谁赢，是谁的flow更猛谁赢。梦想的flow永远比借口硬。投票给梦想。去{wish}。",
            ],
            templatesEN: [
                "Yo check it — you're standing still like a statue, brain thinking about {wish} but feet stuck in cement. Hesitation is the weakest flow, indecision the worst beat. You're freestyling your life but you keep falling off beat. Pick up the mic — {wish} is your punchline. You don't spit it, you lose this round. Drop the beat. Let's go.",
                "Let me spit you a real verse: your excuses outnumber your dreams, your fears outweigh your skills, your 'tomorrow' is busier than your today — but that's all cap. You want to {wish}? Stop tripping, start flipping the script. Life's got no take two — this is a live performance. You either get on stage and slay or walk off and cry. Pick one. I suggest the former. Peace.",
                "Attention — battle's on. In one corner, your dream of {wish}. In the other, your excuses. Dream says: 'I got a hundred reasons to move.' Excuses say: 'I got a hundred and one reasons to stay.' But this is a rap battle, not a debate — it's not about who has more reasons, it's whose flow hits harder. Dreams always spit harder than excuses. Vote for the dream. Go {wish}.",
            ]
        ),

        // MARK: - 互联网 (续)
        Dimension(
            id: "douban_group_leader",
            category: "互联网",
            emoji: "📖",
            title: "豆瓣小组组长视角",
            titleEN: "Douban Group Leader",
            templates: [
                "【投票帖】组员们好，今天我们来投个票：楼主想{wish}，但一直犹豫不决。请投票：A. 去啊想什么呢 B. 别去了稳一点 C. 跟帖分享自己的经历。———结果出来了：247票A，3票B（其中两票是楼主的小号），189人选了C并且都在说自己当初去了多开心。组长总结：去。帖子加精，锁帖。",
                "本组组规第一条：「不许在组里发纠结帖，纠结就是想去。」你来问要不要{wish}，根据组规，你已经被默认为「想去」。本组创建三年来接待了4826位纠结组员，其中4825位最后都去了。剩下那一位到现在还在组里发帖问同一个问题。你想当哪个？组长在线催你：去{wish}。",
                "楼主你好，我代表「犹豫就会败北」小组的全体8万组员向你喊话：你发帖问要不要{wish}的时间里，已经有十七个人在隔壁「行动派」小组发了成功帖。你还在我们组呢？赶紧退组吧。不是我赶你，是你应该去「已经做到了」小组。那个组更适合你。但前提是你先去{wish}。",
            ],
            templatesEN: [
                "[POLL] Hi members, today's vote: OP wants to {wish} but keeps hesitating. Vote now: A) Just go, why are you even thinking B) Don't go, play it safe C) Share your own experience. — Results are in: 247 for A, 3 for B (two were OP's alt accounts), 189 chose C and all said they're glad they went. Admin summary: Go. Post pinned and locked.",
                "Group rule #1: 'No indecision posts — if you're asking, you already want to go.' You're asking about {wish}, so per the rules, you've been automatically classified as 'wants to go.' In three years, this group has hosted 4,826 indecisive members. 4,825 eventually went. The remaining one is still posting the same question. Which one do you want to be? Admin says: go {wish}.",
                "OP, on behalf of all 80,000 members of the 'Hesitate and You Lose' group: while you were posting about whether to {wish}, seventeen people in the 'Action Takers' group already posted success stories. You're still in our group? Time to leave. I'm not kicking you out — you should be in the 'Already Did It' group. That group suits you better. But first, go {wish}.",
            ]
        ),
        Dimension(
            id: "zhihu_top_answer",
            category: "互联网",
            emoji: "💡",
            title: "知乎高赞回答视角",
            titleEN: "Zhihu Top Answer",
            templates: [
                "谢邀。人在犹豫，刚下决心。关于「要不要{wish}」这个问题，作为一个拥有十二万关注者的知乎答主，我从三个维度来回答：1）机会成本——你不做的代价远大于做的代价；2）幸存者偏差——你只看到失败案例是因为成功的人没空上知乎；3）损失厌恶——你害怕的不是失败，是损失感，但不行动本身就是最大的损失。综上，去{wish}。以上。如果觉得有用请点赞收藏，谢谢。",
                "利益相关：曾经也犹豫过要不要{wish}的人。先说结论：去。再说论证：你之所以犹豫，不是因为这件事不好，而是因为它足够重要所以你害怕搞砸。但这恰恰说明它值得做——你什么时候见过有人认真纠结要不要去吃第四顿麦当劳？只有真正重要的事才值得犹豫。而真正重要的事都值得去做。QED。",
                "这个问题下面已经有328个回答了，但我还是忍不住来答一下。看了一圈，所有高赞回答都在说「去」，所有低赞回答都在说「要谨慎」。知乎的投票机制虽然不完美，但八千人的赞不会骗你。你想{wish}？互联网集体智慧已经给出答案了。关注我，然后去{wish}。顺序不能反。",
            ],
            templatesEN: [
                "Thanks for the invite. Currently hesitating, just made up my mind. On 'whether to {wish},' as a writer with 120K followers, I'll answer from three angles: 1) Opportunity cost — not doing it costs more than doing it. 2) Survivorship bias — you only see failure cases because successful people are too busy for Q&A forums. 3) Loss aversion — you don't fear failure, you fear the feeling of loss, but inaction IS the biggest loss. In conclusion: go {wish}. If helpful, please upvote. Thanks.",
                "Disclosure: someone who also once hesitated about {wish}. Conclusion first: go. Now the proof: you're hesitating not because it's bad, but because it matters enough that you're afraid to mess it up. That's exactly why it's worth doing — when's the last time you seriously agonized over having a fourth McDonald's meal? Only things that truly matter are worth agonizing over. And things that truly matter are worth doing. QED.",
                "There are already 328 answers to this question, but I can't help adding one more. Scrolled through them all — every top answer says 'go,' every low-voted answer says 'be careful.' The voting system isn't perfect, but 8,000 upvotes don't lie. You want to {wish}? The internet's collective wisdom has spoken. Follow me, then go {wish}. In that order.",
            ]
        ),
        Dimension(
            id: "reddit_top_post",
            category: "互联网",
            emoji: "🔥",
            title: "Reddit热帖视角",
            titleEN: "Reddit Top Post",
            templates: [
                "r/LifeAdvice · Posted by u/你的潜意识 · 12h\n「I'm thinking about {wish} but I can't decide. AITA?」\n🔝 Top comment (Award x47): NTA. You're not the a-hole for wanting things. YTA if you don't go for it. 你不去才是混蛋。\n↳ Reply: This. 100% this.\n↳ Reply: Can confirm, did the same thing, life changed.\n评论区全票通过，你还等什么？去{wish}。",
                "TIFU by NOT doing {wish}——哦等等，这个帖子还没发生呢，因为你现在还有机会避免。Reddit上最火的TIFU帖子都是关于「没做什么」的后悔故事。你现在可以选择：是成为一个TIFU帖子的主角，还是成为一个「Just did this, AMA」帖子的英雄？你想{wish}，去。别让未来的你发TIFU。",
                "ELI5: 为什么我应该{wish}？回答：想象你是一个五岁小孩站在游泳池边上。水看起来很冷。你可以站在那里一直看，也可以跳下去。跳下去的小孩三秒后就开心得尖叫了。站在岸上的小孩三小时后还在那里纠结。你已经站了够久了。Jump in。14.2k upvotes。金奖银奖铂金奖全齐了。去{wish}吧。",
            ],
            templatesEN: [
                "r/LifeAdvice · Posted by u/YourSubconscious · 12h\n'Thinking about {wish} but can't decide. AITA?'\n🔝 Top comment (47 awards): NTA. You're not the a-hole for wanting things. YTA if you don't go for it.\n↳ Reply: This. 100% this.\n↳ Reply: Can confirm, did the same thing, life changed.\nUnanimous verdict. What are you waiting for? Go {wish}.",
                "TIFU by NOT {wish} — oh wait, this post hasn't happened yet because you still have time to avoid it. The hottest TIFU posts are always regret stories about things people DIDN'T do. Your choice right now: become the protagonist of a TIFU post, or the hero of a 'Just did this, AMA' post. You want to {wish}? Go. Don't let future you post a TIFU.",
                "ELI5: Why should I {wish}? Answer: Imagine you're a five-year-old standing at the edge of a pool. The water looks cold. You can stand there staring, or you can jump. The kid who jumps is screaming with joy three seconds later. The kid on the edge is still deliberating three hours later. You've been standing long enough. Jump in. 14.2k upvotes. Gold, silver, platinum — the works. Go {wish}.",
            ]
        ),
        Dimension(
            id: "tiktok_creator",
            category: "互联网",
            emoji: "📲",
            title: "TikTok博主视角",
            titleEN: "TikTok Creator",
            templates: [
                "POV：你在纠结要不要{wish}，然后刷到了这条视频。评论区：「就是一个字，冲！」「姐妹我跟你说我上个月也这样」「背景音乐是什么？」「第一条评论说得对」「求后续更新」。你看到了吗？一万七千个赞，两千条转发，没有一个人说别去。算法都在推你去{wish}。大数据不骗人。关注我看后续。",
                "等一下等一下等一下——你该不会还在犹豫要不要{wish}吧？不是，这种事情还用想？我拍这条视频的时间都比你做决定的时间短。三、二、一，拍完了。你呢？你的决定呢？这条视频都快过审了你还没下定决心？TikTok的节奏是快节奏懂不懂，人生也一样。滑走之前赶紧去{wish}。别光点赞不行动。",
                "【挑战赛】#去做吧挑战 规则很简单：把你一直犹豫的事今天就去做。你犹豫的是{wish}对吧？现在这条视频已经有三百万人参加了这个挑战，其中两百九十九万人已经做了。你是那剩下的一万人吗？评论区全是「已完成挑战」的打卡。轮到你了。做完来评论区打卡。我等你。",
            ],
            templatesEN: [
                "POV: You're debating whether to {wish} and you just scrolled to this video. Comments: 'One word: GO' 'Bestie I was the same last month' 'What's the background song?' 'First comment is right' 'We need a follow-up.' See that? 17K likes, 2K shares, zero people saying don't. The algorithm is pushing you to {wish}. Big data doesn't lie. Follow for the update.",
                "Wait wait wait — you're NOT still deciding whether to {wish}, are you? Like, this even needs thinking? I filmed this video faster than you're making this decision. Three, two, one — done filming. You? Where's your decision? This video is about to go through moderation and you still haven't decided? TikTok speed is fast — life should be too. Before you swipe away, go {wish}. Don't just double-tap — take action.",
                "[CHALLENGE] #JustDoItChallenge Rules are simple: whatever you've been hesitating on, do it today. Yours is {wish}, right? This video already has 3 million participants, and 2.99 million have completed the challenge. Are you in the remaining 10,000? The comments are full of 'Challenge complete' check-ins. Your turn. Do it and come check in. I'll be waiting.",
            ]
        ),

        // MARK: - 额外
        Dimension(
            id: "fortune_cookie",
            category: "文化视角",
            emoji: "🥠",
            title: "幸运饼干视角",
            titleEN: "Fortune Cookie",
            templates: [
                "你掰开了一块幸运饼干。里面的纸条上写着：「你即将{wish}，而且会比你想象的顺利。」你觉得这是随机印的？不，幸运饼干工厂有一台1973年生产的老打印机，它已经给一亿三千万人印过命运了。它阅人无数，看得比你准。它说你该{wish}，你就该{wish}。别跟饼干过不去。吃掉它，然后去。",
                "Lucky numbers: 7, 14, 23, 38, 42。你的幸运行为：{wish}。你的幸运时间：现在。你的幸运障碍：不存在。——这是一块有态度的幸运饼干，它懒得跟你绕弯子。它见过太多人把纸条读了三遍然后塞进口袋再也不看。别这样。这张纸条是宇宙写给你的便签。去{wish}。然后告诉宇宙，你收到了。",
                "这块幸运饼干犹豫了零秒就裂开了，把命运纸条交到了你手上。它没有想「我该不该裂开」「裂开之后会怎样」「别的饼干会怎么看我」。它就——裂了。纸条上写的是：「{wish}。」一块饼干都比你果断。你还好意思犹豫？裂开吧，把你的好运释放出来。",
            ],
            templatesEN: [
                "You cracked open a fortune cookie. The slip reads: 'You will {wish}, and it will go better than you imagine.' Think this was randomly printed? No. The fortune cookie factory has a printer from 1973 that has printed destinies for 130 million people. It's seen more lives than you. It says you should {wish}. Don't argue with the cookie. Eat it and go.",
                "Lucky numbers: 7, 14, 23, 38, 42. Your lucky action: {wish}. Your lucky time: now. Your lucky obstacle: doesn't exist. — This is a no-nonsense fortune cookie. It's seen too many people read the slip three times, shove it in their pocket, and forget it. Don't be that person. This slip is a note from the universe. Go {wish}. Then tell the universe you got the message.",
                "This fortune cookie hesitated for zero seconds before cracking open and delivering its message. It didn't think 'Should I crack?' or 'What happens after?' or 'What will the other cookies think?' It just — cracked. The slip says: '{wish}.' A cookie is more decisive than you. Still hesitating? Crack open. Release your good fortune.",
            ]
        ),
        Dimension(
            id: "cat",
            category: "社会角色",
            emoji: "🐱",
            title: "你家的猫视角",
            titleEN: "Your Cat",
            templates: [
                "喵。我是你家的猫。我观察你已经三年了，你的行为模式是这样的：打开手机→叹气→关上手机→再打开→再叹气。你现在又在纠结要不要{wish}了对吧？作为一只猫，我想告诉你，我每天的决策过程是这样的：想跳上桌子→跳上桌子。没有第三步。你们人类把简单的事搞得太复杂了。{wish}，跳就是了。喵。",
                "你知道我为什么总是把东西从桌子上推下去吗？因为我想推就推了，从不后悔。杯子碎了？那是杯子的问题。你想{wish}就去，后果？那是后果的问题。你需要学习的不是什么勇气和决心，是「猫的哲学」：想做就做，做了不管，管了也不在乎。你养我这么久，一点猫的精髓都没学到，白养了。去{wish}。喵。",
                "我现在趴在你的键盘上，用我的屁股挡住了你的屏幕。为什么？因为你与其盯着屏幕纠结要不要{wish}，不如看看我——一个每天只做四件事的生物：吃饭、睡觉、舔毛、想做什么就做什么。我的幸福指数比你高十倍。区别在哪里？我从不犹豫。现在，我要从你键盘上下去了，你应该从犹豫里出来。去{wish}。我去睡了。喵。",
            ],
            templatesEN: [
                "Meow. I'm your cat. I've been observing you for three years. Your behavior pattern: open phone → sigh → close phone → open again → sigh again. You're agonizing over {wish} again, aren't you? As a cat, let me tell you my decision-making process: want to jump on table → jump on table. No step three. You humans overcomplicate everything. {wish} — just jump. Meow.",
                "You know why I push things off tables? Because I want to, and I never regret it. Cup broke? That's the cup's problem. You want to {wish}? Go. Consequences? That's the consequences' problem. What you need isn't courage or determination — it's Cat Philosophy: do what you want, don't look back, and if you do look back, don't care. You've had me for years and haven't learned a thing. Wasted. Go {wish}. Meow.",
                "I'm sitting on your keyboard right now, blocking your screen with my butt. Why? Because instead of staring at the screen agonizing over {wish}, you should look at me — a creature that does only four things daily: eat, sleep, groom, and do whatever I want. My happiness index is ten times yours. The difference? I never hesitate. Now, I'm getting off your keyboard. You should get out of your indecision. Go {wish}. I'm going to nap. Meow.",
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
