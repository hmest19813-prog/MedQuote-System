-- مندوبون خارجيون بالكاش فان (بدون حساب دخول للنظام) — مثل "أبو طارق".
--
-- cashvan_stock_loads/cashvan_sales/cashvan_settlements.rep_id كانت مربوطة
-- بـFK إلزامي لـpublic.profiles(id)، وprofiles.id نفسها مربوطة بـFK لـauth.users(id)
-- (كل profile = حساب دخول فعلي). هذا يمنع تسجيل مندوب حقيقي بدون حساب.
--
-- الحل: نلغي الـFK القديم على rep_id (يصير uuid عادي بدون فحص مرجعي)، ونضيف
-- جدول cashvan_external_reps صغير مستقل تماماً عن auth.users لتسجيل مندوبين
-- خارجيين. الواجهة بتجمع profiles + cashvan_external_reps بقائمة واحدة لعرض
-- واختيار "المندوب" بكل فورمات الكاش فان.
--
-- شغّل هذا الملف كاملاً دفعة واحدة في Supabase SQL Editor (بعد cashvan_migration.sql).

BEGIN;

-- ── 1) إلغاء الـFK الإلزامي على rep_id بالجداول الثلاثة ─────
-- (يدوياً بالاسم الافتراضي غير مضمون 100%، فبنكتشفه من information_schema)

DO $$
DECLARE r RECORD;
BEGIN
  FOR r IN
    SELECT tc.constraint_name, tc.table_name
    FROM information_schema.table_constraints tc
    JOIN information_schema.key_column_usage kcu
      ON tc.constraint_name = kcu.constraint_name AND tc.table_schema = kcu.table_schema
    WHERE tc.constraint_type = 'FOREIGN KEY'
      AND tc.table_schema = 'public'
      AND tc.table_name IN ('cashvan_stock_loads','cashvan_sales','cashvan_settlements')
      AND kcu.column_name = 'rep_id'
  LOOP
    EXECUTE format('ALTER TABLE public.%I DROP CONSTRAINT %I', r.table_name, r.constraint_name);
  END LOOP;
END $$;

-- ── 2) جدول المندوبين الخارجيين ──────────────────────────────

CREATE TABLE IF NOT EXISTS public.cashvan_external_reps (
  id          uuid PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
  full_name   text NOT NULL,
  notes       text,
  is_active   boolean NOT NULL DEFAULT true,
  created_by  uuid REFERENCES public.profiles(id),
  created_at  timestamptz DEFAULT now(),
  updated_at  timestamptz DEFAULT now()
);

DROP TRIGGER IF EXISTS trg_cashvan_external_reps_updated_at ON public.cashvan_external_reps;
CREATE TRIGGER trg_cashvan_external_reps_updated_at BEFORE UPDATE ON public.cashvan_external_reps
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

ALTER TABLE public.cashvan_external_reps ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS cver_select ON public.cashvan_external_reps;
CREATE POLICY cver_select ON public.cashvan_external_reps FOR SELECT USING (auth.uid() IS NOT NULL);

DROP POLICY IF EXISTS cver_insert ON public.cashvan_external_reps;
CREATE POLICY cver_insert ON public.cashvan_external_reps FOR INSERT WITH CHECK (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND public.has_perm('cashvan_create'))
  )
);

DROP POLICY IF EXISTS cver_update ON public.cashvan_external_reps;
CREATE POLICY cver_update ON public.cashvan_external_reps FOR UPDATE USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('cashvan_edit'))
);

DROP POLICY IF EXISTS cver_delete ON public.cashvan_external_reps;
CREATE POLICY cver_delete ON public.cashvan_external_reps FOR DELETE USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('cashvan_delete'))
);

GRANT SELECT, INSERT, UPDATE, DELETE ON public.cashvan_external_reps TO authenticated;

-- ── 3) إضافة "أبو طارق" كمندوب خارجي ─────────────────────────

INSERT INTO public.cashvan_external_reps (full_name, notes)
SELECT 'أبو طارق', 'مندوب خارجي — بدون حساب دخول للنظام'
WHERE NOT EXISTS (SELECT 1 FROM public.cashvan_external_reps WHERE full_name = 'أبو طارق');

INSERT INTO public.changelog_entries (title, description) VALUES
  ('الكاش فان: مندوبون خارجيون', 'صار ممكن نسجّل مندوب كاش فان بدون ما يكون له حساب دخول للنظام (مثل أبو طارق) — يظهر بقائمة المندوبين بكل فورمات التزويد/المبيعات/التسويات جنب الموظفين العاديين.');

COMMIT;
