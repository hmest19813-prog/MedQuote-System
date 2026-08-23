-- ============================================================
-- MedQuote Pro — حذف كل العروض + تصفير التسلسل + 4 أرقام
-- شغّله في Supabase → SQL Editor
-- ============================================================

-- 1) حذف البنود أولاً (foreign key)
DELETE FROM public.quotation_items;

-- 2) فك ربط الطلبات بالعروض
UPDATE public.orders SET quotation_id = NULL, quotation_number = NULL;

-- 3) حذف كل العروض
DELETE FROM public.quotations;

-- 4) تصفير العداد
UPDATE public.number_sequences
SET current_value = 0
WHERE id = 'quotation';

-- 5) تحديث الدالة لتصبح 4 أرقام بدل 3
CREATE OR REPLACE FUNCTION public.generate_quotation_number()
RETURNS TEXT AS $$
DECLARE
  current_year INTEGER := EXTRACT(YEAR FROM NOW())::INTEGER;
  next_val     INTEGER;
BEGIN
  UPDATE public.number_sequences
    SET current_value = 0, year = current_year
    WHERE id = 'quotation' AND year < current_year;

  UPDATE public.number_sequences
    SET current_value = current_value + 1
    WHERE id = 'quotation'
    RETURNING current_value INTO next_val;

  RETURN 'QT-' || current_year || '-' || LPAD(next_val::TEXT, 4, '0');
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- تحقق
SELECT * FROM public.number_sequences WHERE id = 'quotation';
SELECT COUNT(*) AS remaining_quotes FROM public.quotations;
