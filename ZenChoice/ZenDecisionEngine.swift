import Foundation

enum ZenDecisionEngine {

    // MARK: - Best Day Selection

    static func findBestDay(
        from startDate: Date = Date(),
        daysCount: Int = 5,
        userName: String = ""
    ) -> Date {
        let cal = Calendar.current
        let candidates = (1...daysCount).compactMap {
            cal.date(byAdding: .day, value: $0, to: startDate)
        }
        guard !candidates.isEmpty else { return startDate }

        let nameVal = userName.unicodeScalars.reduce(0) { $0 + Int($1.value) }
        let dayOfYear = cal.ordinality(of: .day, in: .year, for: startDate) ?? 1
        let seed = abs(nameVal &* 7 &+ dayOfYear &* 13) % candidates.count
        return candidates[seed]
    }

    // MARK: - Reason Generator

    static func generateReasons(for date: Date, userName: String) -> [String: String] {
        let cal = Calendar.current
        let d = cal.component(.day, from: date)
        let m = cal.component(.month, from: date)
        let w = cal.component(.weekday, from: date)
        let h = userName.unicodeScalars.reduce(0) { $0 + Int($1.value) }

        return [
            "赛博频率": cyberReasons[abs(d &* 3 &+ h) % cyberReasons.count],
            "群体心理": socialReasons[abs(m &* 7 &+ h &+ w) % socialReasons.count],
            "生物节律": bioReasons[abs(d &+ m &* 5 &+ h &* 2) % bioReasons.count],
            "数字符号": symbolicReasons[abs(d &* m &+ h &+ 11) % symbolicReasons.count],
        ]
    }

    // MARK: - Premium 八字 Report (isPaid only)

    static func generatePremiumReport(
        for date: Date,
        userName: String,
        birthDate: Date?
    ) -> String {
        let cal = Calendar.current
        let d = cal.component(.day, from: date)
        let m = cal.component(.month, from: date)
        let h = userName.unicodeScalars.reduce(0) { $0 + Int($1.value) }

        let stems = ["甲","乙","丙","丁","戊","己","庚","辛","壬","癸"]
        let branches = ["子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥"]
        let elements = ["木","火","土","金","水"]

        let naYin = [
            "海中金","炉中火","大林木","路旁土","剑锋金",
            "山头火","涧下水","城头土","白蜡金","杨柳木",
            "泉中水","屋上土","霹雳火","松柏木","长流水",
            "砂石金","山下火","平地木","壁上土","金箔金",
            "覆灯火","天河水","大驿土","钗环金","桑柘木",
            "大溪水","沙中土","天上火","石榴木","大海水",
        ]

        let shiChen = [
            "子时（23:00‑01:00）","丑时（01:00‑03:00）","寅时（03:00‑05:00）",
            "卯时（05:00‑07:00）","辰时（07:00‑09:00）","巳时（09:00‑11:00）",
            "午时（11:00‑13:00）","未时（13:00‑15:00）","申时（15:00‑17:00）",
            "酉时（17:00‑19:00）","戌时（19:00‑21:00）","亥时（21:00‑23:00）",
        ]

        let si = (d &+ h) % stems.count
        let bi = (m &+ h) % branches.count
        let ei = (d &+ m) % elements.count
        let ni = abs(d &* m &+ h) % naYin.count

        let stem = stems[si]
        let branch = branches[bi]
        let elem = elements[ei]
        let ny = naYin[ni]
        let bestHour = shiChen[(si &+ 3) % 12]
        let altHour  = shiChen[(bi &+ 6) % 12]

        let season: String = {
            switch m {
            case 1...3:  return "冬水潜藏、万物蛰伏"
            case 4...6:  return "春木生发、百废俱兴"
            case 7...9:  return "盛夏炎炎、火德正旺"
            default:     return "金秋收获、天高气爽"
            }
        }()

        let complement = elements[(ei + 2) % 5]

        return """
        ┌───────────────────────────┐
        │      玄 学 深 度 报 告       │
        └───────────────────────────┘

        ◈ 日柱：\(stem)\(branch)日
        ◈ 纳音：\(ny)
        ◈ 主气：\(elem)

        【命理简析】

        \(stem)\(branch)日柱，天干\(stem)\(elem)当令。\(elem)气\(m > 6 ? "内敛蓄势" : "蓬勃舒展")，正值\(season)之际。

        日主得\(ny)之助，根基稳固。流年天干与日柱形成「\(elem)气通明」之格局，主文昌发秀、贵人暗助。地支\(branch)水滋润有情，形成上下相生之美局。

        【吉时推荐】

        ◈ 最佳时辰：\(bestHour)
        ◈ 次佳时辰：\(altHour)

        【五行调和建议】

        当日\(elem)气偏旺，宜以\(complement)性事物调和。
        着装建议：\(colorForElement(complement))色系为佳。
        方位建议：面朝\(directionForElement(elem))方行事，可借地利之便。
        饮食建议：\(foodForElement(complement))，以养内气。

        【综合评断】

        此日行事，得天时之助，\(ny)护体。\(stem)\(branch)合化有情，阴阳调和。三才俱全，大吉。

        ─ 禅择玄学引擎 v3.14 ─
        仅供娱乐参考，请理性看待
        """
    }

