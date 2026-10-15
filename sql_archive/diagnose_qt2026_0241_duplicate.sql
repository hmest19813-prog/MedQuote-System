-- تشخيص فقط (بدون تعديل) — هل يوجد صفّان فعلاً برقم QT-2026-0241، أم صفّ واحد فقط؟
-- شغّل هذا بمحرر SQL بسوبابيز وشاركني النتيجة

-- 1) كل الصفوف التي رقمها QT-2026-0241 (المفروض صفّ واحد فقط بسبب UNIQUE constraint)
select id, number, customer_name, issuer_company, status, created_at, created_by
from quotations
where number = 'QT-2026-0241'
order by created_at;

-- 2) هل يوجد عرض آخر "مستنسخ" من هذا العرض (باسم إياد حرب) بغض النظر عن رقمه؟
select id, number, customer_name, issuer_company, cloned_from_id, status, created_at
from quotations
where cloned_from_id = (select id from quotations where number = 'QT-2026-0241' limit 1)
   or issuer_company = 'eyad_harb'
order by created_at desc
limit 20;

-- 3) قيمة العدّاد الحالي لتسلسل أرقام العروض الرسمية (للتأكد أنه ما تراجع لرقم قديم)
select * from number_sequences where id = 'quotation';
