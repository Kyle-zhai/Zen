# ZenChoice Social Features Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add "求加持" (request blessings) and "结缘见证" (witness bond) social features with voice recording, Supabase backend, and H5 web pages.

**Architecture:** Supabase PostgreSQL + Storage as backend, accessed via raw URLSession (iOS) and fetch (H5). Device UUID for identity (no login). Universal Links for deep linking between H5 and app.

**Tech Stack:** SwiftUI (iOS 18.0+), Supabase REST API, AVFoundation (voice), GitHub Pages (H5), vanilla JS

**Spec:** `docs/superpowers/specs/2026-04-02-social-features-design.md`

---

## Chunk 1: Data Layer

### Task 1: Add Swift Models

**Files:**
- Modify: `ZenChoice/Models.swift`

- [ ] **Step 1: Add CourageRequest and CourageResponse models**

Add at the end of `Models.swift`, before the closing:

```swift
// MARK: - Social: Courage Request

struct CourageRequest: Codable, Identifiable, Sendable {
    let id: UUID
    let type: RequestType
    let wish: String
    let aiSummary: String?
    let creatorDeviceId: String
    let maxResponses: Int
    let responseCount: Int
    let expiresAt: Date?
    let createdAt: Date?

    enum RequestType: String, Codable, Sendable {
        case encourage
        case witness
    }

    enum CodingKeys: String, CodingKey {
        case id, type, wish
        case aiSummary = "ai_summary"
        case creatorDeviceId = "creator_device_id"
        case maxResponses = "max_responses"
        case responseCount = "response_count"
        case expiresAt = "expires_at"
        case createdAt = "created_at"
    }
}

// MARK: - Social: Courage Response

struct CourageResponse: Codable, Identifiable, Sendable {
    let id: UUID
    let requestId: UUID
    let content: String
    let perspective: String?
    let emojiStamp: String?
    let voiceUrl: String?
    let isAnonymous: Bool
    let senderName: String?
    let senderDeviceId: String
    let createdAt: Date?

    enum CodingKeys: String, CodingKey {
        case id, content, perspective
        case requestId = "request_id"
        case emojiStamp = "emoji_stamp"
        case voiceUrl = "voice_url"
        case isAnonymous = "is_anonymous"
        case senderName = "sender_name"
        case senderDeviceId = "sender_device_id"
        case createdAt = "created_at"
    }
}
```

- [ ] **Step 2: Build to verify**

Run: `xcodebuild -scheme ZenChoice -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build 2>&1 | tail -5`
Expected: `BUILD SUCCEEDED`

- [ ] **Step 3: Commit**

```bash
git add ZenChoice/Models.swift
git commit -m "feat: add CourageRequest and CourageResponse models for social features"
```

---

### Task 2: Supabase SQL Setup

**Files:**
- Create: `docs/supabase-setup.sql`

This file is for the user to run in the Supabase SQL editor. Not compiled into the app.

- [ ] **Step 1: Create the SQL setup file**

```sql
-- ============================================
-- ZenChoice Social Features — Supabase Setup
-- Run this in the Supabase SQL Editor
-- ============================================

-- 1. Create tables
CREATE TABLE courage_requests (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    type text NOT NULL CHECK (type IN ('encourage', 'witness')),
    wish text NOT NULL,
    ai_summary text,
    creator_device_id text NOT NULL,
    max_responses int NOT NULL DEFAULT 1,
    response_count int NOT NULL DEFAULT 0,
    expires_at timestamptz DEFAULT (now() + interval '7 days'),
    created_at timestamptz DEFAULT now()
);

CREATE TABLE courage_responses (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    request_id uuid NOT NULL REFERENCES courage_requests(id) ON DELETE CASCADE,
    content text NOT NULL,
    perspective text,
    emoji_stamp text,
    voice_url text,
    is_anonymous bool NOT NULL DEFAULT true,
    sender_name text,
    sender_device_id text NOT NULL,
    created_at timestamptz DEFAULT now(),
    UNIQUE(request_id, sender_device_id)
);

-- 2. Indexes
CREATE INDEX idx_requests_creator ON courage_requests(creator_device_id);
CREATE INDEX idx_requests_created ON courage_requests(created_at DESC);
CREATE INDEX idx_responses_request ON courage_responses(request_id);

-- 3. Auto-increment response_count trigger
CREATE OR REPLACE FUNCTION increment_response_count()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE courage_requests
    SET response_count = response_count + 1
    WHERE id = NEW.request_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_response_insert
    AFTER INSERT ON courage_responses
    FOR EACH ROW
    EXECUTE FUNCTION increment_response_count();

-- 4. Enable RLS
ALTER TABLE courage_requests ENABLE ROW LEVEL SECURITY;
ALTER TABLE courage_responses ENABLE ROW LEVEL SECURITY;

-- 5. RLS Policies
CREATE POLICY "read_requests" ON courage_requests
    FOR SELECT USING (true);

CREATE POLICY "create_request" ON courage_requests
    FOR INSERT WITH CHECK (true);

CREATE POLICY "create_response" ON courage_responses
    FOR INSERT WITH CHECK (
        (SELECT response_count FROM courage_requests WHERE id = request_id)
        < (SELECT max_responses FROM courage_requests WHERE id = request_id)
    );

CREATE POLICY "read_responses" ON courage_responses
    FOR SELECT USING (true);

-- 6. Create storage bucket (run via Supabase Dashboard > Storage > New Bucket)
-- Name: voice-messages
-- Public: true
-- File size limit: 100KB
-- Allowed MIME types: audio/mp4, audio/m4a, audio/mpeg, audio/webm
```

- [ ] **Step 2: Commit**

```bash
git add docs/supabase-setup.sql
git commit -m "docs: add Supabase SQL setup for social features"
```

---

### Task 3: SocialManager — Supabase API Wrapper

**Files:**
- Create: `ZenChoice/SocialManager.swift`

- [ ] **Step 1: Create SocialManager with config and basic CRUD**

```swift
import Foundation

@MainActor
@Observable
class SocialManager {

    // MARK: - Config (fill in after creating Supabase project)
    private let supabaseUrl = ""  // e.g. "https://xxxxx.supabase.co"
    private let supabaseAnonKey = ""

    // MARK: - Device Identity

    static var deviceId: String {
        if let id = UserDefaults.standard.string(forKey: "deviceId") {
            return id
        }
        let id = UUID().uuidString
        UserDefaults.standard.set(id, forKey: "deviceId")
        return id
    }

    // MARK: - Inbox State

    var requests: [CourageRequest] = []
    var unreadCount: Int = 0

    // MARK: - Create Request

    func createRequest(type: CourageRequest.RequestType, wish: String, aiSummary: String?, maxResponses: Int) async throws -> CourageRequest {
        let body: [String: Any] = [
            "type": type.rawValue,
            "wish": wish,
            "ai_summary": aiSummary as Any,
            "creator_device_id": Self.deviceId,
            "max_responses": maxResponses
        ]

        let data = try await postJSON(path: "/rest/v1/courage_requests", body: body, returnRows: true)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let rows = try decoder.decode([CourageRequest].self, from: data)
        guard let request = rows.first else {
            throw SocialError.invalidResponse
        }
        return request
    }

    // MARK: - Submit Response

    func submitResponse(requestId: UUID, content: String, perspective: String?, emojiStamp: String?, voiceUrl: String?, isAnonymous: Bool, senderName: String?) async throws {
        let body: [String: Any] = [
            "request_id": requestId.uuidString,
            "content": content,
            "perspective": perspective as Any,
            "emoji_stamp": emojiStamp as Any,
            "voice_url": voiceUrl as Any,
            "is_anonymous": isAnonymous,
            "sender_name": senderName as Any,
            "sender_device_id": Self.deviceId
        ]

        _ = try await postJSON(path: "/rest/v1/courage_responses", body: body, returnRows: false)
    }

    // MARK: - Fetch Request by ID

    func fetchRequest(id: UUID) async throws -> CourageRequest {
        let data = try await getJSON(path: "/rest/v1/courage_requests?id=eq.\(id.uuidString)&select=*")

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let rows = try decoder.decode([CourageRequest].self, from: data)
        guard let request = rows.first else {
            throw SocialError.notFound
        }
        return request
    }

    // MARK: - Fetch Responses for a Request

    func fetchResponses(requestId: UUID) async throws -> [CourageResponse] {
        let data = try await getJSON(path: "/rest/v1/courage_responses?request_id=eq.\(requestId.uuidString)&select=*&order=created_at.asc")

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode([CourageResponse].self, from: data)
    }

    // MARK: - Fetch My Requests (Inbox)

    func fetchMyRequests() async throws {
        let data = try await getJSON(path: "/rest/v1/courage_requests?creator_device_id=eq.\(Self.deviceId)&select=*&order=created_at.desc&limit=50")

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        requests = try decoder.decode([CourageRequest].self, from: data)
    }

    // MARK: - Upload Voice

    func uploadVoice(requestId: UUID, responseId: UUID, fileData: Data) async throws -> String {
        let path = "voices/\(requestId.uuidString)/\(responseId.uuidString).m4a"
        let url = URL(string: "\(supabaseUrl)/storage/v1/object/voice-messages/\(path)")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(supabaseAnonKey)", forHTTPHeaderField: "Authorization")
        request.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")
        request.setValue("audio/mp4", forHTTPHeaderField: "Content-Type")
        request.httpBody = fileData
        request.timeoutInterval = 30

        let (_, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw SocialError.uploadFailed
        }

        return "\(supabaseUrl)/storage/v1/object/public/voice-messages/\(path)"
    }

    // MARK: - Share Link

    func shareLink(for request: CourageRequest) -> URL {
        let page = request.type == .encourage ? "encourage" : "witness"
        return URL(string: "https://kyle-zhai.github.io/Zen/\(page).html?id=\(request.id.uuidString)")!
    }

    // MARK: - Private: HTTP Helpers

    private func getJSON(path: String) async throws -> Data {
        guard !supabaseUrl.isEmpty else { throw SocialError.notConfigured }

        let url = URL(string: "\(supabaseUrl)\(path)")!
        var request = URLRequest(url: url)
        request.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")
        request.setValue("Bearer \(supabaseAnonKey)", forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 15

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
            throw SocialError.networkError("GET failed: \(path)")
        }
        return data
    }

    private func postJSON(path: String, body: [String: Any], returnRows: Bool) async throws -> Data {
        guard !supabaseUrl.isEmpty else { throw SocialError.notConfigured }

        let url = URL(string: "\(supabaseUrl)\(path)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")
        request.setValue("Bearer \(supabaseAnonKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if returnRows {
            request.setValue("return=representation", forHTTPHeaderField: "Prefer")
        }
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        request.timeoutInterval = 15

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            let errorBody = String(data: data, encoding: .utf8) ?? "unknown"
            throw SocialError.networkError("POST failed: \(errorBody)")
        }
        return data
    }

    // MARK: - Errors

    enum SocialError: Error, LocalizedError {
        case notConfigured
        case networkError(String)
        case invalidResponse
        case notFound
        case uploadFailed

        var errorDescription: String? {
            switch self {
            case .notConfigured: return "Social features not configured"
            case .networkError(let msg): return "Network error: \(msg)"
            case .invalidResponse: return "Invalid server response"
            case .notFound: return "Request not found"
            case .uploadFailed: return "Voice upload failed"
            }
        }
    }
}
```

