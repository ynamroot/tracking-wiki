# 트래킹 거버넌스 잔여 도구 조사 (원자료)

(Avo·Amplitude Ampli 제외 — 별도 파일. 조사 한계: WebSearch 예산 소진으로 G2/Reddit 커뮤니티 후기 1차 수집은 제한적, 대부분 공식 문서·가격 페이지 직접 확인 기반.)

## 1. Segment Protocols

**푸는 문제:** 검증 + 운영(집행). "Segment가 받는 데이터는 깨끗하고 트래킹 플랜을 따라야 한다". 선제적(proactive)이며 과거 데이터 소급 정리는 안 함. (https://segment.com/docs/protocols/)

**기제와 기술:**
- 트래킹 플랜을 내부적으로 **JSON Schema(draft-07)** 로 표현. UI(스프레드시트형) 또는 JSON 직접 편집. 타입/required/regex, 공통 스키마, CSV 임포트(15MB·10만 행). (https://segment.com/docs/protocols/tracking-plan/create/)
- **검증 시점:** 파이프라인 통과 시 준실시간. 위반은 시간 단위 노출 + 하루 1회 이메일 요약(48시간). (https://segment.com/docs/protocols/faq/)
- **위반 처리 3단계:** ① Forward violations(위반을 별도 Source로 `Violation Generated` 이벤트로 전달, MTU 추가 소모) ② Block(플랜에 없는 이벤트 드롭), Omit Properties(미정의 속성만 제거) ③ Transformation(코드 수정 없이 이름·값 교정). (https://segment.com/docs/protocols/validate/forward-violations/, https://segment.com/docs/protocols/enforce/schema-configuration/, https://segment.com/docs/protocols/transform/)

**사람이 남기는 일:** 계측 코드 작성·호출은 개발자 몫(Typewriter 코드 생성은 되나 심는 건 사람). 버전 관리 시 `context.protocols.event_version` 수동 추가. 위반 원인 추적·플랜 수정·차단 정책 결정.

**한계:** 디바이스 모드(모바일) 이벤트는 차단·속성 생략·JSON 스키마 위반 차단 **불가**(cloud-mode 전용). 소급 불가. Transformation은 조합당 1개 제한. 요소↔이벤트 시각 증빙 없음.

**차단 부작용:** 문서가 강하게 경고 — "전달되지 않은 차단 이벤트는 **영구 복구 불가**". 차단 전 전용 위반 Source로 forward하는 격리(quarantine) 권장.

**가격:** Connections Business/CDP 플랜의 **유료 애드온**. MTU 기반 커스텀 가격. 위반 forward 시 MTU 추가 발생. (https://www.twilio.com/en-us/pricing/customer-data)

## 2. RudderStack Tracking Plans / Data Governance API

**푸는 문제:** 검증 + 운영 + 관측(진단). 스프레드시트 수작업 계측의 오타·단위 오류·누락, 특히 모바일 수정 비용. (https://www.rudderstack.com/blog/rudderstacks-data-governance-api/)

**기제와 기술:**
- 대시보드 편집기 또는 **API/CLI(programmable governance)**로 플랜 정의.
- **검증 시점:** 소스 레벨 실시간(목적지 전송 전). 위반 종류: 미계획 이벤트·속성, 타입 불일치, 필수 누락.
- **위반 처리(핵심 차별점 = 전달 우선):** 기본값이 **propagate** — 위반이 있어도 이벤트를 유지하고 목적지 페이로드에 에러 객체를 붙여 플래그. discard(폐기)·reroute(재라우팅)는 선택지. (https://www.rudderstack.com/knowledge-base/get-started-with-tracking-plans/)
- **Data Governance / Event Audit API:** 실제 수집 이벤트의 스키마·버전 이력·타입에 프로그램 접근 → 누락 키 탐지, 버전 간 키 비교로 **스키마 드리프트** 감지, 키 누락 시 알림 생성 가능. (https://www.rudderstack.com/docs/data-governance/rudderstack-data-governance-api)

**한계:** 스프레드시트 트래킹 플랜 **Deprecated** → API/코드 중심 이동으로 비개발자 진입장벽. 기본이 "전달+플래그"라 나쁜 데이터가 목적지까지 흐름(대신 유실 위험 낮음). 소급 아님. 시각 증빙 없음.

**가격:** 이벤트 볼륨 기반. Free($0, 25만/월, 플랜 1개·이벤트 5개) / Growth($265/월~, 100만~) / Enterprise. **거버넌스가 무료 티어부터 제한적 포함** — Segment(유료 애드온)와 대비. (https://www.rudderstack.com/pricing/)

## 3. Mixpanel Lexicon

**푸는 문제:** 운영·사후 정리. 이미 수집된 이벤트/속성을 문서화·검증·정제하는 **데이터 사전**. 설계 검증·실시간 강제는 약함. (https://docs.mixpanel.com/docs/data-governance/lexicon)

**기제와 기술:**
- 표시명·설명·태그·플랫폼·담당자 부여(표시명은 UI만 변경, 원본 불변).
- **정제 액션:** Hide(쿼리에서만 숨김) / Block(신규 수집만 차단, 복구 불가, 주 용도 민감정보 제거) / Merge(iOS·Android 이표기 통합).
- Verified Data(Enterprise): 관리자가 신뢰 지표에 **수동** "Verified" 배지 — 자동 위반 탐지 아님.
- Lexicon Schemas API 존재하나 강제 검증 게이트로 작동하지 않음.

**괴리 탐지 시점:** **사후·대부분 수동.** 자동 장치는 30일 미활성 이벤트 자동 숨김, 30-Day Volume 지표 정도. **태그 파손을 능동 경보하지 않음** — "수 주 뒤 발견" 문제의식과 정확히 겹치는 빈틈.

**가격:** Free(1M/월) / Growth / Enterprise. **Lexicon·Verified Data는 Enterprise 전용.** (https://mixpanel.com/pricing/)

## 4. mParticle Data Master (현 "Data Plans")

**푸는 문제:** 설계–구현–검증을 잇는 계약 기반. 선언적 스키마("data plan")로 수집 파이프라인에서 위반 대조. 수집 시점 검증에 무게. (https://docs.mparticle.com/guides/platform-guide/data-planning/)

**기제와 기술:**
- 데이터 플랜 = Data Points(최대 1,000개), **JSON Schema** 검증(enum/regex, min/max, additionalProperties). 단 `$ref`, `allOf/anyOf/oneOf`, `if`, `not` 미지원. (https://docs.mparticle.com/developers/apis/dataplanning-api/)
- 작성: Data Plan Builder(Google Sheets 애드온) 또는 JSON 업로드. Snippets Tool로 SDK 코드 스니펫 생성.
- **다층 검증:** ① 클라이언트 측 차단(SDK에 Plan ID/Version 주입 시) ② 수집 후 런타임 검증(Live Stream 실시간) ③ 사후 Violations Report(최대 5분 지연).
- **위반 유형:** Unplanned Event/Attribute, Invalid Attribute. Unplanned는 Allow(기본)/Block 선택.

**개발자 전제:** 강하게 유지 — SDK/API 본문에 `data_plan`(ID+Version)을 **개발자가 직접 넣어야** 검증 작동. 없으면 검증 자체가 실행 안 됨.

**차단 부작용:** 반복 경고 — "blocking will impact your data stream and can lead to data loss." **Quarantine Connection**(차단분 S3 격리 → 수동 backfill) 제공.

**가격:** 공개 가격표 없음, 견적 기반. (https://www.mparticle.com/pricing/)

## 5. Snowplow — 스키마 우선(schema-first)

**한 줄:** 모든 이벤트를 수집 파이프라인 한가운데(Enrich)에서 스키마와 대조 검증하고, 위반은 정상 테이블에 안 넣고 별도 격리. 데이터 품질 운영에 가장 강한 헤비급 인프라.

**기제와 기술:**
- **자체 기술(self-describing) JSON Schema(draft 4).** `iglu:` 주소로 식별. (https://docs.snowplow.io/docs/fundamentals/schemas/)
- **Iglu 레지스트리:** Iglu Server(비공개)/Iglu Central(공개)/Resolver/Igluctl. (https://docs.snowplow.io/docs/api-reference/iglu/)
- **Data Structures:** Draft→development→production 승격. **SchemaVer**(파괴=major, 비파괴=minor, 수정=patch). (https://docs.snowplow.io/docs/data-product-studio/data-structures/)
- **검증 시점:** **Enrich 단계** — 웨어하우스 적재 전 실시간 전수 검증.
- **위반 처리 = 차단 아닌 격리 보존:** **failed events**로 분리, 전량 S3/GCS 백업 → replay 재처리. (https://docs.snowplow.io/docs/understanding-your-pipeline/failed-events/)
- **Data Products/Event Specifications:** 설계→구현→관측 연결. (https://docs.snowplow.io/docs/data-product-studio/event-specifications/)

**개발자 전제:** 유지. Snowtype이 타입 안전 함수를 생성하나 공식 문서 명시 — "호출하는 책임은 개발자에게 남는다." (https://docs.snowplow.io/docs/data-product-studio/snowtype/)

**요소↔이벤트 매핑:** **부분적·수동.** Event Specification의 Event triggers에 스크린샷·URL·설명을 사람이 첨부 가능. DOM 요소↔이벤트 자동 연결·시각 검증은 없음.

**한계:** failed events 복구 수동·전문가 의존. Iglu가 단일 장애점(다운 시 정상 이벤트도 대량 failed). 운영 복잡도·엔지니어링 성숙도 요구 높음.

**가격:** 비공개 견적. Self-Hosted(SLULA) / 관리형. (https://snowplow.io/pricing)

## 6. 신생·인접 도구

**walker.js (walkerOS)** — MIT 오픈소스. **선언적 HTML 태깅**: `data-elb="promotion"`(엔티티), `data-elb-promotion="name:..."`(속성), `data-elbaction="click:select"`(트리거:액션 — load/click/visible/impression/hover/submit/wait/pulse). "화면의 이 요소 = 이 이벤트"가 **마크업 자체에 새겨짐**. "나쁜 이벤트를 수 주 뒤가 아니라 수집 시점에 잡는다"는 스키마 검증 표방. 단 시각 증빙 UI(스크린샷/오버레이) 없음, DOM 결합·규약 학습 곡선. (https://github.com/elbwalker/walkerOS)

**데이터 계약(data contract)** — 규격이지 감지 도구가 아님:
- datacontract-cli(OSS): YAML 계약, 창고/레이크 데이터 검증. 사후 창고 쪽. (https://datacontract.com/)
- ODCS(Linux Foundation): 데이터 제품 단위 거버넌스 합의.
- dbt model contracts: dbt build 시점 검증. 명백히 사후(transform). (https://docs.getdbt.com/docs/collaborate/govern/model-contracts)
- Gable.ai: **shift-left(소스코드/PR)** 정적 분석으로 CI/CD에서 위험 diff 차단. 수집 이전.

**데이터 옵저버빌리티 — 거의 전부 사후(warehouse):**
- Monte Carlo: 신선도·볼륨·스키마·품질·리니지 5축, 적재 후 감지. (https://montecarlo.ai/)
- Great Expectations: 코드 기반 품질 단언. (https://greatexpectations.io/)
- Metaplane: 경량 창고 옵저버빌리티, ML 이상탐지. 사후. (https://www.metaplane.dev/)

핵심: Monte Carlo류는 브라우저 태그 파손을 실시간으로 못 잡고 "깨진 데이터가 창고에 쌓인 뒤" 알림 → "수 주 뒤 발견"의 지연 구간(브라우저→창고)을 앞당기지 못함.

## 교차 정리 (지정 질문)

| 질문 | 답 |
|---|---|
| 개발자 수기 계측 전제 유지? | 상용/스키마 도구 **전부 유지**. 코드 생성기(Typewriter/Snowtype/Snippets)는 함수만 만들고 호출 삽입은 사람. **walker.js만 선언적 HTML 태깅으로 부분적으로 깬다** |
| 괴리 탐지 시점 | Mixpanel=사후·수동 / RudderStack=소스 실시간 / Segment=파이프라인 준실시간 / mParticle=수집·클라이언트 실시간 / Snowplow=Enrich 실시간 전수 / Monte Carlo류=창고 적재 후 / Gable=배포 전(PR) |
| 요소↔이벤트 시각 매핑·증빙 | **거의 모두 없음.** Snowplow만 스크린샷 수동 첨부. walker.js는 매핑이 HTML에 드러나나 시각 증빙 UI 없음 → **가장 넓은 공백** |
| 차단 유실 부작용 | Segment=영구 폐기 경고+격리 권장 / mParticle=경고+Quarantine+수동 backfill / Snowplow=격리 보존+replay / RudderStack=기본 propagate |

## ① 공통 패턴

1. **전부 "데이터 페이로드" 계층에서 동작** — 이벤트=JSON을 스키마와 대조. 화면 UI 계층은 다루지 않음
2. **개발자 수기 계측이 전제로 남음**
3. **JSON Schema 계열이 사실상 표준**
4. **검증 시점 스펙트럼:** 코드/PR(Gable) → 수집(walker.js, mParticle) → 파이프라인(Segment, RudderStack, Snowplow) → 사후 창고(Monte Carlo, Mixpanel)
5. **차단 vs 전달의 두 철학.** 업계 합의는 "차단=유실 위험"이라 격리/전달이 안전
6. **알림·경보는 대체로 약함** — "태그 파손을 능동 경보"하는 체계는 미명시가 많음

## ② 공백 지대 (PRD 기회)

1. **요소↔이벤트 시각적 매핑·증빙** — 스크린샷/셀렉터로 자동 증빙하는 도구 없음. 가장 명확한 차별화 축
2. **비개발자/노코드 계측** — walker.js(선언적 태깅) 정도. 자동 계측 생성은 빈 영역
3. **배포 전 검증** — 대부분 "배포 후 흐르는 데이터"만 봄
4. **능동 경보 루프** — "수 주 뒤 발견"의 실제 원인은 탐지 지연보다 운영 루프 부재일 수 있음
5. **차단 없는 안전한 조기 탐지** — 차단은 유실 위험으로 도입 장벽 → "차단 없이 조기 경보"가 실무 수요

## ③ 용어집 후보

- **Tracking Plan**: 수집할 이벤트·속성을 규정한 단일 진실 원천(대개 JSON Schema)
- **Violation(위반)**: 이벤트/속성이 플랜과 불일치하는 사건
- **Blocked event(차단 이벤트)**: 위반으로 드롭된 이벤트. 격리 안 하면 영구 폐기
- **Schema registry**: 스키마를 저장·배포하는 중앙 저장소(Snowplow Iglu)
- **Self-describing event**: 자기 스키마 주소를 품은 커스텀 이벤트
- **Entity/Context**: 이벤트에 붙는 부가 맥락(사용자·상품·화면)
- **Enrichment(보강)**: Snowplow가 스키마 검증을 수행하는 파이프라인 단계
- **Failed events**: 검증 실패로 격리·백업되는 이벤트(replay 재처리)
- **Propagate**: 위반 이벤트를 버리지 않고 에러 플래그를 붙여 통과(RudderStack 기본)
- **Quarantine(격리)**: 차단·실패 데이터를 별도 보관해 복구 가능하게(mParticle S3)
- **Schema drift**: 실제 이벤트 구조가 계획에서 벗어나는 현상
- **Transformation**: 코드 수정 없이 이벤트/속성 이름·값 교정(Segment)
- **SchemaVer**: 파괴=major/비파괴=minor/수정=patch 스키마 버전 규칙(Snowplow)
- **Data contract**: 생산자-소비자 간 스키마·품질·SLA의 형식적 합의
- **Data observability**: 신선도·볼륨·스키마·분포·리니지 사후 모니터링
- **Shift-left**: 검증을 소스코드/PR 단계로 앞당기는 접근(Gable)
- **Verified Data**: 관리자가 수동 부여하는 신뢰 배지(Mixpanel)
