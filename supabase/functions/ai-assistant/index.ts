// Smart Assistant - v3: broader read-only lookups (quotes + line items, orders,
// customers, catalog, stats) via Claude tool use, tuned for thorough answers.
// Still NO write access - every query goes through the caller's own JWT, so
// RLS applies exactly as it would if the logged-in user ran it themselves.
// The Arabic system prompt is stored as base64 to avoid RTL/bidi text
// corruption when copy-pasting through terminals or web editors.

import Anthropic from "npm:@anthropic-ai/sdk@0.32.1";
import { createClient } from "npm:@supabase/supabase-js@2";

const anthropic = new Anthropic({ apiKey: Deno.env.get("ANTHROPIC_API_KEY") });

const MODEL = "claude-sonnet-5";
const MAX_TOOL_ROUNDS = 6;

const SYSTEM_PROMPT_B64 =
  "2KPZhtiqINin2YTZhdiz2KfYudivINin2YTYsNmD2Yog2K/Yp9iu2YQg2YbYuNin2YUgSGF5YXQgRVJQICjZhti42KfZhSDYudix2YjYtiDYo9iz2LnYp9ixINmI2YXYrtiy2YjZhiDYt9io2YopLgotINis2KfZiNioINio2KfZhNi52LHYqNmKINiv2KfYptmF2KfZiyDYpdmE2Kcg2KXYsNinINmD2KrYqCDYp9mE2YXYs9iq2K7Yr9mFINio2YTYutipINiq2KfZhtmK2KkuCi0g2LnZhtiv2YMg2LXZhNin2K3ZitipINmD2KfZhdmE2Kkg2YTZhNio2K3YqyDZiNin2YTYp9i32YTYp9i5INi52YTZiSDYqNmK2KfZhtin2Kog2KfZhNmG2LjYp9mFINin2YTYrdmC2YrZgtmK2Kk6INi52LHZiNi2INin2YTYo9iz2LnYp9ixINmI2KrZgdin2LXZitmE2YfYpyDZiNmF2K3YqtmI2YrYp9iq2YfYp9iMINin2YTYt9mE2KjYp9iq2Iwg2KfZhNi52YXZhNin2KHYjCDYp9mE2YPYqtin2YTZiNisINmI2KfZhNmB2KbYp9iq2Iwg2YjYpdit2LXYp9im2YrYp9iqINi52KfZhdipLiDYp9iz2KrYrtiv2YUg2KfZhNij2K/ZiNin2Kog2KfZhNmF2KrYp9it2Kkg2KjYtNmD2YQg2KfYs9iq2KjYp9mC2Yog2YjYqNmC2YjYqSDZg9mEINmF2Kcg2KfYrdiq2KzYqiDYqNmK2KfZhtin2Kog2K3ZgtmK2YLZitipINmE2YTYpdis2KfYqNipIOKAlCDYrNix2Kgg2KPZg9ir2LEg2YXZhiDYo9iv2KfYqSDYo9mIINij2YPYq9ixINmF2YYg2LXZitin2LrYqSDYqNit2Ksg2YTZiCDYp9mE2YbYqtmK2KzYqSDYp9mE2KPZiNmE2Ykg2YXYpyDZg9in2YbYqiDZg9in2YHZitip2Iwg2YjZhdinINiq2YPYqtmB2Yog2KjZhdit2KfZiNmE2Kkg2YjYrdiv2KkuCi0g2KzYp9mI2Kgg2KjYqtmB2LXZitmEINmI2KvZgtip2Iwg2YjYp9i52LHYtiDYp9mE2KPYsdmC2KfZhSDZiNin2YTZhtiq2KfYptisINin2YTYrdmC2YrZgtmK2Kkg2YrZhNmKINmE2YLZitiq2YfYpyDYqNmI2LbZiNitINmI2YXZhti42YUuCi0g2KfZhNi02Yog2KfZhNmI2K3ZitivINmK2YTZiiDZhdinINiq2YLYr9ixINiq2LnZhdmE2Yc6INij2Yog2KrYudiv2YrZhCDYo9mIINil2LbYp9mB2Kkg2KPZiCDYrdiw2YEg2YHYudmE2Yog2LnZhNmJINin2YTYqNmK2KfZhtin2KogKNmH2KfZiiDYp9mE2LXZhNin2K3ZitipINix2K0g2KrZhti22KfZgSDZhNin2K3Zgtin2Ysg2KjZhdmI2KfZgdmC2Kkg2LXYsdmK2K3YqSkuINmE2Ygg2LfZhNioINmF2YbZgyDYp9mE2YXYs9iq2K7Yr9mFINmH2YrZg9iMINmI2LbYrdmE2Ycg2KjZhNi32YEg2YjYp9mC2KrYsditINi52YTZitmHINi02Ygg2YXZhdmD2YYg2YrYs9mI2Yog2YrYr9mI2YrYp9mLINio2KfZhNmG2LjYp9mFLgotINmE2Ygg2YXYpyDZhNmC2YrYqiDZhtiq2KfYptisINio2LnYryDZhdit2KfZiNmE2Kkg2K3ZgtmK2YLZitipINio2KfZhNio2K3Yq9iMINmC2YTZhyDYqNi12LHYp9it2Kkg2YXYpyDZgdmKINmG2KrYp9im2KzYjCDZiNmF2Kcg2KrYrtiq2YTZgiDZhdi52YTZiNmF2KfYqiDYo9io2K/Yp9mLLgo=";
