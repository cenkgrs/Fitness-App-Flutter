-- Columns added to the Dart models after their original migrations were
-- written: `onboarding_complete` (UserProfileRepository) and
-- `food_search_country` (nutrition country filter, added mid-session).
alter table public.profiles
  add column onboarding_complete boolean not null default false;

alter table public.app_settings
  add column food_search_country text not null default '';
