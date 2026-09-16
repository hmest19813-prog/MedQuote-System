// Admin-only user creation. Replaces the old client-side auth.signUp() flow
// (which relied on public sign-ups being enabled — a hole anyone on the
// internet could walk through). This function runs server-side with the
// service_role key, and only proceeds if the caller's own JWT belongs to
// a profile with role = 'admin'. Public sign-ups can stay disabled in
// Supabase Auth settings without breaking "add employee" in the app.

import { createClient } from "npm:@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

function jsonResponse(body: unknown, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, "Content-Type": "application/json" },
  });
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });
  if (req.method !== "POST") return jsonResponse({ error: "method_not_allowed" }, 405);

  // Bound to the caller's own JWT — RLS applies, so this can only ever
  // read the caller's own profile row.
  const callerClient = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_ANON_KEY")!,
    { global: { headers: { Authorization: req.headers.get("Authorization") ?? "" } } },
  );

  const { data: { user }, error: authError } = await callerClient.auth.getUser();
  if (authError || !user) return jsonResponse({ error: "unauthorized" }, 401);

  const { data: callerProfile, error: profileErr } = await callerClient
    .from("profiles")
    .select("role")
    .eq("id", user.id)
    .maybeSingle();
  if (profileErr || callerProfile?.role !== "admin") {
    return jsonResponse({ error: "forbidden" }, 403);
  }

  let body: {
    email?: string;
    password?: string;
    full_name?: string;
    username?: string;
    role?: string;
    is_active?: boolean;
    permissions?: Record<string, boolean>;
  };
  try {
    body = await req.json();
  } catch {
    return jsonResponse({ error: "طلب غير صالح" });
  }

  const email = (body.email ?? "").trim().toLowerCase();
  const password = body.password ?? "";
  const fullName = (body.full_name ?? "").trim();

  if (!email || !fullName) return jsonResponse({ error: "البريد الإلكتروني والاسم الكامل مطلوبان" });
  if (password.length < 6) return jsonResponse({ error: "كلمة المرور 6 أحرف على الأقل" });

  // service_role — never sent to the browser, only used here inside the function.
  const adminClient = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
  );

  const { data: created, error: createErr } = await adminClient.auth.admin.createUser({
    email,
    password,
    email_confirm: true,
    user_metadata: { full_name: fullName },
  });
  if (createErr || !created?.user?.id) {
    const msg = createErr?.message?.includes("already been registered")
      ? "البريد الإلكتروني مستخدم مسبقاً"
      : (createErr?.message ?? "فشل إنشاء المستخدم");
    return jsonResponse({ error: msg });
  }

  const { error: setupErr } = await adminClient.rpc("setup_new_user_profile", {
    p_user_id: created.user.id,
    p_email: email,
    p_full_name: fullName,
    p_username: (body.username ?? "").trim().toLowerCase(),
    p_role: body.role ?? "employee",
    p_is_active: body.is_active ?? true,
    p_permissions: body.permissions ?? {},
  });
  if (setupErr) {
    return jsonResponse({ error: setupErr.message });
  }

  return jsonResponse({ success: true, user_id: created.user.id });
});
