-- app_settings: from AppSettings model. Currently a single-device local
-- singleton with no user_id; now keyed per-user, one row each (enforced by
-- primary key doubling as the FK).
create table public.app_settings (
  user_id uuid primary key references auth.users (id) on delete cascade,
  weight_unit text not null default 'kg' check (weight_unit in ('kg', 'lbs')),
  distance_unit text not null default 'km' check (distance_unit in ('km', 'miles')),
  default_rest_time_seconds integer not null default 90,
  auto_start_next_set boolean not null default false,
  sound_enabled boolean not null default true,
  haptics_enabled boolean not null default true,
  countdown_beep_enabled boolean not null default true,
  notifications_enabled boolean not null default true,
  language_code text not null default 'en',
  use_auto_nutrition_calculation boolean not null default true,
  updated_at timestamptz not null default now()
);

create trigger app_settings_set_updated_at
  before update on public.app_settings
  for each row execute function public.set_updated_at();

alter table public.app_settings enable row level security;

create policy "app_settings_select_own" on public.app_settings
  for select using (auth.uid() = user_id);
create policy "app_settings_insert_own" on public.app_settings
  for insert with check (auth.uid() = user_id);
create policy "app_settings_update_own" on public.app_settings
  for update using (auth.uid() = user_id);