- [ ] **Step 2: Build to verify**

Run: `xcodebuild -scheme ZenChoice -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build 2>&1 | tail -5`
Expected: `BUILD SUCCEEDED`

- [ ] **Step 3: Commit**

```bash
git add ZenChoice/SocialManager.swift
git commit -m "feat: add SocialManager with Supabase API wrapper"
```

---

## Chunk 2: Voice Recording

### Task 4: VoiceRecorder Utility

**Files:**
- Create: `ZenChoice/VoiceRecorder.swift`

- [ ] **Step 1: Create VoiceRecorder with AVFoundation**

```swift
import AVFoundation
import SwiftUI

@MainActor
@Observable
class VoiceRecorder {

    var isRecording = false
    var isPlaying = false
    var recordingDuration: TimeInterval = 0
    var recordedFileURL: URL?

    private var audioRecorder: AVAudioRecorder?
    private var audioPlayer: AVAudioPlayer?
    private var timer: Timer?

    static let maxDuration: TimeInterval = 15

    // MARK: - Permissions

    func requestPermission() async -> Bool {
        await withCheckedContinuation { continuation in
            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                continuation.resume(returning: granted)
            }
        }
    }

    // MARK: - Recording

    func startRecording() {
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(.playAndRecord, mode: .default)
        try? session.setActive(true)

        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
            .appendingPathExtension("m4a")

        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 22050,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.medium.rawValue
        ]

        guard let recorder = try? AVAudioRecorder(url: url, settings: settings) else { return }
        audioRecorder = recorder
        recorder.record()

        isRecording = true
        recordingDuration = 0
        recordedFileURL = url

        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            Task { @MainActor in
                guard let self else { return }
                self.recordingDuration = recorder.currentTime
                if recorder.currentTime >= Self.maxDuration {
                    self.stopRecording()
                }
            }
        }
    }

    func stopRecording() {
        audioRecorder?.stop()
        audioRecorder = nil
        timer?.invalidate()
        timer = nil
        isRecording = false
    }

    func deleteRecording() {
        stopRecording()
        stopPlaying()
        if let url = recordedFileURL {
            try? FileManager.default.removeItem(at: url)
        }
        recordedFileURL = nil
        recordingDuration = 0
    }

    // MARK: - Playback (local file)

    func playRecording() {
        guard let url = recordedFileURL else { return }
        playURL(url)
    }

    // MARK: - Playback (remote URL)

    func playRemote(url: URL) {
        // Download to temp first, then play
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let tempURL = FileManager.default.temporaryDirectory
                    .appendingPathComponent(UUID().uuidString)
                    .appendingPathExtension("m4a")
                try data.write(to: tempURL)
                playURL(tempURL)
            } catch {
                // Playback failed silently
            }
        }
    }

    func stopPlaying() {
        audioPlayer?.stop()
        audioPlayer = nil
        isPlaying = false
    }

    private func playURL(_ url: URL) {
        stopPlaying()
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(.playback, mode: .default)
        try? session.setActive(true)

        guard let player = try? AVAudioPlayer(contentsOf: url) else { return }
        audioPlayer = player
        player.delegate = PlaybackDelegate { [weak self] in
            Task { @MainActor in
                self?.isPlaying = false
            }
        }
        player.play()
        isPlaying = true
    }

    // MARK: - Export

    func recordedData() -> Data? {
        guard let url = recordedFileURL else { return nil }
        return try? Data(contentsOf: url)
    }
}

// MARK: - Playback Delegate

private class PlaybackDelegate: NSObject, AVAudioPlayerDelegate {
    let onFinish: () -> Void
    init(onFinish: @escaping () -> Void) { self.onFinish = onFinish }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        onFinish()
    }
}
```

- [ ] **Step 2: Add microphone usage description to Info.plist**

In `ZenChoice.xcodeproj/project.pbxproj`, the `INFOPLIST_KEY_NSMicrophoneUsageDescription` build setting needs to be added. Alternatively, create/modify the Info.plist.

Add to build settings or Info.plist:
```
NSMicrophoneUsageDescription = "Record voice messages for your friends' encouragement"
```

- [ ] **Step 3: Build to verify**

Run: `xcodebuild -scheme ZenChoice -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build 2>&1 | tail -5`
Expected: `BUILD SUCCEEDED`

- [ ] **Step 4: Commit**

```bash
git add ZenChoice/VoiceRecorder.swift
git commit -m "feat: add VoiceRecorder utility with AVFoundation"
```

---

## Chunk 3: Core Views — Respond & Request

### Task 5: RespondView — Friend Response Page

**Files:**
- Create: `ZenChoice/RespondView.swift`

This view is used both when a friend opens the deep link in-app and as the core interaction for both "encourage" and "witness" flows.

- [ ] **Step 1: Create RespondView**

