-- ============================================================
-- الكاش فان — أجرة توصيل خاصة بكل صنف (بدل سعر ثابت لكل طلبية)
--
-- كل صنف يُباع صار يُحسب كـ"توصيلة" مستقلة وقت التسوية، بأجرة
-- خاصة به (قابلة للتعديل من واجهة سريعة). الصنف اللي ما حُدّدت
-- له أجرة بيستخدم "أجرة التوصيل الافتراضية" المدخلة بفورم التسوية
-- (نفس الحقل الموجود مسبقاً، صار دوره fallback بس).
--
-- شغّل هذا الملف كاملاً دفعة واحدة في Supabase SQL Editor.
-- ============================================================

BEGIN;

CREATE TABLE IF NOT EXISTS public.cashvan_item_delivery_rates (
  item_name     text PRIMARY KEY,
  delivery_rate numeric(10,3) NOT NULL DEFAULT 0,
  updated_at    timestamptz DEFAULT now()
);

DROP TRIGGER IF EXISTS trg_cashvan_item_delivery_rates_updated_at ON public.cashvan_item_delivery_rates;
CREATE TRIGGER trg_cashvan_item_delivery_rates_updated_at BEFORE UPDATE ON public.cashvan_item_delivery_rates
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

ALTER TABLE public.cashvan_item_delivery_rates ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS cvidr_select ON public.cashvan_item_delivery_rates;
CREATE POLICY cvidr_select ON public.cashvan_item_delivery_rates FOR SELECT USING (auth.uid() IS NOT NULL);

DROP POLICY IF EXISTS cvidr_write ON public.cashvan_item_delivery_rates;
CREATE POLICY cvidr_write ON public.cashvan_item_delivery_rates FOR ALL USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND (public.has_perm('cashvan_create') OR public.has_perm('cashvan_edit')))
) WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND (public.has_perm('cashvan_create') OR public.has_perm('cashvan_edit')))
);

GRANT SELECT, INSERT, UPDATE, DELETE ON public.cashvan_item_delivery_rates TO authenticated;

INSERT INTO public.changelog_entries (title, description) VALUES
  ('الكاش فان: أجرة توصيل لكل صنف', 'أجرة التوصيل بالتسوية صارت تُحسب لكل صنف مباع على حدة (قابلة للتخصيص من زر "أجرة التوصيل حسب الصنف") بدل سعر ثابت واحد لكل طلبية، مع إمكانية دمج طلبيتين منفصلتين لبعض عند تصحيح بيانات مُدخلة سابقاً.');

COMMIT;
