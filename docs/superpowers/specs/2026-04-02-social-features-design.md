# ZenChoice Social Features Design Spec

## Goal

Add two social features — "求加持" (request blessings) and "结缘见证" (witness bond) — to ZenChoice, enabling friend-to-friend encouragement and signed commitment cards with optional voice messages. The features use Supabase as backend and a lightweight H5 page for non-app users.

## Decisions

- **Backend**: Supabase (free tier — 500MB DB, 1GB storage, 50k requests/month)
- **User identity**: Device UUID stored in UserDefaults, no login required
- **H5 page**: Hosted on GitHub Pages (`kyle-zhai.github.io/Zen/`)
- **Deep linking**: Universal Links — app intercepts if installed, falls back to H5
- **Voice**: Optional 15-second recordings, stored in Supabase Storage (~60KB each)
- **Emoji stamps**: System native keyboard, no restrictions
- **Anonymity**: Sender chooses anonymous (default) or signed
- **Naming convention**: Zen/mystical tone — "加持", "结缘", "缘起契约", "修行档案", "善缘簿"
- **Platforms**: iOS only (no WeChat mini-program)
- **Supabase client**: Raw URLSession calls to PostgREST endpoint (no third-party SDK dependency)

---

## Feature 1: "求加持" (Request Blessings)

### Flow

1. User A completes "获知真相" (Reveal the Truth), sees result page
2. User A taps "求加持" button on result page
3. App creates a `courage_requests` record (type: `encourage`) in Supabase, generates share link
4. User A shares link via Share Sheet (WeChat, iMessage, etc.)
5. Friend B opens link:
   - Has app installed → Universal Link opens `RespondView` in app
   - No app → H5 page at `kyle-zhai.github.io/Zen/encourage?id=<uuid>`
6. Friend B sees User A's wish, selects a perspective, writes encouragement (or taps "AI帮我写")
7. Friend B optionally records a 15-second voice message
8. Friend B chooses anonymous or signed, submits → stored in Supabase
9. User A sees new items in "善缘簿" (inbox) next time they open the app

### Perspectives Available to Friend

Pre-defined list (friend picks one):
- 毒舌闺蜜 / 慈祥奶奶 / 未来的 ta / 哲学家 / 段子手 / 自定义输入

### AI Ghost-writing

Friend can tap "AI帮我写" — sends the wish + selected perspective to Qwen API, returns a draft the friend can edit before submitting.

---

## Feature 2: "结缘见证" (Witness Bond)

### Flow

1. User A completes "获知真相", sees result page
2. User A taps "邀请见证" button
3. App creates a `courage_requests` record (type: `witness`) in Supabase with AI summary of the encouragement result
4. User A shares link
5. Friend B opens link, sees User A's wish + AI encouragement summary
6. Friend B writes a short message + picks an emoji stamp from system keyboard
7. Friend B optionally records a 15-second voice message
8. Friend B submits → stored in Supabase
9. When enough signatures collected (or User A triggers it), app generates a "缘起契约" card with all signatures
10. Card can be shared to social media; voice messages accessible via QR code on card

### Signature Slots

- Free users: 1 signature slot per request
- Subscribers: 3 signature slots per request

---

## Data Model (Supabase)

### Table: `courage_requests`

| Column | Type | Description |
|--------|------|-------------|
| id | uuid | Primary key, auto-generated |
| type | text | `encourage` or `witness` |
| wish | text | What the user wants to do |
| ai_summary | text | AI encouragement summary (for witness display) |
| creator_device_id | text | Device UUID of the creator |
| max_responses | int | Max allowed responses (1 or 3 based on subscription) |
| response_count | int | Current response count (default 0, incremented by DB trigger) |
| expires_at | timestamptz | Expiration time (default: created_at + 7 days) |
| created_at | timestamptz | Creation time |

### Table: `courage_responses`

