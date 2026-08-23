-- إضافة عمود سبب الأرشفة لجداول العروض والطلبات
-- شغّل هذا في Supabase SQL Editor

alter table quotations add column if not exists archive_note text;
alter table orders     add column if not exists archive_note text;