```swift
import SwiftUI

struct RespondView: View {
    @Environment(\.dismiss) private var dismiss
    let request: CourageRequest
    let socialManager: SocialManager
    let isChinese: Bool

    @State private var content = ""
    @State private var selectedPerspective = ""
    @State private var customPerspective = ""
    @State private var emojiStamp = ""
    @State private var isAnonymous = true
    @State private var senderName = ""
    @State private var isSubmitting = false
    @State private var showSuccess = false
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var voiceRecorder = VoiceRecorder()
    @State private var isGeneratingAI = false

    private var cn: Bool { isChinese }

    private let perspectives = [
        ("毒舌闺蜜", "Sassy BFF"),
        ("慈祥奶奶", "Loving Grandma"),
        ("未来的ta", "Future Self"),
        ("哲学家", "Philosopher"),
        ("段子手", "Comedian")
    ]

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Text(cn ? "你的朋友想要" : "Your friend wants to")
                            .font(ZenTheme.bodyFont(15))
                            .foregroundStyle(ZenTheme.distantMountain.opacity(0.6))
                        Text("「\(request.wish)」")
                            .font(ZenTheme.calligraphy(22))
                            .foregroundStyle(ZenTheme.inkBlack)
                            .multilineTextAlignment(.center)
                        Text(request.type == .encourage
                             ? (cn ? "为 ta 加持吧！" : "Send your blessing!")
                             : (cn ? "为 ta 见证这一刻" : "Witness this moment"))
                            .font(ZenTheme.bodyFont(14))
                            .foregroundStyle(ZenTheme.gooseYellow)
                    }
                    .padding(.top, 20)

                    // AI Summary (witness only)
                    if request.type == .witness, let summary = request.aiSummary, !summary.isEmpty {
                        Text(summary)
                            .font(ZenTheme.bodyFont(13))
                            .foregroundStyle(ZenTheme.distantMountain.opacity(0.6))
                            .padding(12)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.7)))
                            .padding(.horizontal)
                    }

                    // Perspective picker (encourage only)
                    if request.type == .encourage {
                        perspectivePicker
                    }

                    // Text input
                    VStack(alignment: .leading, spacing: 8) {
                        Text(request.type == .encourage
                             ? (cn ? "写一句加持" : "Write your blessing")
                             : (cn ? "写一句寄语" : "Leave a message"))
                            .font(ZenTheme.caption(12))
                            .foregroundStyle(.secondary)

                        TextField(cn ? "写点什么..." : "Write something...", text: $content, axis: .vertical)
                            .font(ZenTheme.bodyFont(15))
                            .lineLimit(3...6)
                            .padding(12)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.white))

                        // AI ghostwrite button (encourage only)
                        if request.type == .encourage {
                            Button {
                                Task { await generateAIContent() }
                            } label: {
                                HStack(spacing: 6) {
                                    if isGeneratingAI {
                                        ProgressView().tint(ZenTheme.gooseYellow)
                                    } else {
                                        Image(systemName: "sparkles")
                                    }
                                    Text(cn ? "AI帮我写" : "AI ghostwrite")
                                }
                                .font(ZenTheme.caption(13))
                                .foregroundStyle(ZenTheme.gooseYellow)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Capsule().stroke(ZenTheme.gooseYellow.opacity(0.5)))
                            }
                            .disabled(isGeneratingAI)
                        }
                    }
                    .padding(.horizontal)

                    // Emoji stamp (witness only)
                    if request.type == .witness {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(cn ? "选一个印章" : "Pick a stamp")
                                .font(ZenTheme.caption(12))
                                .foregroundStyle(.secondary)
                            TextField("emoji", text: $emojiStamp)
                                .font(.system(size: 40))
                                .frame(width: 60, height: 60)
                                .multilineTextAlignment(.center)
                                .background(RoundedRectangle(cornerRadius: 12).fill(.white))
                        }
                        .padding(.horizontal)
                    }

                    // Voice recorder
                    voiceSection

                    // Anonymous / signed toggle
                    identitySection

                    // Submit button
                    Button {
                        Task { await submit() }
                    } label: {
                        HStack(spacing: 8) {
                            if isSubmitting {
                                ProgressView().tint(.white)
                            }
                            Text(isAnonymous
                                 ? (cn ? "匿名提交" : "Submit anonymously")
                                 : (cn ? "署名提交" : "Submit with name"))
                        }
                        .font(ZenTheme.calligraphy(16))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(RoundedRectangle(cornerRadius: 14).fill(ZenTheme.inkBlack))
                    }
                    .disabled(content.isEmpty || isSubmitting)
                    .padding(.horizontal)

                    Spacer().frame(height: 40)
                }
            }
            .background(ZenBackground())
            .navigationTitle(request.type == .encourage ? (cn ? "加持" : "Bless") : (cn ? "见证" : "Witness"))
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.gray.opacity(0.6))
                    }
                }
            }
            .alert(cn ? "提交成功" : "Submitted!", isPresented: $showSuccess) {
                Button(cn ? "好的" : "OK") { dismiss() }
            } message: {
                Text(cn ? "你的加持已送达" : "Your blessing has been delivered")
            }
            .alert(cn ? "提示" : "Notice", isPresented: $showError) {
                Button(cn ? "知道了" : "OK") {}
            } message: {
                Text(errorMessage)
            }
        }
    }

    // MARK: - Perspective Picker

    private var perspectivePicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(cn ? "选一个身份视角" : "Pick a perspective")
                .font(ZenTheme.caption(12))
                .foregroundStyle(.secondary)

            let columns = [GridItem(.adaptive(minimum: 90))]
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(perspectives, id: \.0) { zh, en in
                    let label = cn ? zh : en
                    let isSelected = selectedPerspective == label
                    Button {
                        selectedPerspective = label
                        customPerspective = ""
                    } label: {
                        Text(label)
                            .font(ZenTheme.caption(13))
                            .foregroundStyle(isSelected ? .white : ZenTheme.inkBlack)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(isSelected ? ZenTheme.inkBlack : .white)
                            )
                    }
                }

                // Custom input
                TextField(cn ? "自定义..." : "Custom...", text: $customPerspective)
                    .font(ZenTheme.caption(13))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                    .onChange(of: customPerspective) { _, val in
                        if !val.isEmpty { selectedPerspective = "" }
                    }
            }
        }
        .padding(.horizontal)
    }

    // MARK: - Voice Section

    private var voiceSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(cn ? "录一段语音（可选，15秒）" : "Record voice (optional, 15s)")
                .font(ZenTheme.caption(12))
                .foregroundStyle(.secondary)

            HStack(spacing: 12) {
                if voiceRecorder.isRecording {
                    Button { voiceRecorder.stopRecording() } label: {
                        Label(String(format: "%.1fs", voiceRecorder.recordingDuration), systemImage: "stop.circle.fill")
                            .foregroundStyle(.red)
                    }
                } else if voiceRecorder.recordedFileURL != nil {
                    Button {
                        if voiceRecorder.isPlaying {
                            voiceRecorder.stopPlaying()
                        } else {
                            voiceRecorder.playRecording()
                        }
                    } label: {
                        Label(
                            String(format: "%.1fs", voiceRecorder.recordingDuration),
                            systemImage: voiceRecorder.isPlaying ? "stop.circle" : "play.circle"
                        )
                        .foregroundStyle(ZenTheme.gooseYellow)
                    }

                    Button { voiceRecorder.deleteRecording() } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(.red.opacity(0.6))
                    }
                } else {
                    Button {
                        Task {
                            let granted = await voiceRecorder.requestPermission()
                            if granted {
                                voiceRecorder.startRecording()
                            }
                        }
                    } label: {
                        Label(cn ? "录音" : "Record", systemImage: "mic.circle")
                            .foregroundStyle(ZenTheme.distantMountain)
                    }
                }
            }
            .font(ZenTheme.bodyFont(14))
        }
        .padding(.horizontal)
    }

    // MARK: - Identity Section

    private var identitySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Toggle(cn ? "匿名" : "Anonymous", isOn: $isAnonymous)
                .font(ZenTheme.bodyFont(14))
                .tint(ZenTheme.gooseYellow)

            if !isAnonymous {
                TextField(cn ? "你的名字" : "Your name", text: $senderName)
                    .font(ZenTheme.bodyFont(15))
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 8).fill(.white))
            }
        }
        .padding(.horizontal)
    }

    // MARK: - Actions

    private func generateAIContent() async {
        let perspective = customPerspective.isEmpty ? selectedPerspective : customPerspective
        guard !perspective.isEmpty else {
            errorMessage = cn ? "请先选择一个视角" : "Please pick a perspective first"
            showError = true
            return
        }

        isGeneratingAI = true
        defer { isGeneratingAI = false }

        let provider = QwenProvider()
        let prompt = cn
            ? "用户想要「\(request.wish)」。请用「\(perspective)」的视角写一句简短有趣的鼓励，50字以内。"
            : "The user wants to \(request.wish). Write a short fun encouragement from the perspective of \"\(perspective)\", under 50 words."

        do {
            let result = try await provider.generate(prompt: prompt, perspectiveName: perspective, emoji: "")
            content = result.content
        } catch {
            errorMessage = cn ? "AI生成失败，请手动输入" : "AI generation failed, please type manually"
            showError = true
        }
    }

    private func submit() async {
        isSubmitting = true
        defer { isSubmitting = false }

        var voiceUrl: String?

        // Upload voice if recorded
        if let voiceData = voiceRecorder.recordedData() {
            let tempResponseId = UUID()
            do {
                voiceUrl = try await socialManager.uploadVoice(
                    requestId: request.id,
                    responseId: tempResponseId,
                    fileData: voiceData
                )
            } catch {
                // Voice upload failed — submit without voice
            }
        }

        let perspective = request.type == .encourage
            ? (customPerspective.isEmpty ? selectedPerspective : customPerspective)
            : nil

        do {
            try await socialManager.submitResponse(
                requestId: request.id,
                content: content,
                perspective: perspective,
                emojiStamp: emojiStamp.isEmpty ? nil : emojiStamp,
                voiceUrl: voiceUrl,
                isAnonymous: isAnonymous,
                senderName: isAnonymous ? nil : senderName
            )
            HapticManager.success()
            showSuccess = true
        } catch {
            errorMessage = cn ? "提交失败，请重试" : "Submission failed, please retry"
            showError = true
            HapticManager.error()
        }
    }
}
```

- [ ] **Step 2: Build to verify**

Expected: `BUILD SUCCEEDED`

- [ ] **Step 3: Commit**

```bash
git add ZenChoice/RespondView.swift
git commit -m "feat: add RespondView for friend encouragement and witness responses"
```

---

### Task 6: EncourageRequestView — Create & Share

**Files:**
- Create: `ZenChoice/EncourageRequestView.swift`

- [ ] **Step 1: Create EncourageRequestView**

```swift
import SwiftUI

struct EncourageRequestView: View {
    @Environment(\.dismiss) private var dismiss
    let wish: String
    let socialManager: SocialManager
    let isChinese: Bool
    let isSubscribed: Bool

    @State private var isCreating = false
    @State private var createdRequest: CourageRequest?
    @State private var showError = false

    private var cn: Bool { isChinese }

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()

                Image(systemName: "hands.sparkles")
                    .font(.system(size: 48))
                    .foregroundStyle(ZenTheme.gooseYellow)

                Text("「\(wish)」")
                    .font(ZenTheme.calligraphy(20))
                    .foregroundStyle(ZenTheme.inkBlack)
                    .multilineTextAlignment(.center)

                Text(cn ? "邀请朋友为你加持" : "Invite friends to bless you")
                    .font(ZenTheme.bodyFont(15))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.6))

                if let request = createdRequest {
                    // Share button
                    ShareLink(item: socialManager.shareLink(for: request)) {
                        HStack(spacing: 8) {
                            Image(systemName: "square.and.arrow.up")
                            Text(cn ? "分享给朋友" : "Share with friends")
                        }
                        .font(ZenTheme.calligraphy(16))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(RoundedRectangle(cornerRadius: 14).fill(ZenTheme.inkBlack))
                    }
                    .padding(.horizontal, 40)

                    Text(cn ? "朋友打开链接即可为你加持" : "Friends can bless you by opening the link")
                        .font(ZenTheme.caption(12))
                        .foregroundStyle(.secondary)
                } else {
                    Button {
                        Task { await createRequest() }
                    } label: {
                        HStack(spacing: 8) {
                            if isCreating {
                                ProgressView().tint(ZenTheme.gooseYellow)
                            }
                            Text(cn ? "生成加持链接" : "Generate blessing link")
                        }
                        .font(ZenTheme.calligraphy(16))
                        .foregroundStyle(ZenTheme.gooseYellow)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(ZenTheme.gooseYellow, lineWidth: 1.5)
                        )
                    }
                    .disabled(isCreating)
                    .padding(.horizontal, 40)
                }

                Spacer()
            }
            .background(ZenBackground())
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.gray.opacity(0.6))
                    }
                }
            }
            .alert(cn ? "创建失败" : "Failed", isPresented: $showError) {
                Button(cn ? "知道了" : "OK") {}
            } message: {
                Text(cn ? "请检查网络后重试" : "Please check your connection and retry")
            }
        }
    }

    private func createRequest() async {
        isCreating = true
        defer { isCreating = false }

        do {
            createdRequest = try await socialManager.createRequest(
                type: .encourage,
                wish: wish,
                aiSummary: nil,
                maxResponses: 99  // encourage has no limit
            )
            HapticManager.success()
        } catch {
            showError = true
            HapticManager.error()
        }
    }
}
```