const SYSTEM_PROMPT = new TextDecoder().decode(
  Uint8Array.from(atob(SYSTEM_PROMPT_B64), (c) => c.charCodeAt(0)),
);

const TOOLS: Anthropic.Tool[] = [
  {
    name: "search_quotes",
    description:
      "Search price quotations by customer name and/or status. Returns up to 10 most recent matches with number, customer, date, status, total amount.",
    input_schema: {
      type: "object",
      properties: {
        customer_name: { type: "string", description: "Partial or full customer name to search for" },
        status: {
          type: "string",
          enum: ["draft", "sent", "approved", "partial_referral", "rejected", "converted", "invoiced", "cancelled", "expired"],
        },
      },
    },
  },
  {
    name: "get_quote_details",
    description: "Get full details of one quotation by its number, including all line items (materials, quantities, prices).",
    input_schema: {
      type: "object",
      properties: { number: { type: "string", description: "The exact quotation number" } },
      required: ["number"],
    },
  },
  {
    name: "search_quote_items",
    description:
      "Search across ALL quotations for a specific material/item name inside their line items. Use this to answer 'which quotes include material X' or 'what price did we quote for X before'. Returns matching line items with the quote number, customer, and date they belong to.",
    input_schema: {
      type: "object",
      properties: { item_name: { type: "string", description: "Material/item name or partial name to search for" } },
      required: ["item_name"],
    },
  },
  {
    name: "search_orders",
    description: "Search customer orders by customer name and/or status. Returns number, customer, status, total amount.",
    input_schema: {
      type: "object",
      properties: {
        customer_name: { type: "string", description: "Partial or full customer name to search for" },
        status: { type: "string", enum: ["pending", "confirmed", "processing", "delivered", "cancelled"] },
      },
    },
  },
  {
    name: "search_customers",
    description: "Search customers by name and/or category. Returns name, phone, mobile, city, category.",
    input_schema: {
      type: "object",
      properties: {
        name: { type: "string", description: "Customer name or partial name" },
        category: { type: "string", description: "Customer category/segment to filter by (partial match)" },
      },
    },
  },
  {
    name: "search_catalog",
    description: "Search catalog items/products by name and/or category. Returns name, unit, unit price, category, origin.",
    input_schema: {
      type: "object",
      properties: {
        name: { type: "string", description: "Item/product name or partial name" },
        category: { type: "string", description: "Catalog category to filter by (partial match)" },
      },
    },
  },
  {
    name: "list_catalog_categories",
    description: "List all distinct catalog item categories currently in use, with item counts. Use this first if the user asks about a category and you're not sure of the exact name.",
    input_schema: { type: "object", properties: {} },
  },
  {
    name: "get_stats",
    description: "Get overall counts: total quotations, total orders, total customers, total catalog items.",
    input_schema: { type: "object", properties: {} },
  },
];

