-- تشخيص فقط — قراءة، ما بيغيّر أي شي
SELECT tablename FROM pg_tables
WHERE schemaname = 'public' AND tablename LIKE 'property%'
ORDER BY tablename;

SELECT proname FROM pg_proc
WHERE pronamespace = 'public'::regnamespace
  AND proname IN ('is_properties_user','properties_set_password','properties_verify_password','property_create_default_unit');

SELECT tablename, policyname, cmd FROM pg_policies
WHERE schemaname = 'public' AND tablename LIKE 'property%'
ORDER BY tablename, cmd;

SELECT count(*) AS properties_rows FROM public.properties;
