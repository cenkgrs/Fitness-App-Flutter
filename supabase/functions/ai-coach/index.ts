// Single action-routed Edge Function backing lib/shared/ai/ai_workout_coach.dart
// and lib/shared/ai/ai_food_parser.dart. One function/one deploy/one secret
// instead of five, since every action just differs in prompt + JSON schema.
//
// Uses Google Gemini (genuinely free tier — no Cloud Billing account linked,
// so requests are rate-limited rather than charged if the quota is hit).
// GEMINI_API_KEY is a Supabase secret, never shipped in the Flutter client.

// gemini-3.6-flash's free tier is extremely tight (5 requests/day at time of
// writing); flash-lite has a noticeably higher free quota (15/day) for a
// small quality tradeoff — worth it while cost must stay at $0.
const GEMINI_MODEL = "gemini-3.1-flash-lite";
const GEMINI_URL =
  `https://generativelanguage.googleapis.com/v1beta/models/${GEMINI_MODEL}:generateContent`;

const CORS_HEADERS = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

function jsonResponse(body: unknown, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...CORS_HEADERS, "Content-Type": "application/json" },
  });
}

/** Decodes the `sub` (user id) claim from the already-platform-verified JWT
 * on the Authorization header — Supabase verifies the signature before this
 * function even runs, so a raw payload decode here is enough. */
function userIdFromAuthHeader(authHeader: string | null): string | null {
  if (!authHeader?.startsWith("Bearer ")) return null;
  try {
    const token = authHeader.slice("Bearer ".length);
    const payload = token.split(".")[1];
    const decoded = JSON.parse(atob(payload.replace(/-/g, "+").replace(/_/g, "/")));
    return decoded.sub ?? null;
  } catch {
    return null;
  }
}

/** Off by default: with no working subscription system yet (see project
 * plan, Phase 4), every authenticated caller is allowed. Setting this env
 * var to 'true' later turns on real gating without a code rewrite. */
async function checkEntitlement(userId: string | null): Promise<boolean> {
  if (Deno.env.get("REQUIRE_SUBSCRIPTION") !== "true") return true;
  if (!userId) return false;

  const supabaseUrl = Deno.env.get("SUPABASE_URL");
  const serviceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
  const res = await fetch(
    `${supabaseUrl}/rest/v1/subscriptions?user_id=eq.${userId}&select=is_premium`,
    { headers: { apikey: serviceRoleKey!, Authorization: `Bearer ${serviceRoleKey}` } },
  );
  const rows = await res.json();
  return rows[0]?.is_premium === true;
}

async function callGemini(prompt: string, schema: Record<string, unknown>) {
  const apiKey = Deno.env.get("GEMINI_API_KEY");
  if (!apiKey) throw new Error("GEMINI_API_KEY not configured");

  const res = await fetch(`${GEMINI_URL}?key=${apiKey}`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      contents: [{ parts: [{ text: prompt }] }],
      generationConfig: {
        responseMimeType: "application/json",
        responseSchema: schema,
      },
    }),
  });

  if (!res.ok) {
    throw new Error(`Gemini request failed: ${res.status} ${await res.text()}`);
  }
  const data = await res.json();
  const text = data.candidates?.[0]?.content?.parts?.[0]?.text;
  if (!text) throw new Error("Gemini returned no content");
  return JSON.parse(text);
}

// ---- Per-action prompt + schema -------------------------------------------

const EXERCISE_SET_SCHEMA = {
  type: "OBJECT",
  properties: {
    setNumber: { type: "INTEGER" },
    targetReps: { type: "INTEGER" },
    targetWeightKg: { type: "NUMBER" },
    isWarmup: { type: "BOOLEAN" },
  },
  required: ["setNumber", "targetReps", "targetWeightKg", "isWarmup"],
};

const WORKOUT_PLAN_SCHEMA = {
  type: "OBJECT",
  properties: {
    name: { type: "STRING" },
    days: {
      type: "ARRAY",
      items: {
        type: "OBJECT",
        properties: {
          name: { type: "STRING" },
          dayOfWeek: { type: "INTEGER", description: "1 = Monday .. 7 = Sunday" },
          isRestDay: { type: "BOOLEAN" },
          estimatedDurationMinutes: { type: "INTEGER" },
          exercises: {
            type: "ARRAY",
            items: {
              type: "OBJECT",
              properties: {
                name: { type: "STRING" },
                muscleGroup: {
                  type: "STRING",
                  enum: ["chest", "back", "shoulders", "biceps", "triceps", "legs", "glutes", "core", "cardio", "fullBody"],
                },
                equipment: {
                  type: "ARRAY",
                  items: {
                    type: "STRING",
                    enum: ["barbell", "dumbbell", "bench", "cable", "machine", "resistanceBand", "bodyweight", "kettlebell"],
                  },
                },
                instructions: { type: "STRING" },
                restDurationSeconds: { type: "INTEGER" },
                sets: { type: "ARRAY", items: EXERCISE_SET_SCHEMA },
              },
              required: ["name", "muscleGroup", "equipment", "instructions", "restDurationSeconds", "sets"],
            },
          },
        },
        required: ["name", "dayOfWeek", "isRestDay", "estimatedDurationMinutes", "exercises"],
      },
    },
  },
  required: ["name", "days"],
};

