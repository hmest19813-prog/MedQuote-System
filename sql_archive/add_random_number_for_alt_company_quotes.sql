-- ميزة: تسلسل عشوائي (حروف وأرقام) لعروض الأسعار الصادرة باسم شركة أخرى
-- بدل رقم "QT-YYYY-NNNN" المتسلسل الخاص بمؤسسة الحياة، حتى لا يظهر العرض
-- وكأنه جزء من تسلسل الحياة نفسه.
-- شغّل هذا الملف على Supabase SQL Editor مرة واحدة.

CREATE OR REPLACE FUNCTION public.generate_random_quote_serial() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
  chars  TEXT := 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'; -- بدون أحرف/أرقام ملتبسة (0/O, 1/I)
  result TEXT := '';
  i INT;
BEGIN
  FOR i IN 1..4 LOOP
    result := result || substr(chars, (floor(random()*length(chars))+1)::int, 1);
  END LOOP;
  result := result || '-';
  FOR i IN 1..4 LOOP
    result := result || substr(chars, (floor(random()*length(chars))+1)::int, 1);
  END LOOP;
  RETURN result;
END;
$$;

ALTER FUNCTION public.generate_random_quote_serial() OWNER TO postgres;

-- عدّل الدالتين اللي يضبطان رقم العرض حتى تستخدما تسلسلاً عشوائياً
-- كلما كان issuer_company غير 'hayat'

CREATE OR REPLACE FUNCTION public.set_quotation_number() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF NEW.number IS NULL OR NEW.number = '' THEN
    IF NEW.issuer_company IS NOT NULL AND NEW.issuer_company <> 'hayat' THEN
      NEW.number := public.generate_random_quote_serial();
    ELSIF NEW.status = 'draft' THEN
      NEW.number := public.generate_draft_number();
    ELSE
      NEW.number := public.generate_quotation_number();
    END IF;
  END IF;
  RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION public.confirm_draft_quotation() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF OLD.status = 'draft' AND NEW.status != 'draft' THEN
    IF NEW.issuer_company IS NOT NULL AND NEW.issuer_company <> 'hayat' THEN
      NEW.number := public.generate_random_quote_serial();
    ELSE
      NEW.number := public.generate_quotation_number();
    END IF;
  END IF;
  RETURN NEW;
END;
$$;