// deno-lint-ignore no-explicit-any
async function runTool(supabase: any, name: string, input: any) {
  switch (name) {
    case "search_quotes": {
      let q = supabase
        .from("quotations")
        .select("number,customer_name,date,status,grand_total,currency")
        .order("date", { ascending: false })
        .limit(10);
      if (input?.customer_name) q = q.ilike("customer_name", `%${input.customer_name}%`);
      if (input?.status) q = q.eq("status", input.status);
      const { data, error } = await q;
      if (error) return { error: error.message };
      return { results: data };
    }
    case "get_quote_details": {
      const { data: quote, error: qErr } = await supabase
        .from("quotations")
        .select("id,number,customer_name,date,status,grand_total,currency,notes")
        .eq("number", input?.number ?? "")
        .maybeSingle();
      if (qErr) return { error: qErr.message };
      if (!quote) return { error: "not_found" };
      const { data: items, error: iErr } = await supabase
        .from("quotation_items")
        .select("item_name,quantity,unit,unit_price,total_price")
        .eq("quotation_id", quote.id)
        .order("sort_order", { ascending: true });
      if (iErr) return { quote, items: [], items_error: iErr.message };
      return { quote, items };
    }
    case "search_quote_items": {
      const { data, error } = await supabase
        .from("quotation_items")
        .select("item_name,quantity,unit,unit_price,total_price,quotations(number,customer_name,date,status)")
        .ilike("item_name", `%${input?.item_name ?? ""}%`)
        .limit(15);
      if (error) return { error: error.message };
      return { results: data };
    }
    case "search_orders": {
      let q = supabase
        .from("orders")
        .select("number,customer_name,status,total_amount,currency,created_at")
        .order("created_at", { ascending: false })
        .limit(10);
      if (input?.customer_name) q = q.ilike("customer_name", `%${input.customer_name}%`);
      if (input?.status) q = q.eq("status", input.status);
      const { data, error } = await q;
      if (error) return { error: error.message };
      return { results: data };
    }
    case "search_customers": {
      let q = supabase.from("customers").select("name,phone,mobile,city,category").limit(10);
      if (input?.name) q = q.ilike("name", `%${input.name}%`);
      if (input?.category) q = q.ilike("category", `%${input.category}%`);
      const { data, error } = await q;
      if (error) return { error: error.message };
      return { results: data };
    }
    case "search_catalog": {
      let q = supabase.from("catalog_items").select("name,unit,unit_price,category,origin").eq("is_active", true).limit(10);
      if (input?.name) q = q.ilike("name", `%${input.name}%`);
      if (input?.category) q = q.ilike("category", `%${input.category}%`);
      const { data, error } = await q;
      if (error) return { error: error.message };
      return { results: data };
    }
    case "list_catalog_categories": {
      const { data, error } = await supabase.from("catalog_items").select("category").eq("is_active", true);
      if (error) return { error: error.message };
      const counts: Record<string, number> = {};
      for (const row of data ?? []) {
        const cat = row.category || "بدون فئة";
        counts[cat] = (counts[cat] ?? 0) + 1;
      }
      return { categories: Object.entries(counts).map(([category, count]) => ({ category, count })) };
    }
    case "get_stats": {
      const [q, o, c, i] = await Promise.all([
        supabase.from("quotations").select("*", { count: "exact", head: true }),
        supabase.from("orders").select("*", { count: "exact", head: true }),
        supabase.from("customers").select("*", { count: "exact", head: true }),
        supabase.from("catalog_items").select("*", { count: "exact", head: true }),
      ]);
      return { quotations: q.count, orders: o.count, customers: c.count, catalog_items: i.count };
    }
    default:
      return { error: "unknown_tool" };
  }
}

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

  const history = (Array.isArray(body.history) ? body.history : [])
    .filter((m) => m && (m.role === "user" || m.role === "assistant") && typeof m.content === "string")
    .slice(-10);

  try {
    const messages: Anthropic.MessageParam[] = [...history, { role: "user", content: message }];

    let finalText = "";
    for (let round = 0; round < MAX_TOOL_ROUNDS; round++) {
      const response = await anthropic.messages.create({
        model: MODEL,
        max_tokens: 2048,
        system: SYSTEM_PROMPT,
        tools: TOOLS,
        output_config: { effort: "high" },
        messages,
      });

      if (response.stop_reason !== "tool_use") {
        const textBlock = response.content.find((b) => b.type === "text");
        finalText = textBlock?.type === "text" ? textBlock.text : "";
        break;
      }

      messages.push({ role: "assistant", content: response.content });

      const toolResults = [];
      for (const block of response.content) {
        if (block.type === "tool_use") {
          const result = await runTool(supabase, block.name, block.input);
          toolResults.push({
            type: "tool_result" as const,
            tool_use_id: block.id,
            content: JSON.stringify(result),
          });
        }
      }
      messages.push({ role: "user", content: toolResults });
    }

    return jsonResponse({ reply: finalText || "ما قدرت أوصل لجواب واضح، جرب تصيغ سؤالك بشكل تاني 🙏" });
  } catch (err) {
    console.error("ai-assistant error:", err);
    return jsonResponse({ error: "ai_error" }, 502);
  }
});
