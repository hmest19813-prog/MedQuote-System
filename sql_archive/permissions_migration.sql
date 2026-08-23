-- ============================================================
-- MedQuote Pro — الصلاحيات + تسجيل الدخول باليوزر
-- ⚠️  شغّل الـ STEP 1 أولاً، ثم الـ STEP 2 في run منفصل
-- ============================================================

-- ══════════════════════════════════════════════
-- STEP 1 — شغّله وحده أولاً
-- ══════════════════════════════════════════════

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS permissions JSONB NOT NULL DEFAULT '{}'::jsonb;


-- ══════════════════════════════════════════════
-- STEP 2 — بعد ما ينجح STEP 1، شغّل هذا
-- ══════════════════════════════════════════════

-- دالة جلب الإيميل من اسم المستخدم (لتسجيل الدخول)
CREATE OR REPLACE FUNCTION public.get_email_by_username(p_username TEXT)
RETURNS TEXT
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT email
  FROM public.profiles
  WHERE LOWER(TRIM(username)) = LOWER(TRIM(p_username))
  LIMIT 1;
$$;

GRANT EXECUTE ON FUNCTION public.get_email_by_username(TEXT) TO anon, authenticated;

-- دالة إكمال بيانات الـ profile بعد إنشاء المستخدم من JS
-- (الـ JS يعمل signUp أولاً ثم يستدعي هذه الدالة)
CREATE OR REPLACE FUNCTION public.setup_new_user_profile(
  p_user_id     UUID,
  p_email       TEXT,
  p_full_name   TEXT,
  p_username    TEXT,
  p_role        TEXT    DEFAULT 'employee',
  p_is_active   BOOLEAN DEFAULT true,
  p_permissions JSONB   DEFAULT '{}'::jsonb
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_username TEXT;
BEGIN
  v_username := NULLIF(TRIM(COALESCE(p_username, '')), '');
  IF v_username IS NULL THEN
    v_username := split_part(LOWER(TRIM(p_email)), '@', 1);
  END IF;

  INSERT INTO public.profiles (id, email, full_name, username, role, is_active, permissions)
  VALUES (p_user_id, LOWER(TRIM(p_email)), TRIM(p_full_name), v_username, p_role, p_is_active, COALESCE(p_permissions, '{}'::jsonb))
  ON CONFLICT (id) DO UPDATE SET
    full_name   = EXCLUDED.full_name,
    username    = EXCLUDED.username,
    role        = EXCLUDED.role,
    is_active   = EXCLUDED.is_active,
    permissions = EXCLUDED.permissions,
    updated_at  = NOW();
END;
$$;

GRANT EXECUTE ON FUNCTION public.setup_new_user_profile(UUID, TEXT, TEXT, TEXT, TEXT, BOOLEAN, JSONB) TO authenticated;

-- تعيين username للمستخدمين الحاليين الذين ليس لديهم username
UPDATE public.profiles
SET username = split_part(LOWER(email), '@', 1)
WHERE (username IS NULL OR username = '')
  AND email IS NOT NULL;

-- خصّص أسماء المستخدمين (أزل -- من السطر المطلوب):
-- UPDATE public.profiles SET username = 'khaled'  WHERE email = 'hmest19813@gmail.com';
-- UPDATE public.profiles SET username = 'ahlam'   WHERE email = 'hmest19810@gmail.com';
-- UPDATE public.profiles SET username = 'osama'   WHERE email = 'o.alawy.oa@gmail.com';
-- UPDATE public.profiles SET username = 'drm'     WHERE email = 'hmest19811@gmail.com';

-- تحقق
SELECT full_name, username, email, role, is_active FROM public.profiles ORDER BY role DESC, full_name;
