-- profiles: merges AppUser (auth identity) display fields with UserProfile
-- (fitness onboarding data) into one 1:1 row per auth.users id, matching how
-- the Flutter repositories look the two up together in practice.

create table public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  display_name text,
  photo_url text,
  name text not null default '',
  age integer not null default 25,
  height_cm double precision not null default 175,
  weight_kg double precision not null default 75,
  gender text not null default 'unspecified'
    check (gender in ('male', 'female', 'unspecified')),
  fitness_level text not null default 'beginner'
    check (fitness_level in ('beginner', 'intermediate', 'advanced')),
  primary_goal text not null default 'buildMuscle'
    check (primary_goal in ('loseWeight', 'gainWeight', 'buildMuscle', 'loseFat', 'maintainFitness')),
  target_weight_kg double precision not null default 75,
  workout_days_per_week integer not null default 3,
  workout_duration_minutes integer not null default 45,
  workout_location text not null default 'gym'
    check (workout_location in ('gym', 'home', 'both')),
  available_equipment text[] not null default '{}',
  activity_level text not null default 'moderatelyActive'
    check (activity_level in ('sedentary', 'moderatelyActive', 'veryActive')),
  nutrition_preference text not null default 'standard'
    check (nutrition_preference in ('standard', 'highProtein', 'keto', 'vegetarian', 'vegan')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create trigger profiles_set_updated_at
  before update on public.profiles
  for each row execute function public.set_updated_at();

alter table public.profiles enable row level security;

create policy "profiles_select_own" on public.profiles
  for select using (auth.uid() = id);

create policy "profiles_insert_own" on public.profiles
  for insert with check (auth.uid() = id);

create policy "profiles_update_own" on public.profiles
  for update using (auth.uid() = id);

-- Auto-create a profile row the moment a new auth user is created, so the
-- app never has to handle a "no profile yet" race after sign-up.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, display_name, photo_url)
  values (
    new.id,
    new.raw_user_meta_data ->> 'full_name',
    new.raw_user_meta_data ->> 'avatar_url'
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();
