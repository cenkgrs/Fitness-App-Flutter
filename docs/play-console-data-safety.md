# Play Console — Data Safety Form Answers (THRIVE+)

Use this as the answer key while filling in Play Console → App content → Data safety.

## Does your app collect or share any of the required user data types?
**Yes.**

## Is all user data collected by your app encrypted in transit?
**Yes** (HTTPS to Supabase, Google Gemini, Open Food Facts, AdMob, RevenueCat).

## Do you provide a way for users to request that their data is deleted?
**Yes** — in-app: Settings → Delete Account (immediate, permanent).

---

## Data types to declare

### Personal info
- **Name** — Collected. Purpose: App functionality (profile, personalization). Not shared. Optional (user enters it, can leave blank).
- **Email address** — Collected. Purpose: Account management, App functionality. Not shared. Required.
- **User IDs** — Collected. Purpose: Account management, App functionality. Not shared. Required.

### Health and fitness
- **Fitness info** (workouts, sets/reps/weights, activity level) — Collected. Purpose: App functionality, Analytics (your own, not third-party ad analytics). Not shared. Required.
- **Health info** (weight, height, body measurements, body-fat estimate) — Collected. Purpose: App functionality. Not shared. Required.

### App activity
- **App interactions** — Collected (standard: which features are used, e.g. workout completion) — Purpose: App functionality, Analytics. Declare only if you add an analytics SDK; skip if you have none yet.

### Financial info (only if/when subscriptions are live)
- **Purchase history** — Collected via Google Play Billing / RevenueCat. Purpose: App functionality (subscription entitlement). Shared with RevenueCat (service provider) — mark "shared" once RevenueCat is integrated. Not applicable yet if you haven't shipped subscriptions.

### Device or other identifiers (only if/when AdMob is live)
- **Device or other IDs** — Collected via Google AdMob (advertising ID). Purpose: Advertising or marketing. Shared with Google AdMob. Not applicable yet if you haven't shipped ads.

---

## "Data collected" vs "Data shared" — the distinction Play Console asks for

- **Collected**: leaves the user's device to your backend (Supabase) or an API you call (Gemini, Open Food Facts). This is everything above.
- **Shared**: handed to a separate company for *their own* purposes (not just processing on your behalf). Supabase and Gemini are processors acting on your instructions under their API/DPA terms — Play Console generally does **not** require marking these as "shared" the way it does for AdMob (which uses data for its own ad-targeting business) or RevenueCat once real subscriptions are wired up. Mark AdMob/RevenueCat as "shared" only once those integrations actually ship (tasks #41/#42, still pending).

## Notes for right now (pre-ads, pre-subscriptions)
Since ads and subscriptions aren't wired in yet, you can safely file the Data Safety form today declaring only: Name, Email, User IDs, Fitness info, Health info — all "collected, not shared, encrypted in transit, deletable in-app." Come back and add the AdMob/RevenueCat sections to this form once those two tasks ship, since Play Console flags a data-safety mismatch if your form doesn't match what the shipped app actually does.
