-- ai_chat_messages: persisted AI coach chat history. The Edge Function
-- (service role) is the only writer — it inserts both the user's message
-- and the assistant's reply together so the two never get out of sync —
-- but RLS still lets each user read their own history directly from the
-- client for a fast, realtime-capable chat screen.
create table public.ai_chat_messages (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  role text not null check (role in ('user', 'assistant')),
  content text not null,
  created_at timestamptz not null default now()
);

create index ai_chat_messages_user_id_created_at_idx
  on public.ai_chat_messages (user_id, created_at);

alter table public.ai_chat_messages enable row level security;

create policy "ai_chat_messages_select_own" on public.ai_chat_messages
  for select using (auth.uid() = user_id);
