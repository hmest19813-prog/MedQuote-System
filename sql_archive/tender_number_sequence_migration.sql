-- =========================================================
-- Tender Number Sequence Migration
-- تسلسل مستقل للعطاءات (TND-السنة-الرقم) بدل مشاركة تسلسل
-- عروض الأسعار (QT-السنة-الرقم) — نفس نسق QT، يتصفّر كل سنة جديدة.
-- آمن لإعادة التشغيل بالكامل (idempotent).
-- =========================================================

-- 1) تسلسل العطاءات
INSERT INTO public.number_sequences (id, prefix, current_value, year)
VALUES ('tender', 'TND', 0, EXTRACT(YEAR FROM NOW())::INTEGER)
ON CONFLICT (id) DO NOTHING;

-- 2) دالة توليد رقم العطاء (نفس منطق generate_quotation_number بس بتسلسل مستقل)
CREATE OR REPLACE FUNCTION public.generate_tender_number()
RETURNS TEXT AS $$
DECLARE
  current_year INTEGER := EXTRACT(YEAR FROM NOW())::INTEGER;
  next_val     INTEGER;
BEGIN
  UPDATE public.number_sequences
    SET current_value = 0, year = current_year
    WHERE id = 'tender' AND year < current_year;

  UPDATE public.number_sequences
    SET current_value = current_value + 1
    WHERE id = 'tender'
    RETURNING current_value INTO next_val;

  RETURN 'TND-' || current_year || '-' || LPAD(next_val::TEXT, 3, '0');
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 3) trigger INSERT: مسودة → رقم مسودة | عطاء مباشر (نادر) → TND | غير ذلك → QT
CREATE OR REPLACE FUNCTION public.set_quotation_number()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.number IS NULL OR NEW.number = '' THEN
    IF NEW.status = 'draft' THEN
      NEW.number := public.generate_draft_number();
    ELSIF NEW.quote_type = 'tender' THEN
      NEW.number := public.generate_tender_number();
    ELSE
      NEW.number := public.generate_quotation_number();
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 4) trigger UPDATE: عند اعتماد المسودة — عطاء يأخذ TND، غير ذلك يأخذ QT كالسابق
CREATE OR REPLACE FUNCTION public.confirm_draft_quotation()
RETURNS TRIGGER AS $$
BEGIN
  IF OLD.status = 'draft' AND NEW.status != 'draft' THEN
    IF NEW.quote_type = 'tender' THEN
      NEW.number := public.generate_tender_number();
    ELSE
      NEW.number := public.generate_quotation_number();
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER quotation_confirm_trigger
  BEFORE UPDATE ON public.quotations
  FOR EACH ROW
  EXECUTE FUNCTION public.confirm_draft_quotation();

-- 5) بأثر رجعي: العطاءات الموجودة حالياً (QT-...) تاخذ أرقام TND-2026-001/002/003
--    بترتيب تاريخ إنشائها — آمنة للتشغيل أكثر من مرة لأن الترتيب بـ created_at ثابت
--    (مو بالرقم النصي اللي بيتغيّر بعد أول تشغيل).
DROP TABLE IF EXISTS tmp_tender_renumber;
CREATE TEMP TABLE tmp_tender_renumber AS
SELECT id, number AS old_number,
       'TND-2026-' || LPAD(row_number() OVER (ORDER BY created_at)::TEXT, 3, '0') AS new_number
FROM public.quotations
WHERE quote_type = 'tender' AND status <> 'draft';

-- 5أ) تحديث نسخة الرقم المكرّرة بجدول orders (quotation_number) حتى تبقى متزامنة
--     ولا ينكسر البحث عن الطلبية المرتبطة بالعطاء (orders.quotation_id أو orders.quotation_number)
UPDATE public.orders o
SET quotation_number = t.new_number
FROM tmp_tender_renumber t
WHERE o.quotation_id = t.id
   OR (o.quotation_id IS NULL AND o.quotation_number = t.old_number);

-- 5ب) تحديث رقم العطاء نفسه بجدول quotations
UPDATE public.quotations q
SET number = t.new_number
FROM tmp_tender_renumber t
WHERE q.id = t.id;

-- 6) تحديث عدّاد التسلسل حتى يبدأ العطاء الجاي من بعد آخر رقم استُخدم بالخطوة 5
UPDATE public.number_sequences
SET current_value = GREATEST(current_value, (SELECT count(*) FROM tmp_tender_renumber)),
    year = 2026
WHERE id = 'tender';

DROP TABLE IF EXISTS tmp_tender_renumber;
