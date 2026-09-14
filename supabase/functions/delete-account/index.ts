// Deletes the calling user's auth.users row via the Supabase Admin API.
// Every user-data table has `on delete cascade` back to auth.users(id) (see
// supabase/migrations/*), so this single call also removes the user's
// profile, goals, workouts, nutrition, progress and settings rows.
//
// Requires SUPABASE_SERVICE_ROLE_KEY as a secret — never shipped client-side.
// Only deletes the account belonging to the JWT making the request (never a
// caller-supplied id), so a valid session is the only thing needed to use it.

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

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: CORS_HEADERS });

  try {
    const userId = userIdFromAuthHeader(req.headers.get("Authorization"));
    if (!userId) return jsonResponse({ error: "Not authenticated" }, 401);

    const supabaseUrl = Deno.env.get("SUPABASE_URL");
    const serviceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");

    const res = await fetch(`${supabaseUrl}/auth/v1/admin/users/${userId}`, {
      method: "DELETE",
      headers: {
        apikey: serviceRoleKey!,
        Authorization: `Bearer ${serviceRoleKey}`,
      },
    });

    if (!res.ok) {
      return jsonResponse({ error: `Admin delete failed: ${res.status} ${await res.text()}` }, 500);
    }

    return jsonResponse({ success: true });
  } catch (err) {
    return jsonResponse({ error: String(err) }, 500);
  }
});
