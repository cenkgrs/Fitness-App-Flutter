-- goals: from Goal model. A user may have multiple goals over time; the
-- app currently treats "most recent" as active, so no separate is_active
-- flag is introduced — callers order by created_at desc.

create table public.goals (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  type text not null
    check (type in ('loseWeight', 'gainWeight', 'buildMuscle', 'loseFat', 'maintainFitness')),
  current_weight_kg double precision,
  target_weight_kg double precision,
  weekly_workout_target integer not null default 3,
  daily_calorie_target integer not null default 2000,
  daily_protein_target integer not null default 120,
  daily_carbs_target integer not null default 220,
  daily_fat_target integer not null default 65,
  is_manual_nutrition boolean not null default false,
  created_at timestamptz not null default now()
);

create index goals_user_id_created_at_idx on public.goals (user_id, created_at desc);

alter table public.goals enable row level security;

create policy "goals_select_own" on public.goals
  for select using (auth.uid() = user_id);

create policy "goals_insert_own" on public.goals
  for insert with check (auth.uid() = user_id);

create policy "goals_update_own" on public.goals
  for update using (auth.uid() = user_id);

create policy "goals_delete_own" on public.goals
  for delete using (auth.uid() = user_id);
