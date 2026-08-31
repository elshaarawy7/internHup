-- Run this after the original applications migration if that migration was
-- already applied before CV upload support was added.
alter table if exists public.internship_applications
  add column if not exists cv_path text,
  add column if not exists cv_file_name text;

insert into storage.buckets (id, name, public)
values ('cvs', 'cvs', false)
on conflict (id) do nothing;

drop policy if exists "Students upload their own CVs" on storage.objects;
create policy "Students upload their own CVs"
on storage.objects for insert to authenticated
with check (
  bucket_id = 'cvs'
  and (storage.foldername(name))[1] = auth.uid()::text
);

drop policy if exists "Students and companies read relevant CVs" on storage.objects;
create policy "Students and companies read relevant CVs"
on storage.objects for select to authenticated
using (
  bucket_id = 'cvs'
  and (
    owner_id = auth.uid()
    or exists (
      select 1
      from public.internship_applications applications
      join public.internships internships
        on internships.id = applications.internship_id
      where applications.cv_path = name
        and internships.company_id = auth.uid()
    )
  )
);

drop policy if exists "Students delete their own CVs" on storage.objects;
create policy "Students delete their own CVs"
on storage.objects for delete to authenticated
using (bucket_id = 'cvs' and owner_id = auth.uid());