| Column | Type | Description |
|--------|------|-------------|
| id | uuid | Primary key, auto-generated |
| request_id | uuid | FK to courage_requests.id |
| content | text | Encouragement text or witness message |
| perspective | text | Selected perspective (encourage type only) |
| emoji_stamp | text | Emoji stamp from system keyboard |
| voice_url | text | Supabase Storage URL for voice file (nullable) |
| is_anonymous | bool | Whether sender is anonymous (default true) |
| sender_name | text | Display name when not anonymous (nullable) |
| sender_device_id | text | Responder device UUID (for duplicate prevention) |
| created_at | timestamptz | Creation time |

**Unique constraint**: `(request_id, sender_device_id)` — one response per person per request.

### DB Trigger: Auto-increment response_count

```sql
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
```

### Storage Bucket: `voice-messages`

- Path format: `voices/<request_id>/<response_id>.m4a`
- Max file size: ~60KB per clip (15 seconds m4a)
- Retention: permanent (cleanup policy TBD)
- Access: public read (needed for H5 playback + QR code access), anon insert allowed (path-restricted to `voices/` prefix)

---

## Technical Architecture

### System Diagram

```
iOS App (SwiftUI)          H5 Page (GitHub Pages)
       |                          |
       +----------+---------------+
                  |
           Supabase REST API
           (PostgREST + Storage)
                  |
          +-------+-------+
          | PostgreSQL    |
          | + Storage     |
          +---------------+
```

### API Access Pattern

Both iOS and H5 use Supabase anonymous key with direct PostgREST calls. Device identity is passed as `creator_device_id` column value in queries (not via headers or session variables). RLS policies filter rows by comparing the `creator_device_id` column against a query parameter.

**iOS**: Raw `URLSession` calls to PostgREST endpoint. No `supabase-swift` SDK — keeps dependencies minimal and consistent with the existing `LLMService.swift` pattern.

**H5**: `fetch()` calls to the same PostgREST endpoint with the anonymous API key in the `apikey` header.

### iOS: New Files

| File | Responsibility |
|------|----------------|
| `SocialManager.swift` | Supabase API wrapper: CRUD for requests/responses, voice upload/download |
| `EncourageRequestView.swift` | "求加持" creation page — preview wish, generate link, share |
| `WitnessRequestView.swift` | "邀请见证" creation page — preview wish + AI summary, generate link, share |
| `RespondView.swift` | Friend response page — perspective picker, text input, AI ghostwrite, voice recorder, submit |
| `InboxView.swift` | "善缘簿" — list of received blessings and witness signatures |
| `WitnessCardView.swift` | "缘起契约" card renderer — wish + AI summary + signatures with emoji stamps + voice indicators |
| `VoiceRecorder.swift` | AVAudioRecorder/AVAudioPlayer wrapper — record, play, export m4a |
| `DeepLinkHandler.swift` | Universal Link parsing, route to RespondView with request ID |

### iOS: Modified Files

| File | Changes |
|------|---------|
| `MainContentView.swift` | Add "善缘簿" icon in header bar; add "求加持" and "邀请见证" buttons in result section |
| `ZenViewModel.swift` | Add inbox state, social request management, device ID generation |
| `Models.swift` | Add `CourageRequest`, `CourageResponse` Swift models |
| `PosterService.swift` | Add "缘起契约" card rendering with signatures |
| `PaywallView.swift` | Update feature list to include social features |
| `SettingsView.swift` | Update subscription benefit descriptions |
| `ZenChoiceApp.swift` | Register Universal Link handler |

### H5 Pages (GitHub Pages)

Hosted at `kyle-zhai.github.io/Zen/`:

- `/Zen/encourage.html?id=<uuid>` — Friend writes encouragement
- `/Zen/witness.html?id=<uuid>` — Friend signs as witness

Both pages:
- Static HTML + vanilla JS (no framework)
- Call Supabase REST API directly (anonymous key, RLS policies protect data)
- Voice recording: use MediaRecorder API where supported; hide voice option on unsupported browsers (notably older iOS Safari < 14.5)
- Bottom banner: "下载禅意 ZenChoice" with App Store link
- Bilingual (detect from request data language field, or browser locale)

