-- 국내영업 매출현황(wt-kor-sales) 재고 관리(Oligio·Oligio-X 소모품 출고대장) 테이블
-- Supabase → SQL Editor 에 붙여넣고 Run (1회)
-- 실행 후 "재고 관리" 메뉴 → "출고대장 엑셀 업로드"로 기존 이력을 올리면 됩니다.
create table if not exists public.kor_shipments(
  id         bigint generated always as identity primary key,
  product    text not null,               -- 'Oligio' | 'Oligio-X'
  seq        int,                         -- 화면 표시/정렬 보조용 순번(신규는 자동 max+1)
  data       jsonb not null default '{}'::jsonb,   -- {date,author,category,rep,type,detail,qty:{...},client,dealer,note}
  updated_at timestamptz not null default now(),
  updated_by text
);
create index if not exists kor_shipments_product_idx on public.kor_shipments(product);
create index if not exists kor_shipments_seq_idx on public.kor_shipments(seq);

alter table public.kor_shipments enable row level security;
drop policy if exists kor_shipments_rw on public.kor_shipments;
-- 편집 권한 = 접속 권한(로그인=authenticated 사용자), kor_contracts와 동일한 정책
create policy kor_shipments_rw on public.kor_shipments
  for all to authenticated using (true) with check (true);
