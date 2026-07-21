# 오토캡처 진영과 태그매니저 계층 조사 (원자료)

# 파트 A. 오토캡처 · 리트로액티브 분석 도구

## A-1. Heap — 오토캡처의 원조

**동작 원리**
- 스니펫 하나를 심으면 모든 클릭·페이지뷰·폼 제출을 자동 수집. 원시 데이터는 쌓여 있다가 필요할 때 **Virtual Event**(원시 데이터를 가리키는 사람이 읽을 수 있는 이름)를 만들어 분석 단위로 사용(https://www.heap.io/blog/how-autocapture-actually-works)
- Virtual Event는 **소급(retroactive)** 적용 — 설치 6개월 후 정의해도 6개월치 데이터가 딸려 옴. 정의 수정·병합도 과거 데이터에 반영
- 정의는 엔지니어 없이 **Event Visualizer**(웹) / **Visual Labeling**(iOS·Android)의 포인트-앤-클릭 UI로 생성. 모바일은 스크린샷과 요소 설명 표시(https://help.heap.io/hc/en-us/articles/37271984144145, https://help.heap.io/hc/en-us/articles/37271975568273)
- 입력값 자체는 수집하지 않음(민감정보 보호) — 장바구니 금액 같은 커스텀 값은 자동으로 못 얻는 한계와 동전의 양면

**화면 개편으로 이벤트가 깨질 때 — Heap의 대응 장치**
1. **Combo Event**: 마크업 변경으로 기존 정의가 매칭을 멈추면, 새 버전용 정의를 만들고 구버전과 합쳐 "모든 화면 개편 이력에 걸친 추적을 코딩 없이 복원"
2. **비활성(Inactive) 감지**: 72시간 데이터 없는 이벤트에 모래시계 표시(https://help.heap.io/hc/en-us/articles/37272012135057)
3. **Event Repair Flow**: 깨진 이벤트 라벨을 "Repair Event" 버튼으로 수리 — 저장된 차트·대시보드·다운스트림 싱크를 깨뜨리지 않고 정의만 교체(https://help.heap.io/hc/en-us/articles/37271998625169)
4. **검증(Verification)**: Admin/Architect가 이벤트·속성·세그먼트에 "검증됨" 표시 — 자동수집 데이터의 신뢰 문제를 사람의 큐레이션으로 보완(https://help.heap.io/hc/en-us/articles/37271986796433)

**시사점**: 오토캡처 원조조차 "수집은 자동, 의미 부여·검증·수리는 사람". 정의 파손을 막지 못하고 **깨진 후 사람이 고치는 흐름**을 제품화.

## A-2. PostHog — Autocapture + Actions + Toolbar

- **Autocapture 범위**: `a, button, form, input, select, textarea, label` 태그의 클릭·입력 변경·제출 자동 수집. 그 외 요소는 수동 설정(https://posthog.com/docs/data/actions)
- **Actions** = 사후 정의 계층. 매칭 기준 3가지: ① 텍스트 매칭 ② URL 매칭 ③ CSS 셀렉터(복수 조건 AND). 소급 적용
- **Toolbar** = 화면 위 시각 태깅. 요소 클릭 시 내부적으로 CSS 셀렉터를 자동 생성해 Action 생성(https://posthog.com/docs/toolbar)
- **셀렉터 취약성 자체 인정**: 공식 튜토리얼이 "CSS 클래스·위치 기반(:nth-child) 셀렉터는 마크업 변경 시 깨질 수 있으니 `data-*` 속성을 붙이라"고 권고 — **안정적 사후 정의를 위해 결국 개발자가 사전에 앵커를 심어야 하는 역설**(https://posthog.com/tutorials/css-selectors-for-actions)
- 셀렉터 문법 제약: 와일드카드, 복수 속성 셀렉터 결합, 하이픈 포함 클래스 미지원

## A-3. Fullstory · Pendo

- **Fullstory**: 태깅 없이 세션 전체 캡처, 이벤트 추출을 서버 측에서 수행해 소급 질의 가능. Inspect 모드가 CSS 셀렉터를 찾아주고 노이즈 속성을 제거한 "optimized selector" 제안(https://www.fullstory.com/blog/technical-considerations-for-session-replay-solutions/)
- **Pendo**: Feature tagging — Visual Design Studio가 요소 클릭 시 셀렉터 자동 생성. 프라이버시 규칙도 Feature 셀렉터 재사용(https://support.pendo.io/hc/en-us/articles/360031950492)

## A-4. Amplitude · Mixpanel의 후발 도입 — 비판자들의 전향

- **Amplitude**: 2022년 "Auto-track is [Still] Bad!"(Adam Greco)로 정면 비판 → **2024년 Autocapture + Visual Labeling 출시**(https://amplitude.com/blog/autotrack-is-bad, https://amplitude.com/blog/introducing-autocapture)
  - Labeled Event는 Heap Virtual Event와 동형. 라벨은 이벤트 과금량에 미추가. Live events·User Lookup·Session Replay 스트림에는 라벨 안 보이는 제약
  - 파손 대응 공식 명시: "DOM 변경은 Visual Labeling의 요소 참조를 깨뜨릴 수 있다. 다만 Autocapture가 원시 클릭을 계속 수집하므로 라벨 정의를 갱신해 데이터 공백을 메울 수 있다" — 원시 수집의 연속성이 정의 파손의 보험(https://amplitude.com/docs/data/visual-labeling)
  - 현 공식 입장: "택일 아닌 병행" — 오토캡처로 빠른 시작 + 핵심 지표는 수동 계측
- **Mixpanel**: 2024년 12월 웹 Autocapture 알파 → 전 플랜 확대. 페이지뷰·스크롤·폼 제출·클릭·dead click·rage click 수집, `$mp_` 접두사(https://docs.mixpanel.com/docs/tracking-methods/autocapture)
  - **스스로 명시한 한계**: HTML 구조 속성(class, name, aria-label, role, title, type)만 수집, **커스텀 속성(비즈니스 데이터) 수집 불가**. "깊은 분석에는 정밀 트래킹 병행" 권고

## A-5. 오토캡처 논쟁 — 논점 정리

**비판 측 (Amplitude 2022, Adam Greco)** (https://amplitude.com/blog/autotrack-is-bad)
1. 데이터 과잉: 신호를 잡음이 뒤덮음
2. 데이터 품질: 요소 이름 하나만 바꿔도 핵심 지표가 깨지고, 그때마다 사람이 감시·청소 필요. 분석 신뢰 붕괴
3. 가짜 시간 절약: "오토트래킹은 일을 없애지 않는다. **일을 덜 확장 가능한 공정으로 옮길 뿐**"(공동창업자 Jeffrey Wang)
4. 보안·프라이버시: 의도치 않은 민감정보 수집 → GDPR/CCPA 리스크
5. Level 0/1/2 프레임: 분석 대부분은 소수의 안정적 핵심 이벤트로 충분 — "전수 수집의 시간 절약"은 허상

**반박 측 (PostHog "Is autocapture 'still' bad?")** (https://posthog.com/blog/is-autocapture-still-bad)
- 과잉: 도구의 필터링 역량 문제로 환원 / 품질: Data Management로 관리 가능, 수동 계측에도 품질 문제 존재 / 시간: 수동 계측은 엔지니어·PM 일을 늘림, 하이브리드 최적 / 보안: 선택적 수집·셀프호스팅으로 방어

**실무 합의**: "오토캡처로 베이스라인 + 핵심 KPI 10~20개는 구조화 속성과 함께 수동(가급적 서버사이드) 계측" 하이브리드로 수렴(https://amplitude.com/explore/data/autocapture-vs-manual-tracking)

# 파트 B. 태그 매니저 계층

## B-1. Google Tag Manager

**핵심 구조**
- **Tag**: 실행 단위(GA4 이벤트 전송, 픽셀, Custom HTML/JS)
- **Trigger**: 발화 조건 — 클릭(gtm.click/gtm.linkClick), **Element Visibility**(요소가 뷰포트에 N%·M초 보이면 발화, ID/CSS 셀렉터로 지정), **History Change**(SPA 라우팅 감지)(https://support.google.com/tagmanager/answer/7679410)
- **Variable**: 값 추출 — 내장 변수(Click Classes·Click Text), **DOM Element 변수**(CSS 셀렉터로 값 긁기), **Custom JavaScript 변수**(https://support.google.com/tagmanager/answer/7182738)
- **dataLayer**: 개발자가 구조화된 값을 밀어 넣는 공식 통로. 실무 권고는 "DOM 스크레이핑 대신 dataLayer 우선"(https://mixedanalytics.com/blog/dom-scraping-data-layer-gtm-custom-js-variables/)

**커스텀 JS 하드코딩 발생 3유형**(https://www.analyticsmania.com/post/dom-scraping-with-google-tag-manager/)
1. **값 추출**: dataLayer에 없는 값(가격·상품명)을 querySelector로 DOM에서 긁기 — 개발 리소스 없어 dataLayer를 못 깔 때의 우회로
2. **조건 로직**: 트리거 조건으로 표현 안 되는 분기(closest()로 조상 탐색 등)
3. **요소 식별**: 클릭 타깃이 아이콘/스팬으로 잡힐 때 실제 버튼을 찾아 올라가는 로직

**취약성**: "개발자가 CSS 클래스·ID를 바꾸면 변수가 작동을 멈춘다. DOM 스크레이핑은 페이지의 모든 것이 그대로라는 가정에 의존" — 오토캡처의 셀렉터 취약성과 같은 문제가 태그매니저 안에서도 재현

**버전 관리·QA의 실체**
- 컨테이너 버전 관리 + Preview 모드(Tag Assistant). 페이지를 넘나들며 태그 발화·dataLayer 상태 확인, 디버그 세션 공유(https://www.simoahava.com/analytics/new-preview-mode-google-tag-manager/)
- **하지만 Preview는 사람이 직접 돌리는 세션 기반 수동 디버깅**. 프로덕션 상시 자동 검증 아님 — "발행 후에도 계속 잘 돌아가는가"는 아무도 지켜보지 않음

**컨테이너 부채(container debt)**
- 죽은 태그·중복 스크립트·트리거 없는 태그 누적. 경험칙: 컨테이너 JSON 50kb 미만 건강, 200kb 초과 대청소 필요. "발화 0회 태그는 고장났거나 불필요"(https://metricvibes.com/blog/how-to-audit-clean-up-bloated-gtm-container/)
- "6개월 안에 다시 비대해지는 컨테이너는 기술 문제가 아니라 **거버넌스 문제**". 권고 관행(태그 설명 필드, 만료일 명명, 분기별 감사)은 전부 사람의 규율에 의존

## B-2. Tealium iQ · Adobe Launch

- **Tealium iQ**: 1,000+ 턴키 벤더 통합, 유니버설 데이터 레이어, 데이터 거버넌스·프라이버시·컴플라이언스 강조, 생태계 중립(https://www.reflectiz.com/blog/tealium-vs-google-tag-manager/)
- **Adobe Launch**: Adobe Experience Cloud 무료 통합, 자사 생태계 결합 강점

## B-3. "플랜 ↔ 설정 ↔ 실발생" 대조 공백과 검증 계층

태그매니저 자체에는 플랜↔설정↔실발생 자동 대조 기능이 없다. "스프레드시트의 플랜은 표류(drift)하고, CI에 연결된 플랜만 유지된다."

| 도구 | 접근 | 기준선 |
|---|---|---|
| ObservePoint | 크롤러가 전 페이지 주기 순회, 태그 발화·정확성·프라이버시 감사 | 사람이 정의한 규칙 + 스케줄 스캔 |
| DataTrue | 시나리오 시뮬레이션 기반 태그 테스트 + 커스텀 검증 규칙 + PII 감시 | 사람이 정의한 테스트 |
| Trackingplan | 실사용자 트래픽을 청취해 이벤트·속성·목적지 자동 매핑, **기준선 자동 학습** 후 이탈(누락·스키마 변화·네이밍 위반·깨진 픽셀) 24/7 감지 | 자동 학습 (https://www.trackingplan.com/) |
| Avo Inspector | 클라이언트 발생 이벤트의 스키마만 추출해 플랜과 대조 — 미구현·예상밖 속성·타입 불일치를 소스별 신호등 표시 | 사람이 만든 플랜 |

단, 이들은 모두 **관측·경보까지만**. 깨진 설정을 고치거나 새 요소를 계측하는 실행(acting) 계층은 없음. ObservePoint류는 스케줄 스캔이라 "감사와 실제 장애 사이의 시차" 문제(https://www.trackingplan.com/blog/observepoint-competitors)

# ① 두 진영의 트레이드오프 표

| 축 | 오토캡처(사후 정의) | 명시 계측 + 태그매니저(사전 정의) |
|---|---|---|
| 커버리지 | 전수(DOM 상호작용 한정) | 계측한 것만 — 담당자 리소스에 비례 |
| 소급 분석 | 가능(설치 시점까지) | 불가 |
| 의미(semantics) | 없음 — 수집 후 사람이 라벨로 부여 | 계측 시점에 내장 |
| 커스텀 속성(금액 등) | 수집 불가(HTML 구조 속성만) | dataLayer/코드로 자유롭게 전달 |
| 화면 개편 내성 | 원시 수집은 계속되나 정의(셀렉터)가 깨짐 → 사후 수리 | dataLayer 기반이면 강함, 셀렉터 트리거면 똑같이 깨짐 — 깨짐 감지 장치조차 없음 |
| 비용 | 이벤트 볼륨·저장 비용 급증 | 볼륨 통제 가능 |
| 사람의 일 | 셋업↓, 사후 큐레이션·청소·수리↑ | 사전 설계·개발 티켓·QA↑ |
| 포기한 것 | 의미와 신뢰 | 커버리지와 소급성 |

**핵심 통찰**: 두 진영 모두 **"불안정한 UI 표면에 셀렉터로 의미를 고정하는 문제"**를 공유. 오토캡처는 사후 수리 UI로, 태그매니저는 dataLayer 규율(개발자 협조 필요)로 회피할 뿐 어느 쪽도 자동 해결 못함. 2024년 이후 논쟁은 "택일"에서 "하이브리드 + 관리 도구"로 이동.

# ② 공백 지대 (PRD 관점)

1. **깨짐의 자동 복구 부재**: Heap조차 사람이 Repair 버튼으로 수리. 화면 개편 후 요소를 자동 재매칭해 정의를 갱신하는 도구는 확인되지 않음
2. **관측과 실행의 단절**: 검증 계층(Trackingplan, Avo Inspector, ObservePoint)은 "깨졌다/누락됐다"까지만. 계측 추가·수정 실행은 다시 사람(개발 티켓)
3. **태그매니저의 무감시 지대**: GTM Preview는 발행 전 수동 QA뿐. 태그매니저 설정 자체(컨테이너 내부)와 플랜을 대조하는 도구는 사실상 없음 — 기존 검증 도구는 네트워크에 나가는 이벤트만 봄
4. **커버리지 확장의 주체 부재**: "무엇을 계측해야 하는지 스스로 찾아다니며 커버리지를 넓히는 주체"는 양 진영 모두 공백

# ③ 용어집 후보

| 용어 | 뜻 |
|---|---|
| Autocapture(오토캡처) | 스니펫 하나로 클릭·페이지뷰 등 상호작용을 전수 자동 수집 |
| Retroactive analytics(소급 분석) | 수집해 둔 원시 데이터에 나중에 정의를 만들어 과거까지 분석 |
| Virtual Event / Labeled Event | 원시 오토캡처 데이터를 가리키는 사람이 읽을 수 있는 이름(사후 정의 단위) |
| Visual tagging / Visual Labeling | 화면 위에서 요소를 클릭해 이벤트를 정의(내부적으로 셀렉터 자동 생성) |
| Codeless tracking | 코드 수정 없는 이벤트 정의의 총칭 |
| Action (PostHog) | 셀렉터·텍스트·URL로 사후 매칭되는 이벤트 묶음, 소급 적용 |
| Combo Event / Event Repair | 화면 개편으로 깨진 정의를 구·신 버전 결합/재정의로 수리 |
| dataLayer | 개발자가 구조화된 값을 태그매니저에 전달하는 공식 통로 |
| DOM scraping | dataLayer 없이 CSS 셀렉터로 화면에서 값을 긁는 우회 — 개편 시 파손 |
| Trigger / Tag / Container | GTM의 발화 조건 / 실행 단위 / 설정 묶음 |
| Element Visibility trigger | 요소가 뷰포트에 N%·M초 보이면 발화(노출 추적) |
| Container debt / Tag bloat | 죽은 태그·중복 태그가 쌓인 방치 상태 |
| Tracking plan drift | 문서상 플랜과 실제 구현·발생 이벤트의 괴리 |
| Implementation status | 플랜 대비 실발생 이벤트의 구현·정합 상태 표시(Avo) |
| Dead click / Rage click | 무반응 클릭 / 좌절성 연타 — 오토캡처가 추가로 잡는 UX 신호 |
