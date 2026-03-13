import Foundation

// MARK: - Divination Mode

enum DivinationMode: String, CaseIterable, Sendable {
    case todayAuspice = "今日宜忌"
    case findBestDay  = "择日问卦"

    var subtitle: String {
        switch self {
        case .todayAuspice: return "今日何所宜"
        case .findBestDay:  return "何日为吉"
        }
    }

    var placeholder: String {
        switch self {
        case .todayAuspice: return "今天适合做什么…"
        case .findBestDay:  return "你想做什么…"
        }
    }

    var buttonTitle: String {
        switch self {
        case .todayAuspice: return "观今日"
        case .findBestDay:  return "择吉日"
        }
    }
}

// MARK: - Divination Result (local display wrapper)

struct DivinationResult: Sendable {
    let mode: DivinationMode
    let record: DecisionRecord
    let verdict: String?
    let isAuspicious: Bool
    let recommendedTime: String?

    var verdictDescription: String {
        switch verdict {
        case "大吉": return "诸事皆宜，放手去做"
        case "吉":   return "天时地利，顺势而为"
        case "中吉": return "平稳有序，稳中求进"
        case "小吉": return "小有波折，谨慎为上"
        case "慎行": return "今日不宜操之过急"
        default:     return ""
        }
    }

    var verdictColor: String {
        switch verdict {
        case "大吉": return "gold"
        case "吉":   return "warm"
        case "中吉": return "neutral"
        case "小吉": return "cool"
        case "慎行": return "muted"
        default:     return "neutral"
        }
    }
}

// MARK: - User Profile

struct UserProfile: Codable, Identifiable, Sendable {
    let id: UUID
    var name: String
    var birthDate: Date?
    var isPaid: Bool
    var createdAt: Date?

    enum CodingKeys: String, CodingKey {
        case id, name
        case birthDate = "birth_date"
        case isPaid = "is_paid"
        case createdAt = "created_at"
    }
}

struct DecisionRecord: Codable, Identifiable, Sendable {
    let id: UUID
    var userId: UUID
    var wish: String
    var recommendedDate: Date
    var freeReasons: [String: String]
    var premiumReport: String?
    var createdAt: Date?

    enum CodingKeys: String, CodingKey {
        case id, wish
        case userId = "user_id"
        case recommendedDate = "recommended_date"
        case freeReasons = "free_reasons"
        case premiumReport = "premium_report"
        case createdAt = "created_at"
    }

    var formattedDate: String {
        let f = DateFormatter()
        f.locale = Locale(identifier: "zh_CN")
        f.dateFormat = "yyyy年M月d日 EEEE"
        return f.string(from: recommendedDate)
    }

    var shortDate: String {
        let f = DateFormatter()
        f.locale = Locale(identifier: "zh_CN")
        f.dateFormat = "M月d日"
        return f.string(from: recommendedDate)
    }
}
