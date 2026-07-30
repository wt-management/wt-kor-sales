-- 국내영업 매출현황(wt-kor-sales) 메시지 기능용 테이블
-- Supabase → SQL Editor 에 붙여넣고 Run
create table if not exists public.kor_messages(
  id         bigint generated always as identity primary key,
  scope      text not null,            -- 'board' (팀 보드) | 'c:<계약번호>' (계약별 메모)
  author     text not null,            -- 작성자 표시명
  body       text not null,
  created_at timestamptz not null default now()
);
create index if not exists kor_messages_scope_idx on public.kor_messages(scope, created_at desc);

alter table public.kor_messages enable row level security;
drop policy if exists kor_messages_rw on public.kor_messages;
-- 로그인(authenticated) 사용자만 읽기/쓰기/삭제
create policy kor_messages_rw on public.kor_messages
  for all to authenticated using (true) with check (true);
