-- Safe, all-in-one setup for installations where the earlier migration files
-- were not run. Execute this once in Supabase SQL Editor.
create table if not exists public.internship_applications (
  id uuid primary key default gen_random_uuid(),
  internship_id uuid not null references public.internships(id) on delete cascade,
  student_id uuid not null references auth.users(id) on delete cascade,
  student_name text not null,
  student_email text not null,
  cover_letter text not null,
  cv_path text,
  cv_file_name text,
  status text not null default 'pending',
  created_at timestamptz not null default now(),
  unique (internship_id, student_id)
);

alter table public.internship_applications
  add column if not exists cv_path text,
  add column if not exists cv_file_name text;

alter table public.internship_applications enable row level security;

drop policy if exists "Students submit their own applications" on public.internship_applications;
create policy "Students submit their own applications"
on public.internship_applications for insert to authenticated
with check (auth.uid() = student_id);

drop policy if exists "Students view their own applications" on public.internship_applications;
create policy "Students view their own applications"
on public.internship_applications for select to authenticated
using (auth.uid() = student_id);

drop policy if exists "Companies view applications for their internships" on public.internship_applications;
create policy "Companies view applications for their internships"
on public.internship_applications for select to authenticated
using (
  exists (
    select 1 from public.internships
    where internships.id = internship_id
      and internships.company_id = auth.uid()
  )
);

grant select, insert on public.internship_applications to authenticated;

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
