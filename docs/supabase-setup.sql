-- ============================================
-- ZenChoice Social Features — Supabase Setup
-- Run this in the Supabase SQL Editor
-- ============================================

-- 1. Profiles table
CREATE TABLE profiles (
    id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    nickname text NOT NULL,
    account_id text UNIQUE,
    avatar_url text,
    created_at timestamptz DEFAULT now()
);

-- 2. Courage Requests (now using user_id instead of device_id)
CREATE TABLE courage_requests (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    type text NOT NULL CHECK (type IN ('encourage', 'witness')),
    wish text NOT NULL,
    ai_summary text,
    creator_user_id uuid NOT NULL REFERENCES auth.users(id),
    max_responses int NOT NULL DEFAULT 1,
    response_count int NOT NULL DEFAULT 0,
    expires_at timestamptz DEFAULT (now() + interval '7 days'),
    created_at timestamptz DEFAULT now()
);

-- 3. Courage Responses
CREATE TABLE courage_responses (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    request_id uuid NOT NULL REFERENCES courage_requests(id) ON DELETE CASCADE,
    content text NOT NULL,
    perspective text,
    emoji_stamp text,
    voice_url text,
    is_anonymous bool NOT NULL DEFAULT true,
    sender_name text,
    sender_user_id uuid NOT NULL REFERENCES auth.users(id),
    created_at timestamptz DEFAULT now(),
    UNIQUE(request_id, sender_user_id)
);

-- 4. Bonds (Friend Connections)
CREATE TABLE bonds (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    user_a uuid NOT NULL REFERENCES auth.users(id),
    user_b uuid NOT NULL REFERENCES auth.users(id),
    resonance_count int NOT NULL DEFAULT 0,
    created_at timestamptz DEFAULT now(),
    UNIQUE(user_a, user_b),
    CHECK (user_a < user_b)  -- enforce ordering to prevent duplicate pairs
);

-- 5. Anonymous Encouragements
CREATE TABLE anonymous_encouragements (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    sender_user_id uuid NOT NULL REFERENCES auth.users(id),
    receiver_user_id uuid NOT NULL REFERENCES auth.users(id),
    content text NOT NULL,
    is_revealed bool NOT NULL DEFAULT false,
    guessed_correctly bool,
    created_at timestamptz DEFAULT now()
);

-- 6. Friend Requests
CREATE TABLE friend_requests (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    from_user_id uuid NOT NULL REFERENCES auth.users(id),
    to_user_id uuid NOT NULL REFERENCES auth.users(id),
    status text NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'rejected')),
    created_at timestamptz DEFAULT now(),
    UNIQUE(from_user_id, to_user_id)
);

-- 7. Indexes
CREATE INDEX idx_profiles_account_id ON profiles(account_id);
CREATE INDEX idx_requests_creator ON courage_requests(creator_user_id);
CREATE INDEX idx_requests_created ON courage_requests(created_at DESC);
CREATE INDEX idx_responses_request ON courage_responses(request_id);
CREATE INDEX idx_bonds_user_a ON bonds(user_a);
CREATE INDEX idx_bonds_user_b ON bonds(user_b);
CREATE INDEX idx_anon_receiver ON anonymous_encouragements(receiver_user_id, is_revealed);
CREATE INDEX idx_friend_requests_to ON friend_requests(to_user_id, status);
CREATE INDEX idx_friend_requests_from ON friend_requests(from_user_id);

-- 7. Auto-increment response_count trigger
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

-- 8. Increment resonance_count RPC
CREATE OR REPLACE FUNCTION increment_resonance(a_id uuid, b_id uuid)
RETURNS void AS $$
BEGIN
    UPDATE bonds
    SET resonance_count = resonance_count + 1
    WHERE user_a = a_id AND user_b = b_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 9. Enable RLS
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE courage_requests ENABLE ROW LEVEL SECURITY;
ALTER TABLE courage_responses ENABLE ROW LEVEL SECURITY;
ALTER TABLE bonds ENABLE ROW LEVEL SECURITY;
ALTER TABLE anonymous_encouragements ENABLE ROW LEVEL SECURITY;
ALTER TABLE friend_requests ENABLE ROW LEVEL SECURITY;

-- 10. RLS Policies

-- Profiles: anyone can read, users can insert/update their own
CREATE POLICY "profiles_read" ON profiles FOR SELECT USING (true);
CREATE POLICY "profiles_insert" ON profiles FOR INSERT WITH CHECK (auth.uid() = id);
CREATE POLICY "profiles_update" ON profiles FOR UPDATE USING (auth.uid() = id);

-- Courage Requests
CREATE POLICY "read_requests" ON courage_requests FOR SELECT USING (true);
CREATE POLICY "create_request" ON courage_requests FOR INSERT WITH CHECK (auth.uid() = creator_user_id);

-- Courage Responses
CREATE POLICY "read_responses" ON courage_responses FOR SELECT USING (true);
CREATE POLICY "create_response" ON courage_responses
    FOR INSERT WITH CHECK (
        auth.uid() = sender_user_id
        AND (SELECT response_count FROM courage_requests WHERE id = request_id)
            < (SELECT max_responses FROM courage_requests WHERE id = request_id)
    );

-- Bonds: users can read their own bonds, create bonds involving themselves
CREATE POLICY "bonds_read" ON bonds FOR SELECT
    USING (auth.uid() = user_a OR auth.uid() = user_b);
CREATE POLICY "bonds_insert" ON bonds FOR INSERT
    WITH CHECK (auth.uid() = user_a OR auth.uid() = user_b);

-- Anonymous Encouragements: sender can insert, receiver can read/update their own
CREATE POLICY "anon_insert" ON anonymous_encouragements
    FOR INSERT WITH CHECK (auth.uid() = sender_user_id);
CREATE POLICY "anon_read" ON anonymous_encouragements
    FOR SELECT USING (auth.uid() = receiver_user_id OR auth.uid() = sender_user_id);
CREATE POLICY "anon_update" ON anonymous_encouragements
    FOR UPDATE USING (auth.uid() = receiver_user_id);

-- Friend Requests: sender can insert, receiver can read/update
CREATE POLICY "friend_req_insert" ON friend_requests
    FOR INSERT WITH CHECK (auth.uid() = from_user_id);
CREATE POLICY "friend_req_read" ON friend_requests
    FOR SELECT USING (auth.uid() = from_user_id OR auth.uid() = to_user_id);
CREATE POLICY "friend_req_update" ON friend_requests
    FOR UPDATE USING (auth.uid() = to_user_id);

-- 12. Create storage bucket (run via Supabase Dashboard > Storage > New Bucket)
-- Name: voice-messages
-- Public: true
-- File size limit: 100KB
-- Allowed MIME types: audio/mp4, audio/m4a, audio/mpeg, audio/webm
