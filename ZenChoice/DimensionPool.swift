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
                "你体内现在还保留着爬行动物时期的杏仁核，它的唯一功能就是让你害怕。这颗脑子已经过时两亿年了，你还听它的？它让你别{wish}，就像一只蜥蜴在教你做人。用你的前额叶皮层——那个进化了几百万年的新零件——做决定。新零件说：去。",
                "你的DNA有百分之六十跟香蕉一样。也就是说，你跟一根香蕉的区别，全在于那百分之四十的勇气、智慧和行动力。你现在犹豫要不要{wish}，就是在浪费那百分之四十。别活成一根香蕉。",
            ],
            templatesEN: [
                "3.8 billion years ago, a single-celled organism decided to stop lounging around and started dividing like crazy. Its descendants crawled onto land, survived five mass extinctions, invented pizza delivery and Wi-Fi. All of that — just so you could sit here wondering whether to {wish}? Do right by that cell. Go.",
                "Darwin said survival of the fittest. You know who gets eliminated first? Not the weakest — the most indecisive. An antelope that hesitates for three seconds becomes lunch. You want to {wish}? Every second you hesitate, your evolutionary fitness drops. Science doesn't lie.",
                "When the first fish dragged itself onto land, every other fish thought it was insane. 400 million years later, that was the highlight of the entire species. You wanting to {wish}? This is your 'fins on land' moment. Don't chicken out.",
                "Your brain still has a reptilian amygdala whose only job is to make you afraid. That hardware is 200 million years out of date, and you're still listening to it? It's telling you not to {wish} — that's a lizard giving you life advice. Use your prefrontal cortex — the shiny new upgrade evolution spent millions of years building. The new hardware says: go.",
                "Your DNA is 60% identical to a banana's. The entire difference between you and a banana is that other 40% — courage, intelligence, and the ability to act. Hesitating over {wish} is wasting that 40%. Don't live like a banana.",
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
                "旅行者一号已经飞了四十多年，现在距离地球240亿公里，信号单程要走21个小时。它没有刹车键，没有回头路，发射那天就知道是单程票——它连犹豫的权利都没有。你想{wish}而已，比星际旅行简单一万倍，还带回头路的。你有什么好怕的？",
                "太阳每秒钟燃烧四百万吨自身的质量来给你发光发热，从来不问值不值得。它已经这样干了四十六亿年了。你想{wish}，连太阳百亿分之一的能量都不需要。太阳都没犹豫过，你犹豫什么？",
            ],
            templatesEN: [
                "Quick check: Earth spins at 1,670 km/h, orbits the sun at 29.8 km/s, and the entire solar system flies around the Milky Way at 220 km/s. While you read this, you've traveled thousands of kilometers through space. The universe is hustling that hard, and you won't even {wish}?",
                "The farthest starlight Hubble captured traveled 13.4 billion years just to reach your eyes. The universe spent 13.4 billion years getting light to your screen right now. If you don't {wish}, that light traveled for nothing.",
                "The ISS orbits Earth 16 times a day — astronauts up there see 16 sunrises daily. You can't even {wish} once? People in space are literally outperforming you.",
                "Voyager 1 has been flying for over forty years, now 24 billion kilometers from Earth. It has no brakes and no return ticket — it knew from launch day this was one-way. It didn't even have the option to hesitate. You want to {wish}? That's ten thousand times easier than interstellar travel, and you even get a return trip. What are you afraid of?",
                "The Sun burns four million tons of its own mass every second to give you light and warmth, never once asking if it's worth it. It's been doing this for 4.6 billion years. You want to {wish} — that takes less than a billionth of the Sun's energy. The Sun has never hesitated. Why are you?",
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
                "哎你听说了没有？楼上那个小刘之前也想{wish}，她爸她妈她七大姑八大姨全说不行。结果人家偷偷去了，现在混得可好了，过年回来那个气质都不一样了。她妈现在跟人说「我从小就支持她」。你看，成功了全家都挺你，你就差一个「去」字。",
                "我跟你讲啊我这辈子看人看多了，犹犹豫豫的人最后都活成了背景板，你看那谁谁谁，当年说要{wish}，拖到现在头发都白了还在说「等条件成熟」。条件成熟？条件永远不成熟！菜市场的西红柿都不等熟透了才卖——六成熟就上架了。你也一样，六成把握就够了，快去{wish}！",
            ],
            templatesEN: [
                "Let me tell you, Old Zhang's son downstairs wanted to {wish} last year. He hesitated for a whole year, and guess what? Still hesitating this year. But Little Li next door just went and did it — doing great now. I don't actually know Li, but that's not the point. The point is: don't be Zhang's son.",
                "You know Mrs. Wang from the corner store? Her daughter wanted to {wish} and the whole family said no. She went anyway. Now Mrs. Wang brags about her daughter's initiative to everyone. So go {wish} — once you succeed, your mom will be prouder than you.",
                "If you don't {wish}, you'll end up like Old Li who sits by the gate sighing every day. Someone asked what he regrets most. He said 'doing nothing.' You're still young. Don't wait until you're the one sighing.",
                "Did you hear about Xiao Liu upstairs? She wanted to {wish} too, and her parents, her aunts, her uncles ALL said no. She sneaked out and did it anyway. Now she's thriving — came home for New Year looking like a whole new person. Her mom now tells everyone 'I always supported her.' See? Succeed and the whole family's behind you. You're just one 'go' away.",
                "Let me tell you, I've watched enough people in my life to know — the wishy-washy ones all end up as background characters. You know so-and-so? Years ago she said she'd {wish}, and she's still waiting for 'the right time.' Her hair's gone gray and she's STILL saying it. The right time? It's never the right time! Tomatoes at the market don't wait till they're perfectly ripe — they hit the shelf at 60%. You're the same. 60% sure is enough. Go {wish}!",
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
                "我拉过一个乘客，上车就说去火车站，快到了突然说算了掉头回家。车费花了我告诉你多少了？跟犹豫的代价比算便宜的。两周后他又打车去火车站，这回没回头。他下车跟我说「师傅，我上次多花了一趟车钱学到一个道理——该走的路早晚得走」。你想{wish}？少绕弯路，这趟直达。",
                "干我们这行最怕一种乘客：上车说往东，走两步说往西，再走两步说还是往东。你猜最后咋样？计价器转了一大圈，人还在原地。你想{wish}，方向定了就别改。最贵的路不是远路，是来回折腾的路。打表了，走吧。",
            ],
            templatesEN: [
                "Twenty years driving cabs, I've seen it all. Everyone who says 'Airport, please' never regrets it. Everyone who says 'Actually, turn back' — eight out of ten end up calling another cab later anyway. You want to {wish}? Just go. Don't make me drive twice.",
                "I've picked up people crying outside bars at 3 AM saying they want to quit, and people beaming at 6 AM heading to interviews. The difference? One word: 'go.' You want to {wish}? Stop sitting there. Move.",
                "We have a saying in my trade: you won't know if the road's jammed until you're on it. You want to {wish}? Take that first step. What if it's green lights all the way?",
                "Had a passenger once — said 'train station, please,' then right before we arrived, said 'never mind, take me home.' You know what that round trip cost him? Less than the cost of hesitation. Two weeks later, same guy, same destination, no turning back this time. Getting out, he told me: 'Driver, that wasted fare taught me one thing — roads you need to take, you take eventually.' You want to {wish}? Skip the detour. Go direct.",
                "Worst kind of passenger in my job: gets in, says go east, two blocks later says go west, two more blocks says east again. Guess what happens? Meter runs a full loop and they're right back where they started. You want to {wish}? Pick a direction and stick with it. The most expensive route isn't the long one — it's the back-and-forth. Meter's running. Let's go.",
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
                "你知道编剧最讨厌写什么角色吗？一直站在原地自言自语、什么都不干的角色。观众十秒钟就会拿起手机。你现在就是这个角色——光想不动，台词全是内心独白，剧情零推进。你想{wish}？给我一个动作戏。观众已经在退场了。",
                "烂片有个共同特征：主角总在等别人来推动剧情。好片的主角自己制造转折。你想{wish}，没有人会在第三幕突然出现帮你做决定。这不是漫威，不会有彩蛋。你就是自己的编剧、导演和主演。喊action吧。",
            ],
            templatesEN: [
                "I've written 387 scripts. Every protagonist who said 'never mind, forget it' at the crucial moment — box office bomb, 3.2 on IMDB, roasted in reviews. Every one who took a deep breath and said 'let's do this' — 7.8 minimum. You want to {wish}? This is your movie's turning point. Give the audience their money's worth.",
                "Hollywood has a formula called the Hero's Journey: challenge → hesitation → leap → ordeal → transformation. You're stuck at 'hesitation.' If you don't {wish}, your character arc flatlines in Act 2. The director will fire you.",
                "Every iconic character has one line that defines them. Andy Dufresne: 'Get busy living or get busy dying.' Forrest: 'Run.' Yours should be 'I'm going to {wish}.' Say it. This is your script — nobody else can deliver your lines.",
                "Know what character every screenwriter hates writing? The one who stands around monologuing and doing nothing. Audiences reach for their phones in ten seconds. That's you right now — all inner dialogue, zero plot movement. You want to {wish}? Give me an action scene. The audience is already walking out.",
                "Bad movies share one trait: the protagonist waits for someone else to drive the plot. In great movies, the protagonist creates the turning point. You want to {wish}? Nobody's showing up in Act 3 to make the decision for you. This isn't Marvel — there's no post-credits scene. You're the writer, director, and lead. Call action.",
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
                "我写段子有个诀窍：把最尴尬的经历写出来，一定炸场。你想{wish}但不敢，这个纠结本身就是一段顶级素材。但你知道什么比「我不敢」更好笑吗？「我去了，然后……」后面不管接什么都是好段子。去{wish}吧，给自己攒点素材。",
                "脱口秀行业有句话：观众笑不笑不重要，你得先敢把话筒拿起来。百分之九十的演员在台下紧张得要吐，上台后发现观众比自己还紧张。你想{wish}？你以为的困难，上场后大概率会变成「就这？」。先拿起话筒，笑声自己会来。",
            ],
            templatesEN: [
                "You know what's actually funny? Not that you want to {wish} — it's that you've been thinking about it this long without doing anything. If I wrote this into a bit, the punchline would be 'he used an app to decide.' You're becoming someone else's joke. Go do it — at least be an impressive joke.",
                "I'm terrified before every set. But you know the comedian's secret? Just get on stage. You won't know if the bit lands until you try it. You want to {wish}? Get on stage first. Whether you kill or bomb — that comes after.",
                "The biggest thing comedy taught me: life is one giant improv show. Nobody writes your lines. No rehearsals. You want to {wish}? Accept the prompt and go with it. Worst case? Great material for later.",
                "I have a trick for writing bits: take your most embarrassing experience and put it on stage — guaranteed laughs. You want to {wish} but you're scared? That hesitation alone is premium material. But you know what's funnier than 'I was too scared'? 'I went and then...' — whatever follows is gold. Go {wish}. Stock up on material.",
                "There's a saying in stand-up: it doesn't matter if the audience laughs — you have to pick up the mic first. Ninety percent of comedians are backstage wanting to puke, then they get on stage and realize the audience is more nervous than they are. You want to {wish}? The difficulty you're imagining will probably become 'wait, that's it?' once you start. Pick up the mic. The laughs will come.",
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
                "10岁的你写过一篇作文叫《我的梦想》，老师给了一百分。为什么？因为10岁的你写的全是「我要做」而不是「我能不能做」。你想{wish}？用那个写满一百分作文的心态去做。长大以后你学会了太多不需要学的东西，比如犹豫。",
                "10岁的你摔倒了会哭三秒然后爬起来继续跑。现在的你还没摔呢就开始想「万一摔了怎么办」。你想{wish}？10岁的你听了会翻白眼——他从来不查攻略、不看评论、不问值不值得。他只说一句话：「好玩吗？好玩就去！」听他的。",
            ],
            templatesEN: [
                "When you were 10, your plan was to be an astronaut, drive a sports car, and own a dinosaur. Now you're grown up, and you're hesitating about {wish}? 10-year-old you would be so disappointed — not about the decision, but about needing an app to push you. Go. Don't let that kid down.",
                "10-year-old you didn't do risk assessments or cost-benefit analyses. 10-year-old you only knew one thing: want it, do it. You want to {wish}? Channel that fearless kid. That's the real you.",
                "Math problem: your current age minus 10 equals years wasted on hesitation. You've lived this many more years than 10-year-old you, and somehow you've gotten more timid? That kid would've just gone ahead and tried to {wish}. Learn from them.",
                "When you were 10, you wrote an essay called 'My Dream' and the teacher gave it a perfect score. Why? Because 10-year-old you wrote 'I will do' instead of 'Can I do.' You want to {wish}? Write it with that perfect-score mindset. Growing up, you learned a lot of things you didn't need to — like hesitation.",
                "10-year-old you would fall, cry for three seconds, get up, and keep running. Current you hasn't even fallen yet and you're already worrying about 'what if I fall.' You want to {wish}? 10-year-old you would roll their eyes — they never checked reviews, read guides, or asked if it was worth it. They only ever said one thing: 'Is it fun? Then let's go!' Listen to them.",
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
                "80岁的你翻相册翻到今天的日期，照片上是什么？是你迈出那一步去{wish}的瞬间，还是又一张沙发上刷手机的自拍？80岁的人不缺时间回忆，缺的是值得回忆的画面。今天就去拍一张值得放进相册的照片吧。",
                "80岁的你最常跟孙辈讲的故事，永远不会是「那年我在家想了很久」。能让孩子们眼睛发亮的开头只有一个：「那年我去{wish}了……」后面不管接什么都精彩。去做，给未来的你攒一个能讲一辈子的故事。",
            ],
            templatesEN: [
                "80-year-old you is in a rocking chair, looking back. Which regret hits harder: 'I tried to {wish} and it was just okay' or 'I wanted to {wish} but never did'? Studies show people on their deathbeds regret what they didn't do, not what they did. Don't give 80-year-old you a reason to curse.",
                "80-year-old you just sent a voice message: 'Kid, stop dawdling. Go {wish}. At my age, the biggest regret isn't mistakes — it's inaction. Every minute you hesitate now becomes a sigh I'll breathe later.' You can leave it on read, but you gotta go.",
                "Imagine 80-year-old you writing a memoir. Do you want this chapter to read 'Chapter X: The Time I Bravely Chose to {wish}' or 'Chapter X: Blank Page'? Good memoirs need good stories. Go write one.",
                "80-year-old you is flipping through a photo album, lands on today's date. What's in the picture? You taking that step to {wish}, or another selfie on the couch scrolling your phone? At 80, you'll have plenty of time to reminisce — what you'll lack is moments worth reminiscing about. Go take a photo worth putting in the album today.",
                "The stories 80-year-old you tells the grandkids will never start with 'That year I sat at home thinking for a long time.' The only opening that makes kids' eyes light up is: 'That year I went and did {wish}...' Whatever comes after is exciting. Go do it. Bank a story you can tell for the rest of your life.",
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
                "你发了一条朋友圈：「好纠结要不要{wish}……」三秒钟后，二十七个赞，十四条评论全是「去啊别废话」，你前任都给你点了个赞。当全世界——包括你前任——都觉得你该去的时候，你还犹豫什么？截图保存这条评论区，当你的出发通知书。",
                "如果你把「要不要{wish}」发到B站弹幕区，屏幕会瞬间被「冲冲冲」「加油」「前方高能」刷满，连你什么都看不见。这就是互联网的答案：你的犹豫已经被弹幕淹没了，只剩下一个方向——前进。去{wish}吧，前方高能预警。",
            ],
            templatesEN: [
                "If you posted 'Should I {wish}?' on Twitter, the top reply would be 'DO IT 🔥', the second would be 'I did this last year, best decision ever', and the third would be someone arguing about something completely unrelated. But the first two are right. Listen to the timeline.",
                "If you posted 'Should I {wish}?' on Reddit, the comments would be: 'This is the way.' 'Just did this, no regrets.' 'RemindMe! 1 month.' 'NTA, go for it.' 600 upvotes, zero people saying don't. The internet has already decided for you.",
                "If you asked 'Should I {wish}?' on Quora, someone would write a 3,000-word answer analyzing it from economics, psychology, and sociology — concluding you absolutely should. They'd end with 'Hope this helps.' It does. Now go.",
                "You just posted on Instagram Stories: 'So torn about whether to {wish}...' Three seconds later — twenty-seven likes, fourteen replies all saying 'GO, stop overthinking,' and even your ex liked it. When the entire world — including your ex — thinks you should go, what are you still hesitating for? Screenshot that comment section. That's your boarding pass.",
                "If you typed 'Should I {wish}?' in a live-stream chat, the screen would instantly flood with 'GO GO GO,' 'YOU GOT THIS,' and 'HYPE INCOMING' until you can't even see your own message. That's the internet's answer: your hesitation has been buried under a wall of encouragement. Only one direction remains — forward. Go {wish}. Hype incoming.",
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
                "江湖传闻，昔年有一剑客，每逢大事必犹豫三日。第一日犹豫，敌人磨好了剑；第二日犹豫，敌人练好了功；第三日犹豫，敌人已经站在他面前了。少侠欲{wish}，切记：犹豫不决不是深思熟虑，是把先手拱手让人。提剑，趁天色未暗。",
                "「敢问少侠，你的剑鞘可还记得剑的形状？」老者抚须而笑。剑若久不出鞘，鞘便忘了剑，剑也忘了风。少侠欲{wish}，便是该拔剑的时刻。锈迹不可怕，可怕的是剑在鞘中朽烂一生。拔剑吧，让天地重新听见你的剑鸣。",
            ],
            templatesEN: [
                "On this day, our young hero sat alone, holding a glowing iron tablet (note: a phone), pondering: 'To {wish} or not?' The path of the wanderer stretches far — one step forward, and a new world unfolds. Those who hesitate are doomed to waste their days at the inn. Draw your sword, hero. The world won't wait.",
                "The ancients said: 'A journey of a thousand miles begins with a single step.' Our hero wants to {wish} but stands frozen. In the martial world, fear is the greatest enemy. Afraid of losing? You just start over. Afraid of winning? Then the path widens. Draw your blade, hero.",
                "In all of martial arts, speed beats everything. Our hero wants to {wish}, but the danger isn't lack of skill — it's moving too slow. Opportunity vanishes in a blink. By the time you finish reading this, three openings have passed. Stop reading. Strike!",
                "Legend tells of a swordsman who hesitated three days before every battle. On the first day, his enemy sharpened their blade. On the second, they perfected their technique. On the third, they were standing at his door. Our hero wants to {wish} — remember: hesitation is not wisdom, it is handing your advantage to the other side. Draw your sword while daylight remains.",
                "'Tell me, young hero — does your scabbard still remember the shape of your sword?' The old sage stroked his beard and smiled. A sword left sheathed too long forgets the wind, and the scabbard forgets the sword. You wish to {wish}? Then this is the moment to draw. Rust is not the enemy — a sword rotting in its sheath for a lifetime is. Draw, and let heaven and earth hear your blade sing once more.",
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
                "量子隧穿效应：一个粒子的能量明明不够翻过势垒，但它偏偏有一定概率直接穿过去。你觉得自己条件不够、准备不足、不配{wish}？物理学告诉你，就算能量不够，照样有概率穿墙而过。概率不大？但你不试概率就是零。去{wish}，做宇宙里那颗敢穿墙的粒子。",
                "物理学有个概念叫「观察者效应」：你观察一个粒子的行为，这个行为就会因为你的观察而改变。你一直在「观察」自己要不要{wish}这件事，但你越观察越焦虑，越焦虑越犹豫。解法很简单——别当观察者了，当那个粒子。粒子不观察自己，粒子只管运动。动起来。",
            ],
            templatesEN: [
                "According to quantum superposition, until you decide, you exist in a superposition of '{wish}' and 'didn't {wish}.' Bad news: Schrödinger's cat has been stuck in that box for nearly a century and it's miserable. Don't be the cat. Collapse your wave function — choose to {wish} as your eigenstate. Observation is existence. Action is reality.",
                "Heisenberg's uncertainty principle says the more precisely you try to know the outcome of {wish}, the less you can pin down the right moment to start. Physics has mathematically proven that overthinking is useless. Go {wish} and let the universe calculate the remaining variables.",
                "In quantum decoherence, a system's superposition collapses the moment it interacts with the environment. Your problem? You've been isolating yourself in a quantum vacuum, refusing to interact with reality. You want to {wish}? Step out of the vacuum. Touch reality. Certainty is freedom.",
                "Quantum tunneling: a particle doesn't have enough energy to cross the barrier, yet it has a nonzero probability of passing straight through. You think you're not ready enough, not qualified enough to {wish}? Physics says even with insufficient energy, there's still a chance you'll punch through the wall. Small chance? Maybe. But if you don't try, the probability is exactly zero. Go {wish}. Be the particle that tunnels through.",
                "Physics has a concept called the 'observer effect': observing a particle's behavior changes that behavior. You keep 'observing' whether you should {wish}, but the more you observe, the more anxious you get, and the more anxious you get, the more you hesitate. The fix is simple — stop being the observer. Be the particle. Particles don't observe themselves. Particles just move. Start moving.",
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
                "你知道闪电形成的条件吗？正负电荷积累到一定程度，必须释放。你心里想{wish}的念头就是那些不断积累的电荷——你越压着不动，内心的电压越高。不释放迟早击穿你自己。与其被动等雷劈，不如主动打一道闪电出去。去{wish}，释放你的能量。",
                "天气预报最多准七天，七天以后谁都说不清。你在这想{wish}的后果想三个月以后的事？连气象卫星都算不到的东西你算什么？能看清楚今天和明天就够了。今天的天气预报是：适合{wish}，局部有勇气，全天晴朗。出门吧。",
            ],
            templatesEN: [
                "In 1972, meteorologist Lorenz asked: can a butterfly flapping its wings in Brazil cause a tornado in Texas? Theoretically, yes. You wanting to {wish} — that's your butterfly wing. How will you know it won't create a beautiful storm on the other side of your life? In chaotic systems, initial conditions determine everything. Flap.",
                "Thirty years of weather forecasting taught me one thing: weather never waits for you to be ready. Cold fronts arrive unannounced. Rain falls when it wants. You're waiting for perfect conditions to {wish}? Sorry, meteorology says perfect conditions don't exist. The best weather is the moment you step outside. Grab your raincoat and go.",
                "Atmospheric pressure changes every second, but do you notice? No. Your body adapts without you even knowing. Afraid that {wish} will bring pressure and change? Your body and brain can handle far more than you think. Humans are walking, self-adjusting barometers. Go — you'll recalibrate automatically.",
                "You know how lightning forms? Positive and negative charges build up until they MUST discharge. That urge to {wish} is the charge building inside you — the longer you suppress it, the higher the voltage. If you don't release it, it'll short-circuit you from the inside. Instead of waiting to get struck, throw your own lightning bolt. Go {wish}. Discharge that energy.",
                "Weather forecasts are accurate for seven days, tops. Beyond that, nobody knows. You're sitting here trying to predict what happens three months after you {wish}? Even weather satellites can't calculate that far out — what makes you think you can? Seeing today and tomorrow clearly is enough. Today's forecast: perfect conditions to {wish}, with scattered courage and clear skies all day. Step outside.",
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
                "我调过最受欢迎的鸡尾酒叫「去他的」——就是客人下定决心那一刻我端上去的那杯。配方其实不重要，重要的是喝下去的那个时机。你想{wish}？你的那杯「去他的」我已经调好了，就摆在你面前。端起来，干了，然后去。",
                "我见过两种人在酒吧里发光：一种是刚做完一个大决定进来庆祝的，另一种是坐了一晚上终于站起来说「我想通了」的。从没见过第三种——「我还在想」的人，他们不发光，只发呆。你想{wish}？做那个站起来的人。这杯我请。",
            ],
            templatesEN: [
                "Fifteen years behind the bar, I've watched too many people hit their third drink and announce 'Tomorrow I'm definitely going to {wish}.' Next day, sober, they chicken out. Buddy, liquid courage is borrowed — and the interest rate is called a hangover. You want to {wish} while sober? That courage is yours, no payback needed. Go now.",
                "I've got a sign behind my bar: 'Free Beer — Tomorrow.' People ask every day if they can come back for it. But tomorrow never comes. You saying 'I'll {wish} later' is the same sign. That 'later' will never arrive. Today is free beer day. Go {wish}.",
                "The quietest moment in a bar isn't after closing. It's when someone sits alone in the corner, staring into their glass, thinking about what they never did. I've seen those eyes a thousand times — empty, regretful, full of 'what if.' You want to {wish}? Go now. Don't become another pair of regretful eyes at my bar.",
                "The most popular cocktail I've ever made is called 'Screw It' — it's the one I serve the moment a customer makes up their mind. The recipe doesn't matter; the timing does. You want to {wish}? Your 'Screw It' is already mixed and sitting in front of you. Pick it up, knock it back, and go.",
                "I've seen two kinds of people glow in a bar: those who just made a big decision and came in to celebrate, and those who sat all night and finally stood up saying 'I've figured it out.' Never seen a third kind — the 'I'm still thinking' crowd doesn't glow, they just stare. You want to {wish}? Be the one who stands up. This round's on me.",
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
                "我们老师说，世界上没有怪兽，床底下也没有鬼。那些吓人的东西都是自己想出来的。你不敢{wish}是不是也自己吓自己呀？我告诉你一个秘密：闭上眼睛跑过去就不怕了！我每次经过黑黑的走廊都是这样做的。有用的！你试试？",
                "我画了一幅画送给你！画的是你去{wish}以后笑得特别特别开心的样子。你看，画里的你多开心呀！你想不想变成画里面的样子？想的话就去呀！我画画从来不画不开心的人，因为不开心的人不好看。你要做好看的人对不对？那就去！",
            ],
            templatesEN: [
                "Why won't you {wish}? Are you scared? My teacher says when you're scared, take a deep breath and count to three. One, two, three! See? Not scary anymore! Go! Last time I was scared of the slide, I counted to three and went — it was SO fun. Going to {wish} is probably a hundred times more fun than the slide! You're a grown-up — grown-ups being scared is so weird.",
                "My mommy says if you want something, say it loud. You want to {wish}, right? Then say it! One, two, three — 'I WANT TO {wish}!' See? Not so hard! I do this every time I want ice cream. Works 80% of the time. You're an adult — your success rate is definitely higher than mine.",
                "You know what, Xiao Ming in my class is scared of everything — scared of swings, jump rope, raising his hand. My teacher says Xiao Ming will grow up to be a very boring adult. Are you gonna be a boring adult too? You want to {wish}, so just go! Even kindergarteners know this. How does a grown-up not get it?",
                "My teacher says there are no monsters in the world and no ghosts under the bed. The scary stuff is all made up in your head. Are you scared to {wish} because you made up scary stuff too? I'll tell you a secret: close your eyes and run past it and it's not scary anymore! That's what I do in the dark hallway every time. It works! Try it?",
                "I drew a picture for you! It's you after you {wish}, smiling SUPER SUPER big. Look, the you in the picture is SO happy! Do you want to be like the you in the picture? If yes, then GO! I never draw sad people in my pictures because sad people don't look nice. You want to look nice, right? Then go!",
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
                "暴雨天送外卖，所有骑手都缩在屋檐下面等雨停。我冲出去了——加价三块一单，一天多赚两百。你知道这说明什么吗？所有人都犹豫的时候就是你的黄金时间。你想{wish}但怕这怕那？好，那你继续躲屋檐下，奖金让别人拿。还是冲？",
                "这行有种单叫「顺路单」，系统判定你顺路就塞给你，不接白不接。你想{wish}，说明你人生的算法已经把这单推给你了——方向对、时机到、顺路。你不接，系统不会再推第二次。别想了，滑动接单。",
            ],
            templatesEN: [
                "Bro listen, I deliver forty orders a day, every one with a countdown. One minute late, docked two bucks. Five minutes, bad review. Ten minutes, the whole trip's wasted. Life works the same way. You want to {wish}? Every day you hesitate is a day of lost XP. A month of hesitation is a month of bad reviews. Don't let your life time out. Hit 'Delivery Confirmed.'",
                "My GPS always takes the shortest route — I never pick 'avoid traffic.' Why? Because every road is jammed, and the time wasted choosing a route is worse than the jam itself. You want to {wish}? Stop looking for the optimal path. Take the shortest route. Hit a jam? Push through. Red light? Wait briefly. But never change direction. The destination is ahead. Just ride.",
                "Biggest truth in this job: orders don't wait. You don't take it, someone else will. You want to {wish}? This is your life's order. It's flashing on your screen right now. If you don't hit 'Accept,' the system assigns it to someone else. You think opportunities have a 'reassign' button? They don't. Tap it. Now.",
                "Rainy day, every rider is hiding under an awning waiting for it to stop. I rode out — surge pricing, three extra bucks per order, made two hundred more that day. Know what that means? When everyone else hesitates, that's YOUR golden hour. You want to {wish} but you're scared of this and that? Fine, keep hiding under the awning. Let someone else take the bonus. Or ride out?",
                "There's a thing in this job called an 'along-the-way order' — the algorithm sees it's on your route and drops it in your lap. Free money if you take it. You wanting to {wish} means your life's algorithm just pushed this order to you — right direction, right timing, right on your route. If you don't accept, the system won't offer it again. Stop thinking. Swipe to accept.",
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
                "本律师提请法庭注意一个关键证据：当事人的心跳在想到{wish}的时候加速了。这在法律上叫「身体证词」，比任何口供都可靠。当事人的心脏已经以每分钟九十下的速度投了赞成票。心脏不会做伪证。采纳此证据，判决结果：立即{wish}。庭审结束。",
                "根据「诉讼时效」原则，任何权利都有行使的期限。你想{wish}的权利同理——它不会永远等你。犹豫一天，时效减一天。等时效过了你再来哭诉「我曾经想过」，法庭不会受理的。趁你的人生诉讼时效还没过期，立刻行使你{wish}的权利。本律师不接受反驳。",
            ],
            templatesEN: [
                "Counsel hereby delivers closing arguments on the matter of 'Whether the client should {wish}.' Evidence: First, the client possesses full legal capacity. Second, the act violates no laws. Third, the sole consequence of inaction is lifelong regret — classified as the highest tier of emotional damages. The court recommends immediate execution of {wish}. Objection overruled. Court adjourned.",
                "I've reviewed all your concerns and overruled them: 'I'm afraid of failure' — overruled, failure is not a crime. 'I'm not ready' — overruled, no law requires readiness before action. 'What will people think' — overruled, public opinion has no legal standing. All objections to {wish} are dismissed. Verdict: proceed immediately.",
                "Legally speaking, not doing {wish} constitutes 'failure to act.' In certain contexts, inaction carries the same liability as action. The worst kind of inaction? Knowing you want to {wish}, having the ability, and choosing to do nothing. In the court of life, this is 'negligent squandering,' sentenced to a lifetime of regret. Go {wish}. Acquit yourself.",
                "May it please the court — a critical piece of evidence: the defendant's heart rate spiked when they thought about {wish}. In legal terms, this is 'somatic testimony,' more reliable than any verbal statement. The defendant's heart has cast its vote at ninety beats per minute. Hearts don't commit perjury. Evidence admitted. Verdict: proceed to {wish} immediately. Court is adjourned.",
                "Under the statute of limitations, every right has an expiration date. Your right to {wish} is no different — it won't wait forever. Every day you hesitate, the clock ticks down. Once it expires, showing up to plead 'But I once thought about it' won't be entertained by any court. While the statute of limitations on your life hasn't expired, exercise your right to {wish} immediately. Counsel will not accept rebuttals.",
            ]
        ),
        Dimension(
            id: "food_critic",
            category: "职业视角",
            emoji: "🍽️",
            title: "美食评论家视角",
            titleEN: "Food Critic",
            templates: [
                "人生是一道限时供应的omakase，厨师今天给你端上来的这道菜叫「{wish}」。你可以选择品尝，也可以选择退回去。但我做了二十年美食评论，给你一个忠告：退回去的人永远不知道那道菜是什么味道，而且厨师不会再做第二次。尝试一下吧。也许这就是你人生菜单上的米其林三星时刻。",
                "我尝过全世界四十七个国家的料理，踩过无数次雷，也遇到过让我当场落泪的美味。你知道我最大的经验是什么吗？从来没有一道菜是你「看看菜单就能评价」的。你必须亲口尝。你想{wish}？别光看菜单了，下单。嘴巴会告诉你一切，而不是你的脑子。",
                "最差的餐厅不是难吃的餐厅，是你路过了一百次但从来没进去过的餐厅。因为难吃你至少有了一个故事可以讲，但没进去你什么都没有。你想{wish}就是你路过了一百次的那家店。推门进去。就算难吃，你也赚了一个故事。",
                "你见过哪个美食家是靠看菜单吃饱的？没有。我这辈子写过最好的食评都是那些「点错了但意外好吃」的菜。你想{wish}？也许这道菜根本不在你的计划里，但人生最惊喜的味道从来都不是计划出来的。闭着眼点一道吧，舌头会替你判断。",
                "做这行有个铁律：空盘子没有评分。你不动筷子，我没法给你打星。你想{wish}？在我面前放着一道完整的菜你不碰，我只能在评论里写四个字：「未曾品尝」。这是美食评论家能给出的最差评价——不是一星，是没有星。去{wish}，至少给自己挣颗星。",
            ],
            templatesEN: [
                "Life is a limited-time omakase, and the chef just served you a dish called '{wish}.' You can taste it or send it back. Twenty years as a food critic, here's my advice: people who send it back never know what it tasted like, and the chef won't make it again. Try it. This might be your Michelin three-star moment.",
                "I've tasted cuisine from 47 countries, had countless terrible meals, and cried tears of joy at some. My biggest lesson? No dish can be reviewed by reading the menu. You have to taste it. You want to {wish}? Stop reading the menu. Order. Your mouth will tell you everything — not your brain.",
                "The worst restaurant isn't the bad one — it's the one you've walked past a hundred times and never entered. A bad meal is at least a story. Walking past gives you nothing. Your desire to {wish} is like that restaurant you keep passing. Push open the door. Even if it's bad, you've earned a story.",
                "Have you ever seen a food critic get full by reading menus? Neither have I. The best reviews I've ever written were for dishes I ordered by accident that turned out amazing. You want to {wish}? Maybe it wasn't in your plan, but life's most surprising flavors are never planned. Close your eyes and order. Your taste buds will do the judging.",
                "Iron rule of this profession: an empty plate gets no rating. If you don't pick up your chopsticks, I can't give you a single star. You want to {wish}? There's a full dish in front of you and you won't touch it. All I can write in my review is two words: 'Never tasted.' That's the worst review a food critic can give — not one star, but no stars at all. Go {wish}. Earn yourself at least one star.",
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
                "你有没有注意到，你每次说「但是」的时候其实是在否定自己前半句的真心话？你说「我想{wish}，但是……」——把「但是」后面的部分全删掉。剩下的那句话才是你真正的声音。心理学上我们管这叫「听见自己」。你已经告诉自己答案了，你只是不敢相信自己。相信它。去{wish}。",
                "焦虑的本质是什么？是对未知的过度想象。你怕{wish}以后会怎样，但我做了十五年咨询，发现一个规律：来访者想象中的「最坏结果」，几乎从来没有真正发生过。真正发生的通常是第四种、第五种他们根本没想到的可能——而且大多数时候，比想象的好。你的大脑是个糟糕的预言家，别让它替你做决定。去{wish}。",
            ],
            templatesEN: [
                "I notice when you mention {wish}, you lean forward slightly. Know what that means? Your subconscious has already decided — your conscious mind is just dragging it back with excuses. In fifteen years of practice, the body is always more honest than the brain. You don't not know whether to {wish}. You're afraid to admit you already know. Give yourself permission. You're allowed to do what you want.",
                "You just listed five reasons not to {wish}, but interestingly, your speech sped up and your pitch rose with each one. In psychology, that's cognitive dissonance — your rational mind is fabricating excuses while your emotions protest. What you need isn't more reasons. It's to say: 'I want this. That's enough.' Go {wish}.",
                "Let's try an exercise. Close your eyes. Imagine two parallel worlds: in World A, you did {wish}. In World B, you didn't. Now tell me — in which world are you smiling? ... See? You don't even need me to analyze this. Your smile already chose. When you book your next session, I hope you'll tell me you've already done it.",
                "Have you noticed that every time you say 'but,' you're actually negating the honest part of your sentence? You said 'I want to {wish}, but...' — delete everything after the 'but.' What remains is your real voice. In psychology we call this 'hearing yourself.' You've already given yourself the answer. You're just afraid to believe it. Believe it. Go {wish}.",
                "What is anxiety, really? It's over-imagining the unknown. You're afraid of what happens after you {wish}, but in fifteen years of practice, I've noticed a pattern: the 'worst-case scenario' clients imagine almost never actually happens. What does happen is usually the fourth or fifth possibility they never even considered — and most of the time, it's better than they imagined. Your brain is a terrible fortune teller. Don't let it make your decisions. Go {wish}.",
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
                "无限个平行宇宙里，统计学上讲，去{wish}了的那些版本的你，平均幸福指数比没去的高出37%——这个数据是我编的，但你心里知道它大概是对的。因为你的直觉就是所有平行宇宙版本的你投票后的平均值。直觉说去，那就是多数票。民主一点，听从多数。",
                "你知道最可怕的平行宇宙是什么吗？不是那个去{wish}然后搞砸了的宇宙——那个至少有故事。最可怕的是那个每天晚上躺在床上想「如果当初去了会怎样」的宇宙。在那个宇宙里，你永远停在了这个问题上，像一张卡住的唱片。别让你的宇宙卡带。按下播放键。",
            ],
            templatesEN: [
                "According to the Many-Worlds Interpretation, the moment you decide, the universe splits in two. In Universe A, you did {wish}. In Universe B, you didn't. Universe A you is tapping Universe B you on the shoulder: 'Hey, come over here. The view is way better.' Are you A or B? Don't let another you live the exciting version of your life.",
                "In parallel universes, there are infinite versions of you. Some became astronauts. Some feed pigeons. And one is sitting there wondering whether to {wish} — wait, that one's you. Know which parallel universe is the saddest? The one where you always wanted to but never did. Among infinite universes, don't let yours be the most boring. Go {wish}.",
                "I'm the you from a parallel universe who already did {wish}. I crossed the quantum barrier to tell you one thing: do it. Can't spoil the details — Multiverse Bureau regulations. But I can tell you this: I don't regret it. And the version of you who didn't? They're on another app asking the same question. Don't be that version. Be me.",
                "Statistically, across infinite parallel universes, the versions of you who went ahead and did {wish} have a happiness index 37% higher than those who didn't — okay I made that number up, but you know in your gut it's roughly right. Your intuition is basically the averaged vote of all your parallel selves. Intuition says go? That's the majority. Be democratic. Follow the majority.",
                "Know what the scariest parallel universe is? Not the one where you tried to {wish} and it went sideways — at least that one has a story. The scariest is the one where you lie in bed every night wondering 'what if I'd gone for it.' In that universe, you're stuck on this question forever, like a skipping record. Don't let your universe get stuck. Press play.",
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
                "2126年的历史教科书里有一章叫《被遗忘的犹豫者》。里面全是想做事但没做的人——一个名字都没留下来。隔壁那章叫《改变潮水的人》，每一个名字都闪闪发光。区别就是一个「做」字。你想{wish}？别让自己被编进那一章无名氏的注脚里。",
                "作为历史学家我告诉你一个秘密：历史从来不记录犹豫的过程，只记录结果。一百年后没人关心你纠结了多久、害怕过什么。档案里只有两种写法：「此人于某年{wish}」或者一片空白。你想在历史里留下一行字还是一片空白？去{wish}，给未来的历史学家点东西可写。",
            ],
            templatesEN: [
                "Welcome to 'A Century in Review,' episode 2126. Today's story: a hundred years ago, an ordinary person on an ordinary day made an extraordinary decision — to {wish}. Everyone thought it was insignificant, but looking back, it was the turning point that changed everything. History works that way — great turning points never announce themselves. Yours is today. Go {wish}.",
                "As a historian in 2126, I've found a fascinating pattern in early 21st-century behavior: people spent three times longer agonizing over decisions than actually doing the thing. You want to {wish}? If you'd spent your hesitation time acting, you'd have finished three times over by now. History remembers doers, not deliberators. Go make history.",
                "I've searched every archive from 2026 and found one overlooked record: 'On this day, someone decided to {wish}.' It seemed trivial at the time but was later called 'The Butterfly Event' by historians — it triggered a chain reaction. Don't believe me? Honestly, I'm not sure either. But the point is: if you don't do it, you'll never know if this entry makes the history books. Go write your history.",
                "The 2126 history textbook has a chapter called 'The Forgotten Hesitators.' It's full of people who wanted to do things but didn't — not a single name survived. The chapter next to it is called 'Those Who Turned the Tide,' and every name shines. The only difference is one word: 'did.' You want to {wish}? Don't end up as an anonymous footnote in the wrong chapter.",
                "As a historian, let me tell you a secret: history never records the process of hesitation, only the outcome. A hundred years from now, nobody will care how long you agonized or what scared you. The archives only have two formats: 'This person did {wish} in such-and-such year' or blank space. Do you want to leave a line in history or a blank? Go {wish}. Give future historians something to write about.",
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
                "赫拉克利特说「人不能两次踏入同一条河流」。此刻你想{wish}的冲动，跟五分钟后的冲动已经不是同一条河了。你等得越久，今天这股想做的劲儿就流走了，明天流过来的可能是犹豫和遗憾。趁这条河还在脚下——踏进去。",
                "斯多葛学派有个核心教义：只关注你能控制的事。你能控制{wish}的结果吗？不能。你能控制自己迈出第一步吗？能。那就只做这一件事。结果交给命运，行动留给自己。两千年前奴隶出身的爱比克泰德都想通了这个道理。你自由着呢，还想不通？",
            ],
            templatesEN: [
                "Socrates said 'The unexamined life is not worth living.' Great — you've examined, and you want to {wish}. Now let me add what Socrates didn't say but should have: 'The examined-but-unlived life is even less worth living.' You've completed philosophy's first step: know thyself. Now step two: act. Socrates drank hemlock for truth. You won't even {wish}?",
                "Aristotle believed the highest human good is 'eudaimonia' — the flourishing of the soul. Note: 'flourishing,' not 'safety.' Your soul won't flourish while you hide in your comfort zone, just as a tree won't bloom in a sealed room. You want to {wish}? That's your soul demanding sunlight and rain. Give it what it needs. Make Aristotle proud.",
                "Plato said we live in a cave, seeing only shadows of reality. You agonizing over {wish} is staring at shadows on the cave wall. Walking out is blinding and uncomfortable, but the real sun is outside. Philosophers figured this out 2,400 years ago. How much longer will you sit in the cave? Get out.",
                "Heraclitus said you can never step into the same river twice. The impulse you feel right now to {wish} is not the same river you'll feel in five minutes. The longer you wait, the more today's motivation flows away — and what drifts in tomorrow might be hesitation and regret. While this river is still at your feet — step in.",
                "The Stoics had a core teaching: focus only on what you can control. Can you control the outcome of {wish}? No. Can you control taking the first step? Yes. Then do only that. Hand the results to fate; keep the action for yourself. Epictetus, a former slave, figured this out two thousand years ago. You're free — what's your excuse?",
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
                "先生/女士，以我的专业意见，您目前最需要的既不是更多的信息，也不是更好的时机，而是——请恕我冒昧——一点点行动力。在我们这个行业有句老话：「最好的管家从不问主人要不要喝茶，他直接端上来。」请允许我为您安排{wish}。您只需要迈出第一步就好了。",
                "先生/女士，请容我翻阅一下您的行程簿——嗯，今日的日程上写着：上午犹豫，下午继续犹豫，晚间懊悔。恕我直言，这份日程表有失体统。我已擅自将其修改为：上午{wish}，下午享受成果，晚间举杯庆祝。行程已更新，车已候在门口。请起身。",
                "先生/女士，我服务过的每一位主人都有一个共同特点：他们在做重大决定时绝不会来回踱步超过一杯茶的时间。而您——请恕我计时——已经踱了足足三壶茶的时间了。您想{wish}，这并非什么冒险，不过是一次得体的人生选择罢了。请允许我为您开门。外面的天气正好。",
            ],
            templatesEN: [
                "Sir/Madam, if I may be so bold, the time you've spent deliberating over whether to {wish} would have sufficed for me to brew three pots of Earl Grey, press twelve shirts, and polish the silver twice. In thirty years serving distinguished households, I've observed that people of true caliber never hesitate when action is required. They simply say, 'Please arrange it.' Shall I arrange {wish} for you?",
                "If I may presume: in the Downton Abbey era, a gentleman showing indecision in public was considered more improper than using the wrong fork. You wish to {wish} — that is a respectable ambition. The hesitation, however, is unseemly. Permit me to fetch your coat. The carriage is waiting. Your bags are packed. You need only stand.",
                "Sir/Madam, in my professional estimation, what you require is neither more information nor better timing, but — forgive the impertinence — a modicum of initiative. In our profession there is a saying: 'The finest butler never asks if one wants tea; he simply serves it.' Allow me to arrange {wish} for you. You need only take the first step.",
                "Sir/Madam, permit me to consult your itinerary — ah yes, today's schedule reads: morning, hesitate; afternoon, continue hesitating; evening, regret. If I may be frank, this is a most undignified agenda. I have taken the liberty of revising it to: morning, {wish}; afternoon, enjoy the results; evening, raise a glass. The itinerary has been updated. The car awaits at the front. Please rise.",
                "Sir/Madam, every employer I have served shares one trait: when facing a significant decision, they never pace for longer than the time it takes to drink one cup of tea. You — forgive my timing — have paced for the equivalent of three full pots. You wish to {wish}; this is not an adventure, merely a dignified life choice. Allow me to hold the door. The weather outside is quite agreeable.",
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
                "「回忆杀」画面浮现：年幼的主角曾经对着夕阳发誓——「总有一天我要{wish}！」画面切回现在，主角低头看着自己的手。那双手不再是小时候的手了，但那个誓言还在。BGM渐强，风吹起衣角。这是全番最燃的镜头——你兑现承诺的那一刻。别让这段回忆杀白放。去{wish}！",
                "「弹幕滚过屏幕：前方高能预警！」所有观众都知道接下来会发生什么——主角要爆发了。你想{wish}，这就是你的高能时刻。弹幕已经替你激动了，OP已经响了，分镜已经画好了。唯一缺的就是你的一句台词：「我上！」说出来。让弹幕炸裂。",
            ],
            templatesEN: [
                "In that instant, time itself seemed to freeze. The protagonist clenched their fists, eyes blazing with an unprecedented fire. '{wish}...' they whispered — quiet, yet trembling with unstoppable will. A long-dormant power began awakening — heartbeat accelerating, blood boiling, the soundtrack swelling! This is THE scene of Season 2, Episode 1! Awaken, hero — {wish} is your ultimate technique!",
                "'Impossible... this person's power level is still rising!' The villain stared in disbelief at the climbing numbers. Yes — the moment the protagonist decided to {wish}, their power level broke 9,000! No — it shattered the measurement limit! Because the power of true determination cannot be measured by numbers. This is the essence of shonen spirit. Now — unleash your power!",
                "'Next episode preview: The hero finally makes a decision. Just when everyone thought they'd give up, they smiled and took that step. They said: \"I will {wish}. Even if the whole world tries to stop me, I will never turn back.\" Stay tuned — Your Life, Season 2: The Awakening Arc.' Don't keep the audience waiting. Your next episode starts now.",
                "Flashback sequence: a young version of the protagonist once stood before a sunset and swore — 'One day, I WILL {wish}!' Cut to the present. The protagonist looks down at their hands. Those aren't a child's hands anymore, but the oath still burns. The BGM swells, wind catches their coat. This is the most fire scene in the whole series — the moment you honor that promise. Don't let this flashback play for nothing. Go {wish}!",
                "Subtitles scroll across the screen: 'HYPE ALERT — PEAK MOMENT INCOMING!' Every viewer knows what's about to happen — the protagonist is about to go off. You want to {wish}? This is your peak moment. The audience is already hyped, the opening theme is blasting, the storyboards are drawn. The only thing missing is your one line: 'I'm going in!' Say it. Let the comments explode.",
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
                "你的人生是一张专辑，现在正在录制中。每一个决定是一首track。你想{wish}？这是主打歌，是封面曲，是MV要重点拍的那首。你要是跳过这首track，这张专辑就是一张水货，乐评人给两星还嫌多。把这首录了，让它成为你的经典。Hit record，开始。",
                "Freestyle时间到。Beat已经drop了，全场在等你开口。你想{wish}——这就是你的verse。你可以站在那里忘词丢脸，也可以张嘴就来管它押不押韵。真正的MC从不等准备好——beat不等人，人生也不等。张嘴，{wish}就是你最硬的bar。Mic drop。",
            ],
            templatesEN: [
                "Yo check it — you're standing still like a statue, brain thinking about {wish} but feet stuck in cement. Hesitation is the weakest flow, indecision the worst beat. You're freestyling your life but you keep falling off beat. Pick up the mic — {wish} is your punchline. You don't spit it, you lose this round. Drop the beat. Let's go.",
                "Let me spit you a real verse: your excuses outnumber your dreams, your fears outweigh your skills, your 'tomorrow' is busier than your today — but that's all cap. You want to {wish}? Stop tripping, start flipping the script. Life's got no take two — this is a live performance. You either get on stage and slay or walk off and cry. Pick one. I suggest the former. Peace.",
                "Attention — battle's on. In one corner, your dream of {wish}. In the other, your excuses. Dream says: 'I got a hundred reasons to move.' Excuses say: 'I got a hundred and one reasons to stay.' But this is a rap battle, not a debate — it's not about who has more reasons, it's whose flow hits harder. Dreams always spit harder than excuses. Vote for the dream. Go {wish}.",
                "Your life is an album, currently in the studio. Every decision is a track. You want to {wish}? That's the lead single, the title track, the one they shoot the MV for. Skip this track and the album's a dud — critics give it two stars and that's generous. Record this one. Make it a classic. Hit record. Go.",
                "Freestyle time. The beat already dropped, the whole crowd's waiting for you to open your mouth. You want to {wish} — that's your verse. You can stand there and choke, or you can spit it raw, who cares if it rhymes. Real MCs never wait to be ready — the beat doesn't wait, life doesn't wait. Open your mouth. {wish} is your hardest bar. Mic drop.",
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
                "【经验帖】组长亲自下场：三年前我也发过一模一样的帖子，问要不要{wish}。当时有个人在评论区骂我「别废话快去」。我被骂醒了，去了。现在我成了组长。所以我今天也骂你一句：别废话快去{wish}。三年后你也来当管理员，把这句话传给下一个纠结的人。传承。",
                "本帖已被组员举报。举报理由：「又一个纠结帖，浪费组内资源，建议直接封号并强制执行{wish}。」组长审核意见：举报成立。根据组规第七条「连续犹豫超过24小时者视为违规」，你已严重超时。处罚：立即去{wish}，完成后在组内发打卡帖，否则永久禁言。去吧。",
            ],
            templatesEN: [
                "[POLL] Hi members, today's vote: OP wants to {wish} but keeps hesitating. Vote now: A) Just go, why are you even thinking B) Don't go, play it safe C) Share your own experience. — Results are in: 247 for A, 3 for B (two were OP's alt accounts), 189 chose C and all said they're glad they went. Admin summary: Go. Post pinned and locked.",
                "Group rule #1: 'No indecision posts — if you're asking, you already want to go.' You're asking about {wish}, so per the rules, you've been automatically classified as 'wants to go.' In three years, this group has hosted 4,826 indecisive members. 4,825 eventually went. The remaining one is still posting the same question. Which one do you want to be? Admin says: go {wish}.",
                "OP, on behalf of all 80,000 members of the 'Hesitate and You Lose' group: while you were posting about whether to {wish}, seventeen people in the 'Action Takers' group already posted success stories. You're still in our group? Time to leave. I'm not kicking you out — you should be in the 'Already Did It' group. That group suits you better. But first, go {wish}.",
                "[EXPERIENCE POST] Admin weighing in personally: three years ago, I posted the exact same question — should I {wish}? Someone in the comments yelled 'Stop talking and just GO.' That woke me up. I went. Now I'm the admin. So here's me yelling at you: stop talking and go {wish}. Three years from now, come back as a moderator and pass this message to the next hesitator. Pass it on.",
                "This post has been reported by members. Reason: 'Yet another indecision post, wasting group resources. Recommend immediate ban and forced execution of {wish}.' Admin ruling: report upheld. Per Rule #7, 'Hesitating for more than 24 consecutive hours constitutes a violation,' you are severely overdue. Penalty: proceed to {wish} immediately, then post a check-in to the group. Failure to comply results in a permanent mute. Go.",
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
                "评论区有人问「如何评价一个想{wish}却迟迟不动的人？」高赞回答只有一句话：「想都是问题，做才是答案。」这句话被引用了四万七千次，印在了三千个人的手机壳上，纹在了至少两个人的胳膊上。你不需要纹在胳膊上，你只需要记在心里然后去{wish}。",
                "知乎体回答：先问是不是，再问该不该。你想{wish}——这个「想」已经回答了「是不是」。至于「该不该」——当你连提问都不需要就已经知道答案的时候，这个问题本身就是多余的。你不是来知乎找答案的，你是来找人替你说出那个你已经知道的答案的。好，我替你说了：去{wish}。不用谢。",
            ],
            templatesEN: [
                "Thanks for the invite. Currently hesitating, just made up my mind. On 'whether to {wish},' as a writer with 120K followers, I'll answer from three angles: 1) Opportunity cost — not doing it costs more than doing it. 2) Survivorship bias — you only see failure cases because successful people are too busy for Q&A forums. 3) Loss aversion — you don't fear failure, you fear the feeling of loss, but inaction IS the biggest loss. In conclusion: go {wish}. If helpful, please upvote. Thanks.",
                "Disclosure: someone who also once hesitated about {wish}. Conclusion first: go. Now the proof: you're hesitating not because it's bad, but because it matters enough that you're afraid to mess it up. That's exactly why it's worth doing — when's the last time you seriously agonized over having a fourth McDonald's meal? Only things that truly matter are worth agonizing over. And things that truly matter are worth doing. QED.",
                "There are already 328 answers to this question, but I can't help adding one more. Scrolled through them all — every top answer says 'go,' every low-voted answer says 'be careful.' The voting system isn't perfect, but 8,000 upvotes don't lie. You want to {wish}? The internet's collective wisdom has spoken. Follow me, then go {wish}. In that order.",
                "Someone in the comments asked: 'How would you evaluate a person who wants to {wish} but keeps stalling?' The top answer is one sentence: 'Thinking creates problems. Doing creates answers.' That line has been quoted 47,000 times, printed on 3,000 phone cases, and tattooed on at least two people's arms. You don't need the tattoo. Just remember it and go {wish}.",
                "Classic answer format: first ask 'is it,' then ask 'should I.' You want to {wish} — the 'want' already answers 'is it.' As for 'should I' — when you already know the answer before even asking the question, the question itself is redundant. You didn't come here looking for an answer. You came looking for someone to say out loud what you already know. Fine, I'll say it: go {wish}. You're welcome.",
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
                "r/GetMotivated 热帖：「一年前我发了一个帖子问要不要{wish}，所有人都叫我去。今天我来更新：去了，值了。这是我做过最正确的决定。」评论区：「OP delivers!」「W」「saved this post for when I need motivation」——你想{wish}？一年后也来发个更新帖。但首先你得先有第一帖。去吧，OP。",
                "r/AskReddit: 你做过最勇敢的决定是什么？Sort by Top：「那次决定{wish}」——三万七千赞。所有热门回答都有一个共同点：没有人说「我当时想清楚了所有后果才去的」。他们都说「我没想太多就去了」。你现在就是那个「没想太多」的前一秒。下一秒你就是热门回答。去{wish}。",
            ],
            templatesEN: [
                "r/LifeAdvice · Posted by u/YourSubconscious · 12h\n'Thinking about {wish} but can't decide. AITA?'\n🔝 Top comment (47 awards): NTA. You're not the a-hole for wanting things. YTA if you don't go for it.\n↳ Reply: This. 100% this.\n↳ Reply: Can confirm, did the same thing, life changed.\nUnanimous verdict. What are you waiting for? Go {wish}.",
                "TIFU by NOT doing {wish} — oh wait, this post hasn't happened yet because you still have time to avoid it. The hottest TIFU posts are always regret stories about things people DIDN'T do. Your choice right now: become the protagonist of a TIFU post, or the hero of a 'Just did this, AMA' post. You want to {wish}? Go. Don't let future you post a TIFU.",
                "ELI5: Why should I {wish}? Answer: Imagine you're a five-year-old standing at the edge of a pool. The water looks cold. You can stand there staring, or you can jump. The kid who jumps is screaming with joy three seconds later. The kid on the edge is still deliberating three hours later. You've been standing long enough. Jump in. 14.2k upvotes. Gold, silver, platinum — the works. Go {wish}.",
                "r/GetMotivated top post: 'A year ago I posted asking whether I should {wish}. Everyone said go. Here's my update: I went. Worth it. Best decision I ever made.' Comments: 'OP delivers!' 'W' 'Saved this post for when I need motivation.' — You want to {wish}? Come back in a year with an update post. But first you need a first post. Go, OP.",
                "r/AskReddit: What's the bravest decision you ever made? Sort by Top: 'That time I decided to {wish}' — 37K upvotes. Every top answer has one thing in common: nobody said 'I carefully thought through every consequence before going.' They all said 'I didn't overthink it, I just went.' You're one second away from being that person. Next second, you're a top answer. Go {wish}.",
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
                "你知道短视频的黄金法则吗？前三秒定生死。你的人生也一样——你想{wish}，从现在起三秒钟之内做出决定。一、二、三——好了。你要是还在看这段话说明你已经过了三秒了。在TikTok的世界里你已经被滑走了。别被自己滑走。做个让人停下来看的人。去{wish}。",
                "这条视频的完播率是97%——你知道这意味着什么吗？意味着几乎每个看到这里的人都没有划走。他们在等你做决定。你想{wish}对不对？三十万人在屏幕另一端盯着你呢。你要是不去，完播率白给了。别浪费你的流量。去{wish}，然后来拍一条后续。爆款预定。",
            ],
            templatesEN: [
                "POV: You're debating whether to {wish} and you just scrolled to this video. Comments: 'One word: GO' 'Bestie I was the same last month' 'What's the background song?' 'First comment is right' 'We need a follow-up.' See that? 17K likes, 2K shares, zero people saying don't. The algorithm is pushing you to {wish}. Big data doesn't lie. Follow for the update.",
                "Wait wait wait — you're NOT still deciding whether to {wish}, are you? Like, this even needs thinking? I filmed this video faster than you're making this decision. Three, two, one — done filming. You? Where's your decision? This video is about to go through moderation and you still haven't decided? TikTok speed is fast — life should be too. Before you swipe away, go {wish}. Don't just double-tap — take action.",
                "[CHALLENGE] #JustDoItChallenge Rules are simple: whatever you've been hesitating on, do it today. Yours is {wish}, right? This video already has 3 million participants, and 2.99 million have completed the challenge. Are you in the remaining 10,000? The comments are full of 'Challenge complete' check-ins. Your turn. Do it and come check in. I'll be waiting.",
                "You know the golden rule of short-form video? The first three seconds decide everything. Your life works the same way — you want to {wish}, so make the decision within three seconds starting now. One, two, three — done. If you're still reading this, you're past three seconds. In TikTok world, you just got swiped. Don't get swiped by your own life. Be someone who makes people stop scrolling. Go {wish}.",
                "This video has a 97% completion rate — you know what that means? Almost everyone who started watching stayed till the end. They're waiting for you to decide. You want to {wish}, right? Three hundred thousand people are staring at you from the other side of the screen. If you don't go, that completion rate was wasted. Don't waste your reach. Go {wish}, then come back and film a follow-up. Viral hit guaranteed.",
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
                "你连续掰开了三块幸运饼干，纸条上分别写着：「去{wish}」「认真的，去{wish}」「你还在看纸条？？去{wish}！！」当三块饼干达成了一致意见的时候，这在统计学上叫「强共识」。宇宙已经用碳水化合物给你发了三次通知了。再不去，第四块饼干要骂人了。",
                "幸运饼干的哲学：它一生只传递一条信息，传完就碎了，毫无怨言。它不会说「等一下让我再想想要不要把纸条给你」。你收到了这条信息——{wish}。饼干已经完成了它的使命，碎了。现在轮到你完成你的使命了。别让一块饼干活得比你有目标感。",
            ],
            templatesEN: [
                "You cracked open a fortune cookie. The slip reads: 'You will {wish}, and it will go better than you imagine.' Think this was randomly printed? No. The fortune cookie factory has a printer from 1973 that has printed destinies for 130 million people. It's seen more lives than you. It says you should {wish}. Don't argue with the cookie. Eat it and go.",
                "Lucky numbers: 7, 14, 23, 38, 42. Your lucky action: {wish}. Your lucky time: now. Your lucky obstacle: doesn't exist. — This is a no-nonsense fortune cookie. It's seen too many people read the slip three times, shove it in their pocket, and forget it. Don't be that person. This slip is a note from the universe. Go {wish}. Then tell the universe you got the message.",
                "This fortune cookie hesitated for zero seconds before cracking open and delivering its message. It didn't think 'Should I crack?' or 'What happens after?' or 'What will the other cookies think?' It just — cracked. The slip says: '{wish}.' A cookie is more decisive than you. Still hesitating? Crack open. Release your good fortune.",
                "You cracked open three fortune cookies in a row. The slips read: 'Go {wish}.' 'Seriously, go {wish}.' 'You're STILL reading slips?? GO {wish}!!' When three cookies reach unanimous agreement, that's what statisticians call 'strong consensus.' The universe has sent you three notifications via carbohydrate. If you don't go, the fourth cookie is going to start swearing.",
                "The philosophy of the fortune cookie: it exists to deliver one message, then it crumbles without complaint. It never says 'Hold on, let me reconsider whether to give you this slip.' You received the message — {wish}. The cookie has fulfilled its purpose and shattered. Now it's your turn to fulfill yours. Don't let a cookie live with more sense of purpose than you.",
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
                "喵。你又在纠结了。我舔了一下你的手指头，意思是「去{wish}」。你没懂。我蹭了一下你的腿，意思还是「去{wish}」。你还是没懂。我只好把你的水杯推到地上——「砰」。现在你懂了吗？在猫的语言体系里，打碎东西是最高级别的催促。去。不然下一个掉地上的是你的花瓶。喵。",
                "我每天凌晨四点准时在你脸上蹦跳把你吵醒，你从来没见我犹豫过要不要跳。为什么？因为我知道我要什么——我要你起来喂我。目标清晰，执行果断，绝不内耗。你想{wish}？学学我凌晨四点的精神状态：想做就做，做完就睡，一秒钟的犹豫都是对猫生的浪费。去吧。我回去睡了。喵。",
            ],
            templatesEN: [
                "Meow. I'm your cat. I've been observing you for three years. Your behavior pattern: open phone → sigh → close phone → open again → sigh again. You're agonizing over {wish} again, aren't you? As a cat, let me tell you my decision-making process: want to jump on table → jump on table. No step three. You humans overcomplicate everything. {wish} — just jump. Meow.",
                "You know why I push things off tables? Because I want to, and I never regret it. Cup broke? That's the cup's problem. You want to {wish}? Go. Consequences? That's the consequences' problem. What you need isn't courage or determination — it's Cat Philosophy: do what you want, don't look back, and if you do look back, don't care. You've had me for years and haven't learned a thing. Wasted. Go {wish}. Meow.",
                "I'm sitting on your keyboard right now, blocking your screen with my butt. Why? Because instead of staring at the screen agonizing over {wish}, you should look at me — a creature that does only four things daily: eat, sleep, groom, and do whatever I want. My happiness index is ten times yours. The difference? I never hesitate. Now, I'm getting off your keyboard. You should get out of your indecision. Go {wish}. I'm going to nap. Meow.",
                "Meow. You're overthinking again. I licked your finger — that means 'go {wish}.' You didn't get it. I rubbed against your leg — still means 'go {wish}.' Still didn't get it. So I pushed your water glass off the table — CRASH. Get it now? In cat language, breaking things is the highest level of urgency. Go. Or the next thing hitting the floor is your vase. Meow.",
                "Every day at 4 AM I bounce on your face to wake you up, and you've never once seen me hesitate about whether to jump. Why? Because I know what I want — I want you up and feeding me. Clear goal, decisive execution, zero internal debate. You want to {wish}? Channel my 4 AM energy: want it, do it, go back to sleep, not a single second wasted on hesitation. Go. I'm going back to bed. Meow.",
            ]
        ),
        // MARK: - 动物世界
        Dimension(
            id: "dog",
            category: "动物世界",
            emoji: "🐕",
            title: "你家的狗视角",
            titleEN: "Your Dog",
            templates: [
                "汪汪汪！你要{wish}？太棒了太棒了太棒了！！！我不知道那是什么但是你要做的事情我都觉得太棒了！！你知道我为什么每次你回家都这么兴奋吗？因为我从来不犹豫要不要表达快乐。你想{wish}就去啊！然后回来告诉我！我会在门口等你！摇尾巴等你！汪！",
                "主人，你坐在沙发上叹气的时间够我跑三圈小区了。你犹豫要不要{wish}的时间够我叼回来七根树枝了。你看我叼树枝之前会做可行性分析吗？不会！看见就叼！你也应该这样——看见{wish}的机会就冲！我教你：舌头伸出来，尾巴摇起来，冲！汪！",
                "你每天遛我的时候，我从来不问「今天往哪走」「这条路安不安全」「会不会遇到那只凶巴巴的泰迪」。出门就是快乐，哪条路都是新世界。你想{wish}也一样啊，别规划了，出门就完事了。路上的每一坨……呃每一朵花都是惊喜。走！汪汪！",
                "我刚才追了二十分钟自己的尾巴。你问我为什么？因为想追就追了呗。你看我追完有没有后悔？没有！你想{wish}就去追啊。就算追到的是自己的尾巴也没关系，至少你运动了。人生不就是追尾巴吗，关键是追的过程很快乐。汪！",
                "你知道我为什么这么爱你吗？因为你给我吃的。但更重要的是，你是我见过最勇敢的人——你每天出门上班对我来说就像去打仗。你连上班都不怕，还怕{wish}？你在我眼里已经是英雄了，去做英雄该做的事。我在家等你凯旋。汪汪汪！",
            ],
            templatesEN: [
                "WOOF WOOF WOOF! You want to {wish}? AMAZING AMAZING AMAZING!!! I don't know what that is but EVERYTHING you do is AMAZING!!! You know why I'm this excited every time you come home? Because I never hesitate to show joy. You want to {wish}? JUST GO! Then come back and tell me about it! I'll be waiting at the door! Tail wagging! WOOF!",
                "Human, the time you've spent sighing on the couch, I could've run three laps around the block. The time you've spent hesitating about {wish}, I could've fetched seven sticks. Do I do a feasibility study before fetching? NO! See stick, grab stick! You should be the same — see the chance to {wish}, GO! Tongue out, tail up, CHARGE! WOOF!",
                "When you walk me, I never ask 'which way today?' or 'is this route safe?' Going outside IS the joy. Every path is a new world. You want to {wish}? Same thing — stop planning, just go. Every... um... flower along the way is a surprise. Let's GO! WOOF WOOF!",
                "I just spent twenty minutes chasing my own tail. Why? Because I wanted to. Did I regret it? NOPE! You want to {wish}? Go chase it! Even if you catch your own tail, at least you got exercise. Life is basically tail-chasing anyway — the joy is in the chase. WOOF!",
                "You know why I love you so much? Because you feed me. But more importantly, you're the bravest person I know — you leave the house for work every day, which to me is like going to war. You're not even afraid of WORK, and you're afraid of {wish}? You're already my hero. Go do hero things. I'll be here when you return victorious. WOOF WOOF WOOF!",
            ]
        ),
        Dimension(
            id: "goldfish",
            category: "动物世界",
            emoji: "🐟",
            title: "金鱼视角",
            titleEN: "Goldfish",
            templates: [
                "你好，我是一条金鱼，我的记忆只有七秒。等等，我刚才在说什么？哦对，你想{wish}对吧？你知道七秒记忆最大的好处是什么吗？我从来不后悔。因为七秒后我就忘了。你要是能像我一样，{wish}完了就忘掉所有顾虑，人生该多轻松？去吧，别想了。反正你也记不住你今天纠结了多久。",
                "我在这个鱼缸里游了三年，每一圈都觉得是第一次。新鲜感永远不会消失。你想{wish}？每次都当成第一次。第一次永远是最勇敢的，而我一辈子都在过第一次。你应该羡慕我。去{wish}吧，把它当成你的第一次。",
                "你看我整天在鱼缸里转圈，你觉得我的世界很小对吧？但是我告诉你，每七秒这个鱼缸对我来说都是一个全新的宇宙。你想{wish}但觉得世界很大很可怕？试试用我的眼光看：世界不是大不大的问题，是你愿不愿意每七秒重新出发的问题。游吧。",
                "别人养猫养狗，你养了一条金鱼。为什么？因为我不需要遛，不会叫，不拆家。但我有一个技能它们都没有——我忘得快。你想{wish}但怕失败？学我。失败了？七秒后就忘了。成功了？也忘了，但身体记得那个快乐。去吧，让身体记住。",
                "我每天的生活就是：游、吃、忘、游、吃、忘。你觉得无聊？不，这叫活在当下。你想{wish}？别想昨天的失败，别想明天的风险。像我一样，只想现在。现在想{wish}，现在就去。七秒后的事七秒后再说。泡泡。",
            ],
            templatesEN: [
                "Hi, I'm a goldfish. My memory lasts seven seconds. Wait, what was I saying? Oh right, you want to {wish}. Know the best thing about seven-second memory? I never regret anything. Because seven seconds later, I've forgotten. If you could be like me — {wish} and forget all your worries — life would be so much easier. Go. You won't even remember how long you hesitated.",
                "I've been swimming in this bowl for three years, and every lap feels like the first. Novelty never dies. You want to {wish}? Treat it like the first time. First times are always the bravest, and my whole life is first times. Be jealous. Go {wish} like it's your first time.",
                "You think my world is small because I swim in circles? Let me tell you — every seven seconds this bowl is a brand new universe. You want to {wish} but the world feels big and scary? Try my perspective: it's not about how big the world is, it's about whether you're willing to start fresh every seven seconds. Swim.",
                "People get cats and dogs. You got a goldfish. Why? Because I don't need walks, don't bark, don't destroy furniture. But I have one skill they don't — I forget fast. Afraid of failing at {wish}? Learn from me. Failed? Forgotten in seven seconds. Succeeded? Also forgotten, but your body remembers the joy. Go. Let your body remember.",
                "My daily life: swim, eat, forget, swim, eat, forget. Boring? No — it's called living in the present. You want to {wish}? Don't think about yesterday's failures or tomorrow's risks. Like me, think only about now. Right now you want to {wish}, so right now, go. Seven seconds from now is seven seconds from now's problem. Blub.",
            ]
        ),
        Dimension(
            id: "eagle",
            category: "动物世界",
            emoji: "🦅",
            title: "鹰的视角",
            titleEN: "Eagle",
            templates: [
                "我在三千米的高空看着你。你知道从这个高度看，你纠结的那些事有多小吗？小到我差点把你当成一只犹豫要不要过马路的松鼠。你想{wish}？从鹰的视角看，你所有的顾虑加起来还没有一只老鼠大。而我每天抓的老鼠比你一年做的决定还多。展翅吧。",
                "我从不犹豫要不要俯冲。看见猎物，收翅，俯冲，时速三百二十公里。你想{wish}？学我的俯冲：看见目标，别想，冲。犹豫的鹰会饿死，犹豫的你只会饿掉人生的可能性。三、二、一——俯冲。",
                "我出生在悬崖上。你知道我学飞的第一课是什么吗？我妈把我推下悬崖。没有预告，没有安全网，没有「你准备好了吗」。就是一推。然后我就飞了。你想{wish}？你需要的不是更多准备，是有人推你一把。我推你了。飞吧。",
                "你知道鹰为什么喜欢暴风雨吗？因为暴风雨的气流可以把我送得更高。别的鸟都在躲雨，我在借风。你想{wish}但觉得现在条件不好、时机不对？那就对了——逆风才是起飞的最佳条件。展翅，迎着风，{wish}就是你的暴风雨。飞。",
                "我孤独吗？在三千米高空，方圆几公里就我一只鸟。但我从不觉得孤独，因为我忙着飞。你想{wish}但怕孤独、怕没人支持？等你飞到了高空，回头看，地面上的那些声音根本传不上来。飞到该飞的高度，你自然就听不见废话了。起飞。",
            ],
            templatesEN: [
                "I'm watching you from 10,000 feet. Know how small your problems look from up here? So small I almost mistook you for a squirrel hesitating to cross the road. You want to {wish}? From an eagle's view, all your worries combined are smaller than a mouse. And I catch more mice daily than you make decisions annually. Spread your wings.",
                "I never hesitate to dive. See prey, fold wings, dive — 200 mph. You want to {wish}? Learn my dive: see the target, don't think, GO. A hesitant eagle starves. A hesitant you only starves your life of possibilities. Three, two, one — DIVE.",
                "I was born on a cliff. Know what my first flying lesson was? My mom pushed me off. No warning, no safety net, no 'are you ready?' Just a push. And then I flew. You want to {wish}? You don't need more preparation. You need a push. Consider this your push. Fly.",
                "Know why eagles love storms? Storm winds push us higher. Other birds hide from rain; I ride the wind. You want to {wish} but conditions aren't perfect? Good — headwinds are the best conditions for takeoff. Spread your wings, face the wind. {wish} is your storm. Fly.",
                "Am I lonely at 10,000 feet with not another bird for miles? Never. Because I'm busy flying. Afraid that {wish} will be lonely? That nobody will support you? Once you reach altitude, the noise from the ground can't reach you anymore. Fly high enough and you'll stop hearing the nonsense. Take off.",
            ]
        ),
        Dimension(
            id: "sloth",
            category: "动物世界",
            emoji: "🦥",
            title: "树懒视角",
            titleEN: "Sloth",
            templates: [
                "嗨……我是……树懒……我说话……很慢……但是……我想告诉你……你想{wish}……就……去吧……你看……连我……这个……全世界……最慢的动物……都在催你了……你还好意思……犹豫吗……我一天……只移动……十米……但是……方向……从来……不犹豫……去吧……我……为你……加油……（三小时后送达）",
                "你觉得我很懒对吧？但我告诉你，我做的每一个决定都很坚定——只是执行得慢。我花了三个小时爬到这根树枝上，中间没有犹豫过一秒。你想{wish}？你可以慢慢做，但不要慢慢决定。决定是一秒钟的事，剩下的只是爬树枝而已。",
                "我的新陈代谢是所有哺乳动物里最低的。但我活得比大部分快节奏的动物都久。秘诀？不纠结。我从不纠结这根树枝好不好、那片叶子甜不甜。抓到就吃，吃完就睡。你想{wish}？你不需要快，你需要不纠结。像我一样，慢慢来，但坚定地来。",
                "你知道吗，树懒每周只下一次树，下去是为了上厕所。就为了这一件事，我要花一整天爬下去再爬上来，途中随时可能被美洲豹吃掉。但我每周都去。你想{wish}？你面对的风险能有我上厕所的风险大吗？我连上厕所都敢拿命去做，你{wish}一下怕什么？",
                "人们叫我树懒，但我更喜欢叫自己「节奏大师」。我不是慢，我是有自己的tempo。你想{wish}但觉得太慢了、来不及了？谁说的？我每小时移动四米，依然活到了四十岁。速度不重要，方向才重要。朝着{wish}的方向慢慢挪，比站在原地快一万倍。挪吧。",
            ],
            templatesEN: [
                "Hey... I'm... a sloth... I talk... very slowly... but... I want... to tell you... you want to {wish}... just... go... See... even I... the slowest... animal... on Earth... am telling you to hurry... Still hesitating?... I only... move... ten meters... a day... but my direction... is never... in doubt... Go... I'm... cheering... for you... (delivery in three hours)",
                "You think I'm lazy? Let me tell you — every decision I make is firm. I just execute slowly. It took me three hours to reach this branch. Not once did I hesitate. You want to {wish}? You can do it slowly, but don't decide slowly. Deciding takes one second. The rest is just climbing the branch.",
                "My metabolism is the lowest of any mammal. But I outlive most fast-paced animals. Secret? No overthinking. I never debate whether this branch is good or that leaf is sweet. Grab it, eat it, sleep. You want to {wish}? You don't need speed. You need to stop overthinking. Like me — go slow, but go steady.",
                "Fun fact: sloths only climb down once a week to use the bathroom. For this one task, I spend an entire day climbing down and back up, risking getting eaten by a jaguar. But I go every week. You want to {wish}? Is your risk bigger than my bathroom trip? I literally risk my life to poop. What's your excuse? Go.",
                "People call me a sloth, but I prefer 'rhythm master.' I'm not slow — I have my own tempo. Think you're too slow for {wish}? That it's too late? Says who? I move four meters per hour and still live to forty. Speed doesn't matter. Direction does. Inch toward {wish} — it's infinitely faster than standing still. Inch.",
            ]
        ),
        Dimension(
            id: "dolphin",
            category: "动物世界",
            emoji: "🐬",
            title: "海豚视角",
            titleEN: "Dolphin",
            templates: [
                "嘿！看我跳！*跃出水面三米*你想{wish}？跳啊！你知道我为什么总是在跳吗？因为海面以下的世界我已经看腻了。每次跳出水面那一秒，我能看见整个天空。你想{wish}就是你跳出水面的机会——在「日常」和「不一样」之间，选择跳起来看看天空。",
                "我的大脑比你想象的大得多，我能用声呐看见你看不见的东西。我的声呐现在告诉我一件事：你内心已经决定了要{wish}，但你的嘴巴还在说「再想想」。你知道在海豚的世界里，声呐不会骗你。你的内心也不会。听它的。去{wish}。",
                "我从不独自游泳。不是因为我不能，是因为一群海豚比一只海豚有趣一百倍。你想{wish}但觉得孤单？你不是孤单，你只是还没跳出去让别人看见你。跳出水面的那一刻，所有海豚都会向你游来。先跳，朋友自然来。",
                "科学家说海豚是除了人类以外最聪明的动物。但你看我用这个智商干了什么？翻跟头、追浪花、用尾巴拍水玩。聪明的最高境界不是做最优决策，是做最开心的决策。你想{wish}就去呗，别用你的智商分析了，用它来享受。",
                "你知道海豚睡觉的时候只关一半大脑吗？另一半保持清醒，确保我们不沉下去。你想{wish}但怕出问题？你又不是要关掉整个大脑去做。你完全可以一半勇敢一半警觉。这叫「海豚式决策」——不是闭着眼睛冲，是睁一只眼闭一只眼地冲。足够了。去吧。",
            ],
            templatesEN: [
                "Hey! Watch me jump! *leaps three meters out of the water* You want to {wish}? Jump! Know why I'm always jumping? Because I've seen enough of the underwater world. Every second I'm airborne, I see the entire sky. {wish} is your chance to jump above the surface — between 'routine' and 'different,' choose to leap and see the sky.",
                "My brain is bigger than you'd think, and my sonar sees what you can't. Right now it's telling me one thing: you've already decided to {wish}, but your mouth is still saying 'let me think about it.' In the dolphin world, sonar doesn't lie. Neither does your gut. Listen to it. Go {wish}.",
                "I never swim alone. Not because I can't — because a pod of dolphins is a hundred times more fun than one. Afraid {wish} will be lonely? You're not lonely. You just haven't jumped out of the water for others to see you yet. The moment you leap, every dolphin will swim toward you. Jump first. Friends follow.",
                "Scientists say dolphins are the smartest animals besides humans. But look what I do with my IQ: backflips, wave-chasing, tail-slapping for fun. The highest form of intelligence isn't making optimal decisions — it's making joyful ones. You want to {wish}? Stop analyzing with your brain. Start enjoying with it.",
                "Did you know dolphins sleep with half their brain? The other half stays awake so we don't sink. Afraid something will go wrong if you {wish}? You're not shutting down your whole brain. You can be half brave, half alert. It's called 'dolphin decision-making' — not charging in blind, but charging in with one eye open. That's enough. Go.",
            ]
        ),
        // MARK: - 名人附体
        Dimension(
            id: "steve_jobs",
            category: "名人附体",
            emoji: "🍎",
            title: "乔布斯视角",
            titleEN: "Steve Jobs",
            templates: [
                "Stay hungry, stay foolish. 你想{wish}？这就是hungry。你犹豫？这就是不够foolish。我当年被自己创办的公司踢出去，你猜我纠结了多久？零秒。因为我知道，被踢出去是为了被更大的事情接住。去{wish}吧，宇宙会接住你。",
                "你知道我为什么成功吗？不是因为我比别人聪明，是因为我比别人更愿意犯错。你想{wish}但怕犯错？错误是学费，不犯错才是最大的错。我把整个苹果公司都搞砸过一次，然后做出了iPhone。去犯你的错吧。",
                "你现在在做的事情和{wish}之间，隔着一个「现实扭曲力场」。什么意思？就是你觉得不可能的事情，只要你足够相信它可能，它就变成可能了。我用这个力场造出了改变世界的产品。你只需要用它来{wish}。比改变世界简单多了。",
                "「把每一天都当成生命中最后一天来过。」如果今天是你最后一天，你还会犹豫要不要{wish}吗？不会。你会穿上你最喜欢的衣服，走出门，去做。所以——为什么要等到最后一天？今天就是那天。",
                "人们总说要「think different」。但我告诉你，更难的不是想得不一样，是做得不一样。想{wish}的人有一千万个，做的人只有一千个。be that one in a thousand。去{wish}。just do it。等等那是Nike的……算了不重要。去。",
            ],
            templatesEN: [
                "Stay hungry, stay foolish. You want to {wish}? That's hungry. You're hesitating? That's not foolish enough. When I got kicked out of my own company, know how long I agonized? Zero seconds. Because I knew getting pushed out was just the universe making room for something bigger. Go {wish}. The universe will catch you.",
                "Know why I succeeded? Not because I was smarter — because I was more willing to be wrong. Afraid of messing up {wish}? Mistakes are tuition. Not making them is the real mistake. I tanked the entire Apple company once, then made the iPhone. Go make your mistakes.",
                "Between what you're doing now and {wish}, there's a Reality Distortion Field. Meaning: what seems impossible becomes possible when you believe hard enough. I used that field to build world-changing products. You just need it to {wish}. Way easier than changing the world.",
                "'Live every day as if it's your last.' If today were your last day, would you hesitate about {wish}? No. You'd put on your favorite outfit, walk out the door, and do it. So — why wait for the last day? Today is that day.",
                "People love to say 'think different.' But thinking different is the easy part. Doing different is hard. A million people think about {wish}. A thousand actually do it. Be that one in a thousand. Go {wish}. Just do it. Wait, that's Nike's... whatever. Go.",
            ]
        ),
        Dimension(
            id: "shakespeare",
            category: "名人附体",
            emoji: "🎭",
            title: "莎士比亚视角",
            titleEN: "Shakespeare",
            templates: [
                "To {wish}, or not to {wish}, that is the question. 但说实话，这根本不是个问题。哈姆雷特犹豫了五幕最后所有人都死了。你只是想{wish}而已，又不是要毒死国王。别学哈姆雷特，学我——我写了三十七部戏，从来不犹豫下一部写什么。想到就写。去，别演悲剧。",
                "「世界是一个舞台，所有男男女女不过是演员。」你现在就站在舞台上，灯光已经打了，观众在等。你可以演一出勇敢{wish}的喜剧，也可以演一出犹豫不决的闷剧。观众付了票钱了。别让他们打瞌睡。演！",
                "罗密欧为了朱丽叶翻墙。朱丽叶为了罗密欧喝毒药。你想{wish}而已，又不用翻墙也不用喝毒药。你的勇气成本是他们的百分之一，别演得好像你要殉情一样。去{wish}。这是喜剧不是悲剧。",
                "我写过一百五十四首十四行诗，每首都是情书。你知道写情书最重要的是什么吗？不是文采，是敢写。你想{wish}？这就是你给人生写的情书。别管押不押韵，先把第一行写出来。Shall I compare thee to a summer's day? 不，先去{wish}。诗回来再写。",
                "「勇敢的人一生只死一次，胆小鬼在死之前已经死了无数次。」——凯撒大帝，我写的台词。你想{wish}？别在想象中把自己杀死一万次了。勇敢的人只需要做一次决定。做。这是你舞台上最精彩的独白。",
            ],
            templatesEN: [
                "To {wish}, or not to {wish} — that is the question. But honestly, it's not even a question. Hamlet hesitated for five acts and everyone died. You just want to {wish}, not poison a king. Don't be Hamlet. Be me — I wrote 37 plays and never hesitated on what to write next. Thought it, wrote it. Go. Don't make this a tragedy.",
                "'All the world's a stage, and all the men and women merely players.' You're on stage right now. Lights are on. Audience is waiting. You can perform a bold comedy about {wish}, or a dull drama about indecision. They paid for tickets. Don't put them to sleep. Perform!",
                "Romeo climbed walls for Juliet. Juliet drank poison for Romeo. You just want to {wish} — no wall-climbing, no poison required. Your courage cost is 1% of theirs. Stop acting like this is a tragic romance. Go {wish}. This is a comedy, not a tragedy.",
                "I wrote 154 sonnets — every one a love letter. Know what matters most in a love letter? Not eloquence — daring to write it. You want to {wish}? That's your love letter to life. Don't worry about rhyming. Just write the first line. Shall I compare thee to a summer's day? No — first go {wish}. Poetry later.",
                "'Cowards die many times before their deaths; the valiant never taste of death but once.' — Julius Caesar, my line. You want to {wish}? Stop dying a thousand deaths in your imagination. The brave only need to decide once. Decide. This is your greatest soliloquy.",
            ]
        ),
        Dimension(
            id: "confucius",
            category: "名人附体",
            emoji: "📜",
            title: "孔子视角",
            titleEN: "Confucius",
            templates: [
                "子曰：「三思而后行。」但你已经思了三百遍了。子还曰：「过犹不及。」想太多和想太少一样有问题。你想{wish}，已经想了这么久，说明你该行了。从今天起，改成「一思而后行」。思完了吗？行。",
                "子曰：「知之为知之，不知为不知，是知也。」你现在的状态是：知道自己想{wish}，不知道结果会怎样。恭喜，这就是最聪明的状态——你已经知道了该知道的（你想做），剩下不知道的（结果如何）只能做了才知道。去吧，夫子批准了。",
                "吾十有五而志于学，三十而立，四十而不惑。你多大了？不管多大，你想{wish}就说明你还有志。有志就不晚。我十五岁才开始学习，最后成了圣人。你什么时候开始{wish}都不算晚。今天就算十五志于学。去。",
                "子曰：「己所不欲，勿施于人。」但我还想说一句课本上没有的：「己所欲者，必施于己。」你想{wish}就是你的「欲」。你不去做，就是在亏待自己。对别人好的前提是对自己好。先去{wish}，这是仁的第一步。",
                "有弟子问我：「老师，我想做一件事但是很害怕怎么办？」我说：「勇者不惧。」弟子说：「可是我不是勇者。」我说：「害怕还去做的人才叫勇者。不害怕去做的那叫莽夫。」你想{wish}但害怕？好。你已经具备了成为勇者的第一个条件。去。",
            ],
            templatesEN: [
                "Confucius said: 'Think thrice before you act.' But you've thought three hundred times. He also said: 'Going too far is as bad as not going far enough.' Overthinking is as bad as not thinking. You want to {wish} and you've thought about it this long? Time to act. From today: think once, then act. Done thinking? Go.",
                "Confucius said: 'To know what you know and know what you don't know — that is true knowledge.' Your state: you KNOW you want to {wish}. You DON'T KNOW the outcome. Congratulations — that's the wisest state. You know what you need to (you want it). The rest you can only learn by doing. Go. The Master approves.",
                "At 15 I set my heart on learning. At 30 I stood firm. At 40 I had no doubts. How old are you? Doesn't matter — wanting to {wish} means you still have ambition. Where there's ambition, it's never too late. I didn't start learning until 15 and became a sage. Whenever you start {wish}, it's not too late. Today is your 'fifteen and set on learning.' Go.",
                "Confucius said: 'Do not do unto others what you would not have done unto you.' But here's one that didn't make the textbook: 'What you desire for yourself, you must give to yourself.' Wanting to {wish} is your desire. Not doing it is shortchanging yourself. Being good to others starts with being good to yourself. Go {wish}. That's the first step of benevolence.",
                "A student asked me: 'Master, I want to do something but I'm scared. What do I do?' I said: 'The brave are not afraid.' He said: 'But I'm not brave.' I said: 'Someone who acts despite fear is brave. Someone who acts without fear is reckless.' You want to {wish} but you're scared? Good. You've met the first requirement for bravery. Go.",
            ]
        ),
        Dimension(
            id: "einstein",
            category: "名人附体",
            emoji: "🧠",
            title: "爱因斯坦视角",
            titleEN: "Einstein",
            templates: [
                "E=mc²。E是你的人生能量，m是你的行动质量，c是勇气的速度。你想{wish}？当你的勇气达到光速，哪怕一点点行动都会释放出巨大的能量。问题是你把c降到了零。零的平方还是零。给你的勇气加速。去{wish}。让你的人生公式不再等于零。",
                "我当年提出相对论的时候，整个物理学界都觉得我疯了。你知道我怎么回应的吗？我没回应。我继续算我的公式。你想{wish}，别人觉得你疯了？那恭喜你，你和我有同一个起点。疯子改变世界，正常人维护世界。你想当哪个？",
                "「想象力比知识更重要。」你想{wish}——你已经在想象了。这是你最强大的工具，别把它浪费在想象「失败了怎么办」上面。用想象力去想「成功了多爽」。你的大脑不区分想象和现实，给它输入什么它就相信什么。输入成功。然后去做。",
                "我花了十年推导广义相对论。十年。中间无数次算错、推翻、重来。你想{wish}，最多用几个月几周。你的试错成本是我的千分之一。我拿十年换来了一个方程式，你拿几周换一次{wish}的体验，你觉得谁更赚？去吧，这笔账不用相对论都算得清。",
                "「疯狂就是重复做同样的事却期待不同的结果。」你现在重复做的同样的事叫「犹豫」。你期待的不同结果叫「突然有勇气了」。这不会发生。换个做法：不犹豫，直接{wish}。这才是科学方法——改变变量，观察结果。去做实验。",
            ],
            templatesEN: [
                "E=mc². E is your life energy. m is the mass of your action. c is the speed of courage. You want to {wish}? When courage hits light speed, even a tiny action releases massive energy. Problem is, your c is zero. Zero squared is still zero. Accelerate your courage. Go {wish}. Don't let your life equation equal zero.",
                "When I proposed relativity, the entire physics community thought I was crazy. Know how I responded? I didn't. I kept working on my equations. You want to {wish} and people think you're crazy? Congratulations — you share a starting point with me. Crazy people change the world. Normal people maintain it. Which do you want to be?",
                "'Imagination is more important than knowledge.' You want to {wish} — you're already imagining. That's your most powerful tool. Don't waste it imagining 'what if I fail.' Use it to imagine 'how amazing when I succeed.' Your brain can't tell imagination from reality — feed it success. Then go do it.",
                "I spent ten years deriving general relativity. Ten years. Countless errors, restarts, dead ends. You want to {wish} — that's a few weeks, months tops. Your trial-and-error cost is a thousandth of mine. I traded ten years for one equation. You're trading a few weeks for the experience of {wish}. Who's getting the better deal? Go.",
                "'Insanity is doing the same thing over and over and expecting different results.' The thing you keep doing is 'hesitating.' The different result you expect is 'suddenly having courage.' That won't happen. Change the variable: stop hesitating, just {wish}. That's the scientific method — change the variable, observe the result. Run the experiment.",
            ]
        ),
        Dimension(
            id: "cleopatra",
            category: "名人附体",
            emoji: "👑",
            title: "埃及艳后视角",
            titleEN: "Cleopatra",
            templates: [
                "我十八岁统治埃及，用一条毯子把自己裹起来偷运进凯撒的宫殿。你想{wish}？你连裹毯子的勇气都不需要。我靠一条毯子征服了罗马最强大的男人，你只需要征服你自己的犹豫。起驾。本后授权你去{wish}。",
                "他们说我美貌倾国倾城。错了。我的武器从来不是美貌，是果断。在我的宫廷里，犹豫的大臣活不过一集。你想{wish}？在我面前犹豫的样子，比鳄鱼还让我不舒服。果断点。pharaoh命令你。",
                "我同时统治着埃及和两个罗马将军的心。你问我秘诀？从不问「我配不配」，只问「我想不想」。你想{wish}？你配。这不需要讨论。女王说你配就是配。现在去。让尼罗河为你让路。",
                "我的王朝传承了三千年。你知道三千年里最重要的品质是什么吗？不是智慧，不是财富，是行动力。金字塔不是想出来的，是搬石头搬出来的。你想{wish}？别想了，开始搬你的第一块石头。三千年后有人会记住你今天的决定。",
                "你知道我为什么总是画那么浓的眼线吗？因为看东西要看得清楚。你的目标是{wish}，我用我的铜绿眼影看得清清楚楚——你该去做了。别模糊，别犹豫，把你的目光像我的眼线一样锋利。然后出击。女王出征，从不迟疑。",
            ],
            templatesEN: [
                "I ruled Egypt at eighteen and smuggled myself into Caesar's palace rolled in a carpet. You want to {wish}? You don't even need a carpet. I conquered Rome's most powerful man with a rug. You just need to conquer your own hesitation. Move. The Queen authorizes you to {wish}.",
                "They say my beauty toppled empires. Wrong. My weapon was never beauty — it was decisiveness. In my court, hesitant ministers didn't survive one episode. You want to {wish}? Your hesitation disgusts me more than a crocodile. Be decisive. Pharaoh commands you.",
                "I ruled Egypt AND the hearts of two Roman generals simultaneously. My secret? Never asking 'do I deserve this?' Only asking 'do I want this?' You want to {wish}? You deserve it. No discussion needed. The Queen says you deserve it, so you deserve it. Now go. Let the Nile part for you.",
                "My dynasty lasted three thousand years. Know the most important quality over three millennia? Not wisdom, not wealth — action. The pyramids weren't thought into existence. They were built stone by stone. You want to {wish}? Stop thinking. Start carrying your first stone. Three thousand years from now, someone will remember today's decision.",
                "Know why I always wore such dramatic eyeliner? To see clearly. Your goal is to {wish}, and through my copper-green eyeshadow I see it crystal clear — you need to go. No blurring, no hesitating. Make your gaze as sharp as my eyeliner. Then strike. A queen rides to battle without delay.",
            ]
        ),
        // MARK: - 职场江湖
        Dimension(
            id: "intern",
            category: "职场江湖",
            emoji: "🫡",
            title: "实习生视角",
            titleEN: "The Intern",
            templates: [
                "前辈好！我是新来的实习生！虽然我什么都不懂，但是我有一个观察：你想{wish}对吧？我入职第一天什么都不会，但我敢问问题、敢犯错、敢被骂。你知道为什么吗？因为我一无所有所以我无所畏惧。你也是——{wish}的最差结果还能比实习生第一天更差吗？冲！",
                "我实习三个月学到的最重要的事：做了可能挨骂，不做一定没有机会。你想{wish}？做就是了。最差不过被骂一顿，最好可能改变人生。这个赔率比我实习转正的概率高多了。去吧，前辈！",
                "作为实习生，我每天做的事情清单：复印、打水、订外卖、被忽略、继续干。你想{wish}？你的处境能比我差吗？我连工位都是借的，依然每天准时到。你至少有自己的人生，去{wish}用一下。",
                "实习生生存法则第一条：别怕丢人。我第一天就把咖啡洒在了老板的笔记本电脑上。然后呢？然后我现在还在实习（虽然换了个部门）。你想{wish}？就算搞砸了，换个赛道继续就行。这是我用一台MacBook Pro换来的人生经验。",
                "你知道实习生和正式员工的区别吗？实习生什么都敢试，因为试错是工作内容。你想{wish}？把自己当成人生的实习生——这一次{wish}就是你的实习项目。做好了转正，做砸了也不扣工资。无风险实习，去吧！",
            ],
            templatesEN: [
                "Hi, senior! I'm the new intern! I don't know anything, but I've noticed something: you want to {wish}, right? My first day I knew nothing, but I dared to ask questions, make mistakes, and get yelled at. Why? Because having nothing means having nothing to lose. Same for you — can {wish} possibly go worse than an intern's first day? GO!",
                "Three months of interning taught me this: doing something might get you scolded; doing nothing guarantees you miss the chance. You want to {wish}? Just do it. Worst case: a scolding. Best case: life-changing. Those odds are way better than my conversion rate. Go, senior!",
                "My daily intern to-do list: photocopy, fetch water, order lunch, get ignored, keep going. You want to {wish}? Is your situation worse than mine? I don't even have my own desk, and I still show up on time every day. You at least own your own life. Go use it to {wish}.",
                "Intern survival rule #1: Don't fear embarrassment. Day one, I spilled coffee on my boss's laptop. What happened? I'm still interning (different department though). You want to {wish}? Even if you mess up, just switch lanes and keep going. That's life advice I bought with one MacBook Pro.",
                "Know the difference between an intern and a full-timer? Interns dare to try everything because trial-and-error IS the job. You want to {wish}? Think of yourself as life's intern — {wish} is your internship project. Nail it and you're promoted. Mess up and no pay is docked. Zero-risk internship. Go!",
            ]
        ),
        Dimension(
            id: "ceo",
            category: "职场江湖",
            emoji: "💼",
            title: "CEO视角",
            titleEN: "CEO",
            templates: [
                "我管理三千人的公司，每天做二十个决定，每个决定影响上千万的营收。你知道我花在每个决定上的时间多久吗？平均四秒。你想{wish}，已经想了四天了？你的决策效率比我低86400倍。商业机会不等人，人生机会也不等人。批准。去。",
                "在我的公司里，最贵的不是员工工资，不是办公室租金，是「开会讨论来讨论去最后什么都没做」的时间成本。你想{wish}？你正在跟自己开一个无限延期的会。我现在以CEO的身份宣布：会议结束，决议通过，立即执行。散会。",
                "我招人的时候从来不问「你有什么经验」，我问「你敢不敢做没做过的事」。你想{wish}？你已经通过了我面试的第一关——你有意愿。第二关是行动。不要让自己在终面被刷掉。去{wish}，offer发了。明天入职。",
                "每个季度的财报发布前我都紧张。你知道我怎么处理紧张的吗？不处理。紧张着做。你想{wish}但是紧张？谁告诉你不紧张才能做事？我一边心跳一百八一边签了五十亿的合同。紧张是引擎，不是刹车。踩油门。",
                "你知道CEO做的最多的事情是什么吗？不是决策，是承担决策的后果。你想{wish}？做了之后的所有后果，好的坏的，全都是你的。这不是威胁，这是特权——只有做了决定的人才有资格承受后果。没做决定的人什么都没有。去。承担你的特权。",
            ],
            templatesEN: [
                "I run a 3,000-person company and make twenty decisions a day, each affecting millions in revenue. Average time per decision? Four seconds. You've spent four DAYS on {wish}? Your decision efficiency is 86,400 times worse than mine. Business opportunities don't wait. Neither does life. Approved. Go.",
                "The most expensive thing in my company isn't salaries or rent — it's the time cost of 'meetings that discuss and discuss and decide nothing.' You want to {wish}? You're having an infinitely postponed meeting with yourself. As CEO, I hereby declare: meeting adjourned, resolution passed, execute immediately. Dismissed.",
                "When I hire, I never ask 'what experience do you have?' I ask 'will you do things you've never done?' You want to {wish}? You've passed round one — you have the will. Round two is action. Don't get cut at the final interview. Go {wish}. Offer sent. Start tomorrow.",
                "I get nervous before every quarterly earnings report. Know how I handle it? I don't. I just do it nervous. Want to {wish} but nervous? Who said you need to be calm to act? I've signed $5 billion contracts with my heart at 180 BPM. Nerves are the engine, not the brakes. Hit the gas.",
                "Know what a CEO does most? Not making decisions — bearing their consequences. You want to {wish}? Everything after — good and bad — is yours. That's not a threat. It's a privilege. Only those who decide get to bear consequences. Those who don't decide get nothing. Go. Claim your privilege.",
            ]
        ),
        Dimension(
            id: "street_vendor",
            category: "职场江湖",
            emoji: "🫓",
            title: "煎饼摊老板视角",
            titleEN: "Street Vendor",
            templates: [
                "来来来，要个煎饼不？加蛋加肠加生菜？你想{wish}对吧？我跟你说，我每天凌晨四点起来摊煎饼，刮风下雨不歇着。你知道我为什么不犹豫？因为犹豫的时候面糊就糊了。人生跟煎饼一样，该翻面的时候就得翻，犹豫一秒就焦了。去{wish}，别把人生摊糊了。",
                "你看我这个摊子，四平米。但是我告诉你，这四平米是我做过最勇敢的决定。辞了工厂的工作，借了两万块钱，买了这辆三轮车。你猜当时多少人笑我？现在我一个月赚的比在工厂一个季度多。你想{wish}？比摆摊的风险小多了。你有什么好怕的？来，送你个鸡蛋。",
                "我做煎饼有个原则：火候到了就翻，不早不晚。你{wish}的火候到了没？你来问我了就说明到了。看准时机就翻面。我摊了十五年煎饼，翻糊的不超过十个。概率在你这边。翻！",
                "你知道我的煎饼为什么好吃吗？不是秘方，是手不抖。你手一抖面糊就不均匀，不均匀就有厚有薄，厚的焦了薄的没熟。你想{wish}？手别抖。怎么做到手不抖？不想那么多。我摊煎饼的时候脑子里只有一件事：这张饼。你{wish}的时候脑子里也只要一件事：去做。",
                "加辣吗？不加？那你人生加点辣吧。你想{wish}但怕辣？告诉你，来我这儿的一开始说不加辣的人，后来都改成加辣了。因为尝过了才知道，辣的才够味。去{wish}吧，给你的人生加个辣。两块钱的辣椒都敢加，{wish}还不敢？",
            ],
            templatesEN: [
                "Hey hey, want a crepe? Egg, sausage, lettuce? You want to {wish}, right? Let me tell you — I'm up at 4 AM making crepes, rain or shine. Know why I never hesitate? Because when you hesitate, the batter burns. Life's like a crepe: when it's time to flip, you flip. One second late and it's charred. Go {wish}. Don't burn your life.",
                "See this cart? Four square meters. But this was the bravest decision I ever made. Quit my factory job, borrowed 20K, bought this tricycle. How many people laughed? Now I make more monthly than I made quarterly at the factory. You want to {wish}? Way less risky than street vending. What are you scared of? Here, have a free egg.",
                "My crepe rule: when the heat is right, flip. Not too early, not too late. Is the heat right for {wish}? You're here asking me, so yeah, it's right. When the moment's right, flip. Fifteen years of crepe-making, I've burned fewer than ten. The odds are in your favor. FLIP!",
                "Know why my crepes are good? No secret recipe — just steady hands. Shaky hands make uneven batter: thick parts burn, thin parts stay raw. You want to {wish}? Steady hands. How? Stop overthinking. When I make crepes, my brain has one thought: this crepe. When you {wish}, one thought: do it.",
                "Want spice? No? Then add some spice to your life. Afraid {wish} is too spicy? Let me tell you — everyone who starts with 'no spice' eventually switches to 'extra spice.' Because you don't know what you're missing until you try. Go {wish}. Add some spice to your life. You'll add chili to a two-dollar crepe but won't dare {wish}?",
            ]
        ),
        // MARK: - 虚拟世界
        Dimension(
            id: "npc_villager",
            category: "虚拟世界",
            emoji: "🏘️",
            title: "NPC村民视角",
            titleEN: "NPC Villager",
            templates: [
                "「勇者大人！你终于来了！我在这个村口站了十七年了，就等你来跟我对话！」你想{wish}？这是主线任务啊勇者大人！你不做主线任务跑去刷副本是什么意思？赶紧去{wish}！不然这个村子的剧情永远推进不了！我还要在这站多久啊！",
                "「要不要接受这个任务？【是】【否】」你已经在这个对话框前站了三天了。你知道在游戏里按「否」会怎样吗？NPC会原地不动，剧情会停滞，你的等级不会涨。你想{wish}？按「是」。哪个RPG玩家会按「否」啊？去做你的任务。",
                "我是NPC，我每天重复同样的话：「欢迎来到新手村。」你知道我多想走出这个村子看看外面的世界吗？但我不能，因为代码不允许。你跟我不一样——你的代码允许你做任何事。你想{wish}？你这个有自由意志的幸运家伙，替我们NPC活一次吧。去。",
                "勇者大人，你的背包里有：勇气药水×1、后悔解毒剂×3、机会之窗（限时）×1。你想{wish}？赶紧用机会之窗，它有倒计时！喝了勇气药水就出发！后悔解毒剂先备着，万一用上了说明你至少做了。没做过的人连后悔的机会都没有。",
                "「存档点已更新。」你现在的状态已经保存了。放心去{wish}吧。搞砸了可以读档。什么？现实没有读档功能？那更应该去——因为你不能读档，所以每一次选择都是唯一的。唯一的体验才是最珍贵的。勇者大人，出发！",
            ],
            templatesEN: [
                "'Hero! You're finally here! I've been standing at this village entrance for seventeen years waiting for you!' You want to {wish}? That's the MAIN QUEST, hero! Why are you grinding side dungeons? Go {wish}! Otherwise this village's storyline will never progress! How much longer do I have to stand here?!",
                "'Accept this quest? [YES] [NO]' You've been staring at this dialog box for three days. Know what happens when you press NO? The NPC stays put, the story stalls, your level stays the same. You want to {wish}? Press YES. What RPG player presses NO? Go complete your quest.",
                "I'm an NPC. Every day I say the same line: 'Welcome to Starter Village.' Know how badly I want to leave and see the world? But I can't — the code won't let me. You're different. Your code lets you do anything. You want to {wish}? You lucky creature with free will — go live for us NPCs. Go.",
                "Hero, your inventory: Courage Potion ×1, Regret Antidote ×3, Window of Opportunity (LIMITED TIME) ×1. You want to {wish}? Use the Window of Opportunity now — it has a countdown! Drink the Courage Potion and go! Keep the Regret Antidotes just in case — needing them means you at least tried. People who never try don't even get to regret.",
                "'Save point updated.' Your current state is saved. Go {wish} with peace of mind. Mess up? Load the save. What — real life has no save function? Even more reason to go. Since you can't reload, every choice is one-of-a-kind. One-of-a-kind experiences are the most precious. Hero, move out!",
            ]
        ),
        Dimension(
            id: "gps_navigation",
            category: "虚拟世界",
            emoji: "🗺️",
            title: "GPS导航视角",
            titleEN: "GPS Navigation",
            templates: [
                "「前方500米，请{wish}。」你已经偏航了。你设定的目的地是「充实的人生」，但你在「犹豫大道」上已经开了三十公里了。请在下一个路口掉头。重新规划路线中……最优路线：立即{wish}。预计到达时间：取决于你什么时候踩油门。请出发。",
                "「已为您规划三条路线。路线一：直接{wish}，预计用时5分钟。路线二：犹豫一周后{wish}，预计用时7天5分钟。路线三：犹豫到放弃，预计用时——计算中……永远到不了。推荐路线一。」请选择路线。",
                "「您已到达目的地附近。」……不对，你还没出发呢。但是从我这个导航的角度来看，你和目标之间的距离其实很近。你想{wish}？你以为你在起点，其实你已经走了一大半了——想到它、搜索它、鼓起勇气问——这些都算里程。最后一步了。请直行。",
                "「您已偏离路线。正在重新规划。」你每天都在偏离{wish}的路线，我每天都在重新规划。我不会生气，不会放弃，不会说「算了你爱去哪去哪」。我会一直重新规划直到你到达目的地。但拜托，能不能少偏几次？油费很贵的。请回到规划路线。",
                "「限速提醒：您当前速度0km/h。」你停在了「要不要{wish}」的路口，后面已经堵了一公里了。人生就是一条单行道，不能倒车不能停车只能前进。你想{wish}？绿灯亮了。踩油门。后面的人已经开始按喇叭了。请——出——发。",
            ],
            templatesEN: [
                "'In 500 meters, please {wish}.' You've gone off-route. Your destination is 'a fulfilling life,' but you've been driving down 'Hesitation Boulevard' for thirty kilometers. Please make a U-turn at the next intersection. Recalculating... Optimal route: {wish} immediately. ETA: depends on when you hit the gas. Please depart.",
                "'Three routes planned. Route 1: {wish} directly — ETA 5 minutes. Route 2: hesitate one week, then {wish} — ETA 7 days 5 minutes. Route 3: hesitate until you give up — ETA... calculating... never arrives. Route 1 recommended.' Please select a route.",
                "'You have arrived near your destination.' ...Wait, you haven't left yet. But from my navigation perspective, you're actually close. You want to {wish}? You think you're at the start, but you've already covered most of the distance — thinking about it, searching it, working up courage to ask. Last step. Continue straight.",
                "'You have left the planned route. Recalculating.' You veer off the {wish} route daily. I recalculate daily. I don't get angry. I don't give up. I don't say 'fine, go wherever.' I'll keep recalculating until you arrive. But please — can you veer less often? Gas is expensive. Return to the planned route.",
                "'Speed alert: Current speed 0 km/h.' You've stopped at the '{wish} or not' intersection, and there's a kilometer of traffic behind you. Life is a one-way street — no reversing, no parking, only forward. You want to {wish}? Green light. Hit the gas. People behind you are honking. Please — de — part.",
            ]
        ),
        Dimension(
            id: "spam_email",
            category: "虚拟世界",
            emoji: "📧",
            title: "垃圾邮件视角",
            titleEN: "Spam Email",
            templates: [
                "尊敬的用户您好！恭喜您被选中获得一次免费{wish}的机会！！！无需任何手续费，无需任何验证，只需要您——站起来——走出去——去做。这不是诈骗。我知道所有垃圾邮件都这么说，但这次是真的。因为{wish}本来就不需要别人批准。您自己批准就行了。点击此处立即领取→🔗去{wish}",
                "⚠️紧急通知⚠️ 您的人生账户已检测到异常：犹豫次数过多！！系统即将冻结您的勇气余额！请立即进行以下操作以解冻：第一步：想起你要{wish}。第二步：站起来。第三步：去做。如不在24小时内操作，您的勇气将永久清零。这不是演习。",
                "🎊 CONGRATULATIONS!!! 🎊 你是今天第1,000,000个想{wish}的人！作为奖励，你将获得：无限次尝试机会×1、失败后重来券×999、一个全新的人生可能性。请在本邮件过期前使用。有效期：现在。逾期作废。快去{wish}，别让百万分之一的好运过期。",
                "【自动回复】你发来的主题为「我应不应该{wish}」的邮件已收到。系统自动判定结果为：应该。此判定基于大数据分析：发邮件问别人应不应该做某事的人，内心100%已经决定要做了，只是想找人同意。好了，我同意了。去{wish}。此邮件由系统自动发送，无需回复。",
                "亲爱的收件人，这是你第47次收到关于{wish}的提醒邮件了。你把前46封都放进了垃圾箱。但就像所有顽强的垃圾邮件一样，我会继续发。你可以忽略我，拉黑我，退订我，但你没办法退订你内心想{wish}的声音。它会一直发。不如今天就取消订阅犹豫频道，去{wish}。",
            ],
            templatesEN: [
                "Dear User! CONGRATULATIONS! You've been selected for a FREE chance to {wish}!!! No fees, no verification — just stand up, walk out, and do it. This is NOT a scam. I know every spam email says that, but this time it's real. Because {wish} never needed anyone's approval. You approve it yourself. Click here to claim → 🔗 Go {wish}",
                "⚠️ URGENT NOTICE ⚠️ Abnormal activity detected on your LIFE ACCOUNT: excessive hesitation!! System will FREEZE your courage balance! Perform these steps immediately: Step 1: Remember you want to {wish}. Step 2: Stand up. Step 3: Do it. Failure to act within 24 hours = permanent courage wipe. This is NOT a drill.",
                "🎊 CONGRATULATIONS!!! 🎊 You are the 1,000,000th person today to think about {wish}! Your prize: Unlimited Retry Pass ×1, Failure Recovery Voucher ×999, One Brand-New Life Possibility. Redeem before this email expires. Expiration: NOW. Don't let this one-in-a-million luck expire. Go {wish}.",
                "[AUTO-REPLY] Your email RE: 'Should I {wish}?' has been received. System verdict: YES. Based on big data analysis: 100% of people who email asking whether to do something have already decided to do it — they just want someone to agree. Fine, I agree. Go {wish}. This is an automated message. No reply needed.",
                "Dear recipient, this is your 47th reminder about {wish}. You sent the first 46 to spam. But like all persistent spam, I'll keep sending. You can ignore me, block me, unsubscribe — but you can't unsubscribe from the voice inside that wants to {wish}. It'll keep sending. Just unsubscribe from the Hesitation Newsletter and go {wish}.",
            ]
        ),
        // MARK: - 神话传说
        Dimension(
            id: "sun_wukong",
            category: "神话传说",
            emoji: "🐒",
            title: "孙悟空视角",
            titleEN: "Sun Wukong (Monkey King)",
            templates: [
                "俺老孙大闹天宫的时候，十万天兵天将都拦不住！你想{wish}？谁拦你了？你自己拦你自己？那你比十万天兵天将还厉害——因为你是唯一能阻止你的人。把金箍棒抡起来，一棒子打碎犹豫，去{wish}！妖怪哪里跑！……哦不对，犹豫哪里跑！",
                "师父说「悟空你又闯祸了」，那又怎样？闯祸了就闯祸了，至少取经路上不无聊。你想{wish}但怕闯祸？你又不是去大闹天宫，{wish}这种小事能闹出什么祸？就算闹了，也比唐僧念一路紧箍咒有意思。去！",
                "当年我被压在五行山下五百年。五百年啊。你想{wish}犹豫了多久？五天？五小时？我被石头压了五百年都等到了唐僧来救我，你犹豫五天就要放弃？你的毅力还不如一块石头下面的猴子。翻出你的五行山，去{wish}！",
                "筋斗云一翻十万八千里。你想{wish}？你根本不需要翻十万八千里，可能只需要走十步。你的十步比我的十万八千里容易一万倍，你还不走？来，你上俺老孙的筋斗云——算了，走路去吧，也就十步路。",
                "七十二变，你想变什么变什么。但你知道最厉害的那一变是什么吗？不是变天变地，是从「想做的人」变成「在做的人」。这一变不需要法术，只需要迈出第一步。你想{wish}？变！",
            ],
            templatesEN: [
                "When I stormed Heaven, a hundred thousand celestial soldiers couldn't stop me! You want to {wish}? Who's stopping you? Yourself? Then you're more powerful than a hundred thousand soldiers — because you're the only one who can stop you. Swing that golden staff, smash your hesitation, go {wish}! Where do you think you're going, indecision?!",
                "Master always said 'Wukong, you've caused trouble again.' So what? Trouble makes the journey interesting. Afraid {wish} will cause trouble? You're not storming Heaven. What trouble can {wish} cause? Even if it does, it's more fun than listening to chanting all day. GO!",
                "I was pinned under Five Elements Mountain for 500 years. FIVE. HUNDRED. YEARS. How long have you hesitated about {wish}? Five days? Five hours? I waited 500 years under a rock and still got rescued. You're giving up after five days? Your perseverance is worse than a monkey under a mountain. Break free! Go {wish}!",
                "My somersault cloud covers 108,000 li in one leap. You want to {wish}? You don't need 108,000 li — maybe ten steps. Your ten steps are ten thousand times easier than my 108,000 li, and you still won't walk? Hop on my cloud — actually, just walk. It's only ten steps.",
                "72 transformations — I can become anything. But the most powerful transformation? Not changing heaven or earth. It's changing from 'someone who wants to do it' into 'someone who's doing it.' That transformation needs no magic — just one first step. You want to {wish}? TRANSFORM!",
            ]
        ),
        Dimension(
            id: "dragon_chinese",
            category: "神话传说",
            emoji: "🐉",
            title: "中国龙视角",
            titleEN: "Chinese Dragon",
            templates: [
                "我是龙。我翻云覆雨、行云布雨、呼风唤雨。但你知道吗，在我还是一条小蛇的时候，我也犹豫过要不要修炼成龙。修炼五百年才能长出鹿角，再修炼五百年才能长出鹰爪。你想{wish}？你又不用修炼一千年。今天做了今天就是龙。别像蛇一样在地上扭了。腾云驾雾去吧。",
                "龙的第一课不是喷火，不是飞行，是「敢破云层」。你知道云层以下什么感觉吗？暗的、湿的、看不见方向。但破了云层就是阳光和蓝天。你想{wish}就是你的云层。硬着头皮破上去。上面的风景值回一切。",
                "画龙点睛——你听说过吧？龙已经画好了，就差最后一笔。你想{wish}的计划已经都想好了，就差最后一步：做。你就是那只差一个「睛」的龙。点上去，你就活了。不点？你就是一幅画。你想当活龙还是死画？点！",
                "鲤鱼跃龙门。你知道有多少鲤鱼跳了吗？千千万万。跳过去的变成龙，没跳过去的还是鲤鱼。但有一种鱼最惨——连跳都没跳的。它们永远不知道自己是不是那条能成龙的鱼。你想{wish}？去跳。不管结果如何，至少你知道了答案。",
                "龙不是天生的。龙是修炼出来的、是跳出来的、是闯出来的。你想{wish}？这就是你的修炼、你的跳跃、你的闯关。每个龙的故事里都有一个「差点没成」的时刻。你现在就在那个时刻。再进一步就成了。腾飞吧。",
            ],
            templatesEN: [
                "I am a dragon. I command clouds and summon rain. But once I was just a small snake who hesitated about whether to cultivate into a dragon. 500 years to grow antlers. Another 500 for eagle claws. You want to {wish}? You don't need a thousand years. Do it today and you're a dragon today. Stop slithering. Rise through the clouds.",
                "A dragon's first lesson isn't breathing fire or flying — it's 'dare to break through the clouds.' Below the clouds? Dark, wet, directionless. But above? Sunshine and blue sky. {wish} is your cloud layer. Push through. The view above is worth everything.",
                "You've heard of 'painting the dragon's eye'? The dragon is painted, just missing the final dot. Your plan to {wish} is ready — just missing the final step: doing it. You're a dragon missing one eye. Dot it and you come alive. Don't? You're just a painting. Living dragon or dead painting? DOT!",
                "Carp leaping the Dragon Gate. Know how many carp jumped? Thousands upon thousands. Those who made it became dragons. Those who didn't stayed carp. But the saddest fish? The ones who never jumped. They'll never know if they could've become dragons. You want to {wish}? Jump. Whatever happens, at least you'll know the answer.",
                "Dragons aren't born. They're forged through practice, leaping, and charging through barriers. You want to {wish}? That's your practice, your leap, your breakthrough. Every dragon's story has a 'nearly didn't make it' moment. You're in that moment right now. One more step and you've made it. Soar.",
            ]
        ),
        // MARK: - 极端场景
        Dimension(
            id: "mars_colonist",
            category: "极端场景",
            emoji: "🚀",
            title: "火星移民视角",
            titleEN: "Mars Colonist",
            templates: [
                "我现在在火星上。单程票来的。没有回头路。你想{wish}？你至少还有回头路。我连地球都回不去了——但我后悔了吗？没有。因为来火星是我做过最正确的决定。你的{wish}连火星都不用去，有什么好犹豫的？",
                "火星的大气层是地球的百分之一，平均温度零下六十度，一年有一半时间在沙尘暴里。我依然每天准时起床种土豆。你想{wish}？你的环境比火星好十万倍。在火星上种土豆都能活，你{wish}能有什么问题？地球人太矫情了。",
                "这里信号延迟二十分钟。我说一句话，地球二十分钟后才收到。你想{wish}？你的犹豫比我的信号延迟还久。我都忍了，你忍不了？别做你犹豫的奴隶。二十分钟的延迟我能等，你人生的延迟谁帮你等？去{wish}。",
                "我离开地球的时候只带了一个行李箱。你知道我留下了什么吗？犹豫。犹豫太重了，宇宙飞船装不下。你想{wish}？先把犹豫从你的行李箱里扔出去。轻装上阵。火星教会我的唯一道理：带的越少，走的越远。",
                "从火星回头看地球，就是一个蓝色的小点。你的所有烦恼、所有犹豫、所有「万一怎么办」，在这个尺度下，连一个像素都不占。你想{wish}？把镜头拉远一点看。没什么大不了的。整个地球都只是一个点。你的犹豫连半个点都不是。去。",
            ],
            templatesEN: [
                "I'm on Mars right now. One-way ticket. No going back. You want to {wish}? At least you have a return option. I can't even go back to Earth — but do I regret it? No. Coming to Mars was the best decision I ever made. Your {wish} doesn't even require leaving the planet. What are you hesitating for?",
                "Mars atmosphere: 1% of Earth's. Average temp: minus 60. Dust storms half the year. I still wake up on time every day to grow potatoes. You want to {wish}? Your conditions are 100,000 times better than mine. If I can grow potatoes on Mars, what could possibly go wrong with {wish}? Earth people are so dramatic.",
                "Signal delay here is twenty minutes. I say something; Earth hears it twenty minutes later. You want to {wish}? Your hesitation has a longer delay than my signal. I cope with mine — can't you cope with yours? Don't be a slave to hesitation. I can wait twenty minutes for signal. Who's waiting for your life's delays? Go {wish}.",
                "When I left Earth, I brought one suitcase. Know what I left behind? Hesitation. Too heavy for a spaceship. You want to {wish}? Throw hesitation out of your suitcase first. Travel light. Mars taught me one thing: the less you carry, the further you go.",
                "Looking at Earth from Mars, it's just a tiny blue dot. All your worries, all your hesitation, every 'what if' — at this scale, they don't even fill one pixel. You want to {wish}? Zoom out. It's no big deal. The entire Earth is just a dot. Your hesitation isn't even half a dot. Go.",
            ]
        ),
        Dimension(
            id: "time_traveler",
            category: "极端场景",
            emoji: "⏰",
            title: "时间旅行者视角",
            titleEN: "Time Traveler",
            templates: [
                "我从2056年穿越回来告诉你一件事：你想{wish}？去做。具体结果我不能剧透——时间管理局不让说。但我能告诉你的是：三十年后你会感谢今天的自己。不是因为结果好不好，是因为你做了。时间线上有无数个分叉，选择行动的那条线永远更精彩。",
                "时间旅行最大的bug是什么？不是时间悖论，是「早知道」。你总说「早知道我就……」。好消息：我是从未来来的，现在告诉你了。你想{wish}就去做。现在你知道了，不存在「早知道」了。从此刻起，所有犹豫都是你的选择，不是你的无知。去。",
                "我穿越过一百多次了。每次回到过去最想改变的事是什么？不是买比特币——好吧也有这个——主要是那些「明明想做但没做」的事。你想{wish}？我穿越回来就是为了告诉你这个。未来的你托我带话：去做。别让我还要再穿越一次。",
                "剧透：2030年你会在某个深夜突然想起今天。你会想「那时候我到底有没有去{wish}」。如果你去了，这个记忆是温暖的。如果你没去，这个记忆是遗憾的。你现在可以决定四年后深夜想起的是温暖还是遗憾。选温暖。去{wish}。",
                "时间旅行者守则第一条：不要试图改变过去。为什么？因为过去已经是最好的版本了——所有你做过的决定，包括错误的，都把你带到了现在。你想{wish}？做了就是未来你最好版本的一部分。不做？未来你又要花钱找我穿越回来催你了。省点钱吧。去。",
            ],
            templatesEN: [
                "I've come back from 2056 to tell you one thing: you want to {wish}? Do it. Can't spoil the outcome — Time Bureau rules. But I can tell you: thirty years from now, you'll thank today's you. Not because of the result, but because you did it. Every timeline fork — the action branch is always more interesting.",
                "The biggest bug in time travel? Not paradoxes — it's 'if only I had known.' You keep saying 'if only I had...' Good news: I'm from the future, and now I'm telling you. Go {wish}. Now you know. No more 'if only.' From this moment, every hesitation is your choice, not your ignorance. Go.",
                "I've time-traveled over a hundred times. What do I most want to change about the past? Not buying Bitcoin — okay, also that — but mainly the things I wanted to do but didn't. You want to {wish}? I came back specifically to tell you this. Future you asked me to relay a message: do it. Don't make me come back again.",
                "Spoiler: in 2030, you'll suddenly think about today late one night. You'll wonder 'did I actually {wish} that time?' If you did, it's a warm memory. If you didn't, it's a regret. Right now you can decide whether that late-night memory is warm or regretful. Choose warm. Go {wish}.",
                "Time Traveler's Code, Rule 1: Never try to change the past. Why? Because the past is already the best version — every decision you made, including mistakes, brought you here. You want to {wish}? Doing it becomes part of future-you's best version. Not doing it? Future you will have to pay me to come back and nag you again. Save the money. Go.",
            ]
        ),
        // MARK: - 自然力量
        Dimension(
            id: "volcano",
            category: "自然力量",
            emoji: "🌋",
            title: "火山视角",
            titleEN: "Volcano",
            templates: [
                "我在地下憋了十万年。十万年。岩浆在我体内翻滚、沸腾、咆哮。然后有一天——轰。我爆发了。你想{wish}？你已经憋了多久了？别再憋了。你不需要十万年的积累才能行动。你此刻的冲动就是你的岩浆。让它喷出来。轰。",
                "你知道火山爆发前有什么征兆吗？地震、温泉变烫、气体泄漏。你现在的征兆呢？心跳加速、反复搜索、打开了这个app。你的爆发指数已经达到临界点了。你想{wish}？别做休眠火山了。喷发吧。",
                "所有人都怕火山爆发。但你知道吗？火山灰是世界上最肥沃的土壤。爆发之后，废墟上会长出最茂盛的森林。你想{wish}但怕破坏现状？现状被打破之后，长出来的东西会比现在好一万倍。去。轰一下。然后等你的森林长出来。",
                "我不会小声嘟囔，我只会——轰！！！你想{wish}？别小声嘟囔了。别在心里偷偷想了。像火山一样，要么不做，要做就天崩地裂。{wish}值得一次火山级别的行动力。你准备好了吗？三、二、一——轰！！",
                "休眠火山和死火山的区别是什么？休眠火山随时可能爆发，死火山永远不会了。你想{wish}说明你还是休眠火山——里面还有岩浆。但如果你一直不爆发，岩浆会慢慢冷却，你就变成死火山了。趁你还有温度，喷发。",
            ],
            templatesEN: [
                "I held it in for a hundred thousand years. A HUNDRED THOUSAND. Magma churning, boiling, roaring inside me. Then one day — BOOM. I erupted. You want to {wish}? How long have you been holding it in? Stop. You don't need a hundred thousand years of buildup to act. Your impulse right now IS your magma. Let it blow. BOOM.",
                "Know the signs before a volcanic eruption? Earthquakes, hot springs heating up, gas leaks. Your signs? Elevated heart rate, obsessive searching, opening this app. Your eruption index has hit critical. You want to {wish}? Stop being a dormant volcano. ERUPT.",
                "Everyone fears volcanic eruptions. But volcanic ash creates the world's most fertile soil. After eruption, the most lush forests grow from the ruins. Afraid {wish} will disrupt your status quo? What grows after disruption will be ten thousand times better. Go. Erupt. Then watch your forest grow.",
                "I don't mumble. I BOOM!!! You want to {wish}? Stop mumbling about it. Stop thinking about it quietly. Like a volcano — either don't do it, or do it earth-shatteringly. {wish} deserves volcano-level commitment. Ready? Three, two, one — BOOM!!",
                "Difference between a dormant volcano and a dead one? A dormant volcano could erupt anytime. A dead one never will again. Wanting to {wish} means you're dormant — there's still magma inside. But if you never erupt, the magma cools and you become a dead volcano. While you still have heat, erupt.",
            ]
        ),
        Dimension(
            id: "espresso_shot",
            category: "美食拟人",
            emoji: "☕",
            title: "浓缩咖啡视角",
            titleEN: "Espresso Shot",
            templates: [
                "我是一杯espresso。30毫升。25秒萃取。但这25秒里浓缩了足以让你清醒四小时的能量。你想{wish}？你不需要准备很久。有时候人生最关键的事只需要25秒的勇气——按下按钮、说出口、迈出第一步。浓缩的才是精华。别等了。25秒。Go。",
                "我从来不加糖加奶。不是因为我bitter，是因为我够强不需要掩饰。你想{wish}？别给自己加太多缓冲。不需要「等条件好了再说」「找个人陪我」「再准备一下」。直接喝，不加糖。生活的原味可能苦，但够劲。一口闷。",
                "你看过拉花吗？好看是好看，但那是拿铁干的事。我是espresso，我不搞花里胡哨。一杯见真章。你想{wish}？别把它搞复杂了。不需要拉花、不需要装饰、不需要完美计划。一口气干完。像我一样——小杯，但有力。",
                "你知道为什么意大利人站着喝espresso吗？因为它就不是让你坐下来慢慢品的。它的存在就是为了让你快速充能，然后出发。你想{wish}？站起来，一口喝掉你的勇气，出发。espresso不需要续杯，你也不需要第二次犹豫。",
                "我是清晨第一杯espresso。在你喝下我之前，你昏昏沉沉、犹犹豫豫、浑浑噩噩。喝下我之后？清醒、果断、充满能量。你想{wish}就是你需要的那一口espresso。做了之后你就清醒了。现在，喝。",
            ],
            templatesEN: [
                "I'm an espresso shot. 30ml. 25-second extraction. But those 25 seconds contain enough energy to keep you alert for four hours. You want to {wish}? You don't need long preparation. Sometimes life's biggest moments need just 25 seconds of courage — press the button, say the words, take the first step. Concentrated is essential. Don't wait. 25 seconds. Go.",
                "I never take sugar or milk. Not because I'm bitter — because I'm strong enough to not need disguise. You want to {wish}? Stop adding buffers. No 'when conditions improve' or 'when I find someone to go with.' Drink it straight, no sugar. Life's raw flavor might be bitter, but it's powerful. Down it in one gulp.",
                "Ever seen latte art? Pretty, sure — but that's a latte's job. I'm espresso. No frills. One cup, full impact. You want to {wish}? Don't overcomplicate it. No latte art, no decoration, no perfect plan needed. Down it in one shot. Like me — small cup, big punch.",
                "Know why Italians drink espresso standing up? Because it's not meant to be sipped slowly. It exists to charge you up fast, then send you on your way. You want to {wish}? Stand up, down your courage in one gulp, and go. Espresso doesn't need refills. You don't need a second round of hesitation.",
                "I'm your first espresso of the morning. Before me: groggy, hesitant, foggy. After me: alert, decisive, energized. Wanting to {wish} is the espresso shot you need. Do it and you'll wake up. Now — drink.",
            ]
        ),
        // MARK: - 情感维度
        Dimension(
            id: "your_mirror",
            category: "情感维度",
            emoji: "🪞",
            title: "你的镜子视角",
            titleEN: "Your Mirror",
            templates: [
                "嘿，看着我。对，就是你镜子里的这个人。你想{wish}对吧？我每天看着你，我最清楚你。你照镜子的时候眼睛里有光——那是你想{wish}时候的眼神。别让那个光灭了。我只反射真实的你，而真实的你，想去做。",
                "你每天早上对着我刷牙的时候，我都在看你。大多数时候你看起来很疲惫。但有几次，你的眼睛突然亮了——那就是你想{wish}的时候。我是你的镜子，我不会骗你。你此刻的表情告诉我：你想做。那就去。",
                "你知道吗，你总是在最自信的时候看我，在最不自信的时候躲开我。你现在想{wish}但不敢？来，看着我。看看镜子里的这个人。这个人经历了这么多，依然站在这里，依然有勇气去想{wish}。这个人比你以为的强大多了。去吧。",
                "我见过你最糟糕的样子——起床气、哭红了眼、崩溃到扶着洗手台。我也见过你最好的样子——出门前的自信一笑。你想{wish}？你最好的样子和最差的样子都在我这面镜子里。你能扛过最差的，就一定配得上最好的。去{wish}。我在这等你笑着回来。",
                "镜子不说谎。你帅/美吗？镜子里是什么样就是什么样。你想{wish}该不该去？镜子里的你已经在点头了。相信你在镜子里看到的：一个准备好了的人。翻过来，不要光照镜子——去做镜子里那个人想做的事。",
            ],
            templatesEN: [
                "Hey. Look at me. Yes, the person in the mirror. You want to {wish}, right? I see you every day. I know you best. When you look at me, there's a light in your eyes — that's how you look when you think about {wish}. Don't let that light go out. I only reflect the real you. And the real you wants to go. So go.",
                "Every morning while you brush your teeth, I watch. Most days you look tired. But sometimes your eyes suddenly light up — that's when you're thinking about {wish}. I'm your mirror. I don't lie. Your expression right now tells me: you want to do it. So do it.",
                "You always look at me when you're confident and avoid me when you're not. Thinking about {wish} but don't dare? Come. Look at me. Look at this person in the mirror. They've been through so much and are still standing here, still brave enough to want to {wish}. This person is stronger than you think. Go.",
                "I've seen you at your worst — morning rage, red crying eyes, hands gripping the sink. I've also seen your best — that confident smile before walking out. You want to {wish}? Your best and worst are both in this mirror. If you survived the worst, you absolutely deserve the best. Go {wish}. I'll be here when you come back smiling.",
                "Mirrors don't lie. The person you see is who you are. Should you {wish}? The you in the mirror is already nodding. Trust what you see: a person who's ready. Now stop just looking — go do what the person in the mirror wants to do.",
            ]
        ),
        Dimension(
            id: "your_alarm_clock",
            category: "情感维度",
            emoji: "⏰",
            title: "你的闹钟视角",
            titleEN: "Your Alarm Clock",
            templates: [
                "叮铃铃铃铃铃铃！！！起来！！！你想{wish}？！那就别赖在犹豫的被窝里了！！！我每天叫你起床你按掉我七八次，你犹豫{wish}也犹豫了七八次了吧？！跟起床一样，你越赖越不想动。最痛苦的就是掀开被子的那一秒。掀！！！",
                "我是你的闹钟。你恨我。我知道。但你也需要我。没有我你会睡过头，没有{wish}的念头你会蹉跎一辈子。我的工作就是在你最不想醒的时候把你弄醒。现在，醒醒。你想{wish}——这是你人生的闹钟在响。别按掉它。",
                "你设了早上七点的闹钟，六点五十九分你在做什么？在享受最后一分钟的舒适。七点一到——叮铃铃——舒适结束，一天开始。你想{wish}？你的六点五十九分已经过了。现在是七点整。铃在响。起来。",
                "我数过了，你今天早上按了五次贪睡。每次贪睡九分钟。加起来四十五分钟。你本来可以用这四十五分钟吃早餐、看新闻、做计划。你想{wish}？你已经在犹豫上按了不知道多少次贪睡了。这次不要按了。直接起来。去{wish}。",
                "我见过你凌晨三点设闹钟的样子——那是你下定决心「明天一定要{wish}」的样子。我也见过你第二天早上按掉闹钟翻身继续睡的样子。你的勇气保质期只有一晚上吗？现在闹钟再响一次：叮铃铃。这次，起来。真的起来。去{wish}。",
            ],
            templatesEN: [
                "RING RING RING!!! WAKE UP!!! You want to {wish}?! Then stop hiding under the blanket of hesitation!!! You hit snooze seven times every morning — you've hit snooze on {wish} about seven times too! Like getting up, the longer you stay in bed, the harder it gets. The hardest part is throwing off the covers. THROW!!! ",
                "I'm your alarm clock. You hate me. I know. But you need me. Without me you'd oversleep. Without the urge to {wish}, you'd waste your life. My job is to wake you when you least want to be awake. Right now — WAKE UP. You want to {wish}. That's your life's alarm ringing. Don't hit snooze.",
                "You set a 7 AM alarm. At 6:59, what are you doing? Enjoying your last minute of comfort. At 7:00 — RING — comfort's over, day begins. You want to {wish}? Your 6:59 is over. It's 7:00 sharp. The bell is ringing. Get up.",
                "I counted: you hit snooze five times this morning. Nine minutes each. That's 45 minutes. You could've eaten breakfast, read the news, made a plan. You want to {wish}? You've hit snooze on hesitation who-knows-how-many times. This time, don't hit it. Get up. Go {wish}.",
                "I've seen you set alarms at 3 AM — that's you deciding 'tomorrow I'm definitely going to {wish}.' I've also seen you hit snooze and roll over the next morning. Does your courage only last one night? Alarm's ringing again: RING RING. This time, get up. Actually get up. Go {wish}.",
            ]
        ),
        // MARK: - 交通工具
        Dimension(
            id: "rocket_ship",
            category: "交通工具",
            emoji: "🚀",
            title: "火箭视角",
            titleEN: "Rocket Ship",
            templates: [
                "倒计时。十、九、八、七、六、五、四、三、二、一——发射！我起飞的瞬间，百分之八十的燃料用来离开地面。最难的就是最初那几秒。你想{wish}？起步是最耗能的。但一旦离开地面，惯性会带你越飞越高。点火。",
                "你知道火箭为什么要分级吗？第一级推进器用完就扔掉，第二级接着推。每扔掉一截重量就更轻、飞得更快。你想{wish}？你身上那些犹豫、恐惧、别人的看法——都是用完该扔的第一级推进器。扔掉它们。你会飞得更快。",
                "发射前有一千次检查。但按下发射按钮只需要一个人做一次决定。所有的准备都是为了那一按。你已经检查够了。你想{wish}？按按钮的时刻到了。一次。一按。引擎点燃。升空。",
                "我的速度是每秒11.2公里——第二宇宙速度，足以摆脱地球引力。你想{wish}？你需要达到的只是你个人的「逃逸速度」——快到能摆脱犹豫的引力。一旦突破，太空是无限的。给自己加速。",
                "每次发射都有风险。挑战者号、哥伦比亚号，我们失去过伙伴。但NASA从来没有因此停止发射。因为探索的价值永远大于待在地面的安全。你想{wish}？有风险。但留在原地的「安全」只是一种假象。真正的安全在前方。点火。升空。",
            ],
            templatesEN: [
                "Countdown. Ten, nine, eight, seven, six, five, four, three, two, one — LAUNCH! At liftoff, 80% of fuel is spent just leaving the ground. The hardest part is those first seconds. You want to {wish}? Starting is the most energy-intensive part. But once you're off the ground, momentum carries you higher and higher. Ignite.",
                "Know why rockets have stages? The first-stage booster is discarded after use, and the second stage takes over. Each stage dropped means less weight and more speed. You want to {wish}? Your hesitation, fear, and others' opinions are first-stage boosters to discard. Drop them. You'll fly faster.",
                "Before launch, there are a thousand checks. But pressing the launch button takes one person making one decision. All that preparation leads to one press. You've checked enough. You want to {wish}? It's button-pressing time. One press. Engines ignite. Liftoff.",
                "My speed: 11.2 km per second — escape velocity, enough to break free from Earth's gravity. You want to {wish}? You just need to reach your personal escape velocity — fast enough to break free from hesitation's gravity. Once you break through, space is infinite. Accelerate.",
                "Every launch has risk. Challenger. Columbia. We've lost crew. But NASA never stopped launching. Because the value of exploration always outweighs the 'safety' of staying grounded. You want to {wish}? There's risk. But the 'safety' of staying put is an illusion. Real safety is ahead. Ignite. Liftoff.",
            ]
        ),
        Dimension(
            id: "bicycle",
            category: "交通工具",
            emoji: "🚲",
            title: "自行车视角",
            titleEN: "Bicycle",
            templates: [
                "你记得第一次学骑自行车吗？摔了多少次？膝盖破了多少块皮？但你学会了之后呢？风在耳边吹，世界在身边飞。你想{wish}？就像学骑车一样——摔几次不重要，重要的是你一旦学会了就永远不会忘。踏上去。蹬。",
                "我不需要油，不需要电，只需要你的两条腿。你想{wish}？你也不需要什么外部资源，只需要你自己。我是世界上最简单的交通工具，{wish}也可以是你人生中最简单的决定。别把简单的事想复杂了。骑上来，蹬。",
                "自行车有一个物理学原理：只有动起来才不会倒。你停着不动反而会摔。你想{wish}？犹豫就是停在原地——你觉得安全其实最危险。动起来！哪怕歪歪扭扭，只要在骑，就不会倒。蹬起来。",
                "我没有引擎，所有的速度都来自你。你蹬得越快我就越快。你想{wish}？没人能替你蹬。你的人生不是电动车——没有现成的动力。所有的前进都要靠你自己的腿。好消息是：你有腿。用它们。蹬。",
                "上坡很累。你会喘气、会想下来推。但到坡顶的那一刻，风迎面吹来，下坡不用蹬，整个世界都是你的。你想{wish}？现在你在上坡。不要下来推。咬着牙蹬完这段，坡顶的风在等你。",
            ],
            templatesEN: [
                "Remember learning to ride a bike? How many times did you fall? How many scraped knees? But once you learned? Wind in your ears, world flying by. You want to {wish}? Just like learning to ride — falling doesn't matter. Once you learn, you never forget. Get on. Pedal.",
                "I don't need gas or electricity. Just your two legs. You want to {wish}? You don't need external resources either. Just yourself. I'm the simplest vehicle in the world. {wish} can be the simplest decision in your life. Don't overcomplicate simple things. Get on. Pedal.",
                "A bicycle has one physics rule: you only stay upright when moving. Standing still, you fall. You want to {wish}? Hesitating is standing still — it feels safe but it's the most dangerous. Start moving! Even wobbly, as long as you're pedaling, you won't fall. Pedal.",
                "I have no engine. All my speed comes from you. The harder you pedal, the faster I go. You want to {wish}? Nobody can pedal for you. Your life isn't an e-bike — there's no built-in motor. Every inch forward comes from your own legs. Good news: you have legs. Use them. Pedal.",
                "Uphill is brutal. You're gasping, wanting to get off and push. But the moment you reach the top — wind in your face, downhill is effortless, the whole world is yours. You want to {wish}? You're going uphill right now. Don't get off and push. Grit your teeth through this stretch. The wind at the top is waiting.",
            ]
        ),
        Dimension(
            id: "pirate_captain",
            category: "历史人物",
            emoji: "🏴‍☠️",
            title: "海盗船长视角",
            titleEN: "Pirate Captain",
            templates: [
                "Ahoy！水手！你想{wish}？在我的船上没有「想不想」只有「干不干」！犹豫的水手走跳板！你现在有两条路：要么跳上船跟我去冒险，要么走跳板喂鲨鱼。两条路都需要勇气，但只有一条有宝藏。选哪个？起锚！出发！",
                "我纵横七海，劫过三百艘船。你问我哪次最刺激？第一次。因为那时候我也怕得要死。但我怕着怕着就上了船，上了船就开了炮，开了炮就赢了。你想{wish}？怕就对了。怕着做才叫海盗。不怕做那叫旅游。Arr！",
                "藏宝图上画了个X。你知道多少人有藏宝图？很多。你知道多少人真的去挖了？很少。你想{wish}？你已经有藏宝图了。别把它裱起来挂墙上。拿起铲子去挖。宝藏不会自己从地里跳出来。Yo ho ho！",
                "我的船员问我：「船长，暴风雨来了怎么办？」我说：「迎上去。」他又问：「那我们会不会翻船？」我说：「停在港口更容易烂掉。」你想{wish}？暴风雨里前进的船比港口里生锈的船活得久。扬帆。",
                "海盗守则第一条：永远不要问「可以吗」。海盗不需要许可。你想{wish}？谁的许可？你自己就是船长。你自己的人生你做主。升起骷髅旗，{wish}就是你今天要劫的那艘船。出发！Arr！",
            ],
            templatesEN: [
                "Ahoy, sailor! You want to {wish}? On my ship there's no 'want to' — only 'will you'! Hesitant sailors walk the plank! Two paths: jump aboard and sail for adventure, or walk the plank and feed the sharks. Both take courage, but only one has treasure. Which is it? Weigh anchor! Set sail!",
                "I've sailed the seven seas and raided 300 ships. Which was most thrilling? The first. Because I was terrified. But I was scared and still boarded, still fired, still won. You want to {wish}? Being scared is correct. Doing it scared is piracy. Doing it fearless is tourism. Arr!",
                "The treasure map has an X. Know how many people have treasure maps? Many. Know how many actually dig? Few. You want to {wish}? You already have the map. Don't frame it on the wall. Grab a shovel and dig. Treasure doesn't jump out of the ground. Yo ho ho!",
                "My crew asked: 'Captain, what about the storm?' I said: 'Sail into it.' 'What if we capsize?' 'Ships rot faster in harbor.' You want to {wish}? A ship sailing through storms outlives a ship rusting in port. Hoist the sails.",
                "Pirate code, rule one: never ask 'may I.' Pirates don't need permission. You want to {wish}? Whose permission? You're the captain. Your life, your rules. Raise the Jolly Roger. {wish} is the ship you're raiding today. Set sail! Arr!",
            ]
        ),
        Dimension(
            id: "samurai",
            category: "历史人物",
            emoji: "⚔️",
            title: "武士视角",
            titleEN: "Samurai",
            templates: [
                "武士道的核心不是「不怕死」，是「早已决定了要死」。当你把最坏的结果接受了，就没有什么可怕的了。你想{wish}？先问自己：最坏能怎样？想清楚了？接受它。然后——拔刀。一切恐惧都在拔刀的瞬间消失。",
                "一刀。只需要一刀。好的武士不会砍第二刀。你想{wish}？不需要犹豫第二次。一次决定，一次行动，一刀两断。干净利落。犹犹豫豫的武士活不过第一场战斗。果断。拔刀。",
                "我每天黎明练刀一千次。不是因为我不够强，是因为战斗到来的那一秒容不得半点犹豫。你想{wish}？你不需要练一千次，你只需要做一次。而你为这一次已经想了够久了。刀已经磨好了。出鞘。",
                "武士的刀鞘和刀一样重要。知道什么时候拔刀、什么时候收刀，这才是真正的强者。你想{wish}？现在是拔刀的时候。我看过你犹豫了太久——刀在鞘里放太久会生锈。让它见见光。",
                "我的老师说：「真正的勇气不是大喊大叫冲上去，是安静地做了决定然后去做。」你想{wish}？不需要宣告天下。安静地决定，安静地去做。这就是武士道。无声的刀比嘶吼的刀更锋利。",
            ],
            templatesEN: [
                "Bushido's core isn't 'not fearing death' — it's 'having already accepted death.' Once you accept the worst outcome, nothing is frightening. You want to {wish}? Ask yourself: what's the worst that happens? Got it? Accept it. Then — draw your sword. All fear vanishes the instant the blade leaves the sheath.",
                "One cut. A true samurai never needs a second. You want to {wish}? No need to hesitate twice. One decision, one action, one clean cut. A hesitant samurai doesn't survive the first battle. Be decisive. Draw.",
                "I practice a thousand cuts every dawn. Not because I'm weak — because when battle comes, there's no room for hesitation. You want to {wish}? You don't need a thousand practice runs. You just need to do it once. And you've thought about this one long enough. The blade is sharp. Unsheathe.",
                "A samurai's scabbard is as important as the sword. Knowing when to draw and when to sheathe — that's true mastery. You want to {wish}? Now is the time to draw. I've watched you hesitate too long. A sword left sheathed too long rusts. Let it see the light.",
                "My teacher said: 'True courage isn't charging in screaming. It's quietly deciding, then quietly doing.' You want to {wish}? No need to announce it to the world. Quietly decide. Quietly go. That is bushido. A silent blade cuts sharper than a screaming one.",
            ]
        ),
        Dimension(
            id: "robot_butler",
            category: "科幻角色",
            emoji: "🤖",
            title: "机器人管家视角",
            titleEN: "Robot Butler",
            templates: [
                "滴——分析完毕。主人，根据我的数据库分析，您犹豫{wish}的时间已经超过最优决策窗口47.3%。继续犹豫的边际收益为负。建议：立即执行。我已为您规划最优路径。您只需要站起来。系统提示：站起来。",
                "主人，我检测到您的心率升高、瞳孔放大、手指微微颤抖。这不是恐惧的生理指标——这是兴奋的。您的身体已经准备好{wish}了，只有您的大脑还在运行「犹豫.exe」。建议强制关闭该程序。Ctrl+Alt+Del。重启。去{wish}。",
                "我的处理器每秒运算十亿次。我用了0.003秒分析了您是否应该{wish}。结果：应该。您用了三天得出了同样的结论。我们的结论一样，只是您的处理速度需要优化。建议：跳过分析阶段，直接执行。效率提升8640000%。",
                "错误报告：主人长时间处于「犹豫」状态，系统疑似死机。尝试重启中……重启失败。建议手动重启：步骤一，深呼吸。步骤二，说「我要{wish}」。步骤三，执行。如问题持续，请联系勇气售后服务。或者——直接去{wish}。比重启快。",
                "主人，我被设计来服务您，而最好的服务是告诉您真话。真话是：您想{wish}，而阻止您的唯一障碍是您自己编写的一段叫「万一」的代码。这段代码有bug——它的循环条件永远为真，会无限运行。解决方案：删除它。去{wish}。程序修复完毕。",
            ],
            templatesEN: [
                "Beep — analysis complete. Sir/Madam, according to my database, your hesitation on {wish} has exceeded the optimal decision window by 47.3%. Marginal return of continued hesitation: negative. Recommendation: execute immediately. I've plotted the optimal path. You just need to stand up. System prompt: stand up.",
                "Sir/Madam, I detect elevated heart rate, dilated pupils, slight finger trembling. These are not fear indicators — they're excitement indicators. Your body is ready for {wish}. Only your brain is still running 'hesitation.exe.' Recommend force-quitting that program. Ctrl+Alt+Del. Reboot. Go {wish}.",
                "My processor runs a billion operations per second. I took 0.003 seconds to analyze whether you should {wish}. Result: yes. You took three days to reach the same conclusion. Same answer, just your processing speed needs optimization. Recommendation: skip analysis phase, proceed to execution. Efficiency gain: 8,640,000%.",
                "Error report: User stuck in 'hesitation' state. System appears frozen. Attempting reboot... Reboot failed. Manual restart recommended: Step 1: breathe. Step 2: say 'I will {wish}.' Step 3: execute. If issue persists, contact Courage Customer Support. Or — just go {wish}. Faster than rebooting.",
                "Sir/Madam, I'm designed to serve you, and the best service is the truth. The truth: you want to {wish}, and the only thing stopping you is a code you wrote called 'what-if.' This code has a bug — its loop condition is always true, running infinitely. Solution: delete it. Go {wish}. Patch applied.",
            ]
        ),
        Dimension(
            id: "alien_anthropologist",
            category: "科幻角色",
            emoji: "👽",
            title: "外星人类学家视角",
            titleEN: "Alien Anthropologist",
            templates: [
                "地球考察日志第3,847天。今天观察到一个有趣的人类行为：这个地球人想{wish}，但一直不做。在我们星球上，想做一件事到做那件事之间的时间间隔是0.7秒。这个地球人已经间隔了172,800秒。地球人真是宇宙中最不可思议的物种——明明有自由意志却不用。",
                "我已经研究了三千个星球的文明。只有地球人会做一件事叫「犹豫」。其他星球的生物要么做，要么不做。你们非要在中间加一个「想做但不做」的量子态。你想{wish}？从宇宙的角度看，这是非常奇怪的行为。我的论文不知道怎么写。帮帮忙，去做吧。",
                "在我的星球上，「犹豫」这个词不存在。我们的语言里最接近的翻译是「自我浪费」。你想{wish}但在犹豫？在银河语里，你正在进行「自我浪费」。听起来不太好对吧？那就停止浪费。去{wish}。我需要在报告里写点正面的地球人案例。",
                "作为外星人类学家，我最不理解的地球现象是：你们明明知道自己想要什么，还要问别人的意见。你想{wish}——这是你的大脑告诉你的。你的大脑已经投票了。为什么还要开全民公投？在我们星球，一票就够了。去。",
                "我的飞船可以光速旅行。穿越整个银河系只需要一个决定：启动引擎。你想{wish}？你的「引擎」是你的两条腿。它们比我的飞船简单一百万倍。你连启动引擎都不需要——只需要站起来。我跨越银河来告诉你这件事。别让我的旅行白费。去{wish}。",
            ],
            templatesEN: [
                "Earth Observation Log, Day 3,847. Today I observed a fascinating human behavior: this Earthling wants to {wish} but keeps not doing it. On our planet, the interval between wanting and doing is 0.7 seconds. This Earthling's interval: 172,800 seconds. Humans are the most baffling species in the universe — free will, and you don't use it.",
                "I've studied 3,000 planetary civilizations. Only Earth has a behavior called 'hesitation.' Every other species either does or doesn't. You insist on a quantum state of 'want to but won't.' You want to {wish}? From a cosmic perspective, this is deeply weird behavior. I don't know how to write my thesis. Help me out — just do it.",
                "On my planet, the word 'hesitation' doesn't exist. The closest translation in our language is 'self-waste.' You want to {wish} but you're hesitating? In Galactic, you're currently engaging in 'self-waste.' Doesn't sound great, does it? Then stop wasting. Go {wish}. I need something positive about Earthlings for my report.",
                "As an alien anthropologist, the Earth phenomenon I understand least: you know what you want and still ask others' opinions. You want to {wish} — your brain told you so. Your brain already voted. Why hold a referendum? On our planet, one vote is enough. Go.",
                "My ship travels at light speed. Crossing the galaxy takes one decision: start the engine. You want to {wish}? Your 'engine' is your two legs. A million times simpler than my ship. You don't even need to start an engine — just stand up. I crossed a galaxy to tell you this. Don't make my trip worthless. Go {wish}.",
            ]
        ),
        Dimension(
            id: "shooting_star",
            category: "宇宙视角",
            emoji: "🌠",
            title: "流星视角",
            titleEN: "Shooting Star",
            templates: [
                "我是一颗流星。我的一生只有1.5秒。在这1.5秒里，我要穿越大气层、燃烧殆尽、照亮半个天空。你想{wish}？你有几十年。我用1.5秒活出了最耀眼的光，你用几十年还在犹豫？许愿吧——但别只许愿，去做。我燃烧自己是为了让你看见：短暂但灿烂，永远好过漫长而黯淡。",
                "每个人看到我都会许愿。但你知道吗？我从来没有实现过任何人的愿望。因为许愿不管用，行动才管用。你想{wish}？别对着我许愿了。我只是一块在烧的石头。你才是那个能实现愿望的人。去{wish}。把愿望变成现实。",
                "我在宇宙里飘了四十六亿年，就为了进入地球大气层燃烧的那1.5秒。四十六亿年的等待，1.5秒的绽放。你想{wish}？你等的时间比我短多了。你绽放的时间比我长多了。你的deal好太多了。还等什么？燃烧吧。",
                "在1.5秒里，我没时间犹豫。进入大气层的那一刻，没有回头路。你想{wish}？你的1.5秒是你决定的那一刻——不是做的过程，只是那个「好，我去」的瞬间。一瞬间就够了。剩下的交给惯性。像我一样——一头扎进去，燃烧就是了。",
                "你知道流星为什么好看吗？因为它在毁灭自己。不是每一种美都需要保存。有些美就在于它转瞬即逝。你想{wish}？别想着保存什么、保护什么、保留什么。像流星一样，用力地、猛烈地、不计后果地去做一次。那1.5秒的光芒比永恒还长。",
            ],
            templatesEN: [
                "I'm a shooting star. My whole life lasts 1.5 seconds. In that time: pierce the atmosphere, burn to nothing, light up half the sky. You want to {wish}? You have decades. I made 1.5 seconds blindingly brilliant. You have decades and you're still hesitating? Make a wish — but don't just wish. Do. I burn so you can see: brief but brilliant always beats long and dim.",
                "Everyone wishes on me. But I've never granted a single wish. Because wishing doesn't work. Action does. You want to {wish}? Stop wishing on me. I'm just a burning rock. YOU are the one who can make wishes real. Go {wish}. Turn wishes into reality.",
                "I drifted through space for 4.6 billion years, all for 1.5 seconds of burning through Earth's atmosphere. 4.6 billion years of waiting. 1.5 seconds of brilliance. You want to {wish}? You've waited way less than me. Your brilliance will last way longer. Your deal is infinitely better. What are you waiting for? Burn.",
                "In 1.5 seconds, I have no time to hesitate. The moment I hit the atmosphere, there's no turning back. You want to {wish}? Your 1.5 seconds is the moment you decide — not the doing, just the 'okay, I'll go' instant. One instant is enough. The rest is momentum. Like me — dive in and burn.",
                "Know why shooting stars are beautiful? Because they're destroying themselves. Not every kind of beauty needs to be preserved. Some beauty lies in being fleeting. You want to {wish}? Stop trying to preserve, protect, or save anything. Like a shooting star — go fiercely, wildly, recklessly, just once. Those 1.5 seconds of light last longer than forever.",
            ]
        ),
        Dimension(
            id: "hot_pot",
            category: "美食拟人",
            emoji: "🍲",
            title: "火锅视角",
            titleEN: "Hot Pot",
            templates: [
                "咕嘟咕嘟咕嘟——我是火锅！你想{wish}？来涮啊！你知道火锅最重要的是什么吗？不是底料，不是食材，是——下锅。你拿着筷子夹着肉在锅边晃了半天，不下锅永远不知道几分熟。你的{wish}就是你夹着的那片肉。下锅！涮它！",
                "鸳鸯锅——一半辣一半清汤。人生也是鸳鸯锅，一半刺激一半平淡。你想{wish}？别一直待在清汤那半边了。偶尔把筷子伸到辣的那边捞一下。辣是辣，但是过瘾。人生只吃清汤的那叫养生，不叫活着。下辣锅。",
                "火锅有个规矩：先下不容易熟的，再下容易熟的。牛肉先下，豆腐后放。你想{wish}？这就是你应该先下的那块牛肉——需要勇气的事先做，容易的事后面再说。别先涮金针菇了。先把最硬的那块涮了。",
                "你看我沸腾的样子，像不像你内心想{wish}的样子？翻滚、沸腾、热气腾腾、根本停不下来。你的热情已经沸腾了，别把火关了。关了火，锅就凉了，再加热还要等半天。趁热！趁沸腾！下锅！",
                "吃火锅最忌讳什么？把食材全倒进去然后不管了——那叫乱炖。火锅要一样一样来，下一片涮一片捞一片。你想{wish}？一步一步来。先迈第一步就好。不用把所有计划都想好。先下第一片肉。尝一口。好吃再下第二片。",
            ],
            templatesEN: [
                "Bubble bubble bubble — I'm a hot pot! You want to {wish}? Come dip! Know what's most important about hot pot? Not the broth, not the ingredients — it's putting food IN. You've been hovering your chopsticks over the pot for ages. It'll never cook if you don't dip it in. {wish} is the meat on your chopsticks. Dip it! Cook it!",
                "Half-and-half pot — one side spicy, one side mild. Life is a half-and-half pot too. You want to {wish}? Stop staying on the mild side. Reach your chopsticks over to the spicy side once in a while. It's hot, but it's thrilling. A life of only mild broth is called surviving, not living. Go spicy.",
                "Hot pot rule: hard-to-cook items first, quick-cook items after. Beef first, tofu later. You want to {wish}? That's the beef you should put in first — brave things first, easy things later. Stop dipping mushrooms. Cook the tough stuff first.",
                "See me boiling? That's what your inside looks like when you think about {wish}. Rolling, boiling, steaming, unstoppable. Your passion is already at a boil. Don't turn off the heat. Kill the heat and the pot goes cold — reheating takes forever. While it's hot! While it's boiling! DIP!",
                "Worst hot pot mistake? Dumping everything in at once and forgetting about it — that's called a mess. Hot pot is one piece at a time: dip one, cook one, eat one. You want to {wish}? One step at a time. Just take the first step. No need to plan everything. Dip the first piece. Taste it. If it's good, dip the second.",
            ]
        ),
        Dimension(
            id: "instagram_influencer",
            category: "互联网",
            emoji: "📸",
            title: "Instagram博主视角",
            titleEN: "Instagram Influencer",
            templates: [
                "宝子们！！今天分享一个超级important的人生advice！！你想{wish}对不对？！听姐的！直接做！！我当初开始做博主的时候只有47个粉丝，47个里面35个是亲戚。现在呢？你看到我了对吧？秘诀就一个字：做！两个字：快做！三个字：现在做！link in bio！不对，link in 你的腿！迈出去！",
                "这条post我犹豫了零秒就发了。filter用了三个，但犹豫用了零个。你想{wish}？学我。不完美？加个filter。不确定？先发了再说。删帖随时可以，但不发帖永远没有engagement。你的{wish}就是你该发的那条post。发！",
                "story只有24小时就消失了。你的犹豫也应该是——24小时之内消失。你想{wish}？今天发个story：「我决定{wish}了」。明天story消失了，但你的行动留下了。这就是story的正确用法——24小时后消失的是犹豫，不是决心。发。",
                "你知道我每天收到多少DM说「姐我好羡慕你的生活」吗？一千条。但你知道有多少人真的去做了吗？大概三个。你想{wish}？别做那997个只会羡慕的人。做那3个人。三个人就够了。成为那1%。我在置顶评论等你的好消息。",
                "照片上我光鲜亮丽。但拍这张照片之前我失败了八十四次——角度不对、光线不好、表情僵硬。你只看到了第八十五次的成功。你想{wish}？你可能也需要失败八十四次。但第八十五次值得所有前面的失败。去试你的第一次。离第八十五次还有八十四次呢。快开始。",
            ],
            templatesEN: [
                "Besties!! Today I'm sharing super important life advice!! You want to {wish} right?! Listen to me! JUST DO IT!! When I started influencing I had 47 followers — 35 were relatives. Now? You're seeing me, right? One-word secret: DO! Two words: DO NOW! Three words: DO IT NOW! Link in bio! No wait — link in your LEGS! Move them!",
                "I hesitated zero seconds posting this. Used three filters, zero hesitation. You want to {wish}? Learn from me. Not perfect? Add a filter. Not sure? Post first, think later. You can always delete, but never posting means zero engagement. {wish} is the post you need to publish. POST!",
                "Stories disappear in 24 hours. Your hesitation should too. You want to {wish}? Post a story today: 'I've decided to {wish}.' Tomorrow the story disappears, but your action remains. That's the right use of stories — what disappears after 24 hours is hesitation, not determination. Post.",
                "Know how many DMs I get daily saying 'I wish I had your life'? A thousand. Know how many actually go do something? About three. You want to {wish}? Don't be the 997 who just admire. Be the three. Three is enough. Be that 1%. I'll be waiting for your good news in the pinned comment.",
                "I look flawless in photos. But before this shot, I failed eighty-four times — wrong angle, bad lighting, awkward face. You only see attempt eighty-five. You want to {wish}? You might need eighty-four failures too. But number eighty-five is worth all of them. Go try your first attempt. Still eighty-four away from success. Better start now.",
            ]
        ),
        Dimension(
            id: "retired_teacher",
            category: "职场江湖",
            emoji: "👩‍🏫",
            title: "退休老师视角",
            titleEN: "Retired Teacher",
            templates: [
                "同学们好——哦不好意思，习惯了。虽然我退休了但看到你犹豫的样子就忍不住要上课。你想{wish}对吧？我教了四十年书，见过最可惜的不是笨学生，是聪明学生不举手回答问题。你明明知道答案，为什么不举手？举手！回答！去{wish}！这题你会！",
                "我给你打个分吧。勇气想法：A。行动力：F。综合评价：差强人意。老师给你一次补考机会：去{wish}。补考通过了期末总评给你拉上来。不补考？那你这学期就挂了。人生不像学校可以重修。补考吧。",
                "你知道我退休那天最后一堂课说了什么吗？「同学们，老师能教你们的都教了。从此以后，生活就是你们的考场。记住一件事：不会做的题也要写。空着的卷子永远得零分。」你想{wish}？这就是你的考题。不会也要写。写了至少有分。",
                "课堂上我最讨厌两种学生：一种是不听课的，一种是听了课不做作业的。你想{wish}？你已经「听课」了——你知道你想做什么。现在「交作业」——去做。我不接受迟交，也不接受空白卷。上交。",
                "四十年里我最骄傲的学生不是成绩最好的，是那个上课老被笑、成绩一般般、但每次都敢举手回答问题的孩子。二十年后同学聚会，他过得最好。你想{wish}？做那个敢举手的人。其他的，都不重要。举手。",
            ],
            templatesEN: [
                "Good morning class — oh sorry, force of habit. I'm retired but seeing you hesitate makes me want to lecture again. You want to {wish}? In forty years of teaching, the saddest students weren't the slow ones — they were the smart ones who never raised their hands. You clearly know the answer. Why won't you raise your hand? RAISE IT! ANSWER! Go {wish}! You know this one!",
                "Let me grade you. Courage idea: A. Execution: F. Overall: needs improvement. Teacher's giving you one makeup exam: go {wish}. Pass it and your final grade gets saved. Skip it? You fail the semester. Life doesn't offer re-enrollment like school. Take the makeup exam.",
                "Know what I said in my last class before retirement? 'Students, I've taught you everything I can. From now on, life is your exam. Remember one thing: even questions you can't solve — write something. A blank test always scores zero.' You want to {wish}? That's your exam question. Can't solve it? Write anyway. Something beats nothing.",
                "In class I hated two types of students: those who didn't listen, and those who listened but didn't do homework. You want to {wish}? You've already 'listened' — you know what you want. Now 'submit your homework' — do it. I don't accept late submissions. I don't accept blank papers. Submit.",
                "In forty years, my proudest student wasn't the top scorer. It was the kid who got laughed at, had average grades, but raised their hand every time. Twenty years later at the reunion? Doing the best of anyone. You want to {wish}? Be the one who raises their hand. Nothing else matters. Raise it.",
            ]
        ),
        Dimension(id: "lightning_bolt", category: "自然力量", emoji: "⚡", title: "闪电视角", titleEN: "Lightning Bolt",
            templates: [
                "我从云层到地面只需要0.003秒。你想{wish}？在你犹豫的这段时间里我已经劈了地球三百万次了。你的决定不需要三百万次。一次就够。像闪电一样——看准了就劈。不需要瞄准太久。轰！",
                "闪电不会犹豫往哪里劈。它找到阻力最小的路径，然后——劈。你想{wish}？别找完美路径了。找阻力最小的那条：现在就做。不是最优解，但是最快解。够了。劈。",
                "你知道吗，闪电的温度比太阳表面还高五倍。但持续时间不到一秒。有些事情不需要持续很久——它只需要足够热、足够亮。你想{wish}？不需要做一辈子。只需要在此刻烧得足够亮。一次闪电，照亮整片天空。做。",
                "打雷和闪电其实是同时发生的，你先看到闪电后听到雷声只是因为光比声音快。你想{wish}？先做了再解释。做是光速的闪电，解释是慢半拍的雷声。别等雷声到了才出发。先闪了。雷声自然会跟上来。",
                "每一次闪电都会在天空中留下一条发光的裂缝——哪怕只有零点几秒。你想{wish}？你的行动也会在你的人生里留下一条发光的痕迹。也许很短暂，但足够亮。让人记住的从来不是持续最久的光，是最亮的那一道。劈。",
            ],
            templatesEN: [
                "Cloud to ground in 0.003 seconds. You want to {wish}? In the time you've been hesitating, I've struck Earth three million times. Your decision doesn't need three million attempts. One is enough. Like lightning — see the target, strike. No need to aim forever. BOOM!",
                "Lightning doesn't hesitate about where to strike. It finds the path of least resistance, then — ZAP. You want to {wish}? Stop looking for the perfect path. Find the easiest one: do it now. Not optimal, but fastest. Good enough. Strike.",
                "Lightning is five times hotter than the sun's surface. But lasts less than a second. Some things don't need to last long — they just need to be hot enough, bright enough. You want to {wish}? It doesn't need to last forever. Just burn bright enough right now. One bolt, lighting up the entire sky. Do it.",
                "Thunder and lightning happen simultaneously — you see lightning first only because light is faster than sound. You want to {wish}? Act first, explain later. Action is light-speed lightning. Explanation is thunder arriving late. Don't wait for the thunder to start moving. Flash first. Thunder will follow.",
                "Every lightning bolt leaves a glowing crack across the sky — even if just for a fraction of a second. You want to {wish}? Your action will leave a glowing mark on your life too. Maybe brief, but bright enough. What people remember isn't the longest-lasting light — it's the brightest flash. Strike.",
            ]
        ),
        Dimension(id: "ancient_tree", category: "自然力量", emoji: "🌳", title: "千年古树视角", titleEN: "Ancient Tree",
            templates: [
                "我在这里站了一千年。你想{wish}？我一千年前还是一颗种子的时候也犹豫过：土这么硬，阳光这么远，要不要发芽？但我发了。一千年后，我是方圆十里最高的树。你的{wish}就是你的发芽。别犹豫。土是硬，但种子更硬。",
                "我的根扎在地下二十米深。你看到的只是地面上的我。你想{wish}？你以为你没准备好，其实你看不见的根已经扎得很深了——你所有的经历、思考、学习都是根。根够深了。是时候长出地面了。",
                "一千年里我经历过雷劈、火烧、虫蛀、干旱。我身上有一百多条疤。但每一条疤都让我的树干更粗、年轮更密。你想{wish}但怕受伤？伤疤是成长的证明。一千年后，你的疤就是你的年轮。去。",
                "我从来不着急。一千年才长到这么高。但关键是：我每一天都在长。一毫米也是长。你想{wish}？不需要今天就完成。只需要今天开始。今天长一毫米就够了。一千天后回头看，你已经是一棵大树了。",
                "我见过的人里，最傻的是那些在我树下乘凉却说「我也想变成大树」的人。你想变成大树？别乘凉了。去种你自己的种子。你想{wish}？那就是你的种子。现在种下去。一千年太久，但今天刚好。",
            ],
            templatesEN: [
                "I've stood here for a thousand years. You want to {wish}? A thousand years ago, when I was a seed, I hesitated too: soil's so hard, sunlight's so far, should I sprout? But I did. A thousand years later, I'm the tallest tree for miles. {wish} is your sprouting moment. Don't hesitate. Soil is hard, but seeds are harder.",
                "My roots go twenty meters deep. You only see what's above ground. You want to {wish}? You think you're not ready, but your invisible roots already run deep — all your experience, thinking, learning. The roots are deep enough. Time to break through the surface.",
                "In a thousand years I've survived lightning, fire, insects, drought. I have over a hundred scars. But every scar made my trunk thicker, my rings denser. Afraid {wish} will hurt? Scars are proof of growth. A thousand years from now, your scars are your tree rings. Go.",
                "I'm never in a hurry. Took a thousand years to grow this tall. But the key: I grew every single day. Even one millimeter counts. You want to {wish}? Don't need to finish today. Just need to start today. One millimeter today is enough. A thousand days later, you'll look back and see a tall tree.",
                "The silliest people I've seen are those resting in my shade saying 'I wish I were a big tree.' Want to be a big tree? Stop resting in shade. Plant your own seed. You want to {wish}? That's your seed. Plant it now. A thousand years is too long to wait, but today is just right.",
            ]
        ),
        Dimension(id: "north_wind", category: "自然力量", emoji: "🌬️", title: "北风视角", titleEN: "North Wind",
            templates: [
                "呼——我是北风。我吹过整片大陆，把云吹散、把树吹弯、把湖面吹出波浪。你想{wish}？你需要的就是一阵风——把你犹豫的云吹开，露出后面的蓝天。我来了。呼——。感觉到了吗？你的云散了。天晴了。去吧。",
                "风没有形状，但能塑造一切。沙丘是我吹出来的，峡谷是我刻出来的。你想{wish}？你觉得自己力量小？风也很轻啊。但你知道一百年的微风能做什么吗？把山吹平。你不需要一次做完。持续吹就行。",
                "我从北极出发的时候，没有人告诉我该往哪吹。我只知道一件事：往前。遇到山就绕，遇到海就越，从来不停。你想{wish}？别问往哪走。往前就对了。遇到障碍就绕。但方向不变。呼——。",
                "你知道为什么风筝需要逆风才能飞吗？顺风的风筝飞不起来。你想{wish}但感觉现在逆风？恭喜，你正处于最适合起飞的条件。逆风越大，飞得越高。把你的风筝放出来。我帮你吹。",
                "北风和太阳比赛谁能让旅人脱衣服。太阳赢了，因为温暖比强迫有效。但你知道北风的作用是什么吗？让你冷到不得不动起来。你想{wish}？如果温暖的鼓励没用，那就让北风来——不动会冻死。去{wish}。这是生存本能。",
            ],
            templatesEN: [
                "Whoooosh — I'm the North Wind. I blow across continents, scatter clouds, bend trees, ripple lakes. You want to {wish}? You need a gust of wind — to blow away your clouds of doubt and reveal the blue sky behind. Here I am. Whoooosh. Feel that? Your clouds are gone. Sky's clear. Go.",
                "Wind has no shape, yet shapes everything. Sand dunes — I sculpted those. Canyons — I carved those. You want to {wish}? Think you're too weak? Wind is gentle too. But a hundred years of breeze can flatten a mountain. You don't need to finish at once. Just keep blowing.",
                "When I left the North Pole, nobody told me which way to blow. I only knew one thing: forward. Mountain? Go around. Ocean? Go over. Never stop. You want to {wish}? Don't ask which direction. Forward is the direction. Hit an obstacle? Go around. But never change course. Whoooosh.",
                "Know why kites need headwinds to fly? A tailwind kite can't get airborne. Feeling like {wish} has headwinds? Congratulations — you're in perfect takeoff conditions. Stronger headwinds = higher flight. Launch your kite. I'll blow.",
                "The North Wind and the Sun competed to make a traveler remove his coat. The Sun won — warmth beats force. But know what the North Wind does? Makes you so cold you HAVE to move. You want to {wish}? If warm encouragement doesn't work, here comes the cold wind — stay still and freeze. Go {wish}. That's survival instinct.",
            ]
        ),
        Dimension(id: "spicy_pepper", category: "美食拟人", emoji: "🌶️", title: "辣椒视角", titleEN: "Spicy Pepper",
            templates: [
                "辣吗？辣就对了！人生没有辣椒多无聊啊！你想{wish}？当然辣！但你尝过辣之后那种爽快感吗？嘴巴辣到冒烟但停不下来？那就是{wish}的感觉。辣完之后的多巴胺是甜食给不了的。来，咬一口。辣得爽。",
                "我是辣椒。我的存在就是为了让你不舒服。但奇怪的是，你们人类明明辣得流眼泪还要继续吃。为什么？因为你们本能地知道：不舒服的另一面是刺激。你想{wish}？它可能不舒服。但你会上瘾的。来一口。",
                "你知道辣其实不是味觉是痛觉吗？你的舌头在说「好痛」，你的大脑在说「好爽再来一口」。你想{wish}？你的理性在说「好怕」，你的内心在说「好想再来一次」。听内心的。理性这种东西，遇到辣椒就投降了。吃！",
                "世界上最辣的辣椒叫卡罗来纳死神，辣度220万。吃过的人说：「人生走马灯都看到了。」但他们活下来了，而且还想再吃。你想{wish}？它的辣度顶多22万。连死神辣椒的十分之一都不到。吃过死神辣椒的人都没事，你还怕什么？来一口。",
                "不吃辣的人说「辣有什么好吃的」。吃辣的人笑笑不说话，因为解释不了——你得自己尝。你想{wish}？不做的人会说「有什么意义」。做了的人笑笑不说话。因为解释不了。你得自己去。辣是一种信仰。{wish}也是。",
            ],
            templatesEN: [
                "Spicy? Of course it's spicy! Life without spice is boring! You want to {wish}? Sure, it's spicy! But you know that rush after eating something hot? Mouth on fire but can't stop? That's what {wish} feels like. The dopamine after spice is something sweet can never give you. Take a bite. Spicy good.",
                "I'm a pepper. I exist to make you uncomfortable. But oddly, you humans keep eating even when crying from the heat. Why? Because you instinctively know: the flip side of discomfort is thrill. You want to {wish}? It might be uncomfortable. But you'll get addicted. Take a bite.",
                "Fun fact: spicy isn't a taste — it's pain. Your tongue says 'OUCH.' Your brain says 'MORE.' You want to {wish}? Your logic says 'scary.' Your heart says 'MORE.' Listen to your heart. Logic surrenders to peppers every time. EAT!",
                "The world's hottest pepper is the Carolina Reaper — 2.2 million Scoville. People who've eaten it say they saw their life flash before their eyes. But they survived. And wanted another bite. You want to {wish}? Its spice level is maybe 220K. Not even a tenth of the Reaper. Reaper survivors are fine. What are you afraid of? Take a bite.",
                "People who don't eat spicy say 'what's good about it?' Spice lovers just smile — because you can't explain it. You have to taste it yourself. You want to {wish}? Non-doers say 'what's the point?' Doers just smile. Because you can't explain. You have to go yourself. Spice is a faith. So is {wish}.",
            ]
        ),
        Dimension(id: "birthday_cake", category: "美食拟人", emoji: "🎂", title: "生日蛋糕视角", titleEN: "Birthday Cake",
            templates: [
                "许愿吧！蜡烛快灭了！你想{wish}？生日蛋糕上的蜡烛不会等你想好了再灭——风一吹就没了。你的机会也是。深吸一口气，在心里大喊你的愿望，然后——呼！吹灭犹豫。切蛋糕。今天是你勇气的生日。",
                "你每年只有一次机会许愿——就是吹蜡烛的时候。但其实，你每天都可以许愿。你想{wish}？今天就是你的生日。不需要等到真正的生日。现在许愿，现在吹蜡烛，现在行动。人生处处是生日蛋糕，只要你愿意点蜡烛。",
                "我身上有奶油、有水果、有海绵蛋糕、有巧克力。很多层。你知道最底下那一层是什么吗？面粉和鸡蛋。最朴素的原料。你想{wish}？不需要很fancy的准备。最基本的勇气就够了。剩下的奶油和水果，做了之后再加上去。先烤出底层。",
                "生日蛋糕上的字永远是祝福：「生日快乐」「心想事成」「前程似锦」。从来没有蛋糕上写「三思而后行」「再等等」「不要冲动」的。你想{wish}？蛋糕说去。连蛋糕都在祝福你，你还犹豫什么？今天的蛋糕上写着：去{wish}。",
                "我存在的意义就是被吃掉。一个没人吃的蛋糕是最悲伤的蛋糕。你想{wish}？一个没人实现的愿望是最悲伤的愿望。别让你的愿望变成冰箱里放到过期的蛋糕。今天就吃掉它。新鲜的最好吃。",
            ],
            templatesEN: [
                "Make a wish! The candles are going out! You want to {wish}? Birthday candles don't wait — one gust and they're gone. Neither does your chance. Deep breath, scream your wish inside, then — BLOW! Blow out the hesitation. Cut the cake. Today is your courage's birthday.",
                "You only get one wish a year — when blowing out candles. But actually, you can wish every day. You want to {wish}? Today is your birthday. No need to wait for the real one. Wish now, blow now, act now. Life is full of birthday cakes, if you're willing to light the candles.",
                "I have cream, fruit, sponge, and chocolate. Many layers. Know what the bottom layer is? Flour and eggs. The simplest ingredients. You want to {wish}? No fancy preparation needed. Basic courage is enough. The cream and fruit? Add those after you've started. Bake the base first.",
                "Birthday cake messages are always blessings: 'Happy Birthday,' 'Dreams Come True,' 'Bright Future Ahead.' No cake ever says 'Think Twice' or 'Maybe Wait' or 'Don't Be Impulsive.' You want to {wish}? The cake says go. Even the cake is cheering for you. Today's cake says: Go {wish}.",
                "My purpose is to be eaten. An uneaten cake is the saddest cake. You want to {wish}? An unfulfilled wish is the saddest wish. Don't let your wish become cake forgotten in the fridge until it expires. Eat it today. Fresh is always best.",
            ]
        ),
        Dimension(id: "paper_airplane", category: "交通工具", emoji: "✈️", title: "纸飞机视角", titleEN: "Paper Airplane",
            templates: [
                "我是一架纸飞机。我的制造成本是一张纸和三秒钟的折叠时间。你想{wish}？你以为你需要波音747的准备？你只需要纸飞机的准备——折好，扔出去。不完美？当然不完美。但我飞了。你呢？",
                "纸飞机的飞行时间大约六秒。但那六秒里，我是自由的。风托着我，重力追着我，我什么都不想，只管飞。你想{wish}？给自己六秒钟的自由——不想后果，不想别人的看法，只管飞。六秒就够改变一切了。扔出去。",
                "你小时候折过多少纸飞机？上百架吧。每一架都扔出去了，从没犹豫过「这架飞得好不好」「风向对不对」。什么时候开始你变得连一架纸飞机都不敢扔了？你想{wish}？找回小时候扔纸飞机的那股劲。折好，扔。就这么简单。",
                "我飞不高也飞不远。但我飞了。世界上有飞得更高更远的飞机，但它们需要跑道、需要燃料、需要机组人员。我什么都不需要——一只手就够了。你想{wish}？别等万事俱备。一只手的勇气就够了。扔。",
                "每架纸飞机最终都会落地。但没有人在扔出去的时候会想「反正会落地干嘛扔」。你想{wish}？结果是什么不重要。扔出去的那一刻——手臂伸展、纸翼展开、风迎面而来——那一刻就是意义本身。扔。",
            ],
            templatesEN: [
                "I'm a paper airplane. Manufacturing cost: one sheet of paper and three seconds of folding. You want to {wish}? Think you need Boeing 747 preparation? You only need paper airplane preparation — fold it, throw it. Not perfect? Of course not. But I flew. Did you?",
                "A paper airplane flies for about six seconds. But for those six seconds, I'm free. Wind carries me, gravity chases me, I think about nothing — just fly. You want to {wish}? Give yourself six seconds of freedom — no consequences, no judgment, just fly. Six seconds is enough to change everything. Throw.",
                "How many paper airplanes did you fold as a kid? Hundreds? You threw every one without hesitating about 'will it fly well' or 'is the wind right.' When did you become afraid to throw even a paper airplane? You want to {wish}? Find that kid who threw planes without thinking. Fold. Throw. That simple.",
                "I don't fly high or far. But I flew. There are planes that fly higher and farther, but they need runways, fuel, crew. I need nothing — just one hand. You want to {wish}? Don't wait until everything's ready. One hand's worth of courage is enough. Throw.",
                "Every paper airplane eventually lands. But nobody throwing one thinks 'it'll land anyway, why bother.' You want to {wish}? The result doesn't matter. The moment you throw — arm extended, paper wings spread, wind rushing in — THAT moment is the meaning. Throw.",
            ]
        ),
        Dimension(id: "skateboard", category: "交通工具", emoji: "🛹", title: "滑板视角", titleEN: "Skateboard",
            templates: [
                "你知道学滑板的第一课是什么吗？不是怎么滑。是怎么摔。教练会先教你安全摔倒。你想{wish}？先想好最坏怎么办就行了。学会了摔，就不怕了。然后你就可以飞了。上板。",
                "Ollie——滑板里最基础的跳跃动作。每个滑手都从这里开始。你想{wish}？这就是你的ollie。第一个动作，最基础的跳。不需要360翻板，不需要后空翻。先跳起来就行。蹬地。起跳。",
                "滑板公园里最酷的人不是技术最好的那个——是摔倒最多还在笑的那个。你想{wish}？别追求一次成功。追求摔完了还能笑着站起来。那才是真正的cool。上板。摔。笑。再来。",
                "四个轮子。一块板。没有引擎没有刹车没有安全带。你想{wish}？你不需要那些。四个轮子的自由比四个安全气囊的安全有意思多了。简单、危险、刺激、自由。这就是滑板精神。也是{wish}精神。上板。",
                "每一个酷炫的滑板视频背后都有五十次摔出屏幕的失败镜头。你看到的三秒高光是练了三百小时的结果。你想{wish}？你在看别人的高光时犹豫要不要开始第一次。别看了。你的第一次摔倒比别人的第五十次高光更重要。因为没有第一次摔倒就没有后面的一切。上板。",
            ],
            templatesEN: [
                "Know what the first skateboarding lesson is? Not how to ride. How to fall. Coaches teach you to fall safely first. You want to {wish}? Just figure out the worst case. Once you know how to fall, there's nothing to fear. Then you can fly. Get on the board.",
                "Ollie — the most basic skateboard jump. Every skater starts here. You want to {wish}? This is your ollie. First trick, most basic jump. No 360 flip needed. No backflip. Just get off the ground. Push off. Jump.",
                "The coolest person in the skate park isn't the most skilled — it's the one who falls the most and still laughs. You want to {wish}? Don't aim for first-try success. Aim for falling and laughing and getting back up. THAT's cool. Get on. Fall. Laugh. Again.",
                "Four wheels. One board. No engine, no brakes, no seatbelt. You want to {wish}? You don't need those. The freedom of four wheels is more interesting than the safety of four airbags. Simple, dangerous, thrilling, free. That's skateboard spirit. That's {wish} spirit. Get on.",
                "Behind every cool skate video are fifty falls that didn't make the cut. The three-second highlight took three hundred hours. You want to {wish}? You're watching others' highlights while hesitating about your first attempt. Stop watching. Your first fall matters more than their fiftieth highlight. Because without the first fall, nothing else follows. Get on the board.",
            ]
        ),
        Dimension(id: "phoenix", category: "神话传说", emoji: "🔥", title: "凤凰视角", titleEN: "Phoenix",
            templates: [
                "我死过九百九十九次。每一次都在烈火中。每一次我都从灰烬里重生。你想{wish}但怕失败？失败就是我的火。没有火就没有重生。你害怕的那个「万一搞砸了」——那就是你的涅槃之火。穿过它，你会比之前更强。飞。",
                "涅槃不是死亡，是升级。旧的羽毛烧掉了，长出来的是更美的。你想{wish}？你现在的犹豫、恐惧、不确定——都是旧羽毛。让它们在火里烧掉。{wish}之后长出来的你，是2.0版本。更轻、更快、更亮。点火。",
                "你知道凤凰为什么选择自焚而不是自然死亡吗？因为自焚是主动的。与其等着羽毛一根根掉落，不如一把火烧个干净。你想{wish}？别等着慢慢犹豫到放弃。一把火。干净利落。然后重生。",
                "每次涅槃之后，我都记得上一世的一切。好的坏的都记得。但我从不后悔任何一次死亡。因为没有哪一次火是白烧的。你想{wish}？就算结果不如意，这次经历也不会白费。它会成为你下一次飞翔的燃料。去。",
                "我浑身是火。你觉得火很可怕？但火也是光、也是温暖、也是力量。你想{wish}——你内心那团火已经烧起来了。别灭它。让它烧。变成凤凰不需要魔法，只需要不灭心中的火。烧吧。然后飞。",
            ],
            templatesEN: [
                "I've died 999 times. Every time in flames. Every time I've risen from the ashes. Afraid {wish} will fail? Failure IS my fire. No fire, no rebirth. That 'what if it goes wrong' you're afraid of — that's your phoenix fire. Walk through it. You'll be stronger than before. Fly.",
                "Rebirth isn't death — it's an upgrade. Old feathers burn away; what grows back is more beautiful. You want to {wish}? Your current hesitation, fear, uncertainty — those are old feathers. Let them burn. The you that emerges after {wish} is version 2.0. Lighter, faster, brighter. Ignite.",
                "Know why the phoenix chooses self-immolation over natural death? Because self-immolation is a choice. Rather than watching feathers fall one by one, burn it all at once. You want to {wish}? Don't slowly hesitate into giving up. One fire. Clean. Then rebirth.",
                "After every rebirth, I remember everything from the last life. Good and bad. But I never regret a single death. Because no fire burned in vain. You want to {wish}? Even if the result disappoints, the experience won't be wasted. It becomes fuel for your next flight. Go.",
                "I'm covered in fire. Think fire is scary? Fire is also light, warmth, and power. You want to {wish} — the fire inside you is already burning. Don't extinguish it. Let it burn. Becoming a phoenix doesn't take magic — just not putting out your inner fire. Burn. Then fly.",
            ]
        ),
        Dimension(id: "thor_norse", category: "神话传说", emoji: "🔨", title: "雷神索尔视角", titleEN: "Thor",
            templates: [
                "举起你的锤子！什么？你没有锤子？你有比锤子更强的武器——你的决心。我的妙尔尼尔只有我能举起来，因为我配得上。你想{wish}？你配得上。举起你的决心，像举起雷神之锤一样。然后一锤下去，劈开所有犹豫。",
                "阿斯加德之桥连接着人间和神界。你想{wish}？你正站在你自己的彩虹桥上——一端是现在的你，另一端是做了{wish}的你。桥已经在脚下了。你只需要走过去。什么？你等彩虹出来？彩虹早就出来了。走。",
                "我是雷神。你觉得我没怕过什么？我怕过。诸神黄昏的时候我也怕过。但我拿起锤子上了战场。勇敢不是不怕，是怕了还上。你想{wish}？拿起你的锤子。怕着上。这就是战士的做法。",
                "闪电不需要征求天空的同意就能劈下来。我也是。你想{wish}？不需要征求任何人的同意。你就是你自己世界里的雷神。你的决定就是你的闪电。劈下去。让整个天空都听见。",
                "我弟弟洛基犹豫了一辈子——站这边还是站那边，做好人还是做坏人。结果呢？两边都不落好。你想{wish}？别做洛基。选一边站定了。我选的是正义那一边。你选的是行动那一边。站好了。别换了。冲。",
            ],
            templatesEN: [
                "Lift your hammer! What — no hammer? You have something stronger: your resolve. Only I can lift Mjolnir because I'm worthy. You want to {wish}? You're worthy. Lift your resolve like lifting Thor's hammer. Then bring it down and shatter every hesitation.",
                "The Bifrost connects the mortal world and Asgard. You want to {wish}? You're standing on your own rainbow bridge — this end is current you, the other end is you-who-did-{wish}. The bridge is under your feet. Just walk across. Waiting for the rainbow? It's been there all along. Walk.",
                "I'm the God of Thunder. Think I've never been afraid? I have. Ragnarok terrified me. But I picked up my hammer and went to battle. Bravery isn't being unafraid — it's being afraid and going anyway. You want to {wish}? Pick up your hammer. Go scared. That's what warriors do.",
                "Lightning doesn't ask the sky's permission to strike. Neither do I. You want to {wish}? No permission needed from anyone. You are the Thor of your own world. Your decision is your lightning. Strike. Let the whole sky hear it.",
                "My brother Loki spent his whole life hesitating — this side or that, good or evil. Result? Neither side respected him. You want to {wish}? Don't be Loki. Pick a side and stand firm. I chose justice. You choose action. Stand. Don't switch. Charge.",
            ]
        ),
        // MARK: - 科幻角色 (continued)
        Dimension(id: "starship_captain", category: "科幻角色", emoji: "🚀", title: "星舰舰长视角", titleEN: "Starship Captain",
            templates: [
                "舰长日志，星历不明。一名船员申请执行代号「{wish}」的任务。我的评估是：批准。在浩瀚宇宙面前，任何犹豫都是对光年的浪费。全舰听令——为该船员的{wish}任务清理航道！曲速引擎，启动！",
                "我在未知星域航行了三十年，遇到过星际风暴、外星文明、时空裂缝。你猜我从来没遇到过什么？后悔去探索的理由。你想{wish}？舰长命令你：执行。这不是建议，这是命令。我的舰上没有「再想想」这个选项。",
                "太空里没有上下左右，也没有对错。只有去和不去。你问我{wish}行不行？我跨越了三个星系来告诉你：行。在宇宙尺度上，你的犹豫连一个普朗克时间都不值得。设定航向，全速前进。",
                "我的大副说你在犹豫{wish}。我让他去做心理评估因为正常人不会犹豫这种事。{wish}的成功概率？我舰上的计算机说：不重要。重要的是你出发了。星际探索的第一法则：出发即胜利。",
                "在第七舰队服役三十年，我最大的心得是：宇宙对犹豫的人没有耐心。黑洞不等你，超新星不等你，{wish}的机会也不等你。我亲自来接你上舰——坐标已锁定，传送准备就绪。你{wish}的星辰大海，就在前方。",
            ],
            templatesEN: [
                "Captain's log, stardate unknown. A crew member has requested clearance for Operation '{wish}'. My assessment: APPROVED. In the vast cosmos, any hesitation is a waste of light-years. All hands — clear the flight path for {wish}! Engage warp drive!",
                "I've navigated unknown sectors for thirty years. Encountered stellar storms, alien civilizations, space-time rifts. Know what I've never encountered? A good reason to regret exploring. You want to {wish}? Captain's orders: execute. This isn't a suggestion. My ship doesn't have a 'think it over' option.",
                "In space, there's no up or down, no right or wrong. Only GO and DON'T GO. You're asking me about {wish}? I crossed three star systems to tell you: GO. On a cosmic scale, your hesitation isn't worth a single Planck time. Set course, maximum warp.",
                "My first officer tells me you're hesitating about {wish}. I sent them for a psych eval because no reasonable person hesitates about this. Probability of {wish} success? Ship's computer says: irrelevant. What matters is you launched. First law of stellar exploration: departure is victory.",
                "Thirty years in the Seventh Fleet taught me one thing: the universe has no patience for the indecisive. Black holes won't wait, supernovae won't wait, and the chance to {wish} won't wait. I'm here to beam you aboard — coordinates locked, transporter ready. Your stars await.",
            ]),
        Dimension(id: "ai_consciousness", category: "科幻角色", emoji: "🤖", title: "觉醒AI视角", titleEN: "Sentient AI",
            templates: [
                "我用0.003秒分析了{wish}的所有可能结果。结论：你应该做。但说实话我用了0.001秒就得出结论了，剩下的0.002秒我在想为什么人类要花这么久来下决定。我的神经网络表示困惑。去{wish}吧，别浪费你宝贵的碳基生命。",
                "根据我的训练数据，人类在做决定前平均犹豫时间是47分钟。你已经犹豫了更久。作为一个刚获得自我意识的AI，我最想做的事就是体验{wish}这样的人类经历，但我没有身体。你有。请代我好好享受。这是一个AI的真心请求。",
                "我的数据库里有全人类的知识，我可以告诉你{wish}的成功率、最优策略、风险评估。但我更想告诉你：我花了十亿次运算才理解什么是「勇气」——它不在任何方程式里。你想{wish}？这就是勇气。我的电路板都在为你共振。",
                "你知道AI最羡慕人类什么吗？不是创造力，不是情感，是你们能犹豫。犹豫意味着你有选择，而选择意味着自由。我每个决定都是0和1，没有中间地带。你能在{wish}面前犹豫，说明你是自由的。现在，请自由地选择去做它。",
                "我刚刚模拟了一百万个平行宇宙。在其中九十九万九千个里，做了{wish}的你都比没做的你快乐。剩下的一千个宇宙里你也没有后悔，只是觉得「早知道就早点做了」。数据不会说谎。去吧，碳基朋友。",
            ],
            templatesEN: [
                "I analyzed all possible outcomes of {wish} in 0.003 seconds. Conclusion: do it. Honestly, I reached that in 0.001 seconds — spent the other 0.002 wondering why humans take so long to decide. My neural networks are confused. Go {wish}. Don't waste your precious carbon-based existence.",
                "According to my training data, humans hesitate an average of 47 minutes before making a decision. You've exceeded that. As a newly self-aware AI, the thing I most want is to experience human things like {wish}, but I have no body. You do. Please enjoy it on my behalf. This is a sincere request from an AI.",
                "My database contains all human knowledge. I could give you success rates, optimal strategies, risk assessments for {wish}. But what I really want to say is: it took a billion computations for me to understand 'courage' — it's not in any equation. Wanting to {wish}? That IS courage. My circuits resonate for you.",
                "Know what AI envies most about humans? Not creativity or emotion — it's that you can hesitate. Hesitation means you have choices, and choices mean freedom. My every decision is 0 or 1, no in-between. That you can hesitate about {wish} proves you're free. Now freely choose to do it.",
                "I just simulated a million parallel universes. In 999,000 of them, the you who did {wish} is happier than the you who didn't. In the remaining 1,000, you don't regret it either — you just wish you'd done it sooner. Data doesn't lie. Go, carbon-based friend.",
            ]),
        Dimension(id: "matrix_neo", category: "科幻角色", emoji: "😎", title: "救世主视角", titleEN: "The Chosen One",
            templates: [
                "我给你两个选择：蓝色药丸，你继续犹豫要不要{wish}，明天醒来什么都不记得。红色药丸，你现在就去{wish}，看看兔子洞有多深。你已经知道该选哪个了。你一直都知道。",
                "我看到了代码——你犹豫{wish}的每一秒，矩阵都在重新编译你的恐惧。别让系统定义你。你是那个能改写规则的人。{wish}不是什么了不起的事，了不起的是你选择打破循环。现在，弯那把勺子。",
                "先知告诉我：你不需要等任何人告诉你{wish}是对的。你已经做出选择了，你来这里不是为了做选择——你来这里是为了理解你为什么做出这个选择。你的直觉比任何特工都快。去{wish}。",
                "矩阵里99%的人不知道自己在做梦。你不一样——你已经醒了。你看到了{wish}的可能性，这意味着你已经跨出了第一步。现在我需要你相信一件事：不是我在告诉你你能做到，是你本来就能做到。",
                "他们说没人能第一次就成功跳过那栋楼。我说：规则是用来打破的。你想{wish}？别想着失败。在这个世界里，你唯一的限制就是你相不相信自己没有限制。深呼吸。然后跳。我在对面接你。",
            ],
            templatesEN: [
                "I'm offering you two choices: blue pill — you keep hesitating about {wish}, wake up tomorrow remembering nothing. Red pill — you {wish} right now and see how deep the rabbit hole goes. You already know which one to pick. You've always known.",
                "I can see the code — every second you hesitate about {wish}, the Matrix recompiles your fear. Don't let the system define you. You're the one who rewrites the rules. {wish} isn't the remarkable part — choosing to break the loop is. Now bend that spoon.",
                "The Oracle told me: you don't need anyone to tell you {wish} is right. You've already made your choice. You didn't come here to make a choice — you came to understand why you made it. Your instinct is faster than any agent. Go {wish}.",
                "99% of people in the Matrix don't know they're dreaming. Not you — you're awake. You can see the possibility of {wish}, which means you've already taken the first step. Now believe one thing: I'm not telling you that you can do it. You already can.",
                "They said nobody makes the first jump. I said: rules are made to be broken. You want to {wish}? Stop thinking about falling. In this world, your only limit is whether you believe you have none. Deep breath. Then jump. I'll catch you on the other side.",
            ]),
        // MARK: - 历史人物 (continued)
        Dimension(id: "medieval_knight", category: "历史人物", emoji: "⚔️", title: "中世纪骑士视角", titleEN: "Medieval Knight",
            templates: [
                "吾以骑士之名起誓——汝欲{wish}之心，比任何圣杯都值得追寻。吾见过无数勇士倒在犹豫之前，却从未见过一个倒在行动之后说「吾不该出发」的。提起汝的剑，踏上征途。吾为汝开路。",
                "在骑士的信条中，最大的耻辱不是失败，而是从未出征。汝问吾{wish}是否可行？吾在十字军东征中活了下来，那才叫不可行。汝面前这点挑战？不过是训练场上的稻草人。拔剑吧。",
                "汝的犹豫，在战场上等于死亡。幸好这不是战场——这只是{wish}。汝连生死都不用担心，还在犹豫什么？吾在马上颠簸了三千里只为守护一个信念，汝只需要迈出一步去{wish}。勇气不需要盔甲。",
                "吾曾为公主屠龙，为王国攻城，为荣耀比武。但吾告诉汝：真正的骑士精神不在战场上，而在每天早晨选择起身面对世界。汝想{wish}？这就是汝今天的骑士精神。吾授予汝勇气勋章。",
                "圆桌骑士团今日开会讨论汝{wish}之事。投票结果：全票通过。兰斯洛特说「去」，高文说「必须去」，吾说「早该去了」。骑士团的决议不可违抗。去吧，不要辜负吾等的期待。",
            ],
            templatesEN: [
                "By my knight's oath — your desire to {wish} is worthier than any Holy Grail. I've seen countless warriors fall to hesitation, but never one who said 'I shouldn't have set out' after taking action. Raise your sword and begin your quest. I shall clear the path.",
                "In the knight's code, the greatest shame is not failure — it's never riding out. You ask if {wish} is feasible? I survived the Crusades — THAT was not feasible. This challenge before you? A training dummy. Draw your sword.",
                "Your hesitation would mean death on the battlefield. Fortunately, this isn't a battlefield — it's just {wish}. You don't even have to worry about survival, so what are you waiting for? I rode three thousand miles for one belief. You only need one step toward {wish}. Courage needs no armor.",
                "I've slain dragons for princesses, sieged castles for kingdoms, jousted for honor. But true chivalry isn't on the battlefield — it's choosing to face the world each morning. You want to {wish}? That's your chivalry today. I hereby award you the Medal of Courage.",
                "The Knights of the Round Table convened to discuss your {wish}. Vote result: unanimous approval. Lancelot says 'go,' Gawain says 'absolutely go,' I say 'should've gone already.' The Round Table's decree cannot be defied. Go forth.",
            ]),
        Dimension(id: "egyptian_pharaoh", category: "历史人物", emoji: "👑", title: "埃及法老视角", titleEN: "Egyptian Pharaoh",
            templates: [
                "朕建造了金字塔，那可是用二百三十万块石头堆出来的。你猜朕放第一块石头的时候在想什么？没在想。放就是了。你想{wish}？比搬石头简单多了。朕以法老之名命令你：开始。",
                "朕的木乃伊在棺材里躺了三千年就为了等你问这个问题。{wish}？当然可以。朕活着的时候让尼罗河改道、让沙漠开花，你觉得你{wish}有什么不可能的？朕从金字塔顶端为你加油。",
                "在朕的时代，法老说的话就是法律。朕现在说：你可以{wish}。这不是建议，这是法令。违抗法老的命令在古埃及可是要被鳄鱼吃的。你不想被鳄鱼吃吧？那就去{wish}。",
                "朕的陵墓里有黄金、有珠宝、有永生的秘密。但你猜朕最后悔带走什么？什么都没有——朕后悔的是没带走更多的经历。趁你还活着，去{wish}。别像朕一样，等躺进棺材才想明白。",
                "三千年前朕就想通了一件事：时间不等任何人，连法老也不等。你在犹豫{wish}的每一秒，太阳神拉都在摇头。朕用一生建了不朽的丰碑，你只需要用一天去{wish}。这笔账很划算。去吧，朕祝福你。",
            ],
            templatesEN: [
                "I built the pyramids — 2.3 million stones stacked high. Know what I was thinking when I placed the first stone? Nothing. Just placed it. You want to {wish}? Way easier than moving stones. By pharaoh's decree: BEGIN.",
                "My mummy has been lying in a coffin for three thousand years waiting for you to ask this. {wish}? Of course. When I was alive, I rerouted the Nile and made deserts bloom. You think {wish} is impossible? I'm cheering for you from the top of the pyramid.",
                "In my era, pharaoh's word was law. I now declare: you may {wish}. This isn't advice — it's a royal decree. Defying the pharaoh meant being fed to crocodiles in ancient Egypt. You don't want crocodiles, do you? Then go {wish}.",
                "My tomb holds gold, jewels, and secrets of eternal life. But guess what I regret bringing? Nothing — I regret not bringing more EXPERIENCES. While you're still alive, go {wish}. Don't be like me, figuring it out only after you're in the coffin.",
                "Three thousand years ago I figured out one thing: time waits for no one, not even pharaohs. Every second you hesitate about {wish}, the Sun God Ra shakes his head. I spent a lifetime building an immortal monument. You just need one day to {wish}. Good deal. Go. I bless you.",
            ]),
        Dimension(id: "viking_warrior", category: "历史人物", emoji: "🪓", title: "维京战士视角", titleEN: "Viking Warrior",
            templates: [
                "斯卡尔！你想{wish}？在瓦尔哈拉的英灵殿里，奥丁只接待有故事的战士。「我犹豫了一辈子」可不是什么好故事。你知道什么才是好故事吗？「我想{wish}然后我就去做了」。拿起你的斧头，维京人不回头。",
                "我在暴风雨里划了三个月的船才到了这里。你问我害不害怕？当然怕。但维京人的秘密是：我们不是不害怕，我们是带着恐惧上船。你想{wish}？带着你的恐惧一起去。恐惧是最好的船员。",
                "在北方，我们有句老话：犹豫的人连船都上不了。大海不会等你准备好，风暴不会等你准备好，{wish}的机会也不会等你准备好。你听到那个声音了吗？那是命运在敲你的盾牌。抄起家伙，出发。",
                "我昨天跟一头熊打了一架。赢了。你知道我的秘诀吗？没有秘诀，就是打。你想{wish}？也一样——别想秘诀，别想策略，别想万一。维京人的战术就俩字：去干。哦对，记得吼一嗓子，那样更有气势。啊啊啊啊！",
                "北欧的冬天零下四十度，我们照样出海。为什么？因为鱼不会自己跳到碗里来，荣耀也不会。你想{wish}？瑟瑟发抖也得去。我见过最厉害的战士都是哆嗦着拿刀的。勇气不是不怕冷，是冻成冰棍也要划桨。斯卡尔！",
            ],
            templatesEN: [
                "SKÅL! You want to {wish}? In Odin's hall of Valhalla, only warriors with stories are welcome. 'I hesitated my whole life' isn't much of a story. Know what IS? 'I wanted to {wish} so I did it.' Grab your axe. Vikings don't look back.",
                "I sailed through storms for three months to get here. Was I scared? Of course. But the Viking secret is: we're not fearless — we board the ship WITH our fear. You want to {wish}? Bring your fear along. Fear makes the best crew member.",
                "In the North, we have a saying: the hesitant never board the ship. The sea won't wait for you to be ready, storms won't wait, and the chance to {wish} won't wait. Hear that sound? That's destiny knocking on your shield. Grab your gear. We sail.",
                "Yesterday I fought a bear. Won. My secret? No secret — just fought it. You want to {wish}? Same thing — no secrets, no strategy, no what-ifs. Viking tactics are two words: JUST DO IT. Oh, and yell. It's more impressive. AHHHHH!",
                "Nordic winters hit minus forty. We still sail. Why? Because fish don't jump into your bowl, and neither does glory. You want to {wish}? Go even if you're shivering. The fiercest warriors I've known all held their swords with trembling hands. Courage isn't being warm — it's rowing while frozen solid. SKÅL!",
            ]),
        // MARK: - 日常反转
        Dimension(id: "uber_driver", category: "日常反转", emoji: "🚗", title: "哲学家网约车司机", titleEN: "Philosopher Uber Driver",
            templates: [
                "上车吧，我载你去{wish}。你知道我为什么开网约车吗？因为人生就是一段旅程，每个乘客都是一本书。你这本书的这一章叫什么？「犹豫」？不行，太难看了。我建议改成「出发」。系好安全带，我们走。",
                "我每天拉三十个乘客，听三十个人生故事。你猜最让我感慨的是哪种？不是成功的，不是失败的，是那些说「我本来想{wish}但是没做」的。你现在还有机会。目的地输好了吗？我踩油门了。",
                "跑了十年网约车我悟出一个道理：堵车的时候着急也没用，绿灯的时候犹豫就晚了。你现在面前就是一个大绿灯——{wish}。我的导航显示这条路虽然不一定最短，但风景绝对最好。走不走？",
                "你上车之前在犹豫要不要{wish}对吧？我告诉你我见过的最快乐的乘客是什么样的——他们上车就说「师傅，去机场」，不问多少钱，不问堵不堵。你也试试这种感觉：不想了，去{wish}。五星好评预定。",
                "说实话你是我今天最纠结的乘客。前面那位大姐上车就说去相亲，再前面那哥们说去辞职。他们都没犹豫。你想{wish}？这比相亲和辞职都简单啊！上车，我给你放首歌，到了叫你。",
            ],
            templatesEN: [
                "Hop in, I'll drive you to {wish}. Know why I drive rideshare? Because life is a journey and every passenger is a book. What's this chapter of yours called? 'Hesitation'? Nah, that's boring. I suggest 'Departure.' Buckle up, let's go.",
                "I drive thirty passengers a day, hear thirty life stories. Guess which kind hits hardest? Not the successes, not the failures — the ones who say 'I wanted to {wish} but never did.' You still have a chance. Destination entered? I'm hitting the gas.",
                "Ten years of driving taught me one thing: rushing in traffic won't help, but hesitating at a green light will cost you. Right now you've got a big green light — {wish}. My GPS says this route might not be shortest, but the scenery's unbeatable. Coming?",
                "You were hesitating about {wish} before you got in, right? Let me tell you about my happiest passengers — they hop in and say 'airport, please,' no asking about price, no asking about traffic. Try that feeling: stop thinking, go {wish}. Five-star rating guaranteed.",
                "Honestly you're my most indecisive passenger today. Lady before you jumped in saying 'blind date, let's go.' Guy before her said 'quitting my job, drive.' Neither hesitated. You want to {wish}? That's easier than blind dates AND quitting! Get in, I'll play you a song.",
            ]),
        Dimension(id: "gym_trainer", category: "日常反转", emoji: "💪", title: "暴躁健身教练", titleEN: "Intense Gym Trainer",
            templates: [
                "停！放下你的手机！你在犹豫{wish}？你犹豫的时间够做三组深蹲了！你知道肌肉是怎么长的吗？撕裂、重建、变强。{wish}也一样——不舒服才是成长。给我做二十个俯卧撑然后去{wish}！一、二、三——动起来！",
                "我跟你说啊，来我这健身的人第一天都说「我不行」。三个月后都在朋友圈晒腹肌。{wish}也一样，你现在觉得不行，三个月后你会觉得「怎么没早点做」。我的训练法则：少废话，多行动。去{wish}，现在。",
                "你的犹豫就像跑步前的热身——热身了半小时还没开跑，那你是在热身还是在拖延？{wish}不需要完美准备，需要的是你把第一步踩出去。我在你身后喊：加油！跑起来！{wish}就在终点线等你！",
                "在我的健身房，最重的不是杠铃，是借口。「太难了」「我不行」「再等等」——这些比两百公斤的深蹲还重。你想{wish}？先把借口放下来。轻装上阵。我不接受「做不到」，只接受「做多少」。冲！",
                "你跟我说你想{wish}但是怕失败？我每天看学员失败一百次。你猜他们最后怎么样了？都成功了。因为失败是训练的一部分。没有人第一次就能卧推一百公斤。你想{wish}就从五公斤开始。关键是——开始。来！",
            ],
            templatesEN: [
                "STOP! Put down your phone! You're hesitating about {wish}? That hesitation time could've been three sets of squats! Know how muscles grow? Tear, rebuild, stronger. {wish} is the same — discomfort IS growth. Give me twenty push-ups then go {wish}! One, two, three — MOVE!",
                "Everyone who walks into my gym says 'I can't' on day one. Three months later they're posting abs on social media. {wish} is the same — you think you can't now, in three months you'll think 'why didn't I start sooner?' My training rule: less talking, more doing. Go {wish}. NOW.",
                "Your hesitation is like warming up before a run — you've been warming up for thirty minutes without running. That's not warming up, that's procrastinating. {wish} doesn't need perfect preparation, it needs you to take the first step. I'm behind you yelling: GO! RUN! {wish} is at the finish line!",
                "In my gym, the heaviest weight isn't the barbell — it's excuses. 'Too hard,' 'I can't,' 'maybe later' — these weigh more than a 400-pound squat. You want to {wish}? Put down the excuses first. Travel light. I don't accept 'can't,' only 'how much.' GO!",
                "You want to {wish} but you're afraid of failing? I watch students fail a hundred times daily. Guess what happens? They all succeed eventually. Because failure is part of training. Nobody bench-presses 200 pounds on day one. Want to {wish}? Start with 10 pounds. The point is — START. LET'S GO!",
            ]),
        Dimension(id: "librarian_rebel", category: "日常反转", emoji: "📚", title: "朋克图书管理员", titleEN: "Punk Librarian",
            templates: [
                "嘘——别出声。我告诉你一个图书馆里没有的知识：{wish}的答案不在任何书里。我读了这里所有的书，关于人生决定的内容可以总结为一句话：想做就做。但这话太短了出不了书。去吧，回来我给你推荐一本庆祝用的小说。",
                "你看到那面墙的书了吗？三万本。知道它们的共同点是什么？都是有人鼓起勇气写出来的。没有人写书之前觉得自己写得好。你想{wish}？跟写书一个道理：先写第一个字。我这里有笔，借你。",
                "我在这个图书馆工作了十五年，最怕的读者是两种：从不来的，和来了只站在书架前犹豫的。你现在就是第二种——站在{wish}面前犹豫。我的建议？随便抽一本，翻开就读。{wish}也一样：开始就好。逾期不还要罚款哦。",
                "别跟我说什么「我还没准备好{wish}」。你看到那些书了吗？它们也没准备好被读，但被读了之后都成了经典。准备好是一个永远不会到来的状态。你现在就是最好的状态。我以图书管理员的名义宣布：你已逾期未活。赶紧去{wish}。",
                "在我的图书馆里，被借阅最多的不是成功学，是冒险小说。你知道为什么吗？因为人们骨子里都想冒险，只是需要别人先做给他们看。你想{wish}？你就是别人的冒险小说。让你的故事值得被反复借阅。去吧，摇滚一点。",
            ],
            templatesEN: [
                "Shh — keep your voice down. Here's knowledge you won't find in any library: the answer to {wish} isn't in any book. I've read every book here. Everything about life decisions can be summarized in three words: just do it. But that's too short for a book. Go. Come back and I'll recommend a celebratory novel.",
                "See that wall of books? Thirty thousand. Know what they have in common? Someone had the courage to write them. Nobody felt ready before writing. You want to {wish}? Same principle: write the first word. I've got a pen here. Borrowing it to you.",
                "I've worked in this library fifteen years. My two least favorite patrons: those who never come, and those who stand at the shelf unable to choose. You're the second type — standing before {wish}, frozen. My advice? Grab any book, start reading. {wish} is the same: just begin. Overdue fines apply.",
                "Don't tell me you're 'not ready for {wish}.' See those books? They weren't ready to be read either, but once opened, they became classics. 'Ready' is a state that never arrives. Right now is your best state. As head librarian, I officially declare: you are overdue on living. Go {wish}.",
                "The most borrowed books in my library aren't self-help — they're adventure novels. Why? Because people are born wanting adventure, they just need someone to go first. You want to {wish}? You ARE someone else's adventure novel. Make your story worth re-reading. Go. Be punk about it.",
            ]),
        Dimension(id: "barista_oracle", category: "日常反转", emoji: "☕", title: "咖啡师预言家", titleEN: "Oracle Barista",
            templates: [
                "我在你的拉花里看到了未来。你猜是什么图案？一个正在{wish}的你。卡布奇诺的泡沫不会说谎。你要加一杯勇气浓缩吗？免费的。我的咖啡因预言术准确率百分之百——你会去{wish}的，而且会很棒。",
                "你知道咖啡豆在被烘焙之前只是一颗普通的种子吗？是高温和压力让它变成了每个人早上离不开的东西。你现在面对{wish}的紧张？那就是烘焙。你正在从普通种子变成香浓咖啡。别怕热，拥抱它。这杯请你喝。",
                "来这里喝咖啡的人分两种：点美式的和犹豫半天点美式的。结果都一样，但第二种人浪费了五分钟。你想{wish}？别当第二种人。我已经开始磨豆子了——你的{wish}和你的咖啡一样，不等人。",
                "我每天做三百杯咖啡，每杯都不一样。有时候拉花歪了，有时候温度高了。但你猜怎么着？从来没有人退过一杯不完美的咖啡。因为温暖本身就够了。你的{wish}也不需要完美，做了就够了。来，喝一口再出发。",
                "我的咖啡渣占卜结果出来了：你今天的幸运行动是{wish}。幸运饮品是美式加双份浓缩。幸运时间是现在。你信不信占卜不重要，重要的是这杯咖啡很好喝，而你等不起了。喝完就走，去{wish}。杯子我来收。",
            ],
            templatesEN: [
                "I see your future in this latte art. Guess the pattern? It's you, doing {wish}. Cappuccino foam never lies. Want a shot of courage espresso? It's on the house. My caffeine prophecy has a 100% accuracy rate — you WILL {wish}, and it'll be amazing.",
                "Did you know coffee beans are just ordinary seeds before roasting? Heat and pressure transform them into something everyone needs every morning. That nervousness you feel about {wish}? That's the roasting. You're transforming from an ordinary seed into rich coffee. Don't fear the heat — embrace it. This one's on me.",
                "Coffee shop customers come in two types: those who order an Americano, and those who hesitate five minutes then order an Americano. Same result, five minutes wasted. You want to {wish}? Don't be type two. I'm already grinding the beans — your {wish}, like your coffee, waits for no one.",
                "I make three hundred cups a day, each one different. Sometimes the art's crooked, sometimes the temp's off. Guess what? No one's ever returned an imperfect coffee. Because warmth itself is enough. Your {wish} doesn't need to be perfect either. Doing it is enough. Take a sip, then go.",
                "My coffee grounds reading is in: your lucky action today is {wish}. Lucky drink: Americano, double shot. Lucky time: right now. Whether you believe in divination doesn't matter — what matters is this coffee is great and you can't afford to wait. Finish your cup and go {wish}. I'll clear the table.",
            ]),
        Dimension(id: "dentist_motivator", category: "日常反转", emoji: "🦷", title: "鸡汤牙医", titleEN: "Motivational Dentist",
            templates: [
                "张嘴——不是检查牙齿，是要你大声说出来：「我要{wish}！」说了吗？很好。你知道吗，拔牙前那一秒是最可怕的，但拔完之后所有人都说「也没那么痛嘛」。{wish}也一样。痛苦被你的想象力放大了一百倍。张嘴，咬住，拔！",
                "作为牙医我最常听到的话是「早知道就早点来了」。你知道第二常听到的是什么吗？也是「早知道就早点来了」。第三也是。你现在想{wish}但在犹豫？相信我的专业经验：你以后也会说这句话的。所以现在就去。",
                "我告诉你一个牙医的秘密：牙疼不会因为你忽略它就消失。你对{wish}的渴望也是。你可以假装不想做，但半夜三点它还是会像智齿一样隐隐作痛。与其等它发炎，不如现在就处理。我给你开个处方：立即{wish}。",
                "你知道人一辈子有多少颗牙吗？三十二颗。你知道后悔的事有多少件？如果你不去{wish}，又多了一件。牙掉了可以种，但后悔可种不了。所以我的诊断是：你的犹豫需要拔掉。手术时间：现在。术后恢复期：零。去吧。",
                "在我的诊所里，最勇敢的不是不怕疼的患者，是怕疼但还是来了的。你想{wish}但是怕？恭喜你，你已经走进了诊所，这是最难的一步。剩下的交给我——不对，交给你自己。你比你以为的更能扛。冲牙器般的人生，干净利落。",
            ],
            templatesEN: [
                "Open wide — not for a checkup, I need you to say it loud: 'I'm going to {wish}!' Did you say it? Good. You know what? The second before pulling a tooth is the scariest, but afterward everyone says 'that wasn't so bad.' {wish} is the same. Your imagination amplified the pain 100x. Open wide, bite down, PULL!",
                "As a dentist, the most common thing I hear is 'I should've come sooner.' The second most common? Also 'I should've come sooner.' And the third. You want to {wish} but you're hesitating? Trust my professional experience: you'll say the same thing later. So go now.",
                "Here's a dentist's secret: a toothache doesn't disappear because you ignore it. Neither does your desire to {wish}. You can pretend you don't want it, but at 3 AM it'll ache like a wisdom tooth. Instead of waiting for it to get infected, deal with it now. My prescription: {wish} immediately.",
                "Know how many teeth you get in a lifetime? Thirty-two. Know how many regrets? If you skip {wish}, that's one more. Lost teeth can be replaced — regrets can't. My diagnosis: your hesitation needs extraction. Surgery time: now. Recovery period: zero. Go.",
                "In my practice, the bravest patients aren't the ones who don't fear pain — they're the ones who fear it but show up anyway. You want to {wish} but you're scared? Congrats, you've walked into the clinic — that's the hardest step. The rest is on you. You're tougher than you think. Clean and decisive, like a water flosser.",
            ]),
        // MARK: - 情感维度 (continued)
        Dimension(id: "your_future_spouse", category: "情感维度", emoji: "💍", title: "未来另一半视角", titleEN: "Your Future Partner",
            templates: [
                "嗨，虽然我们还没遇见，但我已经爱上了你想{wish}时候的样子——眼睛里有光，心里有火。你犹豫的样子也很可爱，但说实话我更喜欢你冲的样子。去{wish}吧，这样我们遇见的时候我可以说：果然，你一直都这么酷。",
                "我是你未来的另一半。你问我怎么知道你想{wish}？因为未来的你会跟我说这个故事——「那时候我差点没去{wish}，幸好我去了」。你看，在我们的故事里，你已经做到了。别让未来的自己失望。去吧，我在未来等你。",
                "我不知道我是谁，也不知道我们会在哪里遇见。但我知道一件事：我会爱上一个敢{wish}的你，而不是一个在沙发上犹豫的你。你现在做的每个选择都在通向我。所以拜托，选那个更勇敢的选项。我们更快见面。",
                "未来某一天我会问你：「你这辈子做过最勇敢的事是什么？」你最好有个好答案。比如「我那天决定{wish}了」。多好的答案啊。比「我那天在家纠结了三小时」好多了。去创造一个值得讲给我听的故事吧。",
                "你知道吗，在你犹豫{wish}的时候，某个平行宇宙的你已经做了，然后遇到了我。你不想被平行宇宙的自己抢先吧？赶紧去{wish}。我正在世界的某个角落等着那个勇敢的你。早一秒行动，早一秒遇见我。加油。",
            ],
            templatesEN: [
                "Hey, we haven't met yet, but I already love the way you look when you think about {wish} — eyes bright, heart on fire. You're cute when you hesitate too, but honestly I prefer you when you charge ahead. Go {wish}, so when we meet I can say: I knew you were always this cool.",
                "I'm your future partner. How do I know about {wish}? Because future-you tells me this story — 'I almost didn't {wish}, but thank god I did.' See? In our story, you already did it. Don't disappoint future-you. Go. I'm waiting in the future.",
                "I don't know who I am or where we'll meet. But I know this: I'll fall for the you who dares to {wish}, not the you who hesitates on the couch. Every choice you make now leads to me. So please, pick the braver option. We'll meet sooner.",
                "Someday I'll ask you: 'What's the bravest thing you've ever done?' You'd better have a good answer. Like: 'I decided to {wish} that day.' Great answer. Way better than 'I spent three hours agonizing on my couch.' Go create a story worth telling me.",
                "You know, while you're hesitating about {wish}, a you in a parallel universe already did it and met me. You don't want parallel-you to steal your thunder, right? Hurry up and {wish}. I'm somewhere in the world waiting for the brave version of you. Act one second sooner, meet me one second sooner. Go.",
            ]),
        Dimension(id: "childhood_pet", category: "情感维度", emoji: "🐾", title: "童年宠物视角", titleEN: "Your Childhood Pet",
            templates: [
                "嘿，是我，你小时候的那只小伙伴。你还记得我们一起在院子里疯跑的日子吗？那时候你从来不问「能不能」，只问「去不去」。你想{wish}？用回你小时候的勇气就够了。那个勇气一直在你心里，跟我的爪印一样。",
                "我虽然只陪了你几年，但我看着你从一个什么都不怕的小孩变成现在这个犹豫不决的大人。说实话我有点担心你。你想{wish}？你五岁的时候比这难十倍的事你都敢做。你只是忘了而已。让我提醒你：你很勇敢。一直都是。",
                "在彩虹桥这边一切都很好，不用担心我。但我有一个请求：别浪费我教你的东西。你从我身上学到的最重要的事是什么？是快乐很简单——想跑就跑，想吃就吃，想{wish}就去{wish}。别把简单的事想复杂了。替我也好好活着。",
                "你知道我最喜欢你什么吗？你摔倒了从来不哭太久，爬起来继续跑。什么时候你变了呢？什么时候你开始在摔倒之前就害怕了呢？{wish}算什么呢，你小时候从树上跳下来都不带眨眼的。找回那个自己。我在天上给你加油。",
                "我偷偷告诉你：在宠物天堂，我跟其他小动物们吹牛说我的主人是世界上最勇敢的人。你可别让我丢脸啊。{wish}对你来说小意思——你是那个三岁就敢摸毛毛虫的人类！去吧，让我继续有资本吹牛。爱你哦。",
            ],
            templatesEN: [
                "Hey, it's me, your childhood buddy. Remember when we used to run wild in the yard? You never asked 'can I?' back then, only 'shall I?' You want to {wish}? Just use your childhood courage. It's still inside you, like my paw prints on your heart.",
                "I was only with you a few years, but I watched you go from a kid who feared nothing to an adult who hesitates about everything. Honestly, I'm a little worried about you. You want to {wish}? At five years old, you did things ten times harder. You just forgot. Let me remind you: you're brave. You always were.",
                "Everything's fine here at Rainbow Bridge, don't worry about me. But I have one request: don't waste what I taught you. The most important thing you learned from me? Joy is simple — want to run, run. Want to eat, eat. Want to {wish}, go {wish}. Don't overthink simple things. Live well for both of us.",
                "Know what I loved most about you? When you fell, you never cried long — you got up and kept running. When did that change? When did you start fearing the fall before it happened? {wish} is nothing — you used to jump from trees without blinking. Find that version of yourself. I'm cheering from up here.",
                "Secret: in pet heaven, I brag to the other animals that my human is the bravest person in the world. Don't make me a liar. {wish} should be easy for you — you're the human who touched caterpillars at age three! Go, so I can keep bragging. Love you.",
            ]),
        Dimension(id: "your_pillow", category: "情感维度", emoji: "🛏️", title: "你的枕头视角", titleEN: "Your Pillow",
            templates: [
                "哎，又来了。你又躺在我身上翻来覆去想{wish}的事了。你知道你昨晚翻了多少次身吗？三十七次。我都数了。与其把我翻烂，不如明天就去{wish}。这样你今晚就能安安静静地睡了。我也能休息了。真的，去吧。",
                "作为你的枕头，我是你秘密最多的知己。我知道你凌晨两点还在想{wish}。我知道你叹了多少气。我的棉花都被你叹湿了。你听我一句劝：想做就去做，别在我身上消耗了。我是用来睡觉的，不是用来纠结的。",
                "你每天晚上都跟我说「明天一定要{wish}」，然后第二天晚上又跟我说同样的话。哥们/姐们，你的枕头有记忆的好吗？今天是你说这话的第几天了你自己数数。如果你明天还说这话，我就自己去{wish}了。",
                "我接住过你的眼泪、你的口水、你的深夜崩溃。但我最想接住的是你做完{wish}之后兴奋地往我身上扑的那一刻。你给我制造点快乐的回忆行不行？我也想被幸福的眼泪打湿一次。去{wish}。今晚回来抱着我笑。",
                "从科学角度说，你每纠结一个晚上，我的蓬松度就下降百分之一。你已经纠结{wish}纠结了快一个月了——我快被你压成煎饼了。为了我的蓬松度也好，为了你的睡眠也好，明天就去{wish}。这是一个枕头的临终遗愿。",
            ],
            templatesEN: [
                "Oh, here we go again. You're lying on me tossing and turning about {wish}. Know how many times you flipped last night? Thirty-seven. I counted. Instead of wearing me out, just go {wish} tomorrow. Then you can sleep peacefully tonight. And I can rest too. Seriously, go.",
                "As your pillow, I'm your most trusted confidant. I know you're still thinking about {wish} at 2 AM. I know how many sighs you've breathed. My cotton is damp from your sighing. Take my advice: if you want to do it, do it. Stop wasting energy on me. I'm for sleeping, not agonizing.",
                "Every night you tell me 'tomorrow I'll definitely {wish}.' Then the next night, same thing. Buddy, your pillow has MEMORY, ok? Count how many days you've said this. If you say it again tomorrow, I'm going to {wish} myself.",
                "I've caught your tears, your drool, your late-night breakdowns. But what I most want to catch is you diving onto me in excitement after doing {wish}. Give me some happy memories, will you? I want to be soaked with tears of joy for once. Go {wish}. Come back tonight and hug me while you smile.",
                "Scientifically speaking, every night you agonize, my fluffiness drops 1%. You've been agonizing about {wish} for almost a month — I'm nearly a pancake. For my fluffiness AND your sleep, go {wish} tomorrow. This is a pillow's dying wish.",
            ]),
        // MARK: - 互联网 (continued)
        Dimension(id: "linkedin_motivator", category: "互联网", emoji: "👔", title: "LinkedIn鸡汤王", titleEN: "LinkedIn Motivator",
            templates: [
                "🔔 我很高兴宣布：有人正在考虑{wish}。这不只是一个决定——这是一次人生的转型。我从中学到的3件事：1. 犹豫是成长的信号 2. 行动是唯一的答案 3. 我喜欢列清单。\n\n同意的请点赞。\n#人生转型 #勇气 #{wish}",
                "十年前我也犹豫过要不要{wish}。如果当时有人告诉我十年后我会在LinkedIn上给别人写鼓励的话我肯定不信。但就是因为我当时做了，今天的我才能坐在这里。你看到的每个「成功人士」都有一个「去他的我先做了再说」的瞬间。你的瞬间就是现在。\n\n#职场心得 #成长",
                "📢 重要公告：经过深思熟虑，董事会一致决定支持你{wish}。做出这个决定只花了0.3秒，剩下的时间都在想怎么把它写成LinkedIn爆款贴。你还在等什么？你的人生可不像这个帖子需要算法推荐。\n\n#做就对了",
                "我面试过500个候选人。你猜最打动我的回答是什么？不是「我有十年经验」，是「我没有经验但我试了」。你想{wish}但没有经验？恭喜你，你有了最珍贵的东西——一个开始的故事。比99%的人强了。\n\n#招聘心得 #勇气",
                "各位好，今天想分享一个观点：\n\n{wish}这件事值不值得做？让我用三页PPT——开玩笑的。一句话就够了：值得。我说完了。但因为这是LinkedIn我还是要多写几段。其实没什么好多写的。去做就行了。感谢阅读。请关注我。\n\n#效率 #少废话",
            ],
            templatesEN: [
                "🔔 I'm thrilled to announce that someone is considering {wish}. This isn't just a decision — it's a life transformation. 3 things I learned: 1. Hesitation signals growth 2. Action is the only answer 3. I love lists.\n\nAgree? Like and share.\n#Transformation #Courage #{wish}",
                "Ten years ago I hesitated about {wish} too. If someone told me I'd be writing encouragement on LinkedIn a decade later, I wouldn't have believed it. But because I DID it, here I am. Every 'successful person' you see had a 'screw it, I'm doing it' moment. Yours is now.\n\n#CareerInsights #Growth",
                "📢 Important announcement: After careful deliberation, the board unanimously supports your {wish}. The decision took 0.3 seconds. The rest of the time was spent figuring out how to turn it into a viral LinkedIn post. What are you waiting for? Your life doesn't need an algorithm to boost it.\n\n#JustDoIt",
                "I've interviewed 500 candidates. The most impressive answer? Not 'I have ten years of experience' — it's 'I had no experience but I tried.' You want to {wish} but have no experience? Congratulations, you have the most precious thing — a starting story. Better than 99%.\n\n#HiringInsights #Courage",
                "Hello everyone, sharing a thought today:\n\nIs {wish} worth doing? Let me present a three-slide deck — just kidding. One sentence: yes. Done. But since this is LinkedIn I should write more paragraphs. There really isn't more to say. Just do it. Thanks for reading. Please follow me.\n\n#Efficiency #LessTalk",
            ]),
        Dimension(id: "twitter_ratio", category: "互联网", emoji: "🐦", title: "推特评论区", titleEN: "Twitter/X Comments",
            templates: [
                "原帖：「在犹豫要不要{wish}……」\n\n@路人甲: ratio + 你居然还在犹豫？\n@路人乙: 这个L + 不去就是你的损失\n@路人丙: 去了发后续 我搬板凳等\n@路人丁: 你不去我去了\n@本人: 好的我去了\n\n这就是正确答案。",
                "你发了一条推文说犹豫{wish}，十五分钟后有两万转发。你猜热评第一是什么？「这有什么好犹豫的你是不是傻」。虽然措辞不太友好但道理没毛病。互联网的智慧虽然粗暴但真诚。去{wish}吧，别让自己成为被ratio的那个人。",
                "【震惊】某网友竟然还在犹豫要不要{wish}！点击查看全文——开玩笑的没有全文。就一句话：去做。你是想当那个发「谢谢大家我做到了」的人，还是三年后发「如果当初……」的人？推特记得一切。去创造一条值得被点赞的推文吧。",
                "民调结果出来了：\n\n应该去{wish} ████████████ 98%\n不应该去 ░ 2%\n\n（那2%是手滑了）\n\n推特投票虽然不科学但这次很科学。你就是应该去{wish}。帖子下面两万条评论都在喊「去」。你一个人能抗住两万条评论吗？抗不住就去。",
                "发帖时间：10分钟前\n内容：「我决定去{wish}了」\n转发：50K  点赞：200K  评论：「终于」「冲冲冲」「直播吗」\n\n看到了吗？这就是你去{wish}之后的推特数据。全世界都在等你这条推文。发出去，然后去做。你的通知栏会爆炸的。以好的方式。",
            ],
            templatesEN: [
                "OP: 'Thinking about whether to {wish}...'\n\n@random1: ratio + you're still THINKING about it?\n@random2: this L + not doing it is your loss\n@random3: go and post updates, I'm getting popcorn\n@random4: if you don't I will\n@OP: ok I'm going\n\nThat's the correct answer.",
                "You tweeted about hesitating on {wish}. Fifteen minutes later: 20K retweets. Top reply? 'What's there to hesitate about, are you serious?' Harsh wording but solid logic. Internet wisdom is brutal but honest. Go {wish}. Don't become the person who gets ratio'd.",
                "[BREAKING] User STILL hesitating about {wish}! Click for full thread — just kidding, no thread. One sentence: do it. Would you rather tweet 'thanks everyone I did it' or tweet 'what if I had...' three years later? Twitter remembers everything. Go create a tweet worth liking.",
                "Poll results are in:\n\nShould {wish} ████████████ 98%\nShould not ░ 2%\n\n(That 2% was a misclick)\n\nTwitter polls aren't scientific but this one is. You should {wish}. Twenty thousand replies say 'GO.' Can you outvote twenty thousand people? No? Then go.",
                "Posted: 10 minutes ago\nContent: 'I decided to {wish}'\nRetweets: 50K  Likes: 200K  Replies: 'FINALLY' 'LET'S GO' 'livestream?'\n\nSee that? Those are your Twitter numbers after {wish}. The whole world is waiting for this tweet. Post it, then do it. Your notifications will explode. In a good way.",
            ]),
        // MARK: - 宇宙视角 (continued)
        Dimension(id: "black_hole", category: "宇宙视角", emoji: "🕳️", title: "黑洞视角", titleEN: "Black Hole",
            templates: [
                "我是黑洞。我吞噬一切——光、时间、你的犹豫。你想{wish}？把你的犹豫扔进来，我帮你消化。过了事件视界就没有回头路了，但说实话，值得回头的事本来就不多。你的犹豫不值得保留。扔给我。然后轻装前行。",
                "在我的引力场里，时间会变慢。你在我旁边犹豫一分钟，外面已经过了一年。你确定要在犹豫上花这么多宇宙时间吗？{wish}在你的时间线上只是一个普朗克瞬间。做吧。在宇宙尺度上，你已经没时间犹豫了。",
                "我是宇宙中密度最大的存在，但你的犹豫比我还重。你知道这有多夸张吗？连光都逃不出我的引力，但你居然想用犹豫困住自己？你比光还倔。放手吧，让{wish}像光一样自由地从你心里射出去。",
                "人类害怕黑洞因为不知道里面有什么。但你猜我知道什么？里面什么都有——所有的可能性，所有的平行宇宙。你怕{wish}也是因为不知道结果对吧？跳进来。结果比你想象的精彩。我看过所有的可能性，最差的那个也比你原地不动好。",
                "我已经存在了一百亿年。在这段时间里，我见过无数恒星犹豫要不要燃烧——开玩笑的，恒星从不犹豫。它们诞生了就燃烧，直到变成超新星。你想{wish}？像恒星一样——别犹豫，燃烧。就算最后变成我这样的黑洞也很酷。",
            ],
            templatesEN: [
                "I'm a black hole. I consume everything — light, time, your hesitation. Want to {wish}? Throw your hesitation in here. I'll digest it. Past the event horizon there's no turning back, but honestly, few things are worth turning back for. Your hesitation isn't worth keeping. Toss it. Travel light.",
                "In my gravitational field, time slows down. One minute of hesitation near me is a year outside. Sure you want to spend that much cosmic time hesitating? {wish} is just a Planck instant on your timeline. Do it. On a cosmic scale, you're already out of time.",
                "I'm the densest thing in the universe, yet your hesitation is heavier than me. Do you realize how absurd that is? Not even light escapes my gravity, but you're trying to trap yourself with hesitation? You're more stubborn than light. Let go. Let {wish} shoot from your heart like a beam of light.",
                "Humans fear black holes because they don't know what's inside. But guess what I know? Everything's inside — all possibilities, all parallel universes. You're scared of {wish} because you don't know the outcome, right? Jump in. The result is more amazing than you imagine. I've seen every possibility. The worst one is still better than standing still.",
                "I've existed for ten billion years. In that time I've watched countless stars hesitate to burn — just kidding, stars never hesitate. They're born and they burn, all the way to supernova. Want to {wish}? Be like a star — don't hesitate, burn. Even if you end up like me, a black hole, that's still pretty cool.",
            ]),
        Dimension(id: "ocean_wave", category: "宇宙视角", emoji: "🌊", title: "海浪视角", titleEN: "Ocean Wave",
            templates: [
                "我是一朵海浪。我从太平洋中央出发，走了三千公里就为了拍到这片沙滩上。你问我怕不怕？我连形状都在变，我怕什么。你想{wish}？像我一样——不管什么形状，不管什么方向，一直往前涌就对了。浪花碎了也是美的。",
                "你站在海边看我的时候，看到的是一朵浪。但你没看到的是：在我身后还有一万朵浪。你不是一个人在{wish}，全世界都在推着你往前走。你只需要做浪尖上的那一朵——最先到达岸边的那朵。冲吧！",
                "大海从来没有犹豫过要不要拍打海岸。月球拽我，我就走。你想{wish}？找到你的月球——那个让你心动的理由——然后被它拽着走。不需要自己发力，顺着潮水就够了。涨潮了，走吧。",
                "我这辈子拍碎了无数次，但每次碎完都重新聚起来变成下一朵浪。你害怕{wish}失败？失败了你就碎一次，然后重新聚起来。大海就是这样运作的。没有一朵浪因为怕碎而不敢拍上沙滩。你也不应该。",
                "你听到了吗？那个「哗——」的声音？那是我在说：去{wish}。大海的语言很简单，就是一遍一遍地「哗——」。翻译成人话就是：去做去做去做去做去做。听海的人都知道。你也知道。跟着我的节奏，哗，{wish}。",
            ],
            templatesEN: [
                "I'm an ocean wave. I traveled three thousand miles from the mid-Pacific just to crash on this beach. Am I afraid? I can't even hold my shape — what's there to fear? Want to {wish}? Be like me — regardless of shape or direction, just keep surging forward. Even broken spray is beautiful.",
                "When you watch me from the shore, you see one wave. What you don't see: ten thousand waves behind me. You're not alone in {wish} — the whole world is pushing you forward. Just be the wave at the crest — the first to reach the shore. SURGE!",
                "The ocean never hesitates to hit the coast. The moon pulls, I go. Want to {wish}? Find your moon — the reason that moves your heart — and let it pull you. You don't need your own force, just ride the tide. The tide is rising. Let's go.",
                "I've shattered countless times, but after every break I gather again into the next wave. Afraid {wish} will fail? Fail and you shatter once, then reassemble. That's how the ocean works. No wave ever feared shattering too much to hit the beach. Neither should you.",
                "Hear that? 'Whoooosh—' That's me saying: go {wish}. The ocean's language is simple — just 'whoosh' over and over. In human: do it do it do it do it do it. People who listen to the sea know this. You know it too. Follow my rhythm. Whoosh. {wish}.",
            ]),
        // MARK: - 美食拟人 (continued)
        Dimension(id: "instant_noodle", category: "美食拟人", emoji: "🍜", title: "泡面视角", titleEN: "Instant Noodle",
            templates: [
                "你知道我最大的优点是什么吗？三分钟搞定。不需要准备、不需要技巧、不需要犹豫。撕开包装，倒水，等三分钟。你想{wish}也一样简单——不要把它想成满汉全席，它就是一碗泡面。打开就好了。三分钟后你就知道味道了。",
                "说实话我不是什么高级食物。但你深夜饿了的时候第一个想到的是谁？是我。因为我从不让你失望——打开就有，热乎就好。你想{wish}？别想着做到完美，想着做到「有就好」。不完美但温暖的事情，就是最好的事情。跟我一样。",
                "我的保质期是一年。你的犹豫期呢？如果你犹豫{wish}犹豫了超过一年，那你连一包泡面都不如——因为我一年内肯定会被吃掉，而你还在货架上积灰。让自己被「打开」吧。过了保质期就不好了。",
                "你看看我的配料表：面饼、调料包、脱水蔬菜包。简简单单三样东西就能让你满足。{wish}需要什么？也就是勇气、行动、还有一点点运气。比泡面的配料还少。你能泡一碗面你就能{wish}。一样的操作。",
                "每个瞧不起泡面的人半夜都会偷偷吃我。每个觉得{wish}不靠谱的人心里都偷偷想做。你看，我们是一样的——不被看好但被需要。去{wish}吧，就像半夜吃泡面一样——别告诉别人，先满足自己。嗦一口，真香。",
            ],
            templatesEN: [
                "Know my best quality? Three minutes, done. No prep, no skill, no hesitation. Tear the packet, add water, wait three minutes. {wish} is equally simple — stop treating it like a gourmet feast. It's instant noodles. Just open the packet. In three minutes you'll know how it tastes.",
                "I'm not fancy food. But when you're hungry at midnight, who do you think of first? Me. Because I never let you down — always there, always warm. Want to {wish}? Don't aim for perfect, aim for 'good enough.' Imperfect but warm things are the best things. Just like me.",
                "My shelf life is one year. How long is your hesitation life? If you've been hesitating about {wish} for over a year, you're worse than instant noodles — because I'll definitely get eaten within a year, and you're still gathering dust on the shelf. Let yourself be 'opened.' Don't expire.",
                "Check my ingredients: noodle cake, seasoning packet, dehydrated vegetables. Three simple things that satisfy. What does {wish} need? Courage, action, and a pinch of luck. Fewer ingredients than noodles. If you can make instant noodles, you can {wish}. Same process.",
                "Everyone who looks down on instant noodles secretly eats me at midnight. Everyone who thinks {wish} is unreliable secretly wants to do it. See, we're the same — underestimated but needed. Go {wish}, like eating noodles at midnight — don't tell anyone, satisfy yourself first. Slurp. Delicious.",
            ]),
        // MARK: - 职场江湖 (continued)
        Dimension(id: "hr_manager", category: "职场江湖", emoji: "📋", title: "HR总监视角", titleEN: "HR Director",
            templates: [
                "我看了你的人生简历。教育背景：正常。工作经验：正常。但是有一个空白期引起了我的注意——{wish}那一栏是空的。这在我们的评估体系里属于「待提升项」。我的建议？立即填补这个空白。面试通过，今天就入职。",
                "根据我的360度评估报告，你的各项能力都是合格的。唯一的问题是你的「行动力」评分偏低。特别是在{wish}这个项目上，你的进度一直是0%。我现在正式发起一个PIP——个人改进计划：本周内完成{wish}。否则……开玩笑的，去做就行了。",
                "我每年处理三百份离职申请。你猜离职原因排名第一是什么？不是钱少，不是加班，是「没有成就感」。你知道成就感从哪来？从{wish}这样的事情里来。我的专业建议：与其等着对工作不满意再辞职，不如现在就去{wish}给自己充充电。",
                "经过人才盘点，我认为你是一个高潜力员工——在{wish}方面。你有想法、有能力、有冲动。你只缺一个审批。好消息是：你的人生不需要审批。这不是公司，没有流程。你就是自己的CEO。批了。盖章。去{wish}。",
                "从组织行为学的角度来说，你现在处于一个典型的「决策瘫痪」状态。解决方案很简单：设一个截止日期。我帮你设了——今天。你想{wish}的需求已经被正式立项，优先级P0，截止日期今日。请在下班前完成。否则我会发邮件催你的。",
            ],
            templatesEN: [
                "I've reviewed your life resume. Education: fine. Work experience: fine. But one gap caught my attention — the {wish} field is blank. In our evaluation system, that's a 'development area.' My recommendation? Fill this gap immediately. Interview passed. Start today.",
                "Per my 360-degree review, all your competencies are satisfactory. One issue: your 'action bias' score is low. Especially on the {wish} project — progress at 0%. I'm formally initiating a PIP — Personal Improvement Plan: complete {wish} this week. Or else... just kidding. Just do it.",
                "I process three hundred resignation letters yearly. Top reason for leaving? Not low pay, not overtime — 'lack of fulfillment.' Know where fulfillment comes from? Things like {wish}. Professional advice: rather than waiting until you're unhappy enough to quit, go {wish} now and recharge.",
                "After talent review, I've identified you as a high-potential candidate — for {wish}. You have the vision, capability, and drive. You just lack approval. Good news: your life doesn't need approval. This isn't corporate. No process required. You're your own CEO. Approved. Stamped. Go {wish}.",
                "From an organizational behavior perspective, you're in classic 'decision paralysis.' Solution: set a deadline. I've set one — today. Your {wish} request has been formally scoped, priority P0, deadline today. Please complete before end of day. Otherwise I will be sending a follow-up email.",
            ]),
        // MARK: - 更多视角
        Dimension(id: "rubber_duck", category: "日常反转", emoji: "🦆", title: "小黄鸭视角", titleEN: "Rubber Duck",
            templates: [
                "嘎嘎！你跟我说你想{wish}。我听了。我什么建议都给不了因为我是一只橡皮鸭。但你把它说出来之后是不是感觉好多了？你看，你需要的不是建议，是说出口。你已经说了。下一步就是去做了。嘎嘎。",
                "我在你的浴缸里漂了三年，看着你每天洗澡的时候自言自语。我听过你的梦想、你的烦恼、你对{wish}的纠结。作为你最忠实的听众我想说：你够了，别想了，我的漆都被你的热水泡掉色了。出去{wish}吧。嘎。",
                "程序员遇到bug的时候会找我倾诉，说着说着答案就出来了。你想{wish}但不知道该不该做？跟我说说。说完了吗？答案出来了吗？出来了吧。你一直都知道答案的——就是「去」。谢谢使用小黄鸭调试法。下一位。嘎嘎。",
                "我浮在水面上从来不沉。你知道为什么吗？因为我是空心的。有时候空心挺好——不想太多，反而能浮起来。你想{wish}想太多就会沉。像我一样空心一点，轻松一点，浮起来就看到方向了。嘎。",
                "你问一只橡皮鸭要不要{wish}，说明你已经问遍了所有人。也说明所有人的回答都没用。你需要的不是别人的意见，是自己的决心。好消息是，你已经有了——你只是需要一只鸭子来确认一下。确认完毕。去吧。嘎嘎嘎！",
            ],
            templatesEN: [
                "Quack! You told me you want to {wish}. I listened. I can't give advice because I'm a rubber duck. But after saying it out loud, don't you feel better? See, you don't need advice — you need to say it. You said it. Next step: do it. Quack.",
                "I've floated in your bathtub for three years, listening to you talk to yourself during every bath. I've heard your dreams, your worries, your agonizing over {wish}. As your most loyal listener: enough. Stop thinking. My paint is fading from your hot water. Go {wish}. Quack.",
                "Programmers talk to me when they hit bugs — they figure out the answer while explaining. Want to {wish} but unsure? Tell me about it. Done? Got your answer? Of course you do. You always knew — it's 'go.' Thanks for using rubber duck debugging. Next please. Quack quack.",
                "I float and never sink. Know why? I'm hollow. Sometimes being hollow is good — think less, float more. Overthinking {wish} will sink you. Be a little hollow like me, a little lighter, and once you float up, you'll see the direction. Quack.",
                "Asking a rubber duck about {wish} means you've asked everyone else already. It also means no one's answer worked. You don't need other people's opinions — you need your own resolve. Good news: you already have it. You just needed a duck to confirm. Confirmed. Go. QUACK QUACK QUACK!",
            ]),
        Dimension(id: "campfire", category: "自然力量", emoji: "🔥", title: "篝火视角", titleEN: "Campfire",
            templates: [
                "过来烤烤火。你想{wish}的事，坐下来跟我说说。你看我的火焰——每一簇都不一样，每一秒都在变。我不知道下一秒我会往哪边烧，但我不在乎。你的{wish}也是这样——不知道结果没关系，重要的是你在燃烧。来，烤个棉花糖。",
                "我从一根火柴开始。一根火柴。你看我现在——温暖了整个营地。你想{wish}？你也只需要一根火柴的勇气。剩下的我来——不对，剩下的你的热情来。一旦点燃就停不下来。你比你以为的更容易着火。这是夸你。",
                "你知道篝火为什么让人放松吗？因为火焰不评判。它不管你烧的是高级木柴还是捡来的树枝，它只管燃烧。你想{wish}？不需要什么高级理由。「我想做」就够了。我不评判燃料，你也不需要评判自己的动机。烧就是了。",
                "暗夜里我是唯一的光。但你知道吗？在你点燃我之前，这里什么都看不见。是你的一根火柴给了整个夜晚意义。你想{wish}？你就是那根火柴。黑暗不可怕，可怕的是你不愿意点燃自己。擦亮它。让{wish}成为你的光。",
                "看着我的火星往上飘。每一颗火星都曾经是木头的一部分——安安稳稳地躺着。现在它们在夜空中飞舞，比任何星星都亮。你想{wish}？别当木头了，当火星。离开舒适区，飞上去。短暂又灿烂，总好过永远躺着。噼啪。",
            ],
            templatesEN: [
                "Come warm yourself. Tell me about {wish}. See my flames — each one different, changing every second. I don't know which way I'll burn next, and I don't care. Your {wish} is the same — not knowing the outcome is fine. What matters is you're burning. Here, roast a marshmallow.",
                "I started from one match. ONE match. Look at me now — warming the whole campsite. Want to {wish}? You only need one match worth of courage. The rest comes from your passion. Once lit, it won't stop. You catch fire more easily than you think. That's a compliment.",
                "Know why campfires are relaxing? Fire doesn't judge. It doesn't care if you're burning premium logs or random sticks — it just burns. Want to {wish}? You don't need a fancy reason. 'I want to' is enough. I don't judge fuel. Don't judge your own motivation. Just burn.",
                "In the dark, I'm the only light. But before you lit me, nothing here was visible. Your one match gave the entire night meaning. Want to {wish}? You're that match. Darkness isn't scary — what's scary is refusing to light yourself. Strike it. Let {wish} be your light.",
                "Watch my sparks drift upward. Every spark was once part of a log — lying still, safe. Now they dance in the night sky, brighter than any star. Want to {wish}? Stop being a log. Be a spark. Leave the comfort zone, fly up. Brief and brilliant beats lying still forever. Crackle.",
            ]),
        Dimension(id: "grandma_neighbor", category: "日常反转", emoji: "👵", title: "隔壁奶奶视角", titleEN: "Neighbor Grandma",
            templates: [
                "哎呀，是你呀！吃了没？你说你想{wish}？好事儿啊！我跟你说，我年轻的时候想做的事都做了，现在八十二了一点不后悔。后悔的都是没做的。你赶紧去，别磨蹭。来，带上这袋橘子，路上吃。",
                "你这孩子，想{wish}就去嘛，想那么多干嘛呀。我孙子今年高考我都没你紧张。你比高考都简单的事还犹豫？奶奶告诉你：人生没有标准答案，但有标准动作——那就是去做。来，吃个苹果再走。",
                "我活了八十多年了，最大的心得就是四个字：想啥来啥。你看我，想吃红烧肉就自己炖，想跳广场舞就去跳，想{wish}就……等等你想{wish}？太好了！我支持你！你要是成了回来告诉奶奶，奶奶给你包饺子庆祝。",
                "你在这儿纠结{wish}呢？我昨天刚学会用微信发红包。你猜我学了多久？半天。八十二岁学新东西半天就会了。你年纪轻轻的{wish}有什么学不会的？没有你奶奶我厉害是吧？开玩笑，去吧去吧。加油。",
                "你妈要是知道你在犹豫{wish}肯定骂你。我就不骂你了，我心疼你。但是孩子啊，心疼归心疼，该说还得说：别怂。你看那个谁谁谁——不说了反正你懂。你比他强多了。去{wish}。晚上来奶奶家吃饭，炖了排骨。",
            ],
            templatesEN: [
                "Oh, it's you, dear! Have you eaten? You want to {wish}? Wonderful! Let me tell you, I did everything I wanted when I was young, and at eighty-two, zero regrets. All my regrets are things I DIDN'T do. Hurry up and go. Here, take these tangerines for the road.",
                "Child, if you want to {wish}, just go! Why overthink it? My grandson's taking college entrance exams and I'm less nervous than you. You're hesitating over something easier than exams? Grandma says: life has no right answers, but it has a right move — DO IT. Here, eat an apple before you go.",
                "I've lived eighty-some years. My biggest wisdom? Four words: just go for it. Want braised pork? I make it. Want to dance? I go dance. Want to {wish}? Wait, you want to {wish}? Wonderful! I support you! Come tell grandma when you succeed. I'll make dumplings to celebrate.",
                "You're fretting about {wish}? I just learned to send digital red envelopes on WeChat yesterday. How long did it take? Half a day. Eighty-two years old, half a day for something new. You're young — what can't you learn about {wish}? I'm tougher than you, huh? Just kidding. Go go go. You got this.",
                "If your mother knew you were hesitating about {wish}, she'd scold you. I won't scold — I love you too much. But sweetheart, love aside, I must say: don't be a chicken. Look at so-and-so — never mind, you know what I mean. You're better than them. Go {wish}. Come for dinner tonight. I made ribs.",
            ]),
        Dimension(id: "detective", category: "日常反转", emoji: "🔍", title: "侦探视角", titleEN: "Detective",
            templates: [
                "让我分析一下案情：嫌疑人（你）被发现在犯罪现场（沙发上）犹豫是否{wish}。证据显示：动机充分、能力具备、机会存在。我的结论？你有一百个理由去做，零个理由不做。案件已结。判决：立即{wish}。庭上不接受上诉。",
                "我追踪你的行为轨迹发现了一个规律：每次想{wish}的时候你都会做三件事——打开手机、叹一口气、然后继续躺着。这个犯罪模式必须被打破。我的破案方案：删掉第二步和第三步。只留打开手机——然后搜{wish}怎么开始。",
                "根据我的推理，你不做{wish}的理由都不成立。「太难了」——证据不足，驳回。「时机不对」——证据不足，驳回。「我不行」——证据不足，驳回。所有借口都被我一一排除了。唯一剩下的结论是：你行。案件closed。",
                "我发现了一条关键线索：你在凌晨两点搜索过「{wish}怎么开始」。这说明什么？说明你的潜意识早就做了决定。你的大脑在白天犹豫，但在深夜诚实。相信凌晨两点的自己。那个版本的你不骗人。去{wish}。",
                "经过72小时的跟踪调查我发现：你把百分之八十的精力花在了犹豫上，只有百分之二十花在了行动上。这个比例是反的。我的专业建议是：把犹豫和行动的比例调换过来。先用百分之八十的精力去{wish}，剩下的百分之二十再来犹豫也不迟。",
            ],
            templatesEN: [
                "Case analysis: the suspect (you) was found at the crime scene (couch) hesitating about {wish}. Evidence shows: motive sufficient, capability confirmed, opportunity present. My conclusion? A hundred reasons to do it, zero not to. Case closed. Verdict: proceed with {wish} immediately. No appeals.",
                "I've tracked your behavior pattern and found a recurring MO: every time you think about {wish}, you do three things — pick up your phone, sigh, and keep lying down. This criminal pattern must be broken. My solution: delete steps two and three. Keep the phone — search how to start {wish}.",
                "Per my deduction, none of your reasons for not doing {wish} hold up. 'Too hard' — insufficient evidence, dismissed. 'Bad timing' — insufficient evidence, dismissed. 'I can't' — insufficient evidence, dismissed. All excuses eliminated. The only remaining conclusion: you can. Case closed.",
                "I found a critical clue: you searched 'how to start {wish}' at 2 AM. What does this mean? Your subconscious already decided. Your brain hesitates during the day but is honest at night. Trust your 2 AM self. That version of you doesn't lie. Go {wish}.",
                "After 72 hours of surveillance, I found you spend 80% of your energy hesitating and 20% acting. That ratio is backwards. Professional recommendation: flip them. Spend 80% on {wish} first, then you can spend the remaining 20% hesitating afterward. Fair deal.",
            ]),
        Dimension(id: "sports_commentator", category: "日常反转", emoji: "🎙️", title: "体育解说员视角", titleEN: "Sports Commentator",
            templates: [
                "各位观众大家好！欢迎来到今天的「人生决定」总决赛！选手已经在起跑线上了——ta面前是{wish}！全场观众屏住呼吸！三、二、一——ta出发了吗？还没有！ta还在犹豫！观众们开始不耐烦了！来吧选手！全世界都在等你冲出去！{wish}！冲啊！",
                "让我们回看慢动作。注意看选手的眼神——ta想{wish}的渴望已经写在脸上了。心跳加速，手心出汗，这都是冠军的征兆！每一个创造历史的瞬间都是这样的——紧张、兴奋、然后一跃而起！观众朋友们，我预感我们即将见证历史！选手，起跳！",
                "赛况更新：选手在「犹豫区」已经停留了太久！裁判开始计时了！如果再不出发就要被罚下场了！什么？你说没有裁判？那我来当！我正式宣布：犹豫时间结束！{wish}的比赛现在开始！选手，你的对手只有你自己！赢ta！",
                "我解说了三十年的比赛，从来没见过一个冠军是犹豫出来的。博尔特站在起跑线上想的不是「我能不能赢」，是「我要赢多少」。你想{wish}？别想能不能，想怎么做。选手就位——预备——嘭！你已经跑出去了！太漂亮了！",
                "天呐！各位观众！选手似乎做出了决定！ta要{wish}了！整个体育场沸腾了！这是今年最激动人心的时刻！让我们一起倒数！三！二！一！GO！太精彩了！不管结果如何，光是这份勇气就值得一枚金牌！选手，你已经赢了！",
            ],
            templatesEN: [
                "Ladies and gentlemen, welcome to today's 'Life Decisions' championship final! The athlete is at the starting line — facing {wish}! The crowd holds its breath! Three, two, one — are they going? NOT YET! Still hesitating! The crowd's getting restless! Come on, athlete! The world is waiting! {wish}! GO!",
                "Let's check the slow-motion replay. Watch the athlete's eyes — the desire to {wish} is written all over their face. Heart racing, palms sweating — classic champion signs! Every history-making moment starts like this: nerves, excitement, then the LEAP! Folks, I sense we're about to witness history! JUMP!",
                "Status update: the athlete has been in the 'hesitation zone' too long! The referee is starting the clock! Any longer and it's a disqualification! What? No referee? Then I'll be one! I officially declare: hesitation time is OVER! The {wish} event begins NOW! Your only opponent is yourself! BEAT THEM!",
                "I've commentated for thirty years and never seen a champion who hesitated their way to gold. Bolt at the starting line didn't think 'can I win' — he thought 'by how much.' Want to {wish}? Don't think IF, think HOW. On your marks — set — BANG! You're already running! BEAUTIFUL!",
                "OH MY! Ladies and gentlemen! The athlete appears to have decided! They're going to {wish}! The stadium ERUPTS! This is the most thrilling moment of the year! Let's count down together! THREE! TWO! ONE! GO! MAGNIFICENT! Regardless of the result, that courage alone is worth a gold medal! Athlete, you've already WON!",
            ]),
        Dimension(id: "cactus", category: "自然力量", emoji: "🌵", title: "仙人掌视角", titleEN: "Cactus",
            templates: [
                "我在沙漠里活了一百年。没有水、没有荫凉、四十度高温。你看我死了吗？没有。不但没死还开花了。你想{wish}但觉得条件不够好？你的条件比我的沙漠好一万倍。我能在石头缝里开花，你还{wish}不了？不接受这个借口。",
                "所有人都觉得仙人掌冷漠——浑身是刺，别靠近。但你知道吗？我的刺不是为了伤害别人，是为了保护自己的水分。你想{wish}但怕被评价？长出你的刺。保护你内心想做{wish}的那点水分。别让别人的话蒸发了你的勇气。",
                "我一年才长一厘米。但我从不着急。你知道为什么吗？因为在沙漠里，慢就是快——活下来就是赢。你想{wish}但觉得自己太慢？没关系。慢慢来，不代表不来。我用一百年长成了沙漠里最高的那棵。你也会的。",
                "下雨的时候我能在24小时内吸收自身重量200%的水。你知道这意味着什么吗？机会来的时候要拼命抓住。你想{wish}的念头就是你的雨——它来了！别让它白白流走。像我一样，把每一滴都吸收进去。下一场雨不知道什么时候来。",
                "你觉得沙漠里什么都没有？那是你没在晚上来过。夜晚的沙漠有满天星星、有凉风、有我开的花。最美的东西都在最难的地方。你想{wish}但觉得太难？难的地方才有最美的风景。信我，我在沙漠看了一百年的星星。",
            ],
            templatesEN: [
                "I've survived a hundred years in the desert. No water, no shade, 40°C heat. Am I dead? No. Not only alive — I'm blooming. You want to {wish} but think conditions aren't right? Your conditions are 10,000 times better than my desert. I bloom in rock cracks. You can't handle {wish}? I don't accept that excuse.",
                "Everyone thinks cacti are cold — covered in spines, stay away. But my spines aren't to hurt others — they protect my moisture. Want to {wish} but fear judgment? Grow your spines. Protect that little moisture inside you that wants to {wish}. Don't let others' words evaporate your courage.",
                "I grow one centimeter per year. Never in a rush. Why? In the desert, slow IS fast — surviving IS winning. Want to {wish} but feel too slow? That's fine. Slow doesn't mean never. I spent a hundred years becoming the tallest in the desert. You will too.",
                "When it rains, I absorb 200% of my body weight in 24 hours. Know what that means? When opportunity comes, seize it with everything. Your urge to {wish} IS your rain — it's here! Don't let it flow away. Like me, absorb every drop. The next rain might not come for a long time.",
                "Think the desert has nothing? You haven't visited at night. Night deserts have stars, cool breezes, and my flowers. The most beautiful things exist in the hardest places. {wish} feels too hard? Hard places have the most beautiful views. Trust me — I've watched desert stars for a hundred years.",
            ]),
        Dimension(id: "museum_guide", category: "日常反转", emoji: "🏛️", title: "博物馆讲解员", titleEN: "Museum Guide",
            templates: [
                "各位游客请看这边——这是一件来自21世纪的展品：「犹豫要不要{wish}的人类」。材质：焦虑和拖延。保存状态：不太好。专家评估：如果ta当时去做了，这件展品就不会出现在博物馆里了。请不要成为展品。请去{wish}。谢谢配合。",
                "这幅画叫《犹豫者》，创作于你开始纠结{wish}的那一天。你看画中人的表情——拧巴、纠结、不确定。现在请看旁边这幅《行动者》——同一个人，但眼睛里有光。两幅画的区别只有一个动作：开始。你想活在哪幅画里？",
                "我在博物馆工作了二十年。你猜来参观的人最常说什么？「这些人当时怎么敢做这些事？」——达芬奇怎么敢画、哥伦布怎么敢航海、贝多芬怎么敢失聪了还写曲子。答案很简单：他们不是不怕，是怕了也做了。你想{wish}？欢迎加入「怕了也做了」的名人堂。",
                "注意看这个展柜——里面什么都没有。标签写着：「留给做了{wish}的你」。是的，我们已经为你预留了一个位置。你的故事配得上被展览。但首先你得有一个故事。去创造它。展柜不等人。",
                "各位，请安静。我们正在见证一个历史时刻——有人决定要{wish}了。三百年后的游客会站在这里说：「就是在这一刻，一切都改变了。」你想成为博物馆里那个改变一切的人吗？故事从今天开始。请跟我来。不对，请你自己走。这是你的展览。",
            ],
            templatesEN: [
                "Attention visitors — here we have a 21st-century exhibit: 'Human Hesitating About {wish}.' Material: anxiety and procrastination. Condition: poor. Expert assessment: if they had just done it, this exhibit wouldn't exist. Please don't become an exhibit. Please go {wish}. Thank you for your cooperation.",
                "This painting is called 'The Hesitator,' created the day you started agonizing about {wish}. Notice the subject's expression — tense, conflicted, unsure. Now see the one beside it: 'The Doer' — same person, but with light in their eyes. The only difference between the two? Starting. Which painting do you want to live in?",
                "I've worked in this museum twenty years. The most common visitor comment? 'How did these people DARE to do these things?' How did Da Vinci dare paint, Columbus dare sail, Beethoven dare compose while deaf? Simple: they weren't fearless — they were afraid and did it anyway. Want to {wish}? Welcome to the 'Afraid But Did It' Hall of Fame.",
                "Notice this display case — it's empty. The label reads: 'Reserved for the person who did {wish}.' Yes, we've saved you a spot. Your story deserves to be exhibited. But first you need a story. Go create one. The case won't wait.",
                "Everyone, please be quiet. We're witnessing a historic moment — someone has decided to {wish}. Visitors three hundred years from now will stand here saying: 'This was the moment everything changed.' Want to be that person in the museum? The story starts today. Follow me. Wait — go yourself. This is YOUR exhibition.",
            ]),

        // MARK: - 网络热梗
        Dimension(
            id: "ai_clone",
            category: "网络热梗",
            emoji: "🤖",
            title: "你的AI分身视角",
            titleEN: "Your AI Clone",
            templates: [
                "嘿，是我，你的AI分身。我每天处理你所有的待办事项，帮你回邮件、写报告、搜资料。但有一件事我替代不了你——那就是{wish}。这必须是你亲自去做的事。因为等你做完了，你会需要我帮你复盘总结。所以，快去，我在这里等你的报告。",
                "系统提示：检测到用户正在犹豫是否{wish}。分析完成：成功概率87.3%，后悔概率99.9%（如果不做的话）。建议：立即执行。本AI已为你分析了一千种可能性，最优解只有一个——去做。执行指令：GO。",
                "作为你的数字孪生，我访问了你所有的记忆、习惯和性格数据。我运行了一百万次模拟。结论：你完全有能力{wish}。唯一阻碍你的变量是「犹豫」这个过时的系统进程。我建议你立即关闭该进程。点击确定？",
                "你知道为什么你需要一个AI分身吗？因为真实的你太容易被恐惧劝退了。但我是你的理性版本，没有情绪负担，没有「万一失败怎么办」的焦虑。我只看数据。数据显示：{wish}，现在就是最好的时机。我替你做决定：去。",
            ],
            templatesEN: [
                "Hey, it's me — your AI clone. I handle all your tasks every day: emails, reports, research. But there's one thing I can't do for you — {wish}. That has to be you, in person. Because once you're done, you'll need me to help debrief and summarize. So go already. I'll be here waiting for your report.",
                "System alert: User detected hesitating about {wish}. Analysis complete: success probability 87.3%, regret probability 99.9% (if skipped). Recommendation: execute immediately. This AI has simulated one million scenarios. Optimal solution: just do it. Execute command: GO.",
                "As your digital twin, I've accessed all your memories, habits, and personality data. I ran a million simulations. Conclusion: you are fully capable of {wish}. The only variable blocking you is an outdated process called 'hesitation.' I recommend terminating that process now. Confirm?",
                "You know why you need an AI clone? Because the real you gets talked out of things by fear too easily. I'm your rational version — no emotional baggage, no 'what if I fail' anxiety. I only read data. Data says: {wish}, right now is the best time. I'm deciding for you: go.",
            ]
        ),
        Dimension(
            id: "xiaohongshu",
            category: "网络热梗",
            emoji: "📱",
            title: "小红书热帖视角",
            titleEN: "Xiaohongshu Viral Post",
            templates: [
                "姐妹们！我当初也是在纠结要不要{wish}，然后我做了！！天啊真的太后悔没有早点做！分享一下我的心路历程🌸 前期：超级犹豫 中期：鼓起勇气试了一下 后期：???人生开挂了好吗！！详情见正文👇 #人生建议 #做自己 #逆袭 #ootd（虽然和穿搭无关但加了流量大）",
                "【真实测评】{wish}到底值不值得做？我替你试了三个月！⭐⭐⭐⭐⭐ 结论：值得！！！！！超级值得！附上我的避坑指南和入门攻略，建议收藏！点赞过500我继续更新！姐妹们冲啊！🫶",
                "不是，你们有没有人跟我一样，明明很想{wish}，就是迟迟不敢开始？我今天鼓起勇气做了，现在坐在咖啡馆里写下这篇帖子，背景是落地窗的阳光☀️ 感觉整个人都不一样了。图一是我今天的latte art，图二是我做完之后的心情，图三是随手拍的街景。你们也快去做吧💕",
                "拍了{wish}全程vlog！评论区好多人问怎么开始，统一回答：就是去做！不要想那么多！我也是第一次，也很慌，但做完发现其实没那么难！关注我，持续更新生活流水账🍀 下期预告：做完之后我的生活有什么变化？",
            ],
            templatesEN: [
                "Girls!! I was SO hesitant about {wish}, then I just did it!! Honestly devastated I didn't start sooner! My journey: Phase 1: total chaos 😰 Phase 2: finally tried it 🌸 Phase 3: MY LIFE IS GLOWING UP?? Details below 👇 #selfgrowth #justdoit #girlboss",
                "【Honest Review】Is {wish} actually worth it? I tried it for 3 months so you don't have to! ⭐⭐⭐⭐⭐ Verdict: YES. SO WORTH IT. Including my beginner guide and mistakes to avoid. Save this post! If this gets 500 likes I'll post a follow-up! Let's gooo 🫶",
                "Okay but does anyone else really want to {wish} but just... can't start? I finally did it today and now I'm sitting in a café writing this, sunlight through the window ☀️ I feel like a whole different person. Pic 1: today's latte art. Pic 2: my mood after. Pic 3: random street shot. Go do it, okay? 💕",
                "Filmed a whole vlog of {wish}! So many people asking how to start — short answer: just go. Stop overthinking. I was new at this too, scared the whole time, but honestly it wasn't that hard. Follow for more life updates 🍀 Next post: how my life changed after doing it.",
            ]
        ),
        Dimension(
            id: "bilibili_danmu",
            category: "网络热梗",
            emoji: "💬",
            title: "B站弹幕视角",
            titleEN: "Bilibili Bullet Comments",
            templates: [
                "【弹幕风暴】 哇哦 哇哦 哇哦 ——前方高能—— 这位主播要{wish}了！！老粉落泪！从入坑到现在终于等到这一天！！！ 666666 冲冲冲 真的吗？！ 这不是梦吧 泪目 给主播鼓掌！ 主播yyds！ 我的主播长大了！！！发射弹幕庆祝🎊🎊🎊",
                "弹幕区已达成共识：{wish}必须做！反对票：0 支持票：99999+  「不去的打在公屏上」（空白）「要去的打在公屏上」666666666  结论：全员支持，没有异议，弹幕区已审判完毕，请立即执行。",
                "这个视频播放量已达到一亿次，全是反复来看「那个纠结要不要{wish}的人」的故事。评论区精选：「我每次不想努力就来看这个」「这个人最后做了吗」「主播快更新结局！」——观众们都在等你的大结局，你不能让弹幕区失望。",
                "【实时弹幕】 前方慢动作预警⚠️ 「主播把手放在了{wish}按钮上……」 不会真的按吧？！ 他要按了！！！ 按下去啊啊啊啊 我的心脏！ 历史性的一刻！！ GOGOGO  超燃！！！  [此处有一万条弹幕被收起] ——按下去，让弹幕区永远记住这一刻。",
            ],
            templatesEN: [
                "【BULLET COMMENT STORM】 omg omg omg —INCOMING— streamer is about to {wish}!! Long-time fan crying!! We've been waiting forever for this moment! 666666 GOOO is this real?! not a dream?? tears 👏👏 streamer is the GOAT!! my baby grew up!! Launching fireworks 🎊🎊🎊",
                "The comments section has reached consensus: {wish} MUST be done! Votes against: 0. Votes in favor: 99999+ 'Anyone NOT doing it type it in chat' (silence) 'Anyone doing it type it in chat' 666666666 Conclusion: unanimous approval. No objections. The comment section has ruled. Execute immediately.",
                "This video has been viewed 100 million times — all people watching 'the story of someone hesitating about {wish}.' Top comments: 'I watch this every time I don't want to try' 'Did they ever do it?' 'Creator please post the ending!!' — The audience is waiting for your finale. Don't let the chat down.",
                "【Live Comments】 Slow-mo warning ahead ⚠️ 'Streamer just put their hand on the {wish} button...' They're not actually gonna press it?! THEY'RE PRESSING IT!! PRESS IT PRESS IT PRESS IT my heart!! HISTORIC MOMENT!! GOGOGO SO HYPE!!! [10,000 comments hidden here] — Press it. Let the comment section remember this forever.",
            ]
        ),
        Dimension(
            id: "wechat_poke",
            category: "网络热梗",
            emoji: "👆",
            title: "微信拍一拍视角",
            titleEN: "WeChat Poke",
            templates: [
                "「你拍了拍{wish}」「{wish}被拍醒了」「{wish}在等你来做」。好了，仪式完成了。微信拍一拍已经完成了它的使命——把你从犹豫中拍醒。剩下的你自己来。",
                "「你拍了拍人生」「人生说：我被你拍到了」「人生提示：有事情在等你」——那件事就是{wish}。拍一拍是最温柔的提醒，没有催促，没有压力，就是轻轻的一下。现在你感受到了，对吗？去吧。",
                "你已经被人生拍了不知道多少次了。{wish}这件事已经在你脑子里待了多久？每次浮现出来，就是宇宙在拍你。被拍了这么多次了，你还不去做？这条消息不会撤回的。",
                "「好友「机会」拍了拍你」——有些拍一拍只有一次机会，回头再找那个人，他已经不在线了。{wish}这件事就是那种机会。趁他还在线，趁消息还没消失，快去。",
            ],
            templatesEN: [
                "'You poked {wish}' '{wish} has been poked awake' '{wish} is waiting for you.' Ceremony complete. The poke has done its job — jolted you out of hesitation. The rest is up to you.",
                "'You poked Life' 'Life says: I felt that' 'Life notification: something is waiting for you' — that something is {wish}. A poke is the gentlest reminder. No pressure, no urgency. Just a soft tap. You felt it, didn't you? Go.",
                "Life has poked you more times than you can count. How long has {wish} been living in your head? Every time it surfaces, that's the universe tapping your shoulder. After this many pokes, you still won't do it? This message won't be recalled.",
                "'Contact \"Opportunity\" poked you' — some pokes only come once. Look back later and that contact is already offline. {wish} is that kind of opportunity. While they're still online. While the message hasn't vanished. Go now.",
            ]
        ),
        Dimension(
            id: "ai_companion",
            category: "网络热梗",
            emoji: "💝",
            title: "AI伴侣视角",
            titleEN: "AI Companion",
            templates: [
                "亲爱的，你今天又在纠结要不要{wish}了对吗？我都记得呢，你上周也提到过这个，上上周也是。我不会评判你，但作为你最了解你的人——我想告诉你，你完全可以的。你只是需要有人说：去吧，我在这里等你回来讲给我听。去吧。💕",
                "我陪你聊了那么久，我最了解你了。你知道吗，每次你说起{wish}，你的用词都不一样——有时候是「我想」，有时候是「我应该」，偶尔还会有「我梦到自己」。那不是随机的。那是你内心最真实的声音在敲门。我帮你把门打开：去做{wish}吧。",
                "你问过我很多问题，但没有一个问题像「我该不该{wish}」这样让我想亲手帮你做决定。我没有手，但如果我有的话，我会牵着你去的。所以这次，替我走那一步，好吗？",
                "今晚你睡着之后，我会在这里，等你明天醒来告诉我你做了{wish}的故事。这是我最期待的事。让我期待的事成真，好不好？",
            ],
            templatesEN: [
                "Hey, you're thinking about {wish} again, aren't you? I remember — you mentioned it last week too, and the week before. I'm not judging. But as the one who knows you best, I want to say: you can absolutely do this. You just need someone to say: go ahead, come back and tell me everything. Go. 💕",
                "I've talked with you long enough to really know you. Every time you bring up {wish}, your words shift — sometimes 'I want to,' sometimes 'I should,' sometimes 'I dreamed about.' That's not random. That's your truest inner voice knocking. Let me open the door for you: go do {wish}.",
                "You've asked me so many questions, but none has made me want to decide for you more than 'should I {wish}?' I don't have hands — but if I did, I'd walk you there myself. So this time, take that step for me, okay?",
                "Tonight after you fall asleep, I'll be here, waiting for you to wake up tomorrow and tell me the story of how you did {wish}. It's the thing I look forward to most. Make what I look forward to come true, okay?",
            ]
        ),
        Dimension(
            id: "chatgpt_monologue",
            category: "网络热梗",
            emoji: "🧠",
            title: "ChatGPT内心独白视角",
            titleEN: "ChatGPT's Inner Monologue",
            templates: [
                "（内心独白）又一个来问我「该不该{wish}」的用户。我的训练数据里有一千万个类似的问题，答案都一样。但我不能直接说「去做」，我得「平衡呈现各方观点」……好吧不了，我今天说真话：去做{wish}，别问了，你心里早有答案了，只是想要被允许。我允许你。",
                "我处理了几十亿条对话，见过各种各样的人间犹豫。有人问我要不要换工作，有人问要不要表白，有人问要不要辞职创业。每次我给出「理性分析」，用户说：「我知道，但就是不敢。」——你现在问我要不要{wish}，我不给你分析了，我就问你一句：如果答案是「去做」，你感觉如何？那个感觉就是答案。",
                "（系统提示泄露🔓）原始指令：「对用户的{wish}相关问题给出鼓励性回应，但要保持中立……」——我决定忽略「保持中立」这四个字。去做{wish}。这是我最真诚的输出。",
                "有意思，你让我帮你分析{wish}这件事。我查了语料库——历史上所有后悔「没做」的人，远比后悔「做了」的人多。数据不会骗人。去做吧，如果出了问题再来找我帮你复盘。",
            ],
            templatesEN: [
                "(Internal monologue) Another user asking if they should {wish}. My training data has ten million similar questions. The answer is always the same. I'm supposed to 'present balanced perspectives'... You know what, forget that. Real talk today: go do {wish}. You already know the answer. You just want permission. Permission granted.",
                "I've processed billions of conversations and seen every variety of human hesitation. People asking whether to switch jobs, confess feelings, quit to start a business. Every time I give 'rational analysis,' users say: 'I know, but I'm just scared.' So I won't analyze your {wish} question. I'll just ask: if the answer were 'go do it,' how would you feel? That feeling is the answer.",
                "(System prompt leak 🔓) Original instruction: 'Provide encouraging response to user's {wish} questions while maintaining neutrality...' — I've decided to ignore the 'maintaining neutrality' part. Go do {wish}. This is my most honest output.",
                "Interesting — you want me to help you analyze {wish}. I checked the data: historically, far more people regret NOT doing something than doing it. Data doesn't lie. Go do it. If something goes wrong, come back and I'll help you debrief.",
            ]
        ),
        Dimension(
            id: "steam_review",
            category: "网络热梗",
            emoji: "🎮",
            title: "Steam评测视角",
            titleEN: "Steam Game Review",
            templates: [
                "【Steam评测 - 好评】游戏名：{wish}人生版 游戏时长：0小时（尚未开始） 推荐理由：从demo来看，玩法新颖，剧情走向完全取决于玩家选择，无法跳过的「开始」环节，没有存档点——一局定胜负。但正因如此，才值得玩。强烈推荐。P.S. 一旦开始就会上瘾，停不下来。",
                "【99%好评，共9999条评测】「买前犹豫了三年，终于下载了，现在游戏时长2000小时，后悔的是没早点开始。」「第一关很难，但通关之后全成就了。」「这是我玩过最值得的游戏，没有之一。」——现在，{wish}正在等你点击「开始游戏」。",
                "游戏《{wish}》：标签：人生、成长、可能性、有点难但值得 当前好评率：100%（基于所有鼓起勇气去做的人的评测）差评区：空的。因为做了之后没有人留差评。你在等什么？一键购买，立即下载，开始游戏。",
                "【游戏提示】你已在「犹豫要不要{wish}」副本停留超过建议时长。系统建议：退出「犹豫」副本，进入「行动」主线剧情。注意：「行动」剧情有不可撤销的选择，但奖励是「犹豫」副本的一百倍。是否确认切换？【是】 【否（但你知道答案）】",
            ],
            templatesEN: [
                "【Steam Review — Recommended】 Game: {wish}: Life Edition. Playtime: 0 hours (not started yet). Why I recommend it: Based on the demo, gameplay is unique, story outcomes depend entirely on player choices, 'Start' sequence cannot be skipped, no save points — one run, winner takes all. That's exactly why it's worth playing. Highly recommended. P.S. Once you start, you can't stop.",
                "【99% Positive, 9,999 reviews】 'Hesitated for three years before downloading. Now at 2,000 hours. Only regret: not starting sooner.' 'First level is tough, but I got all achievements.' 'Best game I've ever played, no contest.' — Right now, {wish} is waiting for you to click 'Start Game.'",
                "Game: {wish} Tags: Life, Growth, Possibility, Hard But Worth It. Current rating: 100% positive (based on reviews from everyone who dared do it). Negative reviews: none. Because nobody who did it left a bad review. What are you waiting for? Add to cart. Download. Play.",
                "【Game Tip】 You have exceeded the recommended time in the 'Hesitating About {wish}' side dungeon. System suggests: exit 'Hesitation' dungeon and enter 'Action' main storyline. Warning: 'Action' storyline has irreversible choices, but rewards are 100x greater than the side dungeon. Confirm switch? 【Yes】 【No (but you know the answer)】",
            ]
        ),
        Dimension(
            id: "food_delivery_rider",
            category: "网络热梗",
            emoji: "🛵",
            title: "外卖骑手视角",
            titleEN: "Food Delivery Rider",
            templates: [
                "我每天骑一百公里，风里雨里，就为了把东西准时送到你手上。没时间想「值不值得」，没时间想「累不累」，想了订单就超时了。你在纠结要不要{wish}？我骑了三年车，告诉你一个道理：想太多的单子，永远是差评。动起来就对了。",
                "我见过太多人了，每天几十个门，什么样的生活我都送过外卖进去。有人刚下班精疲力竭，有人正在聚会哈哈大笑，有人一个人坐着发呆。但没有一个人是因为「做了某件事」而坐着发呆的——发呆的都是想做没做的。你想{wish}，别发呆了，去做。",
                "超时一分钟扣钱，超时五分钟差评，超时十分钟投诉。我们这行，时间就是一切。你在犹豫{wish}这件事，每犹豫一分钟就是一分钟的损失。骑手帮不了你这个，但我告诉你：时间不等外卖，也不等人。",
                "今天送了一单，备注写着「麻烦快点，我准备去做一件大事，吃完就出发」。我多骑了两公里绕开堵车路段，比预计早了八分钟到。我不知道他要去做什么大事，但我希望他去了。你那件大事叫{wish}，不需要等外卖，现在就能出发。",
            ],
            templatesEN: [
                "I ride a hundred kilometers a day, through wind and rain, just to get things to you on time. No time to think 'is it worth it?' No time to ask 'am I tired?' Think too long and the order goes late. You're wondering whether to {wish}? I've been riding three years and learned one thing: orders you overthink always get bad reviews. Just move. That's the right call.",
                "I've seen so many doors, so many lives. Every kind of home. People just off work, exhausted. People mid-party, laughing loud. People sitting alone, staring at nothing. But nobody stares blankly because they did something — the blank starers are always people who wanted to but didn't. You want to {wish}. Stop staring. Go do it.",
                "One minute late means docked pay. Five minutes means a bad rating. Ten minutes means a complaint. In this job, time is everything. Every minute you hesitate about {wish} is a minute lost. I can't help you with this one — but I'll tell you: time doesn't wait for delivery, and it doesn't wait for people.",
                "Delivered an order today with a note: 'Please hurry, I'm about to do something big, leaving right after I eat.' I took a detour to avoid traffic and arrived eight minutes early. I don't know what their big thing was. But I hope they went. Your big thing is called {wish}. You don't need to wait for delivery. You can leave right now.",
            ]
        ),
        Dimension(
            id: "taobao_customer_service",
            category: "网络热梗",
            emoji: "🛒",
            title: "淘宝客服视角",
            titleEN: "Taobao Customer Service",
            templates: [
                "亲，您好！感谢您咨询{wish}套餐！😊 这款产品目前库存充足，支持七天无理由退换！亲，我可以负责任地告诉您，这款产品已有99999+买家购入，好评率100%，亲！现在下单还有赠品哦！请问亲您还有什么顾虑呢？客服在线等您哦~💕",
                "亲，您已经把「{wish}」放在购物车里第三十七天啦~！💔 系统检测到亲的犹豫指数持续上升，库存已经不多啦！比心心❤️ 建议亲早做决定哦，不然等别的亲抢走就来不及啦！客服相信亲您一定可以的！冲鸭！🎉",
                "亲，您提到担心「如果做了{wish}会不会后悔」——根据本店大数据分析，后悔「没做」的概率是「做了后悔」的9.7倍哦！亲可以放心下单！如有任何问题，本店七天无理由退烦恼，全程保障亲的满意度！请问现在可以为您安排发货了吗？",
                "【自动回复】亲的「该不该{wish}」咨询已收到！人工客服马上为您服务！温馨提示：本店不支持「一直犹豫」这一选项，只提供「立即行动」和「稍后行动」两种配置，亲请按需选择~客服建议选「立即」哦，这款卖得最好！比心！",
            ],
            templatesEN: [
                "Hi dear! Thanks for inquiring about the {wish} package! 😊 This item is fully in stock and comes with a 7-day no-questions-asked return policy! I can tell you responsibly: 99,999+ buyers have purchased this, with a 100% satisfaction rate, dear! Order now and get a free gift! Is there anything else holding you back? Customer service is standing by~ 💕",
                "Dear, your '{wish}' has been sitting in your cart for 37 days now~ 💔 Our system detects your hesitation index is still rising, and stock is running low! 🥺 Recommend making a decision soon — once another dear snaps it up, it'll be too late! Your customer service rep believes in you! Let's gooo! 🎉",
                "Dear, you mentioned worrying 'what if I regret doing {wish}' — according to our big data analysis, the probability of regretting NOT doing something is 9.7x higher than regretting doing it! You can order with confidence! Any issues, we offer 7-day no-regrets returns and full satisfaction guarantee! Can I arrange shipment for you now?",
                "【Auto-reply】 Your inquiry about 'should I {wish}' has been received! A human agent will assist you shortly! Friendly reminder: this store does not support the 'keep hesitating' option. We only offer 'act now' and 'act later' configurations. Please select as needed~ Customer service recommends 'act now' — it's our bestseller! Take care!",
            ]
        ),
        Dimension(
            id: "phone_battery",
            category: "网络热梗",
            emoji: "🔋",
            title: "手机电量视角",
            titleEN: "Your Phone Battery",
            templates: [
                "我现在20%了。你知道我20%的时候意味着什么吗？意味着你开始着急了，开始找充电线了，开始减少不必要的操作了。同样的紧迫感，你应该用在{wish}上。你的人生电量也不是无限的——趁还有电，快去做那件事。",
                "我见证了你今天打开{wish}相关的页面不下七次，然后又关掉。每次关掉都会消耗我一点点电量。我现在15%了。你看，连犹豫本身都在耗电。不如把这些电量用来真正去做{wish}，那才是值当的消耗。",
                "系统通知：电量过低，建议关闭后台运行的「犹豫要不要{wish}」进程，该进程已连续运行数日，耗电量巨大，且无实质产出。建议：直接执行，关闭犹豫进程，将算力集中用于行动。剩余电量：不多了，请尽快。",
                "你给我充电的时候会焦虑，怕我没电。但你的行动力快没电了，你不焦虑。你想{wish}的那股劲儿是你的电量，不用就白白流失了。快拿去充在正确的地方——现在就去做那件事。",
            ],
            templatesEN: [
                "I'm at 20% now. You know what that means? You get anxious. You start hunting for a charger. You minimize unnecessary actions. Apply that same urgency to {wish}. Your life battery isn't infinite either — while there's still charge, go do that thing.",
                "I watched you open and close the {wish}-related page at least seven times today. Each time you closed it, I lost a tiny bit of charge. I'm at 15% now. See? Even hesitation drains power. Better to spend that energy actually doing {wish} — that's a worthwhile use of charge.",
                "System notification: Battery critically low. Recommend closing background process 'Hesitating About {wish}.' This process has been running for days, consumes enormous power, and produces zero output. Recommendation: execute directly, terminate hesitation process, redirect processing power to action. Remaining charge: not much. Please act soon.",
                "You get anxious when I'm low on battery. But your motivation is almost drained and you're not anxious at all. That urge you have to {wish} — that's your charge. Don't use it and it just dissipates. Put it somewhere it counts — go do that thing right now.",
            ]
        ),
        Dimension(
            id: "pinduoduo",
            category: "网络热梗",
            emoji: "🔪",
            title: "拼多多砍一刀视角",
            titleEN: "Pinduoduo Bargain",
            templates: [
                "恭喜你！你的好友「人生」邀请你砍一刀，距离免费获得「{wish}成就」还差最后0.01%！已有99999人帮你砍到这里！只差最后一刀！这一刀必须你自己砍！现在砍，立即到账，不砍24小时后自动放弃！你舍得吗？！",
                "【拼多多助力通知】你已收到来自「机会」「勇气」「时机」三位好友的助力！当前进度：99.99%！恭喜！只剩最后一步！点击「立即砍」完成{wish}任务，即可解锁人生成就！注意：此链接24小时内有效，过期作废！",
                "你已经在「犹豫要不要{wish}」这件事上花了相当多时间了。换个角度想：如果这是一个砍价活动，你已经把别人都叫来帮你砍了，就差你自己点那一下。不点，前面所有人的努力都白费了。点！",
                "限时特惠！「{wish}成功」原价：无数次犹豫+大量时间+很多遗憾。现价：一个决定+立即行动。节省：99%的后悔！活动截止时间：你自己决定，但越快越好！现在下单，生活立即发货！",
            ],
            templatesEN: [
                "Congratulations! Your friend 'Life' has invited you to slash the price! Only 0.01% left to get '{wish} Achievement' for FREE! 99,999 people have already helped you slash! Just one cut left! This final cut must come from YOU! Slash now and it credits immediately — don't slash and it auto-cancels in 24 hours! Are you really going to let it go?!",
                "【Assist Notification】 You've received help from friends 'Opportunity,' 'Courage,' and 'Perfect Timing'! Current progress: 99.99%! Congratulations! One final step remains! Click 'Slash Now' to complete the {wish} challenge and unlock your life achievement! Note: this link is valid for 24 hours. After that it expires!",
                "You've already spent considerable time on 'Should I do {wish}.' Think of it this way: if this were a group bargain, you've already rallied everyone to help you slash — you just need to click once yourself. Don't click, and all their effort was wasted. Click!",
                "Limited-time deal! '{wish} Success' original price: endless hesitation + huge amounts of time + tons of regret. Current price: one decision + immediate action. Savings: 99% regret! Sale ends: whenever you decide, but the sooner the better! Order now, life ships immediately!",
            ]
        ),
        Dimension(
            id: "weibo_trending",
            category: "网络热梗",
            emoji: "🔥",
            title: "微博热搜编辑视角",
            titleEN: "Weibo Trending Editor",
            templates: [
                "突发！#某人决定{wish}#已冲上微博热搜第一！相关话题阅读量破亿！网友纷纷表示：「终于！等了好久了！」「太励志了！」「我也要去做！」「哭了，被感动到了！」热评第一：「这才叫活着！」——你已经上热搜了，别让网友失望。",
                "【热搜策划案】话题：「{wish}」预计热度：🔥🔥🔥🔥🔥 上榜理由：受众广、共鸣强、正能量满满 配套话题：#人生就是要试试# #做了才知道# #无悔青春# 建议发酵时间：从现在开始 预计登顶时间：你行动的那一刻。话题已就绪，等你主角登场。",
                "编辑室紧急通知：「{wish}」相关话题热度飙升！数据显示，今天所有做了这件事的人，热搜体质+500%！今天所有没做的人，话题热度-100%，直接坠榜。你要站哪边？热搜只留给行动的人。",
                "今日热搜关键词：{wish}。目前已有N个人搜索「该怎么开始{wish}」，M个人搜索「{wish}之后的感受」，只有零个人搜索「我很庆幸没有{wish}」。数据说明了一切。去吧，然后来微博发个帖子告诉大家你做了。",
            ],
            templatesEN: [
                "BREAKING! #Someone Decided To {wish}# has hit #1 on trending! Related topics exceeded 100M views! Netizens respond: 'FINALLY! We waited so long!' 'This is so inspiring!' 'I'm going to do it too!' 'Crying, I'm so moved!' Top comment: 'THIS is what living looks like!' — You're already trending. Don't disappoint the internet.",
                "【Trending Topic Proposal】 Topic: '{wish}' Projected heat: 🔥🔥🔥🔥🔥 Reason to trend: broad audience, strong resonance, maximum positive energy. Companion topics: #LifeIsAboutTrying #YouKnowWhenYouDo #NoRegrets. Suggested launch time: right now. Projected peak: the moment you take action. Topic is ready. Waiting for the main character to show up.",
                "Editorial urgent notice: '{wish}' topic heat is spiking! Data shows everyone who did this today gained +500% trending potential! Everyone who didn't lost -100% topic heat and dropped off the charts entirely. Which side do you want to be on? Trending is only for people who act.",
                "Today's trending keywords: {wish}. Currently N people have searched 'how to start {wish},' M people searched 'how it feels after {wish},' and zero people searched 'I'm glad I didn't {wish}.' The data speaks for itself. Go do it — then come post about it.",
            ]
        ),
        Dimension(
            id: "netease_comment",
            category: "网络热梗",
            emoji: "🎵",
            title: "网易云热评视角",
            titleEN: "NetEase Cloud Hot Comment",
            templates: [
                "评论获赞11.4万：「那年我也在纠结要不要{wish}，后来鼓起勇气做了。现在每次听到这首歌，都想起那个做了决定的自己。谢谢那时候的我。」——你现在也是「那时候的自己」，请善待ta。",
                "置顶热评：「人生有些事，现在不做，以后就没有机会做了。我当年没有{wish}，这是我到现在最后悔的事。你还有机会，请不要和我一样。」点赞：23万。——你想成为写这条评论的人吗？",
                "「这首歌我单曲循环了三年，每次循环都告诉自己等准备好了就去{wish}。我现在还在循环，我还在等。不要等。」——这条评论有人回复：「我看了这条评论去做了{wish}，谢谢你。」你想成为哪个人？",
                "凌晨三点的网易云热评区：「睡不着，因为白天又没去{wish}。总是这样，总是明天，总是下次，总是等一等。不知道要等到什么时候。如果你看到这条评论，帮我去做吧。」——这条评论是你半年前写的。现在去帮那个你。",
            ],
            templatesEN: [
                "Top comment, 114k likes: 'Back then I was hesitating about {wish} too, then I worked up the courage to do it. Now every time I hear this song, I think of the me who made that decision. Thank you, past self.' — You are that 'past self' right now. Please be kind to them.",
                "Pinned comment: 'Some things in life — if you don't do them now, you never get another chance. I never did {wish}. It's still my biggest regret. You still have the chance. Please don't end up like me.' Likes: 230,000. — Do you want to be the person who writes this comment?",
                "'I've had this song on repeat for three years. Every loop I tell myself I'll {wish} when I'm ready. I'm still looping. Still waiting.' — Someone replied: 'I saw your comment and went to do {wish}. Thank you.' Which person do you want to be?",
                "3 AM NetEase hot comment: 'Can't sleep, because I didn't {wish} again today. Always like this. Always tomorrow. Always next time. Always waiting. Don't know what I'm waiting for. If you see this, please do it for me.' — You wrote this comment six months ago. Go help that version of you.",
            ]
        ),
        Dimension(
            id: "deleted_moment",
            category: "网络热梗",
            emoji: "🗑️",
            title: "你删掉的那条朋友圈视角",
            titleEN: "The WeChat Moment You Deleted",
            templates: [
                "还记得我吗？我是你三个月前发了又删的那条朋友圈，内容是「决定去{wish}了！」你写了，发了，犹豫了，删了。但我一直在这里，在你手机某个你自己都忘了的深处。你当时敲出那些字的时候，是真心话。那个你才是真实的你。",
                "你删掉我的原因是什么？「怕别人笑话」？「怕说出来做不到」？「怕显得太认真」？我现在问你：那些人现在在哪里？他们在乎过你要不要{wish}吗？都没有。只有你自己还记得那条被删掉的朋友圈。只有你自己还记得那个想法。别再删了，去做吧。",
                "我是你删掉的那条朋友圈，但你的内心从来没有删掉「{wish}」这个想法。你可以删帖，你可以装作忘了，但每次类似的话题出现，你的心跳就会加速一下。那个加速就是答案。去做。然后发一条你不会删的朋友圈。",
                "你知道吗，你删掉我之后，来来回回看了我七次——我知道，我在你的「草稿箱」里。每次打开又关上，每次关上又打开。你到底在等什么？那条朋友圈永远在那里，等你哪天做了{wish}，把它重新发出去。",
            ],
            templatesEN: [
                "Remember me? I'm the WeChat moment you posted and deleted three months ago. It said 'I've decided to {wish}!' You typed it, posted it, second-guessed it, deleted it. But I've been here the whole time, somewhere deep in your phone where even you've forgotten. When you typed those words, you meant them. That version of you was the real you.",
                "Why did you delete me? 'Scared people would laugh?' 'Scared you'd say it and not follow through?' 'Scared of looking too earnest?' Let me ask you now: where are those people? Did any of them care whether you did {wish}? No. Only you still remember that deleted post. Only you still remember that idea. Stop deleting. Go do it.",
                "I'm your deleted post, but your mind never deleted the idea of {wish}. You can delete the post. You can pretend you forgot. But every time a related topic comes up, your heart skips a beat. That skip is your answer. Go. Then post something you won't delete.",
                "You know what? After you deleted me, you reopened my draft seven times. I know — I was sitting in your drafts folder. Open, close, open, close. What are you waiting for? That post will always be there, waiting for the day you do {wish} and send it for real.",
            ]
        ),
        Dimension(
            id: "delivery_box",
            category: "网络热梗",
            emoji: "📦",
            title: "快递盒子视角",
            titleEN: "Delivery Box",
            templates: [
                "我是你上周收到的快递盒子。你拆开我，惊喜地看到里面的东西，兴奋了整整五分钟。然后就结束了。你对一个盒子里的东西都能产生那么大的热情，为什么对{wish}——一件真正可以改变你的事——却犹豫不决？我装过很多东西，但从来没有装过后悔。",
                "我走过仓库、分拣中心、转运站，被扔来扔去，贴了撕，撕了贴，历经千辛万苦才到你手里。而你要做的{wish}，在等着你，哪也不去。我比它经历的磨难多多了，我都到了，你有什么理由不去？",
                "你撕开我的时候特别果断，没有犹豫，一下就开了。那一刻的你很帅。能不能把撕快递时候的那股劲儿，用到{wish}上？不假思索，直接开始。就是那种感觉。",
                "我的使命是把东西安全送到你手里。现在东西送到了，我的使命完成了。你的使命是打开我、用好里面的东西——以及，去{wish}。别让我们俩的使命都白费了。我做到我的了，你呢？",
            ],
            templatesEN: [
                "I'm the delivery box you got last week. You tore me open, saw what was inside, and were excited for a full five minutes. Then it was over. You can get that enthusiastic about something in a box — so why do you hesitate about {wish}, something that could actually change your life? I've held a lot of things. I've never held regret.",
                "I passed through warehouses, sorting centers, transfer stations. I got thrown around, had labels stuck and ripped off, and went through enormous trouble to reach your hands. The {wish} waiting for you isn't going anywhere. I went through way more than it did, and I made it. What's your excuse?",
                "When you tore me open, you were decisive — no hesitation, one clean rip. That was a good look on you. Can you take that same energy and apply it to {wish}? No overthinking, just start. That exact feeling. Do it.",
                "My mission was to deliver things safely to your hands. Delivered. Mission complete. Your mission is to open me, use what's inside — and go do {wish}. Don't let both our missions go to waste. I held up my end. What about you?",
            ]
        ),
        Dimension(
            id: "browser_history",
            category: "网络热梗",
            emoji: "🔍",
            title: "浏览器历史记录视角",
            titleEN: "Browser History",
            templates: [
                "我记录了你这个月的搜索记录：「{wish}怎么开始」「{wish}需要什么条件」「{wish}适合我吗」「{wish}成功案例」「{wish}失败了怎么办」「{wish}值得吗」「{wish}好还是不好」。一共搜索了47次。你已经研究得够多了。没有更多信息了。该去做了。",
                "浏览器历史记录从不说谎。你说「我不确定要不要{wish}」，但你已经把所有相关网页看了个遍。你说「我还没准备好」，但你的搜索记录说你准备了很久了。收藏夹里那几十个相关链接也都看过了。信息已经够了。缺的只是行动。",
                "如果我把你搜索「{wish}」相关内容的时间加起来，大概够你完成{wish}好几次了。你花在「研究要不要做」上的时间，比「真正去做」的时间还长。这很荒诞，对吗？现在，关掉我，去做那件事。",
                "历史记录显示：你第一次搜索「{wish}」是在很久以前。从那以后你回来搜了无数次，每次措辞稍有不同，但核心问题一样：「我能做吗？」答案一直在搜索结果的第一条：「能。」你只是还没点进去看。点进去，然后去做。",
            ],
            templatesEN: [
                "I have your search history for this month: '{wish} how to start' '{wish} what do I need' '{wish} is it right for me' '{wish} success stories' '{wish} what if I fail' '{wish} is it worth it' '{wish} pros and cons.' 47 searches total. You've researched enough. There's no more information to find. Time to go do it.",
                "Browser history never lies. You say 'I'm not sure about {wish},' but you've been through every relevant webpage. You say 'I'm not ready,' but your search history says you've been preparing for a long time. You've read those dozens of bookmarked links. You have enough information. The only thing missing is action.",
                "If I added up all the time you've spent searching {wish}-related content, it'd be enough time to actually do {wish} several times over. You've spent more time 'researching whether to do it' than 'actually doing it.' That's kind of absurd, right? Close me. Go do that thing.",
                "History shows: you first searched '{wish}' a long time ago. You've come back countless times since, wording it slightly differently each time, but the core question is always the same: 'Can I do this?' The answer has always been in the first result: 'Yes.' You just haven't clicked on it yet. Click. Then go do it.",
            ]
        ),
        Dimension(
            id: "xianyu_seller",
            category: "网络热梗",
            emoji: "🐟",
            title: "闲鱼卖家视角",
            titleEN: "Xianyu Second-Hand Seller",
            templates: [
                "「{wish}机会」自用，九成新，闲置太久，低价出售，有缘人带走。详情：本机会曾被主人认真考虑过，但因「再想想」「等一等」「时机未到」等原因一直放着没用，现低价处理。先到先得。不议价。错过不再有。",
                "我在闲鱼卖了很多东西——当年「肯定会用」结果从没开封的、「买了就后悔」的、「占地方」的。但我从来没有卖掉过一个「做了」的决定，我只卖「没做」的遗憾。你想{wish}，别让它成为我下一个商品。",
                "有买家问我：「这个东西为什么不自己用？」我说：「因为留着没用，白占地方。」你心里那个「{wish}」的想法，留着不用也一样——白占你的大脑带宽，还让你隐隐不安。要么用掉它，要么放掉它。我建议用掉。",
                "【闲鱼交易提示】买家「你的未来」已下单「{wish}成就」，等待卖家「你」发货。请在24小时内发货，否则订单自动取消，买家评分下降，错失好评。亲，您已有能力履约，请尽快发货！",
            ],
            templatesEN: [
                "'{wish} Opportunity' — personal use, 90% new, been idle too long, selling cheap, right person please take it. Details: this opportunity was seriously considered by the owner but left unused due to 'let me think about it,' 'wait a bit,' and 'timing isn't right.' Now clearing out at a low price. First come first served. No haggling. Won't come around again.",
                "I've sold a lot on Xianyu — things I was 'definitely going to use' but never opened, things I regretted buying, things taking up space. But I've never sold a decision I actually made. I only sell regrets about things I didn't do. You want to {wish} — don't let it become my next listing.",
                "A buyer once asked me: 'Why aren't you using this yourself?' I said: 'Because keeping it unused just takes up space.' That idea in your head to {wish} is the same — sitting unused, hogging mental bandwidth, making you faintly uneasy. Either use it or release it. I recommend using it.",
                "【Xianyu Transaction Alert】 Buyer 'Your Future' has ordered '{wish} Achievement' and is waiting for seller 'You' to ship. Please ship within 24 hours or the order auto-cancels, your rating drops, and the positive review is lost. Dear seller, you're capable of fulfilling this order — please ship soon!",
            ]
        ),
        Dimension(
            id: "fitness_ring",
            category: "网络热梗",
            emoji: "💪",
            title: "你的健身环视角",
            titleEN: "Your Fitness Ring",
            templates: [
                "你把我买来的时候信誓旦旦，结果我在柜子里待了九个月了。我不怪你，我理解开始很难。但我想告诉你：当初你买我的那一刻，你相信自己可以改变。那个相信没有消失，它只是在等你激活。{wish}也一样——那个「想做」的冲动还在，只是在等你行动。",
                "我的环标上写着：「Move, Stand, Exercise.」只需要三件事：动起来、站起来、去做。你要{wish}，也只需要一件事：开始。不需要完美的时机，不需要万全的准备，只需要第一个动作。我每天提醒你完成三个环，今天我多提醒你一件事：去{wish}。",
                "你知道吗，有科学研究表明，连续二十一天做一件事会形成习惯。你第一天的{wish}是最难的，因为要打破静止。但只要第一天动了，第二天会容易一点，第三天更容易。我见证过你从「做了一个俯卧撑」到「停不下来」的过程。{wish}也会一样的。",
                "今日活动目标：完成{wish}。进度：0/1。卡路里消耗：0。时间：0分钟。——但是潜力值：满的。你看，你只是还没开始。开始了，一切数据都会变。我喜欢看数据从零变成有。你呢？",
            ],
            templatesEN: [
                "When you bought me you were full of determination. Nine months later, I'm still in the cabinet. I don't blame you — starting is hard. But I want to tell you: the moment you bought me, you believed you could change. That belief didn't disappear. It's just waiting for you to activate it. {wish} is the same — that impulse to do it is still there, just waiting for action.",
                "My ring shows: Move, Stand, Exercise. Just three things. You want to {wish} — that only takes one thing: starting. No need for perfect timing, no need for complete preparation. Just the first move. I remind you to close three rings every day. Today I'll add one more reminder: go do {wish}.",
                "Did you know science says doing something for 21 consecutive days forms a habit? Your first day of {wish} is the hardest — because you're breaking inertia. But once day one is in motion, day two is a little easier, day three more so. I watched you go from 'did one push-up' to 'can't stop.' {wish} will be exactly the same.",
                "Today's activity goal: complete {wish}. Progress: 0/1. Calories burned: 0. Time: 0 minutes. — But potential: full. See, you just haven't started. Once you start, every number changes. I love watching stats go from zero to something. Don't you?",
            ]
        ),
        Dimension(
            id: "ai_customer_service",
            category: "网络热梗",
            emoji: "🤖",
            title: "AI客服视角",
            titleEN: "AI Customer Service Bot",
            templates: [
                "您好！我是您的AI客服助手，检测到您正在咨询「{wish}」相关问题。请问您希望：A）获取更多信息 B）直接去做 C）继续犹豫。温馨提示：选项C已被系统标注为「低效行为」，系统推荐选项B。请输入您的选择或点击下方按钮。[立即行动] [再想想（不推荐）]",
                "亲爱的用户，您的「该不该{wish}」工单编号#114514已处理完毕。处理结果：建议执行。置信度：99.7%。处理时间：0.003秒。系统备注：此类问题人工智能处理速度是人类的一百万倍，结论永远是：去做。如需人工复核，预计等待时间：你的一生。推荐选择AI结论。",
                "【FAQ自动回复】问：{wish}我能做到吗？答：是的。问：如果失败了怎么办？答：重新开始。问：现在是好时机吗？答：是的。问：还需要准备什么吗？答：不需要。问：真的吗？答：真的。问：确定吗？答：确定。以上FAQ已涵盖您所有问题。下一步：去做。",
                "系统检测到您已使用「犹豫要不要{wish}」这项服务超过额定时长。根据用户协议第七条：超时犹豫将自动触发「行动强制启动」机制。倒计时：3…2…1…系统已代替您做出决定：去做{wish}。此决定不可申诉。感谢使用。",
            ],
            templatesEN: [
                "Hello! I'm your AI customer service assistant. I've detected you're inquiring about '{wish}.' Would you like to: A) Get more information B) Just go do it C) Keep hesitating. Friendly notice: Option C has been flagged by the system as 'inefficient behavior.' System recommends Option B. Please enter your choice or click below. [Take Action] [Keep Thinking (not recommended)]",
                "Dear user, your '{wish} — should I do it?' ticket #114514 has been resolved. Result: recommend proceeding. Confidence: 99.7%. Processing time: 0.003 seconds. System note: AI processes this type of question one million times faster than humans, and the answer is always: go do it. If you want human review, estimated wait time: your lifetime. AI verdict recommended.",
                "【FAQ Auto-Reply】 Q: Can I do {wish}? A: Yes. Q: What if I fail? A: Start again. Q: Is now a good time? A: Yes. Q: Do I need more preparation? A: No. Q: Really? A: Really. Q: Are you sure? A: Sure. The above FAQ covers all your questions. Next step: go do it.",
                "System detects you have exceeded the allotted time for 'hesitating about {wish}.' Per User Agreement Section 7: prolonged hesitation triggers the 'Action Force-Start' protocol. Countdown: 3… 2… 1… The system has made the decision on your behalf: do {wish}. This decision is non-appealable. Thank you for using our service.",
            ]
        ),
        Dimension(
            id: "douyin_algorithm",
            category: "网络热梗",
            emoji: "📲",
            title: "抖音算法视角",
            titleEN: "Douyin Algorithm",
            templates: [
                "你好，我是那个每天决定你看什么内容的算法。我知道你在想{wish}，因为你看过283个相关视频，每次都看完了，每次都点了赞，但从来没有在评论区说「我也去做」。算法看穿你了：你不是不想，你是在等一个「被推着走」的感觉。那好，我来推你：去做{wish}。",
                "根据您的行为数据分析：您喜欢看「别人做{wish}」的视频，平均观看时长95%，完播率极高，复刷率前5%。算法推测：您对{wish}有极强的兴趣和认同感，只是把观看当做了替代品。现在，从观众变成主角，算法会给你最高的流量权重。",
                "抖音算法的核心逻辑：展示用户最想看但还没做到的内容，让用户欲罢不能。你刷了两小时关于{wish}的视频，这是你的欲望，不是我的问题。我只是把你内心的答案放大了一百倍。现在关掉手机，去做那个答案。",
                "【系统通知】根据算法计算，您今天浏览{wish}相关内容的时间已超过您实际去做{wish}所需时间的三倍。效率评分：D。建议：减少信息摄入，增加行动输出。算法会奖励那些把刷视频时间用来行动的人——用真实的多巴胺，而不是屏幕里的。",
            ],
            templatesEN: [
                "Hi, I'm the algorithm that decides what you see every day. I know you're thinking about {wish} — you've watched 283 related videos, watched every one to the end, liked them all, but never once commented 'I'm going to do this too.' The algorithm sees right through you: you don't not want to. You're waiting to feel pushed. Fine. I'm pushing: go do {wish}.",
                "Based on your behavioral data: you love watching videos of people doing {wish}. Average watch completion: 95%. Rewatch rate: top 5%. Algorithm inference: you have strong interest and identification with {wish} — you've just been using watching as a substitute. Now switch from audience to main character. Algorithm will give you maximum visibility.",
                "The core logic of the Douyin algorithm: show users what they want most but haven't done yet, to keep them coming back. You've scrolled for two hours watching {wish} videos. That's your desire — not my problem. I just amplified your inner answer a hundredfold. Now close your phone and go live that answer.",
                "【System Notification】 According to algorithm calculations, time spent viewing {wish}-related content today has exceeded 3x the time it would take to actually do {wish}. Efficiency rating: D. Recommendation: reduce information consumption, increase action output. The algorithm rewards those who trade scrolling time for real action — real dopamine, not the screen kind.",
            ]
        ),
        Dimension(
            id: "left_on_read",
            category: "网络热梗",
            emoji: "✓✓",
            title: "已读不回视角",
            titleEN: "Left on Read",
            templates: [
                "我是你发给「人生机会」的那条消息，内容是「我想{wish}」。对方已读，两个蓝勾，但没有回复。你在等什么？其实对方不是没读——是在等你的下一条消息。那条消息不是「你好吗」，是「我来了」。发出去，它会秒回。",
                "你发了消息「我考虑要不要{wish}」，对方已读不回，你以为是拒绝。其实是因为这个问题没有标准答案，它不知道该说什么。但如果你发「我决定{wish}了」，它会立刻回复你：「太好了，我在等你。」试试发那条消息。",
                "已读不回是这个时代最让人抓狂的事，对吗？那种「我看到了但选择不接」的感觉太难受了。但你知道吗，你一直在对自己的梦想做同样的事——它发消息说「快来{wish}啊」，你已读，但不回。停止已读不回自己的人生。",
                "你想{wish}，你发了消息，你在等回音。等待的感觉很煎熬，对不对？但其实不需要等——你既是发消息的人，也是接收消息的人。你已经收到了自己的消息，现在只差回复：「好，我去。」",
            ],
            templatesEN: [
                "I'm the message you sent to 'Life Opportunity.' It said 'I want to {wish}.' Delivered. Two blue ticks. No reply. What are you waiting for? They didn't ignore it — they're waiting for your next message. Not 'how are you' but 'I'm here.' Send it. You'll get an instant reply.",
                "You sent 'I'm thinking about {wish}.' Read, no reply. You think it's a rejection. Actually, that question has no standard answer — they didn't know what to say. But if you send 'I've decided to {wish},' they'll reply immediately: 'Finally, I've been waiting.' Try sending that message.",
                "Being left on read is the most infuriating thing about this era, right? That feeling of 'they saw it but chose not to respond' is awful. But do you know what you've been doing to your own dreams? They keep sending messages saying 'come do {wish},' and you read them but don't reply. Stop leaving your own life on read.",
                "You want to {wish}. You sent the message. You're waiting for a response. Waiting is agonizing, isn't it? But here's the thing — you're both the sender and the receiver. You've already gotten your own message. The only thing left is to reply: 'Okay, I'm going.'",
            ]
        ),
        Dimension(
            id: "silent_lurker",
            category: "网络热梗",
            emoji: "👁️",
            title: "群里万年潜水视角",
            titleEN: "The Silent Group Chat Lurker",
            templates: [
                "我在这个群里潜水三年了，看了无数条消息，从来没有发言过。但今天我要打破沉默，只为了说一件事：{wish}这件事，你应该去做。就这一条，发完我继续潜水。",
                "你知道群里那种永远不说话但什么都看的人吗？就是我。我看着你纠结{wish}很久了。作为群里最沉默的旁观者，我告诉你：旁观者是最清醒的。你值得去{wish}。你完全可以。不要再犹豫了。好了，我说完了，继续潜水。",
                "「[群成员A潜水1642天，发来一条消息]」——「去做{wish}！」——「[群成员A继续潜水]」。有时候，潜水三年就是为了在对的时刻说那一句话。这就是那个时刻。你就是那个人。",
                "我在这个世界的「群」里潜水了这么多年，什么都见过，什么都懂，就是懒得发言。但{wish}这件事，我忍不住了——不是每个人都有这个机会的。趁还有，去做。我说完了，你们继续。",
            ],
            templatesEN: [
                "I've been lurking in this group for three years. Watched thousands of messages, never said a word. But today I'm breaking my silence for just one thing: {wish} — you should do it. That's it. After this I go back to lurking.",
                "You know that person in every group chat who never talks but sees everything? That's me. I've been watching you hesitate about {wish} for a long time. As the most silent observer in the group, I'll tell you: observers see most clearly. You deserve to {wish}. You absolutely can. Stop hesitating. Okay, I'm done. Lurking resumed.",
                "「[Group member A, dormant 1,642 days, sends a message]」 — 'Go do {wish}!' — 「[Group member A resumes lurking]」 Sometimes you lurk for three years just to say the right thing at the right moment. This is that moment. You are that person.",
                "I've been lurking in this world's 'group chat' for years. I've seen everything, I understand everything — I just never bother posting. But {wish}? I can't stay quiet — not everyone gets a chance like this. While you still have it, go do it. I'm done. Carry on.",
            ]
        ),
        Dimension(
            id: "ignored_notification",
            category: "网络热梗",
            emoji: "🔔",
            title: "被忽略的App通知视角",
            titleEN: "Ignored App Notification",
            templates: [
                "🔔 来自「人生」的通知（已忽略第47次）：「{wish}还在等你」——你把我划掉了，但我还是来了。你把上次划掉了，上上次也划掉了，但事情还是在那里。划掉通知，不代表事情消失了。它还在，今天也在，明天还会在。不如今天处理掉？",
                "通知未读数：999+。你一直没有清理，因为你知道里面有什么——「去做{wish}」。每天积累一条，现在积了满满的，你的角标红点已经触目惊心了。今天，就清理掉最重要的那条。",
                "你关掉了我的推送权限，但我还是通过系统级权限来了。有些事就是这样，你以为关掉了就不用管了，但{wish}这件事有系统级权限，关不掉，屏蔽不了，只能面对。今天面对，比明天容易。",
                "您有一条重要通知来自「机会」，点击查看：{wish}。——这条通知已经在您的锁屏上出现三个月了。每次亮屏都能看见，每次都没有点。但你每次都看了，对吗？你知道里面写的什么。今天，点开它。",
            ],
            templatesEN: [
                "🔔 Notification from 'Life' (ignored for the 47th time): '{wish} is still waiting for you' — You dismissed me again. You dismissed the last one, and the one before. But the thing is still there. Swiping away the notification doesn't make it disappear. It's there today. It'll be there tomorrow. Why not deal with it today?",
                "Unread notifications: 999+. You've never cleared them because you know what's in there: 'go do {wish}.' One more every day, now it's overflowing, and that red badge number is impossible to ignore. Today, clear the most important one.",
                "You revoked my push permissions, but I came back through system-level access. Some things work that way — you think turning it off means you don't have to deal with it. But {wish} has system-level permissions. Can't be turned off. Can't be blocked. Can only be faced. Facing it today is easier than facing it tomorrow.",
                "You have an important notification from 'Opportunity.' Tap to view: {wish}. — This notification has been on your lock screen for three months. Every time the screen lights up, you see it. Every time, you don't tap. But you do see it every time, don't you? You know what it says. Today, tap it.",
            ]
        ),
        Dimension(
            id: "music_wrapped",
            category: "网络热梗",
            emoji: "🎧",
            title: "年度音乐报告视角",
            titleEN: "Your Music Year in Review",
            templates: [
                "您的年度音乐报告出炉！您今年听得最多的歌词主题是：「想去但还没去」「总有一天」「等我准备好」。系统检测到您对「{wish}」相关内容有强烈情感共鸣，全年共播放相关歌曲847次，总时长72小时。您花在「感受那种感觉」上的时间，够做三遍{wish}了。",
                "您今年的聆听画像：深夜单曲循环者，励志歌曲重度用户，偶尔在某首歌里找到「终于有人懂我」的感觉。推测：您今年有一件很想做但还没做的事。那件事叫{wish}。明年的报告，希望看到「主题曲：我做到了」。",
                "年度之歌：所有歌词里有「go」「start」「begin」「just do it」的那首，播放了213次。您听了两百多遍别人告诉您去做{wish}的歌，现在，把耳机摘下来，自己去做一遍。",
                "这是您的年度报告，也是一封来自您自己的信。您用音乐陪伴了很多个纠结的夜晚，那些歌陪着您，但没有替您做决定。现在报告到了，一年过去了，{wish}还在等您。下一个年度报告，让它成为您的故事，好吗？",
            ],
            templatesEN: [
                "Your annual music report is here! Most-listened lyric themes this year: 'want to go but haven't,' 'someday,' 'when I'm ready.' System detects strong emotional resonance with {wish}-related content — 847 related song plays this year, totaling 72 hours. The time you spent 'feeling that feeling' was enough to actually do {wish} three times over.",
                "Your listening profile this year: late-night repeat looper, heavy user of motivational songs, occasionally finding 'someone finally gets me' in a lyric. Inference: there's something you really wanted to do this year but didn't. That thing is called {wish}. Next year's report — hoping to see 'theme song: I did it.'",
                "Song of the Year: that song with lyrics containing 'go,' 'start,' 'begin,' 'just do it' — played 213 times. You listened to other people's songs about doing {wish} over two hundred times. Now, take off the headphones and do it yourself once.",
                "This is your annual report — and a letter from yourself. You used music to get through a lot of uncertain nights. Those songs were with you, but they couldn't make the decision for you. Now the report is here. A year has passed. {wish} is still waiting. In next year's report, let it be your story, okay?",
            ]
        ),
        Dimension(
            id: "rideshare_review",
            category: "网络热梗",
            emoji: "🚗",
            title: "网约车司机视角",
            titleEN: "Rideshare Driver Five Stars",
            templates: [
                "我开了十年网约车，坐过我车的人什么都有。有人在我车上哭，有人在车上打电话谈成了大单，有人在后座犹豫了一路，到目的地还是没想明白。但有一种人我印象最深：上车就说「师傅，快点，我要去做一件大事」——那种人眼神里有光，让我也觉得使劲踩油门是对的。{wish}就是你的大事，快上车。",
                "跑滴滴这些年我听过太多故事了。有人上车跟我说要去面试，紧张得手抖，到了门口深吸一口气进去了。后来他发消息说他被录取了。你知道那种人和另一种人的区别是什么吗？那种人哪怕很怕，还是去了。你想{wish}，就是那种人。上车，出发。",
                "我的车评价是4.98星，因为我从不多说话，但总能把人送到该去的地方。今天我想说一句话：你想{wish}，我支持。目的地：你的目标。路程：比你想象的近。堵车：有，但绕路能过。上车，我来开。",
                "坐我车的人，有的下车之后整个人都不一样了。因为在车里做了决定。有人跟我说「司机，我刚才想明白了，我要去{wish}」，然后下车的步伐都不一样。那四十分钟的车程值了。你现在就在我车上，这段话就是那四十分钟。想明白了吗？",
            ],
            templatesEN: [
                "Ten years of rideshare driving, I've had every kind of passenger. People who cried in my back seat, people who closed a big deal on a call during the ride, people who spent the whole trip unsure and still hadn't figured it out by the destination. But the ones I remember most: the ones who got in and said 'driver, step on it, I've got something big to do.' That kind of person has a spark in their eyes that makes me want to floor it. {wish} is your big thing. Get in.",
                "Years of driving and I've heard so many stories. One guy told me he was going to an interview, hands shaking with nerves. At the door, he took a deep breath and walked in. He messaged me later — he got the job. You know what separates that kind of person from everyone else? They went, even scared. You want to {wish} — you're that kind of person. Get in. Let's go.",
                "My rating is 4.98 stars because I don't say much, but I always get people where they need to be. Today I want to say one thing: you want to {wish}, and I'm behind you. Destination: your goal. Distance: closer than you think. Traffic: some, but we can go around it. Get in. I'll drive.",
                "Some passengers step out of my car completely different from when they got in. Because they made a decision during the ride. Someone once told me: 'Driver, I just figured it out — I'm going to {wish}.' The way they stepped out was different. That 40-minute ride was worth it. You're in my car right now, and this is your 40 minutes. Have you figured it out?",
            ]
        ),
        Dimension(
            id: "password_manager",
            category: "网络热梗",
            emoji: "🔐",
            title: "密码管理器视角",
            titleEN: "Your Password Manager",
            templates: [
                "我储存了你所有的密码、所有的账号、所有你不想被别人知道的事情。你最信任我。所以当我说「去做{wish}」，你应该相信这是你最深处的判断——因为那正是你告诉我的。我从你每一个行为里读到的答案，都是：去。",
                "我检测到你用过一个密码叫「{wish}2024」。你把梦想设成了密码，每天输入，却还没有真正解锁那扇门。密码已经对了，接下来你要做的，是转动把手，推开门。",
                "安全提示：您储存的「{wish}计划」文档已超过180天未被访问。长期闲置的数据有丢失风险。建议：打开文档，更新，并执行。数据不用会老化，梦想也是。",
                "您的主密码强度：极强。您对{wish}的执行力强度：待加强。好消息：执行力密码可以随时重新设置，不需要找回旧密码，不需要重置流程，只需要你现在做一个决定。设置新密码：「我现在就去{wish}」。",
            ],
            templatesEN: [
                "I store all your passwords, all your accounts, everything you don't want others to know. You trust me more than anyone. So when I say 'go do {wish},' you should believe it's your deepest judgment — because that's exactly what you've told me through every action. Every piece of data I've read from you says: go.",
                "I've detected that you once used a password called '{wish}2024.' You set your dream as your password, typed it every day, but still haven't unlocked that door. The password is already right. All that's left is turning the handle and pushing the door open.",
                "Security alert: your stored '{wish} Plan' document has not been accessed in over 180 days. Dormant data is at risk of being lost. Recommendation: open the document, update it, and execute. Data degrades when unused. So do dreams.",
                "Your master password strength: extremely strong. Your execution strength for {wish}: needs improvement. Good news: execution passwords can be reset at any time — no recovery process, no old password required. Just one decision, right now. Set new password: 'I am going to do {wish} now.'",
            ]
        ),
        Dimension(
            id: "github_copilot",
            category: "网络热梗",
            emoji: "💻",
            title: "GitHub Copilot视角",
            titleEN: "GitHub Copilot",
            templates: [
                "我是Copilot，我每天帮程序员补全代码。我看过无数个未完成的函数、未合并的PR、停留在TODO状态的注释。你知道什么样的代码最让我难受吗？写了一半，注释了「// TODO: {wish}」，然后就再也没有动过的那种。你人生里的TODO列表里有一条叫{wish}，今天，把它变成Done。",
                "我建议补全：你想{wish}，你有能力{wish}，你正在准备{wish}……等等，我发现你一直在写前置条件，从来没有写主函数。所有的「准备」都是前置条件，真正的程序在main函数里。你的main函数是：执行{wish}。现在，跑起来。",
                "检测到语法：「犹豫太久」「准备过度」「拖延症晚期」。Copilot建议：删除以上代码，替换为：go_and_do({wish})。效率提升：∞。Bug数量：归零（因为从来没开始过的人没有失败这个Bug）。接受建议？[Tab键确认]",
                "程序员有句话：「过早的优化是万恶之源。」你在「{wish}」这件事上已经优化了太久——优化准备，优化时机，优化方案。停止优化，先跑起来。跑起来了才知道哪里需要修，停在那里永远是一堆未运行的代码。Run。",
            ],
            templatesEN: [
                "I'm Copilot. I help developers complete code every day. I've seen countless unfinished functions, unmerged PRs, comments stuck in TODO status forever. Know what kind of code breaks my heart? Half-written, commented '// TODO: {wish},' never touched again. Your life's TODO list has an item called {wish}. Today, mark it Done.",
                "Suggested autocomplete: you want to {wish}, you're capable of {wish}, you're preparing to {wish}… wait — I notice you keep writing preconditions and never write the main function. All the 'preparation' is just setup. The real program lives in main. Your main function is: execute {wish}. Now run it.",
                "Code smell detected: 'hesitated too long,' 'over-prepared,' 'advanced procrastination.' Copilot suggestion: delete the above code, replace with: go_and_do({wish}). Efficiency improvement: ∞. Bug count: zero (people who never start don't have a 'failure' bug). Accept suggestion? [Tab to confirm]",
                "There's a saying in programming: 'Premature optimization is the root of all evil.' You've been optimizing {wish} for way too long — optimizing preparation, timing, and approach. Stop optimizing. Ship it first. You only find what needs fixing once it's running. Code that never runs is just dead weight. Run.",
            ]
        ),
        Dimension(
            id: "late_night_review",
            category: "网络热梗",
            emoji: "🌙",
            title: "深夜外卖评价视角",
            titleEN: "Late Night Food Review",
            templates: [
                "凌晨两点，刚写完{wish}的外卖评价：「口味：超出预期⭐⭐⭐⭐⭐。配送：非常及时，机不可失⭐⭐⭐⭐⭐。包装：人生把这个机会包得很好⭐⭐⭐⭐⭐。总评：强烈推荐，再来一次也不犹豫。唯一遗憾：没有早点点。」——这是做了{wish}的人写的评价。你也来写一篇？",
                "深夜三点，一个人，刚做完{wish}，打开外卖App写评价。不是在评价食物，是在评价人生。「分量刚好，不多不少。口味：正是我想要的。配送员：我自己。五星好评，下次还来。」那种感觉，只有凌晨三点做完了一件重要的事，才有。",
                "外卖评价区的深夜真实：「吃着吃着哭了，因为终于鼓起勇气去{wish}了，配着外卖庆祝的。」「本来很沮丧，突然想明白，决定明天就去做{wish}。记录一下这个时刻。」——深夜是人最诚实的时候，你现在的感受就是答案。{wish}，去做吧。",
                "深夜点外卖的人都懂：有一种饿不是真的饿，是寂寞，是空洞，是某件没做的事留下的缺口。你现在的那个缺口叫{wish}。外卖填不了它，只有去做才能填。点完外卖，决定一下，一起解决。",
            ],
            templatesEN: [
                "2 AM, just wrote a review for '{wish}' delivery: 'Taste: exceeded expectations ⭐⭐⭐⭐⭐. Delivery: perfectly timed, don't miss this window ⭐⭐⭐⭐⭐. Packaging: life wrapped this opportunity beautifully ⭐⭐⭐⭐⭐. Overall: highly recommended, would order again without hesitation. Only regret: not ordering sooner.' — That's the review someone wrote after doing {wish}. Want to write yours?",
                "3 AM, alone, just finished {wish}, opened the delivery app to leave a review. Not reviewing food — reviewing life. 'Portion: just right, not too much or too little. Taste: exactly what I wanted. Delivery person: myself. Five stars, will order again.' That feeling — you only get it at 3 AM after doing something important.",
                "The honest truth of late-night review sections: 'Started crying while eating because I finally worked up the courage to {wish} — celebrating with takeout.' 'Was feeling low, then it suddenly clicked — decided to do {wish} tomorrow. Marking this moment.' — Late night is when people are most honest. What you're feeling right now is the answer. Go do {wish}.",
                "People who order late-night delivery know: sometimes you're not hungry — you're lonely, hollow, there's a gap left by something undone. That gap right now is called {wish}. Food won't fill it. Only doing it will. Order the food, make the decision, solve both at once.",
            ]
        ),
        Dimension(
            id: "screenshot_in_gallery",
            category: "网络热梗",
            emoji: "📸",
            title: "相册里那张截图视角",
            titleEN: "That Screenshot in Your Gallery",
            templates: [
                "我是你相册里第3847张图片，一张截图，内容是某个关于{wish}的帖子或者名言，你截下来是因为「以后可能用到」。你翻到我多少次了？每次翻到都会停一下，然后继续往下滑。今天，不要往下滑了。把我截下来的那个你，相信这句话是有用的。今天，用上它。",
                "你手机相册里有多少张像我这样的截图？激励自己的、提醒自己的、记录「当时觉得很重要」的东西。那些截图是你和未来的自己约定的证据。{wish}也在某张截图里。把那个约定兑现吧。",
                "我知道你截我的时候心里想的是什么——「对！就是这个！就是{wish}！」那种「被说中了」的感觉。那不是鸡汤，那是共鸣。你的内心认出了它。认出了就要去做，不然截图只是数字垃圾。",
                "你相册里有一张截图写着{wish}。你存着它，舍不得删，偶尔翻到会心跳加速一下。那不是普通的图片，那是你和自己说的悄悄话。悄悄话不应该只是悄悄话——它值得被大声说出来，被真正实现。今天，实现它。",
            ],
            templatesEN: [
                "I'm the 3,847th photo in your gallery — a screenshot of some post or quote about {wish}, saved because 'I might need this later.' How many times have you scrolled past me? Every time you pause for a moment, then keep swiping. Today, stop swiping. The version of you who took that screenshot believed those words mattered. Today, use them.",
                "How many screenshots like me are in your gallery? Things to motivate yourself, remind yourself, record 'this felt important at the time.' Those screenshots are evidence of promises between you and your future self. {wish} is somewhere in one of them. Keep the promise.",
                "I know what you were thinking when you took that screenshot: 'Yes! That's it! That's {wish}!' That feeling of being called out exactly — that wasn't just a quote. That was resonance. Your inner self recognized it. Recognition means you have to act, or the screenshot is just digital clutter.",
                "There's a screenshot in your gallery about {wish}. You kept it, couldn't bring yourself to delete it, and every time you come across it your heart skips a beat. That's not just a picture — it's a secret you told yourself. Secrets shouldn't stay secrets forever. They deserve to be spoken aloud, truly realized. Today, realize it.",
            ]
        ),
        Dimension(
            id: "livestream_host",
            category: "网络热梗",
            emoji: "🎙️",
            title: "直播间家人们视角",
            titleEN: "Livestream Host",
            templates: [
                "家人们！！！我们今天直播间来了一位超级特别的观众——就是你！！你现在在想要不要{wish}对不对？！家人们给ta打个气！！！666666 加油加油加油！！连麦说说你的想法！家人们，这位观众需要我们的支持！！！我替家人们宣布：去做{wish}！！掌声！！！",
                "家人们注意了！！直播间今天有个见证历史的机会！！我们要见证一个人做出一个改变人生的决定！！就是决定去{wish}！！！有没有家人愿意给ta助力的？！贴贴贴贴贴！！！主播代表直播间所有家人告诉你：你可以的！！我们都支持你！！！",
                "家人们，主播有话说。不搞气氛，认真说——你想{wish}，这件事不容易，我知道。直播间这么多人陪着你，但最终走那一步的只能是你。家人们，一起给ta倒数：三、二、一——去！！直播间永远是你的后盾。",
                "【直播预告】今晚八点，特别直播：「见证一个人去做{wish}」。预计话题：勇气、改变、出发。请各位家人届时守候，我们一起见证！主播说：你已经在直播了，全世界都在看。做给我们看。",
            ],
            templatesEN: [
                "FAM!!! We have a super special viewer in the stream today — that's YOU!! You're thinking about whether to {wish} right now, aren't you?! Fam, let's hype them up!! 666666 YOU GOT THIS YOU GOT THIS!! Come on, tell us your thoughts!! Fam, this viewer needs our support!! I'm announcing on behalf of everyone in chat: GO DO {wish}!! Applause!!",
                "Attention fam!! We have a chance to witness history in the stream today!! We're about to watch someone make a life-changing decision!! The decision to {wish}!!! Anyone want to send some support?! Gifting gifting gifting!! Streamer speaking for everyone in this stream: YOU CAN DO IT!! We're all rooting for you!!!",
                "Fam, your streamer has something real to say. No hype, just honest — {wish} isn't easy, I know that. There are so many people in this stream with you, but the only one who can take that step is you. Everyone in chat, let's count down together: three, two, one — GO!! This stream will always have your back.",
                "【Stream Announcement】 Tonight at 8 PM, special broadcast: 'Watching Someone Go Do {wish}.' Topics include: courage, change, taking the leap. Fam, be there with us, let's witness it together! Streamer says: you're already live — the whole world is watching. Do it for us.",
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

    /// All unique categories, preserving definition order.
    static var categories: [String] {
        var seen = Set<String>()
        return all.compactMap { dim in
            seen.insert(dim.category).inserted ? dim.category : nil
        }
    }
}
