-- subscriptions: server-side cache of RevenueCat entitlement state. Written
-- only by a RevenueCat webhook Edge Function (service_role), never by the
-- client, so a paid feature (e.g. the ai-coach Edge Function in Phase 3)
-- can trust this table instead of a client-supplied "is premium" flag.
create table public.subscriptions (
  user_id uuid primary key references auth.users (id) on delete cascade,
  is_premium boolean not null default false,
  product_id text,
  expires_at timestamptz,
  updated_at timestamptz not null default now()
);

create trigger subscriptions_set_updated_at
  before update on public.subscriptions
  for each row execute function public.set_updated_at();

alter table public.subscriptions enable row level security;

-- Read-only for the owning user; no insert/update/delete policy for
-- clients — only service_role (which bypasses RLS) may write.
create policy "subscriptions_select_own" on public.subscriptions
  for select using (auth.uid() = user_id);
