-- يلغي الوصول لإدارة المحاسبة والبريد الوارد عن أحلام وأحمد وسامح
-- (كانت ظاهرة لهم: أحلام/أحمد بصلاحية محاسبة صريحة أو بدون تحديد فيرجع للـdefault القديم true، والثلاثة ببريد وارد صريح true)
UPDATE public.profiles
SET permissions = permissions || '{"accounting_access": false, "inbox_access": false}'::jsonb
WHERE id IN (
  '6f484e98-e110-4ceb-8070-e61810c5f108', -- ahlam
  '65ce1c8f-6151-402a-8bcd-4270b3cf6d0a', -- ahmad
  '0f55b566-cf94-4184-b35e-9e293d6c04da'  -- sameh
);