- [ ] **Step 2: Build and commit**

```bash
git add ZenChoice/EncourageRequestView.swift
git commit -m "feat: add EncourageRequestView for creating blessing requests"
```

---

### Task 7: WitnessRequestView — Create & Share

**Files:**
- Create: `ZenChoice/WitnessRequestView.swift`

- [ ] **Step 1: Create WitnessRequestView**

```swift
import SwiftUI

struct WitnessRequestView: View {
    @Environment(\.dismiss) private var dismiss
    let wish: String
    let aiSummary: String
    let socialManager: SocialManager
    let isChinese: Bool
    let maxSignatures: Int  // 1 for free, 3 for subscribers

    @State private var isCreating = false
    @State private var createdRequest: CourageRequest?
    @State private var showError = false

    private var cn: Bool { isChinese }

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()

                Image(systemName: "signature")
                    .font(.system(size: 48))
                    .foregroundStyle(ZenTheme.gooseYellow)

                Text("「\(wish)」")
                    .font(ZenTheme.calligraphy(20))
                    .foregroundStyle(ZenTheme.inkBlack)
                    .multilineTextAlignment(.center)

                Text(cn
                     ? "邀请朋友见证你的决定（最多\(maxSignatures)人）"
                     : "Invite friends to witness (\(maxSignatures) max)")
                    .font(ZenTheme.bodyFont(15))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.6))

                // AI summary preview
                Text(aiSummary)
                    .font(ZenTheme.bodyFont(13))
                    .foregroundStyle(ZenTheme.distantMountain.opacity(0.5))
                    .lineLimit(3)
                    .padding(.horizontal, 24)
                    .multilineTextAlignment(.center)

                if let request = createdRequest {
                    ShareLink(item: socialManager.shareLink(for: request)) {
                        HStack(spacing: 8) {
                            Image(systemName: "square.and.arrow.up")
                            Text(cn ? "分享给见证人" : "Share with witnesses")
                        }
                        .font(ZenTheme.calligraphy(16))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(RoundedRectangle(cornerRadius: 14).fill(ZenTheme.inkBlack))
                    }
                    .padding(.horizontal, 40)
                } else {
                    Button {
                        Task { await createRequest() }
                    } label: {
                        HStack(spacing: 8) {
                            if isCreating {
                                ProgressView().tint(ZenTheme.gooseYellow)
                            }
                            Text(cn ? "生成见证链接" : "Generate witness link")
                        }
                        .font(ZenTheme.calligraphy(16))
                        .foregroundStyle(ZenTheme.gooseYellow)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(ZenTheme.gooseYellow, lineWidth: 1.5)
                        )
                    }
                    .disabled(isCreating)
                    .padding(.horizontal, 40)
                }

                Spacer()
            }
            .background(ZenBackground())
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.gray.opacity(0.6))
                    }
                }
            }
            .alert(cn ? "创建失败" : "Failed", isPresented: $showError) {
                Button(cn ? "知道了" : "OK") {}
            } message: {
                Text(cn ? "请检查网络后重试" : "Please check your connection and retry")
            }
        }
    }

    private func createRequest() async {
        isCreating = true
        defer { isCreating = false }

        do {
            createdRequest = try await socialManager.createRequest(
                type: .witness,
                wish: wish,
                aiSummary: aiSummary,
                maxResponses: maxSignatures
            )
            HapticManager.success()
        } catch {
            showError = true
            HapticManager.error()
        }
    }
}
```

- [ ] **Step 2: Build and commit**

```bash
git add ZenChoice/WitnessRequestView.swift
git commit -m "feat: add WitnessRequestView for creating witness requests"
```

---

## Chunk 4: Inbox & Witness Card

### Task 8: InboxView — 善缘簿

**Files:**
- Create: `ZenChoice/InboxView.swift`

- [ ] **Step 1: Create InboxView**

```swift
import SwiftUI

struct InboxView: View {
    @Environment(ZenViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss

    @State private var isLoading = false
    @State private var selectedRequest: CourageRequest?
    @State private var responses: [CourageResponse] = []
    @State private var showDetail = false

    private var cn: Bool { viewModel.L.isChinese }
    private var manager: SocialManager { viewModel.socialManager }

    var body: some View {
        NavigationStack {
            Group {
                if manager.requests.isEmpty && !isLoading {
                    ContentUnavailableView(
                        cn ? "暂无善缘" : "No blessings yet",
                        systemImage: "tray",
                        description: Text(cn ? "去结果页分享，邀请朋友为你加持" : "Share from results to invite friends")
                    )
                } else {
                    List(manager.requests) { request in
                        Button {
                            selectedRequest = request
                            Task { await loadResponses(for: request) }
                        } label: {
                            requestRow(request)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle(cn ? "善缘簿" : "Blessings")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(cn ? "完成" : "Done") { dismiss() }
                }
            }
            .task {
                isLoading = true
                try? await manager.fetchMyRequests()
                isLoading = false
            }
            .sheet(isPresented: $showDetail) {
                if let request = selectedRequest {
                    InboxDetailView(
                        request: request,
                        responses: responses,
                        socialManager: manager,
                        isChinese: cn
                    )
                }
            }
            .overlay {
                if isLoading {
                    ProgressView()
                }
            }
        }
    }

    private func requestRow(_ request: CourageRequest) -> some View {
        HStack(spacing: 12) {
            Text(request.type == .encourage ? "🙏" : "✍️")
                .font(.title2)

            VStack(alignment: .leading, spacing: 4) {
                Text("「\(request.wish)」")
                    .font(ZenTheme.bodyFont(15))
                    .foregroundStyle(ZenTheme.inkBlack)

                HStack(spacing: 4) {
                    if request.type == .encourage {
                        Text(cn ? "收到 \(request.responseCount) 条加持" : "\(request.responseCount) blessings received")
                    } else {
                        Text(cn ? "\(request.responseCount)/\(request.maxResponses) 人已见证" : "\(request.responseCount)/\(request.maxResponses) witnessed")
                    }
                }
                .font(ZenTheme.caption(12))
                .foregroundStyle(.secondary)
            }

            Spacer()

            if let date = request.createdAt {
                Text(date, style: .relative)
                    .font(ZenTheme.caption(11))
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }

    private func loadResponses(for request: CourageRequest) async {
        do {
            responses = try await manager.fetchResponses(requestId: request.id)
            showDetail = true
        } catch {
            // Failed to load — do nothing
        }
    }
}

// MARK: - Detail View

struct InboxDetailView: View {
    let request: CourageRequest
    let responses: [CourageResponse]
    let socialManager: SocialManager
    let isChinese: Bool

    @Environment(\.dismiss) private var dismiss
    @State private var voiceRecorder = VoiceRecorder()

    private var cn: Bool { isChinese }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    Text("「\(request.wish)」")
                        .font(ZenTheme.calligraphy(20))
                        .foregroundStyle(ZenTheme.inkBlack)
                        .padding(.top, 20)

                    if responses.isEmpty {
                        Text(cn ? "还没有人响应" : "No responses yet")
                            .font(ZenTheme.bodyFont(14))
                            .foregroundStyle(.secondary)
                            .padding(.top, 40)
                    }

                    ForEach(responses) { response in
                        responseCard(response)
                    }

                    // Re-share button
                    ShareLink(item: socialManager.shareLink(for: request)) {
                        Label(cn ? "再次分享" : "Share again", systemImage: "square.and.arrow.up")
                            .font(ZenTheme.bodyFont(14))
                            .foregroundStyle(ZenTheme.distantMountain)
                    }
                    .padding(.top, 20)

                    Spacer().frame(height: 40)
                }
                .padding(.horizontal)
            }
            .background(ZenBackground())
            .navigationTitle(request.type == .encourage ? (cn ? "加持详情" : "Blessings") : (cn ? "见证详情" : "Witnesses"))
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(cn ? "完成" : "Done") { dismiss() }
                }
            }
        }
    }

    private func responseCard(_ response: CourageResponse) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            // Header: perspective or emoji stamp
            HStack {
                if let perspective = response.perspective, !perspective.isEmpty {
                    Text(perspective)
                        .font(ZenTheme.caption(12))
                        .foregroundStyle(ZenTheme.gooseYellow)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Capsule().fill(ZenTheme.gooseYellow.opacity(0.15)))
                }
                if let stamp = response.emojiStamp, !stamp.isEmpty {
                    Text(stamp).font(.title2)
                }
                Spacer()
                Text(response.isAnonymous ? (cn ? "匿名" : "Anonymous") : (response.senderName ?? ""))
                    .font(ZenTheme.caption(12))
                    .foregroundStyle(.secondary)
            }

            // Content
            Text(response.content)
                .font(ZenTheme.bodyFont(15))
                .foregroundStyle(ZenTheme.inkBlack)
                .lineSpacing(4)

            // Voice playback
            if let urlString = response.voiceUrl, let url = URL(string: urlString) {
                Button {
                    if voiceRecorder.isPlaying {
                        voiceRecorder.stopPlaying()
                    } else {
                        voiceRecorder.playRemote(url: url)
                    }
                } label: {
                    Label(
                        voiceRecorder.isPlaying ? (cn ? "停止" : "Stop") : (cn ? "播放语音" : "Play voice"),
                        systemImage: voiceRecorder.isPlaying ? "stop.circle" : "play.circle"
                    )
                    .font(ZenTheme.caption(13))
                    .foregroundStyle(ZenTheme.gooseYellow)
                }
            }
        }
        .padding(14)
        .background(RoundedRectangle(cornerRadius: 14).fill(.white.opacity(0.8)))
    }
}
```

