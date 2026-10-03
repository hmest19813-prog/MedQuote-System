-- أحلام فقط كانت تملك letters_access=true، وهذا كان يمنحها (بدون قصد) وصول كامل
-- لسندات القبض/الصرف عن طريق مفتاح "letters_access" المُعاد استخدامه كبروكسي.
-- بعد فصل vouchers_access/vouchers_create/vouchers_delete كصلاحيات مستقلة، الـdefault
-- الجديد لها false لكل الموظفين — فبدون هذا التحديث، أحلام تفقد وصول السندات فوراً
-- عند النشر. هذا يحافظ فقط على وضعها الحالي (باقي الموظفين كان letters_access=false
-- عندهم أصلاً، فما بتغيّر شي لهم).
UPDATE public.profiles
SET permissions = permissions || '{"vouchers_access": true, "vouchers_create": true, "vouchers_delete": true}'::jsonb
WHERE id = '6f484e98-e110-4ceb-8070-e61810c5f108'; -- ahlam
