import SwiftUI
import AuthenticationServices
import CryptoKit

struct AuthView: View {
    @Environment(ZenViewModel.self) private var viewModel

    @State private var email = ""
    @State private var showEmailInput = false
    @State private var magicLinkSent = false
    @State private var isLoading = false
    @State private var errorMessage = ""
    @State private var showError = false
    @State private var currentNonce = ""
    @State private var appleSignInDelegate: AppleSignInDelegate?

    private var cn: Bool { viewModel.L.isChinese }
    private var auth: AuthManager { viewModel.authManager }

    var body: some View {
        ZStack {
            ZenBackground()

            VStack(spacing: 32) {
                Spacer()

                // Logo
                VStack(spacing: 8) {
                    Text(cn ? "禅意" : "ZenChoice")
                        .font(ZenTheme.calligraphy(40))
                        .foregroundStyle(ZenTheme.inkBlack)
                    Text(cn ? "开始你的修行" : "Begin your journey")
                        .font(ZenTheme.bodyFont(15))
                        .foregroundStyle(ZenTheme.distantMountain.opacity(0.5))
                }

                Spacer()

                if magicLinkSent {
                    // Magic link sent confirmation
                    VStack(spacing: 12) {
                        Image(systemName: "envelope.badge.fill")
                            .font(.system(size: 48))
                            .foregroundStyle(ZenTheme.gooseYellow)
                        Text(cn ? "验证邮件已发送" : "Verification email sent")
                            .font(ZenTheme.bodyFont(16))
                            .foregroundStyle(ZenTheme.inkBlack)
                        Text(cn ? "请查看 \(email) 的收件箱" : "Check your inbox at \(email)")
                            .font(ZenTheme.caption(13))
                            .foregroundStyle(.secondary)
                        Button(cn ? "重新发送" : "Resend") {
                            Task { await sendMagicLink() }
                        }
                        .font(ZenTheme.caption(13))
                        .foregroundStyle(ZenTheme.gooseYellow)
                        .padding(.top, 8)
                    }
                } else if showEmailInput {
                    // Email input
                    VStack(spacing: 16) {
                        TextField(cn ? "输入邮箱地址" : "Enter your email", text: $email)
                            .font(ZenTheme.bodyFont(16))
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            .autocapitalization(.none)
                            .padding(14)
                            .background(RoundedRectangle(cornerRadius: 12).fill(.white))
                            .padding(.horizontal, 40)

                        Button {
                            Task { await sendMagicLink() }
                        } label: {
                            HStack(spacing: 8) {
                                if isLoading {
                                    ProgressView().tint(.white)
                                }
                                Text(cn ? "发送验证邮件" : "Send verification email")
                            }
                            .font(ZenTheme.calligraphy(16))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(RoundedRectangle(cornerRadius: 14).fill(ZenTheme.inkBlack))
                        }
                        .disabled(email.isEmpty || isLoading)
                        .padding(.horizontal, 40)

                        Button(cn ? "返回" : "Back") {
                            showEmailInput = false
                        }
                        .font(ZenTheme.caption(13))
                        .foregroundStyle(.secondary)
                    }
                } else {
                    // Login options
                    VStack(spacing: 14) {
                        // Apple Sign In (custom button for consistent style)
                        Button {
                            triggerAppleSignIn()
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "apple.logo")
                                Text(cn ? "Apple 登录" : "Sign in with Apple")
                            }
                            .font(ZenTheme.calligraphy(16))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(ZenTheme.inkBlack)
                            )
                        }
                        .padding(.horizontal, 40)

                        // Email Sign In
                        Button {
                            showEmailInput = true
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "envelope")
                                Text(cn ? "邮箱登录" : "Sign in with Email")
                            }
                            .font(ZenTheme.calligraphy(16))
                            .foregroundStyle(ZenTheme.inkBlack)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(ZenTheme.inkBlack.opacity(0.3), lineWidth: 1.5)
                            )
                        }
                        .padding(.horizontal, 40)

                        // Test bypass
                        #if DEBUG
                        Button {
                            auth.testBypass()
                        } label: {
                            HStack(spacing: 6) {
                                Image(systemName: "flask")
                                Text("Test Mode")
                            }
                            .font(ZenTheme.caption(13))
                            .foregroundStyle(ZenTheme.distantMountain.opacity(0.4))
                        }
                        .padding(.top, 8)
                        #endif
                    }
                }

                Spacer().frame(height: 60)
            }
        }
        .alert(cn ? "提示" : "Notice", isPresented: $showError) {
            Button(cn ? "知道了" : "OK") {}
        } message: {
            Text(errorMessage)
        }
    }

    // MARK: - Actions

    private func triggerAppleSignIn() {
        let nonce = randomNonceString()
        currentNonce = nonce

        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)

        let delegate = AppleSignInDelegate { result in
            Task { await handleAppleSignIn(result) }
        }
        // Keep delegate alive
        appleSignInDelegate = delegate

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = delegate
        controller.performRequests()
    }

    private func handleAppleSignIn(_ result: Result<ASAuthorization, Error>) async {
        switch result {
        case .success(let authorization):
            guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
                  let tokenData = credential.identityToken,
                  let idToken = String(data: tokenData, encoding: .utf8) else {
                errorMessage = cn ? "Apple 登录失败" : "Apple sign in failed"
                showError = true
                return
            }
            do {
                try await self.auth.signInWithApple(idToken: idToken, nonce: currentNonce)
            } catch {
                errorMessage = error.localizedDescription
                showError = true
            }
        case .failure(let error):
            if (error as NSError).code != ASAuthorizationError.canceled.rawValue {
                errorMessage = error.localizedDescription
                showError = true
            }
        }
    }

    private func sendMagicLink() async {
        isLoading = true
        defer { isLoading = false }
        do {
            try await auth.sendMagicLink(email: email)
            magicLinkSent = true
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }

    // MARK: - Nonce Helpers

    private func randomNonceString(length: Int = 32) -> String {
        let charset = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        while remainingLength > 0 {
            let randoms: [UInt8] = (0..<16).map { _ in
                var random: UInt8 = 0
                _ = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                return random
            }
            randoms.forEach { random in
                if remainingLength == 0 { return }
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }

    private func sha256(_ input: String) -> String {
        let data = Data(input.utf8)
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }
}

// MARK: - Apple Sign In Delegate

private class AppleSignInDelegate: NSObject, ASAuthorizationControllerDelegate {
    let completion: (Result<ASAuthorization, Error>) -> Void

    init(completion: @escaping (Result<ASAuthorization, Error>) -> Void) {
        self.completion = completion
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        completion(.success(authorization))
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        completion(.failure(error))
    }
}
