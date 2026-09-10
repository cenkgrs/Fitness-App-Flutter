-- Extends the Phase 1 `foods` catalog to support caching results pulled
-- live from an external food database (Open Food Facts), and lets
-- SupabaseNutritionRepository upsert meals by (user_id, date, type),
-- mirroring the key scheme LocalNutritionRepository already used in Hive.

alter table public.foods
  add column barcode text unique,
  add column source text not null default 'user';

-- The catalog is populated by the app itself (live search results +
-- user-added quick foods), not a separate admin/seed step, so any
-- authenticated client may insert into it. Update is also needed for
-- upsert-on-barcode-conflict to refresh a previously-cached product.
create policy "foods_insert_authenticated" on public.foods
  for insert with check (auth.role() = 'authenticated');

create policy "foods_update_authenticated" on public.foods
  for update using (auth.role() = 'authenticated');

alter table public.meals
  add constraint meals_user_date_type_unique unique (user_id, date, type);
