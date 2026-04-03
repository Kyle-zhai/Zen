import Foundation

enum DeepLinkHandler {

    enum Destination {
        case encourage(requestId: UUID)
        case witness(requestId: UUID)
        case bond(fromUserId: String)
        case authCallback(accessToken: String, refreshToken: String)
    }

    static func parse(url: URL) -> Destination? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }

        let path = url.path
        let queryItems = components.queryItems ?? []

        // Auth callback: zenchoice://auth?access_token=xxx&refresh_token=xxx
        if url.scheme == "zenchoice" && url.host == "auth" {
            if let access = queryItems.first(where: { $0.name == "access_token" })?.value,
               let refresh = queryItems.first(where: { $0.name == "refresh_token" })?.value {
                return .authCallback(accessToken: access, refreshToken: refresh)
            }
            return nil
        }

        // Bond invite: ?from=userId
        if path.contains("bond") {
            if let fromId = queryItems.first(where: { $0.name == "from" })?.value, !fromId.isEmpty {
                return .bond(fromUserId: fromId)
            }
            return nil
        }

        // Courage requests: ?id=uuid
        guard let idString = queryItems.first(where: { $0.name == "id" })?.value,
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