- [ ] **Step 2: Build and commit**

```bash
git add ZenChoice/InboxView.swift
git commit -m "feat: add InboxView (善缘簿) with detail view and voice playback"
```

---

### Task 9: WitnessCardView — 缘起契约 Card

**Files:**
- Create: `ZenChoice/WitnessCardView.swift`
- Modify: `ZenChoice/PosterService.swift`

- [ ] **Step 1: Create WitnessCardView for rendering**

```swift
import SwiftUI

struct WitnessCardView: View {
    let wish: String
    let aiSummary: String
    let responses: [CourageResponse]
    let isChinese: Bool

    private var cn: Bool { isChinese }

    var body: some View {
        VStack(spacing: 0) {
            // Top accent
            Rectangle()
                .fill(ZenTheme.gooseYellow)
                .frame(height: 6)

            VStack(spacing: 18) {
                // Title
                Text(cn ? "缘起契约" : "Bond of Courage")
                    .font(ZenTheme.calligraphy(20))
                    .foregroundStyle(ZenTheme.inkBlack)
                    .padding(.top, 20)

                // Wish
                Text("「\(wish)」")
                    .font(.system(size: 18, weight: .heavy, design: .serif))
                    .foregroundStyle(ZenTheme.inkBlack)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)

                // AI summary
                if !aiSummary.isEmpty {
                    VStack(spacing: 4) {
                        Text(aiSummary)
                            .font(.system(size: 12, weight: .regular, design: .serif))
                            .foregroundStyle(ZenTheme.distantMountain.opacity(0.6))
                            .lineLimit(3)
                            .multilineTextAlignment(.center)
                        Text(cn ? "— 禅意解读" : "— ZenChoice")
                            .font(ZenTheme.caption(10))
                            .foregroundStyle(ZenTheme.distantMountain.opacity(0.4))
                    }
                    .padding(.horizontal, 20)
                }

                // Divider
                HStack(spacing: 6) {
                    Rectangle().fill(ZenTheme.gooseYellow).frame(width: 30, height: 1)
                    Text(cn ? "见证人" : "Witnesses")
                        .font(ZenTheme.caption(10))
                        .foregroundStyle(ZenTheme.distantMountain.opacity(0.5))
                    Rectangle().fill(ZenTheme.gooseYellow).frame(width: 30, height: 1)
                }

                // Signatures
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(responses) { response in
                        HStack(spacing: 8) {
                            if let stamp = response.emojiStamp, !stamp.isEmpty {
                                Text(stamp).font(.title3)
                            }
                            Text(response.content)
                                .font(.system(size: 13, weight: .regular, design: .serif))
                                .foregroundStyle(ZenTheme.inkBlack)
                                .lineLimit(2)
                            Spacer()
                            Text("— \(response.isAnonymous ? (cn ? "匿名" : "Anon") : (response.senderName ?? ""))")
                                .font(ZenTheme.caption(11))
                                .foregroundStyle(.secondary)
                            if response.voiceUrl != nil {
                                Text("🎙").font(.caption)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)

                Spacer().frame(height: 8)

                // Footer
                VStack(spacing: 4) {
                    Text(cn ? "禅意 ZenChoice" : "ZenChoice")
                        .font(ZenTheme.caption(10))
                        .foregroundStyle(ZenTheme.distantMountain.opacity(0.4))
                    Text(cn ? "扫码结缘加持" : "Scan to send blessings")
                        .font(ZenTheme.caption(9))
                        .foregroundStyle(ZenTheme.distantMountain.opacity(0.3))
                }
                .padding(.bottom, 16)
            }
        }
        .frame(width: 340)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: .black.opacity(0.08), radius: 16, y: 8)
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
```

- [ ] **Step 2: Add rendering method to PosterService**

Add to `PosterService.swift`:

```swift
@MainActor
static func renderWitnessCard(wish: String, aiSummary: String, responses: [CourageResponse], isChinese: Bool) -> UIImage? {
    let view = WitnessCardView(wish: wish, aiSummary: aiSummary, responses: responses, isChinese: isChinese)
    let renderer = ImageRenderer(content: view)
    renderer.scale = 3
    return renderer.uiImage
}
```

- [ ] **Step 3: Build and commit**

```bash
git add ZenChoice/WitnessCardView.swift ZenChoice/PosterService.swift
git commit -m "feat: add WitnessCardView (缘起契约) and PosterService rendering"
```

---

## Chunk 5: Integration

### Task 10: DeepLinkHandler

**Files:**
- Create: `ZenChoice/DeepLinkHandler.swift`

- [ ] **Step 1: Create DeepLinkHandler**

```swift
import Foundation

enum DeepLinkHandler {

    enum Destination {
        case encourage(requestId: UUID)
        case witness(requestId: UUID)
    }

    static func parse(url: URL) -> Destination? {
        let path = url.path
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let idString = components.queryItems?.first(where: { $0.name == "id" })?.value,
              let uuid = UUID(uuidString: idString) else {
            return nil
        }

        if path.contains("encourage") {
            return .encourage(requestId: uuid)
        } else if path.contains("witness") {
            return .witness(requestId: uuid)
        }
        return nil
    }
}
```

- [ ] **Step 2: Update ZenChoiceApp.swift to handle Universal Links**

Add `.onOpenURL` handler to `ContentView()`:

```swift
// In ZenChoiceApp body:
WindowGroup {
    ContentView()
        .environment(viewModel)
        .onOpenURL { url in
            viewModel.handleDeepLink(url: url)
        }
}
```

- [ ] **Step 3: Build and commit**

```bash
git add ZenChoice/DeepLinkHandler.swift ZenChoice/ZenChoiceApp.swift
git commit -m "feat: add DeepLinkHandler and Universal Link handling"
```

---

### Task 11: ZenViewModel — Social State

**Files:**
- Modify: `ZenChoice/ZenViewModel.swift`

- [ ] **Step 1: Add social properties and methods**

Add to `ZenViewModel`:

```swift
// MARK: - Social

let socialManager = SocialManager()

var showInbox: Bool = false
var showEncourageRequest: Bool = false
var showWitnessRequest: Bool = false
var showRespondSheet: Bool = false
var deepLinkRequest: CourageRequest?

// Daily social limit tracking
private static let socialCountKey = "dailySocialCount"
private static let socialDateKey = "dailySocialDate"
var dailySocialCount: Int = 0

var socialDailyLimit: Int {
    isSubscribed ? 999 : 2
}

var canCreateSocialRequest: Bool {
    dailySocialCount < socialDailyLimit
}

func loadSocialUsage() {
    let today = Calendar.current.startOfDay(for: Date())
    let savedDate = UserDefaults.standard.object(forKey: Self.socialDateKey) as? Date ?? .distantPast
    if Calendar.current.isDate(today, inSameDayAs: savedDate) {
        dailySocialCount = UserDefaults.standard.integer(forKey: Self.socialCountKey)
    } else {
        dailySocialCount = 0
        UserDefaults.standard.set(0, forKey: Self.socialCountKey)
        UserDefaults.standard.set(today, forKey: Self.socialDateKey)
    }
}

func incrementSocialUsage() {
    dailySocialCount += 1
    UserDefaults.standard.set(dailySocialCount, forKey: Self.socialCountKey)
    let today = Calendar.current.startOfDay(for: Date())
    UserDefaults.standard.set(today, forKey: Self.socialDateKey)
}

// AI summary for witness card
func generateAISummary() -> String {
    guard let result = currentResult, let first = result.dimensions.first else { return "" }
    return first.content
}

// Deep link handling
@MainActor
func handleDeepLink(url: URL) {
    guard let destination = DeepLinkHandler.parse(url: url) else { return }

    Task {
        let requestId: UUID
        switch destination {
        case .encourage(let id): requestId = id
        case .witness(let id): requestId = id
        }

        do {
            deepLinkRequest = try await socialManager.fetchRequest(id: requestId)
            showRespondSheet = true
        } catch {
            errorMessage = L.isChinese ? "链接已失效" : "Link expired"
            showError = true
        }
    }
}
```

Also update `initialize()` to load social usage:

```swift
// Add after loadDailyUsage():
loadSocialUsage()
```

- [ ] **Step 2: Build and commit**

```bash
git add ZenChoice/ZenViewModel.swift
git commit -m "feat: add social state management to ZenViewModel"
```

---

### Task 12: MainContentView — Entry Points

**Files:**
- Modify: `ZenChoice/MainContentView.swift`

- [ ] **Step 1: Add social buttons to result section**

In `resultSection(_:)`, after `ForEach(result.dimensions...)` and before `subscriberUpsell`, add:

