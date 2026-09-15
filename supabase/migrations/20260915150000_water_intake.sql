-- water_intake: one row per user per day, incremented as the user logs
-- glasses/bottles of water. A running total rather than a log of individual
-- add-events since the UI only ever needs "how much today", not a history
-- of each sip.
create table public.water_intake (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  date date not null,
  amount_ml integer not null default 0,
  unique (user_id, date)
);

create index water_intake_user_id_date_idx on public.water_intake (user_id, date);

alter table public.water_intake enable row level security;

create policy "water_intake_select_own" on public.water_intake
  for select using (auth.uid() = user_id);
create policy "water_intake_insert_own" on public.water_intake
  for insert with check (auth.uid() = user_id);
create policy "water_intake_update_own" on public.water_intake
  for update using (auth.uid() = user_id);
create policy "water_intake_delete_own" on public.water_intake
  for delete using (auth.uid() = user_id);
