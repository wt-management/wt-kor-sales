# wt-kor-sales — 국내영업 매출현황 (담당: 영업전략파트 / 이혜린 대리)

이 repo는 **국내영업 매출현황** 사이트 한 개(`index.html`)만 담습니다. 배포 주소: https://wt-management.github.io/wt-kor-sales/

## 이 사이트가 하는 일
원텍 국내 거래처별 계약체결 리스트(엑셀)를 분석하는 로그인형 대시보드. Supabase `cons_cache` 테이블의 **key='kor_sales'** 한 행(JSON)을 읽어 종합/담당자/제품/채널·지역/수금/계약리스트/미납 7개 뷰를 그립니다. 계약 건별 원본이 담겨 있어 **민감정보(거래처·대표자·사업자번호·이메일·금액)** 사이트입니다.

## 고칠 때 규칙 (꼭 지켜주세요)
1. **비밀키 금지** — `sb_secret_...`(서비스키)를 코드에 절대 넣지 마세요. 이 파일에 있는 `SUPA_KEY`(sb_publishable_...)는 공개용 anon 키라 괜찮습니다.
2. **민감 데이터 임베드 금지** — 계약/거래처 실데이터를 index.html 안에 직접 써넣지 마세요. 항상 Supabase에서 읽습니다.
3. **접근 게이트·공용 스니펫 수정 주의** — `allowed()`(누가 들어올 수 있는지), `boot/doLogin/doLogout`, `renderSwitcher`(사이트 이동), SSO(`_sso`) 부분은 전 사이트 공통 로직이라 이유 없이 바꾸지 마세요. 화면/분석 로직만 고치면 대부분 안전합니다.
4. **매출월 기준** — 월 필터·월별추이는 `saleMonth`(매출월)만 씁니다(계약월 폴백 금지). 매출월 미지정 건은 '전체'에만 잡힙니다.
5. **올리기 전 확인** — 저장 후 Claude Code에게 "문법 확인해줘"(node로 `<script>` 파싱 검사) 요청. 브랜치 보호가 없어 **main에 push하면 1~2분 뒤 바로 라이브**됩니다. 잘못 올렸으면 `git revert`로 되돌릴 수 있습니다.

## 데이터 갱신
엑셀이 바뀌면 소유자(박민우 과장)가 `cons_cache` key='kor_sales'를 다시 씁니다. 이 사이트 코드는 데이터를 읽기만 합니다.

## 관련
- 중앙 런처: https://wt-management.github.io/wontech/ (이 사이트는 '영업전략파트' 그룹 카드)
- 사이트 목록/권한: Supabase `site_registry` 테이블(key='kor_sales')