```swift
// Social action buttons
HStack(spacing: 12) {
    Button {
        if viewModel.canCreateSocialRequest {
            viewModel.showEncourageRequest = true
        } else {
            viewModel.showPaywall = true
        }
    } label: {
        HStack(spacing: 6) {
            Image(systemName: "hands.sparkles")
            Text(cn ? "求加持" : "Request Blessing")
        }
        .font(ZenTheme.bodyFont(14))
        .foregroundStyle(ZenTheme.inkBlack)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(ZenTheme.gooseYellow.opacity(0.2))
        )
    }

    Button {
        if viewModel.canCreateSocialRequest {
            viewModel.showWitnessRequest = true
        } else {
            viewModel.showPaywall = true
        }
    } label: {
        HStack(spacing: 6) {
            Image(systemName: "signature")
            Text(cn ? "邀请见证" : "Invite Witness")
        }
        .font(ZenTheme.bodyFont(14))
        .foregroundStyle(ZenTheme.inkBlack)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(ZenTheme.gooseYellow.opacity(0.2))
        )
    }
}
```

- [ ] **Step 2: Add inbox button to header bar**

Replace or add next to the archive button:

```swift
// In headerBar, add before Spacer() or after settings button:
Button { viewModel.showInbox = true } label: {
    ZStack(alignment: .topTrailing) {
        Image(systemName: "tray")
            .font(.title3)
            .foregroundStyle(ZenTheme.distantMountain.opacity(0.6))
        if viewModel.socialManager.unreadCount > 0 {
            Text("\(viewModel.socialManager.unreadCount)")
                .font(.system(size: 9, weight: .bold))
                .foregroundStyle(.white)
                .padding(3)
                .background(Circle().fill(.red))
                .offset(x: 6, y: -6)
        }
    }
}
```

- [ ] **Step 3: Add sheet modifiers**

Add to the existing sheet chain:

```swift
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
```

- [ ] **Step 4: Build and commit**

```bash
git add ZenChoice/MainContentView.swift
git commit -m "feat: add social entry points to MainContentView"
```

---

### Task 13: PaywallView & SettingsView Updates

**Files:**
- Modify: `ZenChoice/PaywallView.swift`
- Modify: `ZenChoice/SettingsView.swift`

- [ ] **Step 1: Add social features to PaywallView feature list**

In PaywallView's feature list VStack, add after the existing rows:

```swift
featureRow(icon: "hands.sparkles",
           title: cn ? "无限求加持" : "Unlimited Blessings",
           desc: cn ? "每天无限次邀请朋友加持（免费版2次/天）" : "Unlimited daily blessing requests (free: 2/day)")
featureRow(icon: "signature",
           title: cn ? "更多见证人" : "More Witnesses",
           desc: cn ? "每次邀请3位见证人（免费版1位）" : "3 witnesses per request (free: 1)")
featureRow(icon: "mic",
           title: cn ? "语音永久保留" : "Permanent Voice Messages",
           desc: cn ? "所有语音消息永久保留（免费版最近5条）" : "Keep all voice messages (free: last 5)")
```

- [ ] **Step 2: Update SettingsView subscription benefits**

In the subscription section, the existing benefit descriptions are sufficient. No code changes needed unless the user wants to add social-specific info.

- [ ] **Step 3: Build and commit**

```bash
git add ZenChoice/PaywallView.swift
git commit -m "feat: add social features to PaywallView feature list"
```

---

## Chunk 6: H5 Web Pages

### Task 14: H5 Encourage Page

**Files:**
- Create: `docs/h5/encourage.html`

This file will be deployed to `kyle-zhai.github.io/Zen/encourage.html`.

- [ ] **Step 1: Create the encourage H5 page**

```html
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>禅意 · 为 ta 加持</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: #F5F6FA;
            color: #1E272E;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
        }
        .container { max-width: 400px; width: 100%; }
        .header { text-align: center; padding: 30px 0 20px; }
        .header .icon { font-size: 48px; }
        .header h2 { font-size: 20px; margin: 12px 0 4px; font-weight: 700; }
        .header .wish { font-size: 22px; font-weight: 800; font-family: serif; margin: 8px 0; }
        .header .sub { color: #888; font-size: 14px; }
        .section { margin: 16px 0; }
        .section label { font-size: 12px; color: #888; display: block; margin-bottom: 8px; }
        .perspectives { display: flex; flex-wrap: wrap; gap: 8px; }
        .perspectives button {
            border: 1px solid #ddd; background: #fff; border-radius: 8px;
            padding: 8px 14px; font-size: 13px; cursor: pointer;
            transition: all 0.2s;
        }
        .perspectives button.active { background: #1E272E; color: #fff; border-color: #1E272E; }
        .custom-input, textarea, .name-input {
            width: 100%; border: 1px solid #eee; border-radius: 10px;
            padding: 12px; font-size: 15px; background: #fff;
            font-family: inherit; resize: none;
        }
        textarea { min-height: 80px; }
        .ai-btn {
            display: inline-flex; align-items: center; gap: 4px;
            border: 1px solid #F6E58D; background: transparent; border-radius: 20px;
            padding: 6px 14px; font-size: 13px; color: #C9A000; cursor: pointer;
            margin-top: 8px;
        }
        .ai-btn:disabled { opacity: 0.5; }
        .voice-section { display: flex; align-items: center; gap: 12px; }
        .voice-btn {
            border: none; background: #f0f0f0; border-radius: 8px;
            padding: 8px 16px; font-size: 14px; cursor: pointer;
        }
        .voice-btn.recording { background: #ff4444; color: #fff; }
        .toggle-row { display: flex; align-items: center; justify-content: space-between; }
        .submit-btn {
            width: 100%; padding: 14px; border: none; border-radius: 14px;
            background: #1E272E; color: #fff; font-size: 16px; font-weight: 600;
            cursor: pointer; margin-top: 20px;
        }
        .submit-btn:disabled { opacity: 0.5; }
        .banner {
            margin-top: 30px; padding: 16px; background: #fff; border-radius: 12px;
            text-align: center; width: 100%;
        }
        .banner a { color: #C9A000; text-decoration: none; font-weight: 600; }
        .success { text-align: center; padding: 60px 0; }
        .success .icon { font-size: 64px; }
        .success h2 { margin: 16px 0 8px; }
        .hidden { display: none; }
        .error { color: #ff4444; font-size: 13px; margin-top: 4px; }
    </style>
</head>
<body>
    <div class="container" id="form-page">
        <div class="header">
            <div class="icon">🙏</div>
            <div class="sub" id="sub-text">为 ta 加持吧！</div>
            <div class="wish" id="wish-text">...</div>
        </div>

        <div class="section">
            <label id="perspective-label">选一个身份视角</label>
            <div class="perspectives" id="perspectives"></div>
            <input class="custom-input" id="custom-perspective" placeholder="自定义..." style="margin-top: 8px;">
        </div>

        <div class="section">
            <label id="content-label">写一句加持</label>
            <textarea id="content" placeholder="写点什么..."></textarea>
            <button class="ai-btn" id="ai-btn" onclick="aiGenerate()">✨ AI帮我写</button>
        </div>

        <div class="section">
            <label>录一段语音（可选，15秒）</label>
            <div class="voice-section">
                <button class="voice-btn" id="voice-btn" onclick="toggleVoice()">🎙 录音</button>
                <span id="voice-duration"></span>
                <button class="voice-btn hidden" id="voice-delete" onclick="deleteVoice()">🗑</button>
            </div>
        </div>

        <div class="section">
            <div class="toggle-row">
                <label>匿名</label>
                <input type="checkbox" id="anonymous" checked>
            </div>
            <input class="name-input hidden" id="sender-name" placeholder="你的名字" style="margin-top: 8px;">
        </div>

        <button class="submit-btn" id="submit-btn" onclick="submit()" disabled>匿名提交</button>
        <div class="error hidden" id="error-msg"></div>
    </div>

    <div class="container hidden" id="success-page">
        <div class="success">
            <div class="icon">✅</div>
            <h2>加持已送达</h2>
            <p style="color: #888">你的祝福已经传递给朋友了</p>
        </div>
    </div>

    <div class="banner">
        <p>下载「禅意 ZenChoice」获得更多功能</p>
        <a href="https://apps.apple.com/app/zenchoice/id000000000">前往 App Store →</a>
    </div>

<script>
// Config — fill in Supabase credentials
const SUPABASE_URL = '';
const SUPABASE_KEY = '';
const QWEN_KEY = '';

const params = new URLSearchParams(window.location.search);
const requestId = params.get('id');
let requestData = null;
let selectedPerspective = '';
let mediaRecorder = null;
let audioChunks = [];
let voiceBlob = null;
let voiceDuration = 0;
let voiceTimer = null;

const perspectivesCN = ['毒舌闺蜜', '慈祥奶奶', '未来的ta', '哲学家', '段子手'];
const perspectivesEN = ['Sassy BFF', 'Loving Grandma', 'Future Self', 'Philosopher', 'Comedian'];

async function init() {
    if (!requestId || !SUPABASE_URL) { document.body.innerHTML = '<p style="text-align:center;padding:40px">链接无效</p>'; return; }

    const res = await fetch(`${SUPABASE_URL}/rest/v1/courage_requests?id=eq.${requestId}&select=*`, {
        headers: { 'apikey': SUPABASE_KEY, 'Authorization': `Bearer ${SUPABASE_KEY}` }
    });
    const rows = await res.json();
    if (!rows.length) { document.body.innerHTML = '<p style="text-align:center;padding:40px">这段缘分已圆满</p>'; return; }
    requestData = rows[0];

    document.getElementById('wish-text').textContent = `「${requestData.wish}」`;

    const isCN = /[\u4e00-\u9fff]/.test(requestData.wish);
    const persp = isCN ? perspectivesCN : perspectivesEN;
    const container = document.getElementById('perspectives');
    persp.forEach(p => {
        const btn = document.createElement('button');
        btn.textContent = p;
        btn.onclick = () => selectPerspective(p, btn);
        container.appendChild(btn);
    });

    document.getElementById('anonymous').addEventListener('change', e => {
        document.getElementById('sender-name').classList.toggle('hidden', e.target.checked);
        updateSubmitLabel();
    });
    document.getElementById('content').addEventListener('input', updateSubmitBtn);

    // Hide voice if not supported
    if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
        document.getElementById('voice-btn').parentElement.parentElement.classList.add('hidden');
    }
}

function selectPerspective(p, btn) {
    document.querySelectorAll('.perspectives button').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
    selectedPerspective = p;
    document.getElementById('custom-perspective').value = '';
}

function updateSubmitBtn() {
    document.getElementById('submit-btn').disabled = !document.getElementById('content').value.trim();
}

function updateSubmitLabel() {
    const anon = document.getElementById('anonymous').checked;
    document.getElementById('submit-btn').textContent = anon ? '匿名提交' : '署名提交';
}

async function aiGenerate() {
    const persp = document.getElementById('custom-perspective').value || selectedPerspective;
    if (!persp) { showError('请先选择一个视角'); return; }
    if (!QWEN_KEY) { showError('AI暂不可用'); return; }

    const btn = document.getElementById('ai-btn');
    btn.disabled = true; btn.textContent = '⏳ 生成中...';

    try {
        const res = await fetch('https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions', {
            method: 'POST',
            headers: { 'Authorization': `Bearer ${QWEN_KEY}`, 'Content-Type': 'application/json' },
            body: JSON.stringify({
                model: 'qwen-turbo-latest',
                messages: [
                    { role: 'system', content: '你是一个有趣的鼓励大师。回复时直接输出内容，不加前缀。' },
                    { role: 'user', content: `用户想要「${requestData.wish}」。用「${persp}」的视角写一句简短有趣的鼓励，50字以内。` }
                ],
                temperature: 0.9, max_tokens: 200
            })
        });
        const data = await res.json();
        const content = data.choices?.[0]?.message?.content;
        if (content) document.getElementById('content').value = content.trim();
        updateSubmitBtn();
    } catch (e) { showError('AI生成失败'); }
    btn.disabled = false; btn.textContent = '✨ AI帮我写';
}

async function toggleVoice() {
    const btn = document.getElementById('voice-btn');
    if (mediaRecorder && mediaRecorder.state === 'recording') {
        mediaRecorder.stop(); clearInterval(voiceTimer);
        btn.textContent = '▶ 播放'; btn.classList.remove('recording');
        document.getElementById('voice-delete').classList.remove('hidden');
        return;
    }
    if (voiceBlob) { new Audio(URL.createObjectURL(voiceBlob)).play(); return; }

    try {
        const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
        mediaRecorder = new MediaRecorder(stream);
        audioChunks = []; voiceDuration = 0;
        mediaRecorder.ondataavailable = e => audioChunks.push(e.data);
        mediaRecorder.onstop = () => {
            voiceBlob = new Blob(audioChunks, { type: 'audio/webm' });
            stream.getTracks().forEach(t => t.stop());
        };
        mediaRecorder.start();
        btn.textContent = '⏹ 停止'; btn.classList.add('recording');
        voiceTimer = setInterval(() => {
            voiceDuration += 0.1;
            document.getElementById('voice-duration').textContent = voiceDuration.toFixed(1) + 's';
            if (voiceDuration >= 15) { mediaRecorder.stop(); clearInterval(voiceTimer); btn.textContent = '▶ 播放'; btn.classList.remove('recording'); }
        }, 100);
    } catch (e) { showError('无法访问麦克风'); }
}

function deleteVoice() {
    voiceBlob = null; voiceDuration = 0;
    document.getElementById('voice-btn').textContent = '🎙 录音';
    document.getElementById('voice-duration').textContent = '';
    document.getElementById('voice-delete').classList.add('hidden');
}

async function submit() {
    const btn = document.getElementById('submit-btn');
    btn.disabled = true; btn.textContent = '提交中...';

    const persp = document.getElementById('custom-perspective').value || selectedPerspective;
    const content = document.getElementById('content').value.trim();
    const anon = document.getElementById('anonymous').checked;
    const name = anon ? null : document.getElementById('sender-name').value.trim();
    const deviceId = getDeviceId();

    let voiceUrl = null;
    if (voiceBlob) {
        try {
            const respId = crypto.randomUUID();
            const path = `voices/${requestId}/${respId}.webm`;
            await fetch(`${SUPABASE_URL}/storage/v1/object/voice-messages/${path}`, {
                method: 'POST',
                headers: { 'Authorization': `Bearer ${SUPABASE_KEY}`, 'apikey': SUPABASE_KEY, 'Content-Type': 'audio/webm' },
                body: voiceBlob
            });
            voiceUrl = `${SUPABASE_URL}/storage/v1/object/public/voice-messages/${path}`;
        } catch (e) { /* voice upload failed, continue without */ }
    }

    try {
        const body = {
            request_id: requestId, content, perspective: persp || null,
            emoji_stamp: null, voice_url: voiceUrl,
            is_anonymous: anon, sender_name: name, sender_device_id: deviceId
        };
        const res = await fetch(`${SUPABASE_URL}/rest/v1/courage_responses`, {
            method: 'POST',
            headers: { 'apikey': SUPABASE_KEY, 'Authorization': `Bearer ${SUPABASE_KEY}`, 'Content-Type': 'application/json' },
            body: JSON.stringify(body)
        });
        if (res.ok || res.status === 201) {
            document.getElementById('form-page').classList.add('hidden');
            document.getElementById('success-page').classList.remove('hidden');
        } else {
            const err = await res.text();
            if (err.includes('unique')) showError('你已为此加持过');
            else if (err.includes('response_count')) showError('这段缘分已圆满');
            else showError('提交失败，请重试');
            btn.disabled = false; updateSubmitLabel();
        }
    } catch (e) { showError('网络错误'); btn.disabled = false; updateSubmitLabel(); }
}

function showError(msg) {
    const el = document.getElementById('error-msg');
    el.textContent = msg; el.classList.remove('hidden');
    setTimeout(() => el.classList.add('hidden'), 3000);
}

function getDeviceId() {
    let id = localStorage.getItem('zen_device_id');
    if (!id) { id = crypto.randomUUID(); localStorage.setItem('zen_device_id', id); }
    return id;
}

init();
</script>
</body>
</html>
```

