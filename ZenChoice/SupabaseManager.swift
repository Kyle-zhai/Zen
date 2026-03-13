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

    func syncProfile(name: String, birthDate: Date, userId: UUID) async throws {
        let profile = UserProfile(
            id: userId,
            name: name,
            birthDate: birthDate,
            isPaid: false,
            createdAt: nil
        )
        try await supabase.from("profiles").upsert(profile).execute()
    }

    func saveRecord(_ record: DecisionRecord) async throws {
        try await supabase.from("decision_records").insert(record).execute()
    }

    func fetchHistory(userId: UUID) async throws -> [DecisionRecord] {
        let records: [DecisionRecord] = try await supabase
            .from("decision_records")
            .select()
            .eq("user_id", value: userId.uuidString)
            .order("created_at", ascending: false)
            .execute()
            .value
        return records
    }
}
