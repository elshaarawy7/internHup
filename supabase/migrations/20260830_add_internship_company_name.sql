-- Run this migration in your Supabase project before publishing internships.
-- It adds the information the company owner enters for every offer.
alter table public.internships
  add column if not exists company_name text,
  add column if not exists requirements text,
  add column if not exists duration text,
  add column if not exists deadline timestamptz;

-- Existing offers predate these fields, so they remain nullable for compatibility.
