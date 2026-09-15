-- ============================================================
-- عملاء الأونلاين — ONLINE CUSTOMERS
--
-- سجل منفصل تماماً عن جدول public.customers (عملاء الحياة العلمية
-- الحاليين/المحتملين). عملاء الأونلاين مرتبطون فقط بالطلبات
-- اليومية (public.daily_orders) عبر رقم الهاتف كمعرّف أساسي —
-- يُنشأون/يتحدّثون تلقائياً عند إنشاء طلبية يومية بهاتف جديد أو
-- موجود، ويمكن إضافتهم يدوياً من تبويب "عملاء الأونلاين".
--
-- شغّل هذا الملف كاملاً دفعة واحدة في Supabase SQL Editor.
-- يفترض وجود public.has_perm(text) و public.get_my_role() و
-- public.update_updated_at() و public.daily_orders مسبقاً.
-- يشمل Backfill تلقائي لأي طلبيات يومية موجودة فعلاً (تجريبية أو
-- حقيقية) قبل ربط الـFK، حتى لا تفشل الإضافة.
-- ============================================================

BEGIN;

CREATE TABLE IF NOT EXISTS public.online_customers (
  phone       text PRIMARY KEY,
  name        text NOT NULL,
  region      text,
  created_at  timestamptz NOT NULL DEFAULT now(),
  updated_at  timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.online_customers REPLICA IDENTITY FULL;

DROP TRIGGER IF EXISTS trg_online_customers_updated_at ON public.online_customers;
CREATE TRIGGER trg_online_customers_updated_at BEFORE UPDATE ON public.online_customers
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

-- Backfill: أي طلبية يومية موجودة فعلاً (حتى لو تجريبية) فيها رقم هاتف
-- لازم يكون له سجل مطابق بعملاء الأونلاين قبل ربط الـFK، وإلا تفشل الإضافة
INSERT INTO public.online_customers (phone, name, region)
SELECT DISTINCT ON (customer_phone) customer_phone, customer_name, region
FROM public.daily_orders
WHERE customer_phone IS NOT NULL
ORDER BY customer_phone, created_at DESC
ON CONFLICT (phone) DO NOTHING;

-- ربط الطلبات اليومية بعملاء الأونلاين عبر رقم الهاتف
ALTER TABLE public.daily_orders DROP CONSTRAINT IF EXISTS daily_orders_customer_phone_fkey;
ALTER TABLE public.daily_orders
  ADD CONSTRAINT daily_orders_customer_phone_fkey
  FOREIGN KEY (customer_phone) REFERENCES public.online_customers(phone);

-- ── الصلاحيات (RLS) — نفس نمط customers/daily_orders ─────────

ALTER TABLE public.online_customers ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS online_customers_select ON public.online_customers;
CREATE POLICY online_customers_select ON public.online_customers FOR SELECT USING (auth.uid() IS NOT NULL);

DROP POLICY IF EXISTS online_customers_insert ON public.online_customers;
CREATE POLICY online_customers_insert ON public.online_customers FOR INSERT WITH CHECK (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND (public.has_perm('customers_create') OR public.has_perm('daily_orders_create')))
  )
);

DROP POLICY IF EXISTS online_customers_update ON public.online_customers;
CREATE POLICY online_customers_update ON public.online_customers FOR UPDATE USING (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND (public.has_perm('customers_edit') OR public.has_perm('daily_orders_create') OR public.has_perm('daily_orders_edit')))
  )
);

DROP POLICY IF EXISTS online_customers_delete ON public.online_customers;
CREATE POLICY online_customers_delete ON public.online_customers FOR DELETE USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('customers_delete'))
);

GRANT SELECT, INSERT, UPDATE, DELETE ON public.online_customers TO authenticated;

ALTER PUBLICATION supabase_realtime ADD TABLE public.online_customers;

COMMIT;
