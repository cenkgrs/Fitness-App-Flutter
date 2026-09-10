-- workout_programs / workout_sessions: from WorkoutProgram and
-- WorkoutSession models. Days/exercises/sets stay as JSONB mirroring the
-- existing Dart toJson()/fromJson() shapes exactly (WorkoutDay -> Exercise
-- -> ExerciseSet is generated/embedded per-program, not a shared catalog
-- referenced by id) — this keeps the Supabase repository a near 1:1 mapping
-- of the current Hive one instead of a large normalization rewrite. Revisit
-- if a searchable shared exercise catalog becomes a real requirement.

create table public.workout_programs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  name text not null,
  days jsonb not null default '[]',
  created_at timestamptz not null default now()
);

create index workout_programs_user_id_idx on public.workout_programs (user_id);

alter table public.workout_programs enable row level security;

create policy "workout_programs_select_own" on public.workout_programs
  for select using (auth.uid() = user_id);
create policy "workout_programs_insert_own" on public.workout_programs
  for insert with check (auth.uid() = user_id);
create policy "workout_programs_update_own" on public.workout_programs
  for update using (auth.uid() = user_id);
create policy "workout_programs_delete_own" on public.workout_programs
  for delete using (auth.uid() = user_id);

create table public.workout_sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  workout_day_id text not null,
  workout_day_name text not null,
  status text not null default 'notStarted'
    check (status in ('notStarted', 'inProgress', 'paused', 'completed', 'cancelled')),
  started_at timestamptz not null default now(),
  completed_at timestamptz,
  sets jsonb not null default '[]',
  personal_record_set_ids text[] not null default '{}'
);

create index workout_sessions_user_id_started_at_idx
  on public.workout_sessions (user_id, started_at desc);

alter table public.workout_sessions enable row level security;

create policy "workout_sessions_select_own" on public.workout_sessions
  for select using (auth.uid() = user_id);
create policy "workout_sessions_insert_own" on public.workout_sessions
  for insert with check (auth.uid() = user_id);
create policy "workout_sessions_update_own" on public.workout_sessions
  for update using (auth.uid() = user_id);
create policy "workout_sessions_delete_own" on public.workout_sessions
  for delete using (auth.uid() = user_id);
