# ZenChoice (禅意)

An iOS app that encourages you to do the things you hesitate about — with humor, warmth, and socially viral flair.

## What It Does

Type in what you want to do but keep putting off — confess your feelings, quit your job, learn guitar, adopt a cat — and ZenChoice gives you multi-perspective encouragement to just go for it.

Each generation delivers 3–6 unique "dimensions" of encouragement: a philosopher's take, an economist's analysis, a cat's verdict, and more. The results are designed to be screenshot-worthy and shareable.

## Features

- **Multi-Perspective Encouragement** — Each session generates encouragement from multiple creative angles (philosopher, economist, time traveler, your future self, etc.)
- **30+ Built-in Dimensions** — A rich pool of fun, relatable perspectives with bilingual support (Chinese / English)
- **AI-Powered Custom Perspectives** (Subscriber) — Define up to 3 custom perspectives with your own name, description, and tone. AI generates unique encouragement tailored to your style.
- **Courage Archive** — Save and revisit your last 30 brave moments
- **Share Cards** — One-tap generation of beautiful quote cards for social sharing
- **Daily Usage Limits** — Free: 15/day, Monthly: 20/day, Yearly: 30/day
- **Bilingual** — Full Chinese and English support, auto-detected from system language

## Tech Stack

- **SwiftUI** with `@Observable` (iOS 18.0+)
- **StoreKit 2** for auto-renewable subscriptions
- **Qwen (DashScope) API** for AI-generated encouragement (OpenAI-compatible)
- **Concurrency** — `async/await`, `withTaskGroup` for parallel API calls

## Project Structure

```
ZenChoice/
├── ZenChoiceApp.swift          # App entry point
├── ZenViewModel.swift          # Core view model (state, generation logic)
├── Models.swift                # Data models
├── EncouragementEngine.swift   # Template-based dimension pool (30+ perspectives)
├── DimensionPool.swift         # Dimension definitions (CN/EN)
├── LLMService.swift            # LLM provider protocol + Qwen implementation
├── SubscriptionManager.swift   # StoreKit 2 subscription handling
├── MainContentView.swift       # Home screen
├── ResultCardView.swift        # Encouragement result display
├── PaywallView.swift           # Subscription paywall
├── SettingsView.swift          # Settings & custom perspectives
├── CourageArchiveView.swift    # Saved encouragement history
├── ShareCardView.swift         # Social share card generation
├── PosterService.swift         # Share card rendering
├── ZenTheme.swift              # Design system (colors, fonts)
├── ZenBackground.swift         # Animated background
├── HapticManager.swift         # Haptic feedback
└── PrivacyInfo.xcprivacy       # Privacy manifest
```

## Setup

1. Clone the repository
2. Open `ZenChoice.xcodeproj` in Xcode 16+
3. Set your DashScope API key in `LLMService.swift`:
   ```swift
   private let apiKey: String = "YOUR_DASHSCOPE_API_KEY"
   ```
4. Configure your StoreKit product IDs in `SubscriptionManager.swift` if needed
5. Build and run on iOS 18.0+ device or simulator

## Subscription Tiers

| Feature | Free | Monthly | Yearly |
|---------|------|---------|--------|
| Daily uses | 15 | 20 | 30 |
| Dimensions per session | 4 | 6 | 6 |
| Custom AI perspectives | — | 3 | 3 |
| Courage archive | — | 30 records | 30 records |
| Share cards | — | Yes | Yes |

## Links

- [Privacy Policy](https://kyle-zhai.github.io/Zen/privacy.html)
- [Terms of Use](https://kyle-zhai.github.io/Zen/terms.html)
- [Support](https://kyle-zhai.github.io/Zen/support.html)

## Contact

**Email:** yn.zhai0205@gmail.com

## License

Copyright 2026 Yinan Zhai. All rights reserved.
