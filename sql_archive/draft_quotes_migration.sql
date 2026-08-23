-- =========================================================
-- Draft Quotes Migration
-- تسلسل مستقل للمسودات (2026D-NNN) + trigger اعتماد
-- =========================================================

-- 1. إضافة تسلسل المسودات
INSERT INTO public.number_sequences (id, prefix, current_value, year)
VALUES ('draft', '2026D', 0, 2026)
ON CONFLICT (id) DO NOTHING;

-- 2. دالة توليد رقم المسودة (بريفيكس ثابت 2026D بدون reset سنوي)
CREATE OR REPLACE FUNCTION public.generate_draft_number()
RETURNS TEXT AS $$
DECLARE
  next_val INTEGER;
BEGIN
  UPDATE public.number_sequences
    SET current_value = current_value + 1
    WHERE id = 'draft'
    RETURNING current_value INTO next_val;

  RETURN '2026D-' || LPAD(next_val::TEXT, 3, '0');
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 3. تعديل trigger INSERT: مسودة → رقم مسودة | غير ذلك → رقم رسمي
CREATE OR REPLACE FUNCTION public.set_quotation_number()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.number IS NULL OR NEW.number = '' THEN
    IF NEW.status = 'draft' THEN
      NEW.number := public.generate_draft_number();
    ELSE
      NEW.number := public.generate_quotation_number();
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 4. trigger UPDATE: عند اعتماد المسودة يُخصَّص رقم رسمي في تلك اللحظة
CREATE OR REPLACE FUNCTION public.confirm_draft_quotation()
RETURNS TRIGGER AS $$
BEGIN
  IF OLD.status = 'draft' AND NEW.status != 'draft' THEN
    NEW.number := public.generate_quotation_number();
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER quotation_confirm_trigger
  BEFORE UPDATE ON public.quotations
  FOR EACH ROW
  EXECUTE FUNCTION public.confirm_draft_quotation();
