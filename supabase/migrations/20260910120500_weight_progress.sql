-- weight_entries: from WeightEntry model.
create table public.weight_entries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  date date not null,
  weight_kg double precision not null,
  note text
);

create index weight_entries_user_id_date_idx on public.weight_entries (user_id, date);

alter table public.weight_entries enable row level security;

create policy "weight_entries_select_own" on public.weight_entries
  for select using (auth.uid() = user_id);
create policy "weight_entries_insert_own" on public.weight_entries
  for insert with check (auth.uid() = user_id);
create policy "weight_entries_update_own" on public.weight_entries
  for update using (auth.uid() = user_id);
create policy "weight_entries_delete_own" on public.weight_entries
  for delete using (auth.uid() = user_id);

-- progress_metrics: from ProgressMetric model — generic time-series points
-- (e.g. "exercise:bench_press_1rm") used for strength/progress charts.
create table public.progress_metrics (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  metric_key text not null,
  date date not null,
  value double precision not null,
  unit text not null
);

create index progress_metrics_user_id_key_date_idx
  on public.progress_metrics (user_id, metric_key, date);

alter table public.progress_metrics enable row level security;

create policy "progress_metrics_select_own" on public.progress_metrics
  for select using (auth.uid() = user_id);
create policy "progress_metrics_insert_own" on public.progress_metrics
  for insert with check (auth.uid() = user_id);
create policy "progress_metrics_update_own" on public.progress_metrics
  for update using (auth.uid() = user_id);
create policy "progress_metrics_delete_own" on public.progress_metrics
  for delete using (auth.uid() = user_id);
