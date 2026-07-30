-- 국내영업 매출현황(wt-kor-sales) 계약 데이터 편집용 테이블
-- Supabase → SQL Editor 에 붙여넣고 Run (1회)
-- 실행 후 기존 459건은 관리자가 cons_cache(kor_sales)에서 이관합니다.
create table if not exists public.kor_contracts(
  id         bigint generated always as identity primary key,
  no         int,                       -- 화면 표시용 계약번호(신규는 자동 max+1)
  data       jsonb not null default '{}'::jsonb,   -- 계약 전체(거래처·제품·일자·금액 등)
  updated_at timestamptz not null default now(),
  updated_by text
);
create index if not exists kor_contracts_no_idx on public.kor_contracts(no);

alter table public.kor_contracts enable row level security;
drop policy if exists kor_contracts_rw on public.kor_contracts;
-- 편집 권한 = 접속 권한(로그인=authenticated 사용자)
create policy kor_contracts_rw on public.kor_contracts
  for all to authenticated using (true) with check (true);
