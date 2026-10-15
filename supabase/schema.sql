-- DevNorte v0.2 — run once in Supabase SQL Editor.
create extension if not exists pgcrypto;
create table if not exists public.profiles (
 id uuid primary key references auth.users(id) on delete cascade,
 username text not null check (char_length(username) between 2 and 60),
 created_at timestamptz not null default now()
);
create table if not exists public.posts (
 id uuid primary key default gen_random_uuid(),
 user_id uuid not null references public.profiles(id) on delete cascade,
 category text not null check (category in ('Proyecto','Pregunta','Colaboración','Carrera')),
 title text not null check (char_length(btrim(title)) between 8 and 120),
 body text not null check (char_length(btrim(body)) between 15 and 5000),
 repo_url text check (repo_url is null or (char_length(repo_url)<=500 and repo_url ~ '^https://[^[:space:]]+$')),
 created_at timestamptz not null default now()
);
create table if not exists public.comments (
 id uuid primary key default gen_random_uuid(),
 post_id uuid not null references public.posts(id) on delete cascade,
 user_id uuid not null references public.profiles(id) on delete cascade,
 body text not null check (char_length(btrim(body)) between 2 and 2000),
 created_at timestamptz not null default now()
);
create table if not exists public.votes (
 post_id uuid not null references public.posts(id) on delete cascade,
 user_id uuid not null references public.profiles(id) on delete cascade,
 created_at timestamptz not null default now(),
 primary key (post_id,user_id)
);
create index if not exists posts_created_at_idx on public.posts(created_at desc);
create index if not exists comments_post_idx on public.comments(post_id,created_at);
-- Login-trigger inserts profile without requiring client-side privileged writes.
create or replace function public.create_devnorte_profile() returns trigger
language plpgsql security definer set search_path = '' as $$
begin
 insert into public.profiles (id,username)
 values (new.id, left(coalesce(nullif(new.raw_user_meta_data ->> 'user_name',''), 'dev_' || left(new.id::text,8)),60))
 on conflict (id) do nothing;
 return new;
end;
$$;
drop trigger if exists on_auth_user_created_devnorte on auth.users;
create trigger on_auth_user_created_devnorte after insert on auth.users
for each row execute procedure public.create_devnorte_profile();
-- Existing registered auth accounts (if any)
insert into public.profiles(id,username)
select id,left(coalesce(nullif(raw_user_meta_data ->> 'user_name',''), 'dev_' || left(id::text,8)),60)
from auth.users on conflict (id) do nothing;
alter table public.profiles enable row level security;
alter table public.posts enable row level security;
alter table public.comments enable row level security;
alter table public.votes enable row level security;
-- Explicitly grant access; RLS controls the rows.
grant usage on schema public to anon,authenticated;
grant select on public.profiles, public.posts, public.comments, public.votes to anon,authenticated;
grant insert,update,delete on public.posts, public.comments, public.votes to authenticated;
-- No direct profile updates in MVP.
drop policy if exists profiles_read on public.profiles;
create policy profiles_read on public.profiles for select to anon,authenticated using (true);
drop policy if exists posts_read on public.posts;
create policy posts_read on public.posts for select to anon,authenticated using (true);
drop policy if exists posts_create on public.posts;
create policy posts_create on public.posts for insert to authenticated with check ((select auth.uid())=user_id);
drop policy if exists posts_update_own on public.posts;
create policy posts_update_own on public.posts for update to authenticated using ((select auth.uid())=user_id) with check ((select auth.uid())=user_id);
drop policy if exists posts_delete_own on public.posts;
create policy posts_delete_own on public.posts for delete to authenticated using ((select auth.uid())=user_id);
drop policy if exists comments_read on public.comments;
create policy comments_read on public.comments for select to anon,authenticated using (true);
drop policy if exists comments_create on public.comments;
create policy comments_create on public.comments for insert to authenticated with check ((select auth.uid())=user_id);
drop policy if exists comments_delete_own on public.comments;
create policy comments_delete_own on public.comments for delete to authenticated using ((select auth.uid())=user_id);
drop policy if exists votes_read on public.votes;
create policy votes_read on public.votes for select to anon,authenticated using (true);
drop policy if exists votes_create on public.votes;
create policy votes_create on public.votes for insert to authenticated with check ((select auth.uid())=user_id);
drop policy if exists votes_delete_own on public.votes;
create policy votes_delete_own on public.votes for delete to authenticated using ((select auth.uid())=user_id);
