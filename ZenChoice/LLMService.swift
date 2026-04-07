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
    case allModelsExhausted

    var errorDescription: String? {
        switch self {
        case .notConfigured: return "LLM not configured"
        case .networkError(let msg): return "Network error: \(msg)"
        case .invalidResponse: return "Invalid API response"
        case .apiError(let msg): return "API error: \(msg)"
        case .allModelsExhausted: return "All models exhausted"
        }
    }
}

/// Qwen (通义千问 DashScope) API provider with automatic model fallback.
/// Uses a single API key; when one model hits its token/rate limit, switches to the next.
final class QwenProvider: LLMProvider {
    static let shared = QwenProvider()

    private let apiKey: String = Secrets.dashScopeApiKey
    private let endpoint = URL(string: "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions")!

    /// Models ordered by preference. When one is exhausted, the next is tried.
    private static let modelFallbackChain: [String] = [
        "qwen-turbo-latest",
        "qwen-turbo",
        "qwen-plus",
        "qwen-long",
    ]

    /// Track which models are temporarily blocked (quota/rate limit).
    /// Key = model name, Value = earliest retry time.
    private var blockedModels: [String: Date] = [:]

    /// Pick the first available (non-blocked) model.
    private func nextAvailableModel() -> String? {
        let now = Date()
        // Unblock models whose cooldown has expired (retry after 1 hour)
        blockedModels = blockedModels.filter { $0.value > now }
        return Self.modelFallbackChain.first { !blockedModels.keys.contains($0) }
    }

    /// Mark a model as temporarily exhausted (block for 1 hour).
    private func blockModel(_ model: String) {
        blockedModels[model] = Date().addingTimeInterval(3600)
    }

    /// Check if an error response indicates token/rate limit exhaustion.
    private func isQuotaError(statusCode: Int, body: String) -> Bool {
        // DashScope returns 429 for rate limit, 400/403 for quota exhausted
        if statusCode == 429 { return true }
        let quotaKeywords = ["quota", "limit", "exhausted", "exceeded", "insufficient", "balance",
                             "Arrearage", "FreeTierQuotaExhaust", "throttl"]
        return quotaKeywords.contains(where: { body.localizedCaseInsensitiveContains($0) })
    }

    func generate(prompt: String, perspectiveName: String, emoji: String) async throws -> DimensionResult {
        // Try each available model in the fallback chain
        var lastError: Error = LLMError.allModelsExhausted

        while let model = nextAvailableModel() {
            do {
                return try await callModel(model: model, prompt: prompt, perspectiveName: perspectiveName, emoji: emoji)
            } catch let error as LLMError {
                switch error {
                case .apiError(let msg) where isQuotaError(statusCode: 0, body: msg):
                    // Quota/rate error → block this model and try next
                    blockModel(model)
                    lastError = error
                    continue
                default:
                    throw error
                }
            }
        }

        throw lastError
    }

    private func callModel(model: String, prompt: String, perspectiveName: String, emoji: String) async throws -> DimensionResult {
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

        let responseBody = String(data: data, encoding: .utf8) ?? "unknown"

        guard httpResponse.statusCode == 200 else {
            // Check if this is a quota/rate limit error
            if isQuotaError(statusCode: httpResponse.statusCode, body: responseBody) {
                blockModel(model)
                throw LLMError.apiError(responseBody)
            }
            throw LLMError.apiError("HTTP \(httpResponse.statusCode): \(responseBody)")
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