const MEAL_ENTRIES_SCHEMA = {
  type: "OBJECT",
  properties: {
    entries: {
      type: "ARRAY",
      items: {
        type: "OBJECT",
        properties: {
          name: { type: "STRING" },
          quantityGrams: { type: "NUMBER" },
          calories: { type: "NUMBER" },
          proteinG: { type: "NUMBER" },
          carbsG: { type: "NUMBER" },
          fatG: { type: "NUMBER" },
        },
        required: ["name", "quantityGrams", "calories", "proteinG", "carbsG", "fatG"],
      },
    },
  },
  required: ["entries"],
};

const TEXT_SCHEMA = {
  type: "OBJECT",
  properties: { text: { type: "STRING" } },
  required: ["text"],
};

async function handleAction(action: string, payload: Record<string, unknown>) {
  switch (action) {
    case "generate_workout_plan": {
      const prompt =
        `You are a certified strength & conditioning coach. Generate a 7-day ` +
        `weekly workout program (rest days included) for this user profile: ` +
        `${JSON.stringify(payload.profile)}. Recent body-weight history: ` +
        `${JSON.stringify(payload.recentWeightEntries ?? [])}. Tailor exercise ` +
        `selection to their available equipment, fitness level, workout ` +
        `location, days per week, and session duration. ` +
        `On every non-rest day, include a FULL session: 4-6 exercises ` +
        `covering the day's target muscle groups from different angles ` +
        `(e.g. a "Back and Biceps" day needs both a horizontal pull like a ` +
        `row and a vertical pull like a pulldown/pull-up, plus isolation ` +
        `work — never just one exercise per muscle group). Each exercise ` +
        `needs 3-4 working sets (plus a warm-up set for compound lifts), ` +
        `with rep ranges matching the user's primary goal (strength: ` +
        `4-6 reps, hypertrophy/build muscle: 8-12 reps, fat loss/endurance: ` +
        `12-15 reps). The exercises list must total realistic volume for ` +
        `the stated session duration — do not return a day with only 1-2 ` +
        `exercises. Respond in the user's language if evident from their ` +
        `profile, otherwise Turkish.`;
      return await callGemini(prompt, WORKOUT_PLAN_SCHEMA);
    }

    case "recommend_next_weight": {
      const prompt =
        `Progressive overload coach. Given the recent completed sets ` +
        `${JSON.stringify(payload.recentSets)} and the current baseline target ` +
        `${JSON.stringify(payload.currentTarget)}, recommend the next set's ` +
        `target reps/weight. Increase load only if the lifter met or beat the ` +
        `target reps on all recent sets; otherwise repeat or slightly reduce.`;
      return await callGemini(prompt, EXERCISE_SET_SCHEMA);
    }

    case "analyze_workout": {
      const prompt =
        `Analyze this completed workout session and give a short (2-3 ` +
        `sentence), encouraging, specific summary covering load management ` +
        `and any notable personal records: ${JSON.stringify(payload.session)}. ` +
        `Respond in Turkish.`;
      return await callGemini(prompt, TEXT_SCHEMA);
    }

    case "generate_nutrition_suggestion": {
      const prompt =
        `Given this user's recent daily nutrition logs vs. their targets: ` +
        `${JSON.stringify(payload.recentDays)}, give one short, actionable ` +
        `suggestion (e.g. "increase protein by 20g") in 1-2 sentences, in Turkish.`;
      return await callGemini(prompt, TEXT_SCHEMA);
    }

    case "parse_meal_text": {
      const prompt =
        `Parse this free-text meal description into structured food entries ` +
        `with estimated nutrition per item: "${payload.text}". Use reasonable ` +
        `standard nutrition estimates for the described quantities. Text may ` +
        `be in Turkish or English.`;
      return await callGemini(prompt, MEAL_ENTRIES_SCHEMA);
    }

    default:
      throw new Error(`Unknown action: ${action}`);
  }
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: CORS_HEADERS });

  try {
    const { action, ...payload } = await req.json();
    const userId = userIdFromAuthHeader(req.headers.get("Authorization"));

    if (!(await checkEntitlement(userId))) {
      return jsonResponse({ error: "Subscription required" }, 403);
    }

    const result = await handleAction(action, payload);
    return jsonResponse(result);
  } catch (err) {
    return jsonResponse({ error: String(err) }, 500);
  }
});