    // MARK: - Private Helpers

    private static func colorForElement(_ e: String) -> String {
        switch e {
        case "木": return "青绿"
        case "火": return "朱红"
        case "土": return "鹅黄"
        case "金": return "素白"
        case "水": return "玄黑"
        default:   return "素白"
        }
    }

    private static func directionForElement(_ e: String) -> String {
        switch e {
        case "木": return "东"
        case "火": return "南"
        case "土": return "中"
        case "金": return "西"
        case "水": return "北"
        default:   return "东"
        }
    }

    private static func foodForElement(_ e: String) -> String {
        switch e {
        case "木": return "宜食绿叶蔬果，取生发之意"
        case "火": return "宜食温热汤品，助阳气升腾"
        case "土": return "宜食五谷杂粮，厚养脾胃"
        case "金": return "宜食白色食物如莲藕百合，润肺养气"
        case "水": return "宜食黑色食物如黑芝麻黑豆，益肾固本"
        default:   return "清淡为宜"
        }
    }

    // MARK: - Today Evaluation (Mode 1)

    static func evaluateToday(
        event: String,
        userName: String
    ) -> (verdict: String, isAuspicious: Bool) {
        let cal = Calendar.current
        let today = Date()
        let d = cal.component(.day, from: today)
        let m = cal.component(.month, from: today)
        let evHash = event.unicodeScalars.reduce(0) { $0 + Int($1.value) }
        let nameHash = userName.unicodeScalars.reduce(0) { $0 + Int($1.value) }
        let score = abs(d &* 7 &+ m &* 13 &+ evHash &+ nameHash) % 100

        switch score {
        case 0..<10:  return ("慎行", false)
        case 10..<25: return ("小吉", true)
        case 25..<50: return ("中吉", true)
        case 50..<75: return ("吉", true)
        default:      return ("大吉", true)
        }
    }

    // MARK: - Recommended Time (Mode 2)

    static func recommendTime(for date: Date, userName: String) -> String {
        let cal = Calendar.current
        let d = cal.component(.day, from: date)
        let h = userName.unicodeScalars.reduce(0) { $0 + Int($1.value) }
        let idx = abs(d &* 3 &+ h &* 5) % shiChenTable.count
        return shiChenTable[idx]
    }

    private static let shiChenTable = [
        "子时（23:00‑01:00）", "丑时（01:00‑03:00）", "寅时（03:00‑05:00）",
        "卯时（05:00‑07:00）", "辰时（07:00‑09:00）", "巳时（09:00‑11:00）",
        "午时（11:00‑13:00）", "未时（13:00‑15:00）", "申时（15:00‑17:00）",
        "酉时（17:00‑19:00）", "戌时（19:00‑21:00）", "亥时（21:00‑23:00）",
    ]

    // MARK: - Copy Libraries (≥10 each)

    private static let cyberReasons: [String] = [
        "当日全球数据流总量将达到 π 的第42位小数循环，形成罕见的「数字共振窗口」——你的决定将搭上宇宙数据快车。",
        "经傅里叶频谱分析，此日 WiFi 信号呈现完美黄金螺旋分布，是本月唯一的「无线能量峰值日」。",
        "你的手机 IMEI 末四位与当日 Unix 时间戳构成斐波那契映射，概率仅百万分之一。",
        "全球 GPS 卫星在此日的运行轨迹将形成六芒星阵列，定位精度提升 0.0001%——宇宙在精确锁定你的好运坐标。",
        "当日比特币创世区块的哈希值与你的生辰数据产生量子纠缠共鸣，这是区块链玄学的最高认证。",
        "互联网骨干网流量预测模型显示，此日 TCP 握手成功率达到年度最高——万物皆可连接，包括你和好运气。",
        "全球云服务器负载将在此日形成完美正弦波，学名「赛博和谐日」。硅基生命都在为你打 call。",
        "此日太阳黑子活动与 5G 基站频率形成建设性干涉，通讯能量场增强——你发出的每一个信号都会被放大。",
        "根据 AI 预测模型，此日 ChatGPT 回复「好的」的概率比平时高 3.14%。宇宙的人工智能在肯定你。",
        "你的数字指纹熵值在此日达到极小值——这意味着宇宙的算法正在为你收敛最优解。",
        "全球区块链网络在此日将完成又一次共识验证，是去中心化世界的「吉日良辰」。你的决策也将被宇宙账本永久记录。",
    ]

