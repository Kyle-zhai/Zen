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
