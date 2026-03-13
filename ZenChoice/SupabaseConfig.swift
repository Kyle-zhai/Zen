import Foundation
import Supabase

enum SupabaseConfig {
    // 🔗 把你在网页上看到的两个值填在这里
    static let url = URL(string: "https://qjpxhhjwqlrowteaguth.supabase.co")!
    static let anonKey = "sb_publishable_GB0muX_x7meEZNv9VPtxaQ__HoXiYCn"
}

// 以后在 App 任何地方都可以直接用这个 client
let supabase = SupabaseClient(
    supabaseURL: SupabaseConfig.url,
    supabaseKey: SupabaseConfig.anonKey
)