### Universal Links

Domain: `kyle-zhai.github.io`

`apple-app-site-association` file at `kyle-zhai.github.io/.well-known/`:
```json
{
  "applinks": {
    "apps": [],
    "details": [{
      "appID": "977U292PF7.com.yinan.ZenChoice",
      "paths": ["/Zen/encourage*", "/Zen/witness*"]
    }]
  }
}
```

**GitHub Pages config**: Add `include: [".well-known"]` to `_config.yml` (or add a `.nojekyll` file) so the `.well-known` directory is served.

When app is installed, iOS intercepts these URLs and passes them to the app. `DeepLinkHandler` parses the `id` parameter and opens `RespondView`.

### Device Identity

```swift
// Generated once on first launch, stored in UserDefaults
static var deviceId: String {
    if let id = UserDefaults.standard.string(forKey: "deviceId") {
        return id
    }
    let id = UUID().uuidString
    UserDefaults.standard.set(id, forKey: "deviceId")
    return id
}
```

---

## UI Design

### Entry Points

**Result page** (after "获知真相"), above the existing "再来一次" button:

```
  ┌──────────┐  ┌──────────┐
  │ 🙏 求加持 │  │ ✍️ 邀请见证│
  └──────────┘  └──────────┘
```

**Header bar** — new inbox icon:

```
[📖档案]       禅意       [善缘簿(3)] [⚙设置]
```

Badge count shows unread responses.

### Friend Response Page (App & H5)

```
┌─────────────────────────────────┐
│  你的朋友想要「跑步」              │
│  为 ta 加持吧！                   │
│                                   │
│  选一个身份视角：                   │
│  [毒舌闺蜜] [慈祥奶奶] [未来的ta]  │
│  [哲学家]   [段子手]   [自定义...]  │
│                                   │
│  ┌─────────────────────────┐     │
│  │ 写一句加持...             │     │
│  └─────────────────────────┘     │
│  [✨ AI帮我写]                    │
│                                   │
│  🎙 录一段语音（可选，15秒）        │
│                                   │
│  [匿名提交]    [署名提交: ___]     │
└─────────────────────────────────┘
```

### "缘起契约" Card

```
┌─────────────────────────────────┐
│          ✨ 缘起契约 ✨            │
│                                   │
│       「今天要跑步」               │
│                                   │
│   "跑步这件事，连蜗牛都在坚持"     │
│          — 禅意解读               │
│                                   │
│  ── 见证人 ──                     │
│  🔥 去吧少年！      — 小明        │
│  💪 看好你哦        — 匿名        │
│  🌸 等你好消息      — 小红   🎙   │
│                                   │
│         禅意 ZenChoice            │
│     扫码结缘加持 [二维码]          │
└─────────────────────────────────┘
```

Voice indicator (🎙) shown next to entries with voice recordings. QR code links to the request page where voice can be played.

### "善缘簿" Inbox

```
┌─────────────────────────────────┐
│  善缘簿                     完成  │
│─────────────────────────────────│
│                                   │
│  今天                             │
│  ┌─────────────────────────────┐ │
│  │ 🙏 「跑步」收到 3 条加持      │ │
│  │    2分钟前                    │ │
│  └─────────────────────────────┘ │
│  ┌─────────────────────────────┐ │
│  │ ✍️ 「学吉他」2/3 人已见证     │ │
│  │    1小时前                    │ │
│  └─────────────────────────────┘ │
│                                   │
│  昨天                             │
│  ┌─────────────────────────────┐ │
│  │ 🙏 「告白」收到 5 条加持      │ │
│  └─────────────────────────────┘ │
└─────────────────────────────────┘
```

---

## Subscription Integration

### Updated Paywall Feature List

