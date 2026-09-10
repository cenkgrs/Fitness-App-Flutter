-- foods: shared catalog (Food model has no user_id — it's looked up by all
-- users, not owned by one). Writable only via service_role (e.g. an admin
-- seeding/import script or an Edge Function), never directly by clients.
create table public.foods (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  brand text,
  calories_per_100g double precision not null,
  protein_per_100g double precision not null,
  carbs_per_100g double precision not null,
  fat_per_100g double precision not null
);

alter table public.foods enable row level security;

create policy "foods_select_all_authenticated" on public.foods
  for select using (auth.role() = 'authenticated');

-- meals: from Meal model. entries stay JSONB, mirroring MealEntry.toJson()
-- (quick-add entries have no catalog row to join against, so normalizing
-- entries into their own table buys nothing here).
create table public.meals (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  date date not null,
  type text not null check (type in ('breakfast', 'lunch', 'dinner', 'snack')),
  entries jsonb not null default '[]'
);

create index meals_user_id_date_idx on public.meals (user_id, date);

alter table public.meals enable row level security;

create policy "meals_select_own" on public.meals
  for select using (auth.uid() = user_id);
create policy "meals_insert_own" on public.meals
  for insert with check (auth.uid() = user_id);
create policy "meals_update_own" on public.meals
  for update using (auth.uid() = user_id);
create policy "meals_delete_own" on public.meals
  for delete using (auth.uid() = user_id);
