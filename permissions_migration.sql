-- ============================================================
-- MedQuote Pro — الصلاحيات + تسجيل الدخول باليوزر
-- ⚠️  شغّل الـ STEP 1 أولاً، ثم الـ STEP 2 في run منفصل
-- ============================================================

-- ══════════════════════════════════════════════
-- STEP 1 — شغّله وحده أولاً (فقط هذا السطرين)
-- ══════════════════════════════════════════════

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS permissions JSONB NOT NULL DEFAULT '{}'::jsonb;


-- ══════════════════════════════════════════════
-- STEP 2 — بعد ما ينجح STEP 1، شغّل هذا
-- ══════════════════════════════════════════════

-- دالة جلب الإيميل من اسم المستخدم
-- (SECURITY DEFINER لأن profiles محمية بـ RLS واللوجن يكون قبل أي session)
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

-- السماح للزوار (anon) باستخدام الدالة أثناء تسجيل الدخول
GRANT EXECUTE ON FUNCTION public.get_email_by_username(TEXT) TO anon, authenticated;

-- استبدال دالة إنشاء المستخدمين بنسخة تدعم username و permissions
CREATE OR REPLACE FUNCTION public.create_user_with_profile(
  p_email       TEXT,
  p_password    TEXT,
  p_full_name   TEXT,
  p_role        TEXT    DEFAULT 'employee',
  p_is_active   BOOLEAN DEFAULT true,
  p_username    TEXT    DEFAULT NULL,
  p_permissions JSONB   DEFAULT '{}'::jsonb
)
RETURNS UUID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, auth, extensions
AS $$
DECLARE
  v_user_id UUID;
  v_username TEXT;
BEGIN
  SELECT id INTO v_user_id
  FROM auth.users
  WHERE email = LOWER(TRIM(p_email))
  LIMIT 1;

  IF v_user_id IS NULL THEN
    INSERT INTO auth.users (
      instance_id, id, aud, role, email, encrypted_password,
      email_confirmed_at, raw_app_meta_data, raw_user_meta_data,
      created_at, updated_at, confirmation_token, recovery_token
    ) VALUES (
      '00000000-0000-0000-0000-000000000000',
      gen_random_uuid(),
      'authenticated', 'authenticated',
      LOWER(TRIM(p_email)),
      crypt(p_password, gen_salt('bf')),
      NOW(),
      '{"provider":"email","providers":["email"]}'::jsonb,
      jsonb_build_object('full_name', p_full_name),
      NOW(), NOW(), '', ''
    )
    RETURNING id INTO v_user_id;
  END IF;

  v_username := NULLIF(TRIM(COALESCE(p_username, '')), '');
  IF v_username IS NULL THEN
    v_username := split_part(LOWER(TRIM(p_email)), '@', 1);
  END IF;

  INSERT INTO public.profiles (
    id, email, full_name, username, role, is_active, permissions
  ) VALUES (
    v_user_id, LOWER(TRIM(p_email)), TRIM(p_full_name),
    v_username, p_role, p_is_active, COALESCE(p_permissions, '{}'::jsonb)
  )
  ON CONFLICT (id) DO UPDATE SET
    full_name   = EXCLUDED.full_name,
    username    = EXCLUDED.username,
    role        = EXCLUDED.role,
    is_active   = EXCLUDED.is_active,
    permissions = EXCLUDED.permissions,
    updated_at  = NOW();

  RETURN v_user_id;
END;
$$;

-- تعيين username للمستخدمين الحاليين الذين ليس لديهم username
UPDATE public.profiles
SET username = split_part(LOWER(email), '@', 1)
WHERE (username IS NULL OR username = '')
  AND email IS NOT NULL;

-- خصّص أسماء المستخدمين كما تريد (أزل -- من السطر المطلوب):
-- UPDATE public.profiles SET username = 'khaled'  WHERE email = 'hmest19813@gmail.com';
-- UPDATE public.profiles SET username = 'ahlam'   WHERE email = 'hmest19810@gmail.com';
-- UPDATE public.profiles SET username = 'osama'   WHERE email = 'o.alawy.oa@gmail.com';
-- UPDATE public.profiles SET username = 'drm'     WHERE email = 'hmest19811@gmail.com';

-- تحقق من النتيجة (بدون عمود permissions لتجنب مشاكل parse)
SELECT full_name, username, email, role, is_active
FROM public.profiles
ORDER BY role DESC, full_name;