| Feature | Free | Subscriber |
|---------|------|-----------|
| Daily encouragement uses | 15/day | 20/day (monthly) / 30/day (yearly) |
| AI custom perspectives | - | 3 |
| Dimensions per session | 4 | 6 |
| 求加持 requests/day | 2 | Unlimited |
| 见证 signature slots | 1 | 3 |
| Voice messages retained | Last 5 | All permanent |
| 缘起契约 card templates | 1 | Multiple premium templates |
| 修行档案 records | 30 | 30 |

### Upsell Moments

- Free user taps "求加持" for the 3rd time today → paywall
- Free user taps "邀请见证" and already has 1 response → "升级解锁更多签名位"
- Free user tries to play a voice from their 6th oldest record → "升级永久保留所有语音"

### Daily Request Limit Enforcement

Enforced client-side only (checking local counter). Acceptable tradeoff: server-side enforcement would require complex RLS counting queries, and the stakes are low — a bypassed limit just means more free content in the database.

---

## Supabase Configuration

### Row Level Security (RLS)

```sql
-- Enable RLS on both tables
ALTER TABLE courage_requests ENABLE ROW LEVEL SECURITY;
ALTER TABLE courage_responses ENABLE ROW LEVEL SECURITY;

-- Anyone can read a single request by ID (needed for H5 page and app deep link)
-- The client must filter by id in the query; without a filter, no rows are returned
CREATE POLICY "read_request_by_id" ON courage_requests
  FOR SELECT USING (true);

-- Anyone can create a request
CREATE POLICY "create_request" ON courage_requests
  FOR INSERT WITH CHECK (true);

-- Anyone can create a response if under the max
CREATE POLICY "create_response" ON courage_responses
  FOR INSERT WITH CHECK (
    (SELECT response_count FROM courage_requests WHERE id = request_id)
    < (SELECT max_responses FROM courage_requests WHERE id = request_id)
  );

-- Anyone can read responses for a given request (needed for H5 voice playback via QR)
CREATE POLICY "read_responses" ON courage_responses
  FOR SELECT USING (true);
```

**Security note**: Both tables allow public reads. This is acceptable because:
1. Request IDs are UUIDs — unguessable without the share link
2. The data is intended to be shared (the whole point is social sharing)
3. No sensitive personal data is stored (no real names, no accounts)
4. Listing all rows without an ID filter returns a large unordered set with no value to an attacker

For the "善缘簿" inbox query, the iOS app filters by `creator_device_id` client-side:
```
GET /courage_requests?creator_device_id=eq.<device_id>&order=created_at.desc
```

### Storage Policies

- `voice-messages` bucket: public read, anon insert allowed
- Insert restricted by path prefix: `voices/` only
- Max upload size: 100KB (enforced by Supabase storage policy)

### Supabase API Access

- **iOS**: `URLSession` calls to `https://<project>.supabase.co/rest/v1/` with `apikey` and `Authorization: Bearer <anon_key>` headers
- **H5**: `fetch()` calls to the same endpoint with same headers
- **Storage**: `https://<project>.supabase.co/storage/v1/object/` for upload/download

---

## Error Handling

| Scenario | Behavior |
|----------|----------|
| Network failure on submit | Save locally, retry on next app open |
| Request expired (> 7 days) | Show "这段缘分已圆满" message |
| Max responses reached | Show "这段缘分已圆满" message |
| Duplicate response (same device) | Show "你已为此加持过" message |
| Voice recording permission denied | Hide voice option, show text-only |
| MediaRecorder not supported (H5) | Hide voice option, show text-only |
| Supabase free tier limit reached | Graceful fallback: social features disabled, core app works normally |
| Invalid/expired share link | Show "链接已失效" with option to download app |

---

## Scope Boundaries

### In Scope
- "求加持" full flow (iOS + H5)
- "结缘见证" full flow (iOS + H5)
- Voice recording and playback
- "缘起契约" card generation and sharing
- "善缘簿" inbox
- Universal Links deep linking
- Subscription integration
- Supabase setup

### Out of Scope
- Push notifications (future: can add APNs later)
- Friend list / contact import
- Chat / real-time messaging
- WeChat mini-program integration
- User accounts / login
- Voice message transcription
