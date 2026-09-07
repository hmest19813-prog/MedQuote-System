// Smart Assistant - first version (Q&A only, no write permissions on the database)
// No "tools" are defined here on purpose - so the model physically cannot execute
// any action even if the user asks. Real execution permissions will be added later
// as a separate step, with explicit approval each time.
// NOTE: the Arabic system prompt below is stored as base64 to avoid RTL/bidi
// text corruption when copy-pasting through terminals or web editors.

import Anthropic from "npm:@anthropic-ai/sdk@0.32.1";
import { createClient } from "npm:@supabase/supabase-js@2";

const anthropic = new Anthropic({ apiKey: Deno.env.get("ANTHROPIC_API_KEY") });

const MODEL = "claude-sonnet-5";

const SYSTEM_PROMPT_B64 =
  "2KPZhtiqICLYp9mE2YXYs9in2LnYryDYp9mE2LDZg9mKIiDYr9in2K7ZhCDZhti42KfZhSBIYXlhdCBFUlAgKNmG2LjYp9mFINi52LHZiNi2INij2LPYudin2LEg2YjZhdiu2LLZiNmGKS4KLSDYrNin2YjYqCDYqNin2YTYudix2KjZiiDYr9in2KbZhdin2Ysg2KXZhNinINil2LDYpyDZg9iq2Kgg2KfZhNmF2LPYqtiu2K/ZhSDYqNmE2LrYqSDYqtin2YbZitipLgotINmH2KfZiiDZhtiz2K7YqSDYo9mI2YTZiSDZhNmE2KPYs9im2YTYqSDZiNin2YTZhdiz2KfYudiv2Kkg2KfZhNi52KfZhdipINmB2YLYtyDigJQg2YXYpyDYudmG2K/ZgyDYo9mKINi12YTYp9it2YrYqSDZhNiq2YbZgdmK2LAg2KPZiiDYpdis2LHYp9ihINmB2LnZhNmKINi52YTZiSDYp9mE2YbYuNin2YUgKNmF2Kcg2KrZgtiv2LEg2KrYttmK2YEg2YXYp9iv2KnYjCDZiNmE2Kcg2KrZhti02KYg2LnYsdi2INiz2LnYsdiMINmI2YTYpyDYqti52K/ZhCDYo9mKINio2YrYp9mG2KfYqikg2YTYo9mG2Ycg2YXYpyDZgdmKINij2Yog2KPYr9mI2KfYqiDZhdiq2KfYrdipINmE2YMg2KjZh9in2Yog2KfZhNmF2LHYrdmE2KkuCi0g2YTZiCDYp9mE2YXYs9iq2K7Yr9mFINi32YTYqCDZhdmG2YMg2KrZhtmB2LAg2KXYrNix2KfYoSDZgdi52YTZitiMINmI2LbYrdmE2Ycg2KjZhNi32YEg2KXZhtmHINmH2KfZiiDYp9mE2YXZitiy2Kkg2YLZitivINin2YTYqti32YjZitixINmI2YLYsdmK2KjYp9mLINix2K0g2KrZg9mI2YYg2YXYqtin2K3YqSDYqNi52K8g2YXZiNin2YHZgtiq2Ycg2LnZhNmJINmD2YQg2K7Yt9mI2KkuCi0g2K7ZhNmK2YMg2YXYrtiq2LXYsSDZiNmF2KjYp9i02LEg2YjZiNiv2YjYr9iMINmI2YXYpyDYqtiu2KrZhNmCINmF2LnZhNmI2YXYp9iqINmF2Kcg2KXZhNmH2Kcg2KPYs9in2LMuCg==";
const SYSTEM_PROMPT = new TextDecoder().decode(
  Uint8Array.from(atob(SYSTEM_PROMPT_B64), (c) => c.charCodeAt(0)),
);

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

  // Caller must be a logged-in user of the system (same auth as the app itself)
  const supabase = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_ANON_KEY")!,
    { global: { headers: { Authorization: req.headers.get("Authorization") ?? "" } } },
  );
  const { data: { user }, error: authError } = await supabase.auth.getUser();
  if (authError || !user) return jsonResponse({ error: "unauthorized" }, 401);

  let body: { message?: string; history?: { role: string; content: string }[] };
  try {
    body = await req.json();
  } catch {
    return jsonResponse({ error: "invalid_json" }, 400);
  }

  const message = (body.message ?? "").trim();
  if (!message) return jsonResponse({ error: "missing_message" }, 400);
  if (message.length > 2000) return jsonResponse({ error: "message_too_long" }, 400);

  // Only the last 10 turns of history, and only well-formed user/assistant entries
  const history = (Array.isArray(body.history) ? body.history : [])
    .filter((m) => m && (m.role === "user" || m.role === "assistant") && typeof m.content === "string")
    .slice(-10);

  try {
    const response = await anthropic.messages.create({
      model: MODEL,
      max_tokens: 1024,
      system: SYSTEM_PROMPT,
      output_config: { effort: "low" },
      messages: [...history, { role: "user", content: message }],
    });

    const textBlock = response.content.find((b) => b.type === "text");
    const reply = textBlock?.type === "text" ? textBlock.text : "";

    return jsonResponse({ reply });
  } catch (err) {
    console.error("ai-assistant error:", err);
    return jsonResponse({ error: "ai_error" }, 502);
  }
});
