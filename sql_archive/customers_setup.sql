-- ============================================================
-- MedQuote Pro — Customers Module + Quotation Permissions
-- شغّل هذا في Supabase → SQL Editor
-- ============================================================

-- 1. جدول العملاء
CREATE TABLE IF NOT EXISTS public.customers (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name        TEXT NOT NULL,
  phone       TEXT,
  alt_phone   TEXT,
  address     TEXT,
  website     TEXT,
  notes       TEXT,
  assigned_to UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  created_by  UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  updated_at  TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.customers ENABLE ROW LEVEL SECURITY;

CREATE POLICY "customers_all_auth" ON public.customers
  FOR ALL USING (auth.uid() IS NOT NULL)
  WITH CHECK (auth.uid() IS NOT NULL);

-- 2. ربط العميل بجدول عروض الأسعار
ALTER TABLE public.quotations
  ADD COLUMN IF NOT EXISTS customer_id UUID REFERENCES public.customers(id) ON DELETE SET NULL;

-- 3. تحديث صلاحيات عروض الأسعار حسب الدور
DROP POLICY IF EXISTS "quotations_all_auth" ON public.quotations;

CREATE POLICY "quotations_select" ON public.quotations
  FOR SELECT USING (
    auth.uid() IS NOT NULL AND (
      (SELECT role FROM public.profiles WHERE id = auth.uid()) IN ('admin', 'manager')
      OR created_by = auth.uid()
      OR created_by IS NULL
    )
  );

CREATE POLICY "quotations_insert" ON public.quotations
  FOR INSERT WITH CHECK (auth.uid() IS NOT NULL);

CREATE POLICY "quotations_update" ON public.quotations
  FOR UPDATE USING (
    (SELECT role FROM public.profiles WHERE id = auth.uid()) IN ('admin', 'manager')
    OR created_by = auth.uid()
  );

CREATE POLICY "quotations_delete" ON public.quotations
  FOR DELETE USING (
    (SELECT role FROM public.profiles WHERE id = auth.uid()) IN ('admin', 'manager')
  );

-- 4. تحقق من النتيجة
SELECT tablename, policyname FROM pg_policies
WHERE tablename IN ('quotations','customers')
ORDER BY tablename, policyname;
