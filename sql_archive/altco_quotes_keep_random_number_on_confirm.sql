-- بَگ: اعتماد مسودة عرض صادر باسم شركة بديلة (إياد حرب/بكين) كان يستبدل رمزها العشوائي
-- برقم من تسلسل عروض حياة الرسمي (QT-2026-####) — حسب الاتفاق، عروض الشركات البديلة
-- لازم تبقى برمز عشوائي منفصل دايماً، سواء مسودة أو معتمدة.
-- شغّل هذا الملف مرة واحدة على Supabase SQL Editor.

CREATE OR REPLACE FUNCTION public.confirm_draft_quotation() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF OLD.status = 'draft' AND NEW.status != 'draft' THEN
    IF NEW.issuer_company IS NULL OR NEW.issuer_company = 'hayat' THEN
      NEW.number := public.generate_quotation_number();
    END IF;
  END IF;
  RETURN NEW;
END;
$$;