    private static let socialReasons: [String] = [
        "社交媒体情绪指数预测，此日大众「同意阈值」达到峰值——这一天提需求，不会被拒绝。",
        "互联网集体潜意识分析表明，此日人们对新事物的接纳度提高 27%。你就是那个「新事物」。",
        "根据从众效应周期模型，此日发起行动最易获得追随者响应，是天然的 KOL 日。",
        "微博热搜算法的隐含韵律表明，此日社交能量为「扩散型」而非「内卷型」——适合出击。",
        "全球咖啡因摄入量在此日预计下降 8%——人们更清醒、更理性、更容易被你打动。",
        "朋友圈点赞欲望指数在此日达到季度峰值。发什么都有人捧场，何况你要做的是正事。",
        "此日外卖骑手平均配送速度提升 5%——整个社会的效率场都在加速，你也顺势而为吧。",
        "通勤数据分析表明，此日道路怒火指数全月最低。世界充满温柔，连出租车司机都在微笑。",
        "根据邓巴数模型推演，此日是拓展社交半径的最佳时机——你的贵人就在第 151 个联系人之后。",
        "群体博弈论模拟显示，此日纳什均衡点恰好落在「合作解」——这是一个双赢日。",
        "此日豆瓣评分平均值预测将高出 0.3 分——人们正处于宽容周期的波峰，善意值拉满。",
    ]

    private static let bioReasons: [String] = [
        "你的体感节律、情绪节律与智力节律在此日形成罕见的三相交汇，学名「身心灵合相」。",
        "根据 28 天月亮周期折算，你的情绪能量将在此日抵达波峰——心中有光，万事可期。",
        "褪黑素与皮质醇的昼夜节律在此日达到完美拮抗平衡。你会格外清醒，决断如神。",
        "此日气压变化曲线与人体心率变异性(HRV)形成共振频率，是最佳行动窗口。你的心跳在为你倒计时。",
        "肠道菌群代谢周期分析表明，此日血清素分泌量达到小高峰——科学证明，你这天会特别自信。",
        "线粒体 ATP 产能效率在此日达到月度巅峰，你将拥有 130% 的日常能量。超级赛亚人模式启动。",
        "杏仁核活跃度在此日降至谷底——焦虑感自然减弱，决策质量悄然提升。",
        "此日你的端粒酶活性预计比平日高 1.7%——连你的细胞都在为这个决定加油。",
        "根据生物钟模型，此日下午 3:14 是你的「心流窗口」，万事皆可成，灵感挡不住。",
        "副交感神经在此日占据主导地位——你的身体在用最古老的语言告诉你：放手去做。",
        "多巴胺受体密度在此日的特定时段达到周期性高点——一切行动都自带快感加成。",
    ]

    private static let symbolicReasons: [String] = [
        "当日日期数字之和为吉数，在东方玄学中暗含「万事通达」之意。数字不会说谎。",
        "此日所对应的卦象为「泽火革」——除旧布新的上上之选，天意昭然。",
        "此日对应塔罗牌「命运之轮」正位——宇宙的齿轮正在为你转动，请抓住把手。",
        "将日期转化为二进制，恰好形成回文结构——这是时间的对称之美在向你致意。",
        "此日是本月的素数日——素数不可分割，正如你的决心坚不可摧。",
        "在玛雅历法中，此日对应「风之日」——适合启动、传播与远行。让风带走犹豫。",
        "此日的天干地支组合属于「天德贵人」日——古人认为此日行事，必有神明庇佑。",
        "把当日日期映射到色彩频谱，恰好落在「藏蓝与金」的交界——沉稳中蕴含辉煌。",
        "此日在黄道十二宫中，金星与木星形成六分相——爱与幸运交织，宜一切美好之事。",
        "将日期数字进行九宫格排列，此日恰好构成「洛书」核心结构——天地人三才贯通，不可多得。",
        "此日六十甲子纳音属「大林木」——参天之木，正是大展宏图、根深叶茂之兆。",
    ]
}