- [ ] **Step 2: Commit**

```bash
git add docs/h5/encourage.html
git commit -m "feat: add H5 encourage page for non-app users"
```

---

### Task 15: H5 Witness Page

**Files:**
- Create: `docs/h5/witness.html`

- [ ] **Step 1: Create the witness H5 page**

Similar structure to encourage.html but adapted for witness flow:
- Shows AI summary from the request
- Has emoji stamp input instead of perspective picker
- No AI ghostwrite button
- Submit labels say "见证" instead of "加持"

```html
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>禅意 · 结缘见证</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: #F5F6FA; color: #1E272E;
            min-height: 100vh; display: flex; flex-direction: column;
            align-items: center; padding: 20px;
        }
        .container { max-width: 400px; width: 100%; }
        .header { text-align: center; padding: 30px 0 20px; }
        .header .icon { font-size: 48px; }
        .header .wish { font-size: 22px; font-weight: 800; font-family: serif; margin: 8px 0; }
        .header .sub { color: #888; font-size: 14px; }
        .summary { background: #fff; border-radius: 10px; padding: 12px; margin: 12px 0; color: #666; font-size: 13px; line-height: 1.6; text-align: center; }
        .section { margin: 16px 0; }
        .section label { font-size: 12px; color: #888; display: block; margin-bottom: 8px; }
        textarea, .name-input {
            width: 100%; border: 1px solid #eee; border-radius: 10px;
            padding: 12px; font-size: 15px; background: #fff;
            font-family: inherit; resize: none;
        }
        textarea { min-height: 80px; }
        .emoji-input {
            width: 60px; height: 60px; font-size: 40px; text-align: center;
            border: 1px solid #eee; border-radius: 12px; background: #fff;
        }
        .voice-section { display: flex; align-items: center; gap: 12px; }
        .voice-btn {
            border: none; background: #f0f0f0; border-radius: 8px;
            padding: 8px 16px; font-size: 14px; cursor: pointer;
        }
        .voice-btn.recording { background: #ff4444; color: #fff; }
        .toggle-row { display: flex; align-items: center; justify-content: space-between; }
        .submit-btn {
            width: 100%; padding: 14px; border: none; border-radius: 14px;
            background: #1E272E; color: #fff; font-size: 16px; font-weight: 600;
            cursor: pointer; margin-top: 20px;
        }
        .submit-btn:disabled { opacity: 0.5; }
        .banner {
            margin-top: 30px; padding: 16px; background: #fff; border-radius: 12px;
            text-align: center; width: 100%;
        }
        .banner a { color: #C9A000; text-decoration: none; font-weight: 600; }
        .success { text-align: center; padding: 60px 0; }
        .success .icon { font-size: 64px; }
        .hidden { display: none; }
        .error { color: #ff4444; font-size: 13px; margin-top: 4px; }
    </style>
</head>
<body>
    <div class="container" id="form-page">
        <div class="header">
            <div class="icon">✍️</div>
            <div class="sub">为 ta 见证这一刻</div>
            <div class="wish" id="wish-text">...</div>
        </div>
        <div class="summary hidden" id="summary-text"></div>

        <div class="section">
            <label>选一个印章</label>
            <input class="emoji-input" id="emoji-stamp" placeholder="😊">
        </div>

        <div class="section">
            <label>写一句寄语</label>
            <textarea id="content" placeholder="写点什么..."></textarea>
        </div>

        <div class="section">
            <label>录一段语音（可选，15秒）</label>
            <div class="voice-section">
                <button class="voice-btn" id="voice-btn" onclick="toggleVoice()">🎙 录音</button>
                <span id="voice-duration"></span>
                <button class="voice-btn hidden" id="voice-delete" onclick="deleteVoice()">🗑</button>
            </div>
        </div>

        <div class="section">
            <div class="toggle-row">
                <label>匿名</label>
                <input type="checkbox" id="anonymous" checked>
            </div>
            <input class="name-input hidden" id="sender-name" placeholder="你的名字" style="margin-top: 8px;">
        </div>

        <button class="submit-btn" id="submit-btn" onclick="submit()" disabled>匿名见证</button>
        <div class="error hidden" id="error-msg"></div>
    </div>

    <div class="container hidden" id="success-page">
        <div class="success">
            <div class="icon">✅</div>
            <h2>见证已送达</h2>
            <p style="color: #888">你的祝福已经传递给朋友了</p>
        </div>
    </div>

    <div class="banner">
        <p>下载「禅意 ZenChoice」获得更多功能</p>
        <a href="https://apps.apple.com/app/zenchoice/id000000000">前往 App Store →</a>
    </div>

<script>
const SUPABASE_URL = '';
const SUPABASE_KEY = '';

const params = new URLSearchParams(window.location.search);
const requestId = params.get('id');
let requestData = null;
let mediaRecorder = null;
let audioChunks = [];
let voiceBlob = null;
let voiceDuration = 0;
let voiceTimer = null;

async function init() {
    if (!requestId || !SUPABASE_URL) { document.body.innerHTML = '<p style="text-align:center;padding:40px">链接无效</p>'; return; }

    const res = await fetch(`${SUPABASE_URL}/rest/v1/courage_requests?id=eq.${requestId}&select=*`, {
        headers: { 'apikey': SUPABASE_KEY, 'Authorization': `Bearer ${SUPABASE_KEY}` }
    });
    const rows = await res.json();
    if (!rows.length) { document.body.innerHTML = '<p style="text-align:center;padding:40px">这段缘分已圆满</p>'; return; }
    requestData = rows[0];

    document.getElementById('wish-text').textContent = `「${requestData.wish}」`;
    if (requestData.ai_summary) {
        const el = document.getElementById('summary-text');
        el.textContent = requestData.ai_summary;
        el.classList.remove('hidden');
    }

    document.getElementById('anonymous').addEventListener('change', e => {
        document.getElementById('sender-name').classList.toggle('hidden', e.target.checked);
        updateSubmitLabel();
    });
    document.getElementById('content').addEventListener('input', updateSubmitBtn);

    if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
        document.getElementById('voice-btn').parentElement.parentElement.classList.add('hidden');
    }
}

function updateSubmitBtn() {
    document.getElementById('submit-btn').disabled = !document.getElementById('content').value.trim();
}

function updateSubmitLabel() {
    const anon = document.getElementById('anonymous').checked;
    document.getElementById('submit-btn').textContent = anon ? '匿名见证' : '署名见证';
}

async function toggleVoice() {
    const btn = document.getElementById('voice-btn');
    if (mediaRecorder && mediaRecorder.state === 'recording') {
        mediaRecorder.stop(); clearInterval(voiceTimer);
        btn.textContent = '▶ 播放'; btn.classList.remove('recording');
        document.getElementById('voice-delete').classList.remove('hidden');
        return;
    }
    if (voiceBlob) { new Audio(URL.createObjectURL(voiceBlob)).play(); return; }
    try {
        const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
        mediaRecorder = new MediaRecorder(stream);
        audioChunks = []; voiceDuration = 0;
        mediaRecorder.ondataavailable = e => audioChunks.push(e.data);
        mediaRecorder.onstop = () => { voiceBlob = new Blob(audioChunks, { type: 'audio/webm' }); stream.getTracks().forEach(t => t.stop()); };
        mediaRecorder.start();
        btn.textContent = '⏹ 停止'; btn.classList.add('recording');
        voiceTimer = setInterval(() => {
            voiceDuration += 0.1;
            document.getElementById('voice-duration').textContent = voiceDuration.toFixed(1) + 's';
            if (voiceDuration >= 15) { mediaRecorder.stop(); clearInterval(voiceTimer); btn.textContent = '▶ 播放'; btn.classList.remove('recording'); }
        }, 100);
    } catch (e) { showError('无法访问麦克风'); }
}

function deleteVoice() {
    voiceBlob = null; voiceDuration = 0;
    document.getElementById('voice-btn').textContent = '🎙 录音';
    document.getElementById('voice-duration').textContent = '';
    document.getElementById('voice-delete').classList.add('hidden');
}

async function submit() {
    const btn = document.getElementById('submit-btn');
    btn.disabled = true; btn.textContent = '提交中...';

    const content = document.getElementById('content').value.trim();
    const emoji = document.getElementById('emoji-stamp').value.trim();
    const anon = document.getElementById('anonymous').checked;
    const name = anon ? null : document.getElementById('sender-name').value.trim();
    const deviceId = getDeviceId();

    let voiceUrl = null;
    if (voiceBlob) {
        try {
            const respId = crypto.randomUUID();
            const path = `voices/${requestId}/${respId}.webm`;
            await fetch(`${SUPABASE_URL}/storage/v1/object/voice-messages/${path}`, {
                method: 'POST',
                headers: { 'Authorization': `Bearer ${SUPABASE_KEY}`, 'apikey': SUPABASE_KEY, 'Content-Type': 'audio/webm' },
                body: voiceBlob
            });
            voiceUrl = `${SUPABASE_URL}/storage/v1/object/public/voice-messages/${path}`;
        } catch (e) { /* continue without voice */ }
    }

    try {
        const body = {
            request_id: requestId, content, perspective: null,
            emoji_stamp: emoji || null, voice_url: voiceUrl,
            is_anonymous: anon, sender_name: name, sender_device_id: deviceId
        };
        const res = await fetch(`${SUPABASE_URL}/rest/v1/courage_responses`, {
            method: 'POST',
            headers: { 'apikey': SUPABASE_KEY, 'Authorization': `Bearer ${SUPABASE_KEY}`, 'Content-Type': 'application/json' },
            body: JSON.stringify(body)
        });
        if (res.ok || res.status === 201) {
            document.getElementById('form-page').classList.add('hidden');
            document.getElementById('success-page').classList.remove('hidden');
        } else {
            const err = await res.text();
            if (err.includes('unique')) showError('你已见证过了');
            else if (err.includes('response_count')) showError('见证人数已满');
            else showError('提交失败，请重试');
            btn.disabled = false; updateSubmitLabel();
        }
    } catch (e) { showError('网络错误'); btn.disabled = false; updateSubmitLabel(); }
}

function showError(msg) {
    const el = document.getElementById('error-msg');
    el.textContent = msg; el.classList.remove('hidden');
    setTimeout(() => el.classList.add('hidden'), 3000);
}

function getDeviceId() {
    let id = localStorage.getItem('zen_device_id');
    if (!id) { id = crypto.randomUUID(); localStorage.setItem('zen_device_id', id); }
    return id;
}

init();
</script>
</body>
</html>
```

