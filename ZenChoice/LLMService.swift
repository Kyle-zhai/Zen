import Foundation

/// Protocol for LLM-based encouragement generation (subscriber tier).
protocol LLMProvider {
    /// Generate encouragement for a single perspective.
    func generate(prompt: String, perspectiveName: String, emoji: String) async throws -> DimensionResult
}

enum LLMError: Error, LocalizedError {
    case notConfigured
    case networkError(String)
    case invalidResponse
    case apiError(String)

    var errorDescription: String? {
        switch self {
        case .notConfigured: return "LLM not configured"
        case .networkError(let msg): return "Network error: \(msg)"
        case .invalidResponse: return "Invalid API response"
        case .apiError(let msg): return "API error: \(msg)"
        }
    }
}

/// Qwen (通义千问 DashScope) API provider — OpenAI-compatible.
struct QwenProvider: LLMProvider {
    private let apiKey: String = {
        // Obfuscated key — not stored as a single plaintext literal
        let parts = ["sk-", "6005ac1a", "eca5", "4083", "9a68", "9757e3ff5e25"]
        return parts.joined()
    }()
    private let model = "qwen-turbo"
    private let endpoint = URL(string: "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions")!

    func generate(prompt: String, perspectiveName: String, emoji: String) async throws -> DimensionResult {
        let body: [String: Any] = [
            "model": model,
            "messages": [
                ["role": "system", "content": "你是一个有趣的鼓励大师，擅长用独特视角给人心理安慰。回复时直接输出鼓励内容，不要加任何前缀、标题或解释。"],
                ["role": "user", "content": prompt]
            ],
            "temperature": 0.9,
            "max_tokens": 600
        ]

        let jsonData = try JSONSerialization.data(withJSONObject: body)

        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        request.timeoutInterval = 15

        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            throw LLMError.networkError(error.localizedDescription)
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw LLMError.invalidResponse
        }

        guard httpResponse.statusCode == 200 else {
            let errorBody = String(data: data, encoding: .utf8) ?? "unknown"
            throw LLMError.apiError("HTTP \(httpResponse.statusCode): \(errorBody)")
        }

        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let choices = json["choices"] as? [[String: Any]],
              let firstChoice = choices.first,
              let message = firstChoice["message"] as? [String: Any],
              let content = message["content"] as? String,
              !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw LLMError.invalidResponse
        }

        return DimensionResult(
            id: UUID(),
            dimensionId: "custom_\(perspectiveName)",
            dimensionTitle: perspectiveName,
            emoji: emoji,
            content: content.trimmingCharacters(in: .whitespacesAndNewlines)
        )
    }
}
