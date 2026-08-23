UPDATE public.quotations
SET created_by = (
  SELECT id FROM public.profiles WHERE full_name ILIKE '%Jawabreh%' LIMIT 1
)
WHERE number = 'QT-2026-0042';