- [ ] **Step 2: Commit**

```bash
git add docs/h5/witness.html
git commit -m "feat: add H5 witness page for non-app users"
```

---

### Task 16: GitHub Pages & Universal Links Configuration

**Files:**
- Create: `docs/h5/.nojekyll`
- Create: `docs/h5/.well-known/apple-app-site-association`

- [ ] **Step 1: Create AASA file**

```json
{
    "applinks": {
        "apps": [],
        "details": [
            {
                "appID": "977U292PF7.com.yinan.ZenChoice",
                "paths": ["/Zen/encourage*", "/Zen/witness*"]
            }
        ]
    }
}
```

- [ ] **Step 2: Create .nojekyll file**

Empty file to ensure GitHub Pages serves `.well-known` directory.

- [ ] **Step 3: Add Associated Domains entitlement to Xcode project**

In Xcode: Target > Signing & Capabilities > + Capability > Associated Domains

Add: `applinks:kyle-zhai.github.io`

This creates/modifies the `.entitlements` file.

- [ ] **Step 4: Commit**

```bash
git add docs/h5/.nojekyll docs/h5/.well-known/apple-app-site-association
git commit -m "feat: add AASA file and GitHub Pages config for Universal Links"
```

- [ ] **Step 5: Deploy H5 pages**

Copy `docs/h5/` contents to the `kyle-zhai.github.io` repository under the `/Zen/` path. Ensure the directory structure is:

```
kyle-zhai.github.io/
├── .well-known/
│   └── apple-app-site-association
├── .nojekyll
├── Zen/
│   ├── encourage.html
│   ├── witness.html
│   ├── privacy.html (existing)
│   └── terms.html (existing)
```

---

## Post-Implementation Checklist

- [ ] Create a Supabase project and fill in `supabaseUrl` and `supabaseAnonKey` in `SocialManager.swift`
- [ ] Run `docs/supabase-setup.sql` in Supabase SQL Editor
- [ ] Create `voice-messages` storage bucket in Supabase Dashboard (public, 100KB limit)
- [ ] Fill in Supabase credentials in H5 pages (`encourage.html` and `witness.html`)
- [ ] Fill in Qwen API key in `encourage.html`
- [ ] Add `NSMicrophoneUsageDescription` to Info.plist
- [ ] Add Associated Domains capability in Xcode
- [ ] Deploy H5 pages to GitHub Pages
- [ ] Test Universal Links on a real device
- [ ] Update App Store Connect app description with new social features
- [ ] Remove API keys from code before pushing to GitHub
