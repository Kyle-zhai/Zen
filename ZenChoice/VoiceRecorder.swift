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
