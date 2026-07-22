# 트래킹 플랜 자동화 — 용어집

이 문서는 원자료 리서치(`research/raw/`의 8개 파일)에 등장한 기술 용어를 주제별로 묶어 우리말로 풀어 쓴 것이다. 독자는 데이터매니저·기획자·프론트엔드 개발자 누구나로 잡았다. 풀이는 원자료에 나온 내용만 근거로 삼았고, 출처 URL이 원자료에 있는 용어는 그대로 이어 붙였다(없으면 생략).

용어 뒤 괄호는 원어, 줄표(—) 뒤는 한 줄 풀이, 그 아래 들여쓴 줄은 필요할 때만 붙인 보충(어느 도구가 쓰는 개념인지 등)이다.

---

## ① 계측·트래킹 플랜 기본

이벤트를 "심는" 일과 그 설계도에 관한 기본 낱말들.

- **트래킹 플랜(tracking plan)** — 어떤 이벤트·속성을 어떻게 수집할지 미리 정한 명세. 대개 표나 JSON Schema 형태다.
  - 제품·개발·분석·비즈니스 팀이 함께 보는 기준 문서로 쓰인다. Avo·Amplitude·Segment·RudderStack·mParticle이 모두 이 개념을 중심에 둔다.
- **단일 진실 원천(single source of truth)** — "이벤트에 대한 정답은 여기 하나뿐"이라고 정해 둔 기준. 트래킹 플랜이 그 역할을 한다. ([Avo Tracking Plan](https://www.avo.app/docs/data-design/avo-tracking-plan))
- **이벤트·속성(event / property)** — 이벤트는 추적하는 행동 한 단위(예: "로그인"), 속성은 그 이벤트에 딸린 데이터 필드(예: 로그인 방식). 속성은 이벤트용·사용자용·그룹용으로 나뉘기도 한다.
- **소스·목적지(source / destination)** — 소스는 데이터를 내보내는 앱·플랫폼(iOS·Android·웹·백엔드), 목적지는 데이터를 받는 분석 도구.
- **수동 계측(manual instrumentation)** — 개발자가 코드에 직접 이벤트 발생 코드를 심는 것. 조사한 상용 도구는 사실상 전부 이 전제를 유지한다(코드 생성기가 함수를 만들어 줘도 "어디서·언제" 호출할지는 사람 몫).
- **코드젠(codegen)** — 트래킹 플랜 명세에서 계측용 코드(타입 안전 함수)를 자동 생성하는 것. 심는 노동은 줄지 않지만 오타·타입 오류는 준다.
  - 도구별 이름이 다르다: Avo Codegen, Amplitude Ampli, Segment Typewriter, Snowplow Snowtype, mParticle Smartype, RudderStack RudderTyper. Mixpanel은 코드젠이 없다.
- **타입 안전 래퍼(type-safe wrapper)** — 분석 SDK를 감싸, 잘못된 값·빠진 필수 속성을 코드 실행 전이나 실행 중에 걸러 주는 함수 묶음. 코드젠이 만들어 내는 결과물이다.
- **택소노미(taxonomy)** — 회사 전역에서 통일한 이벤트 이름 규칙·분류 체계. 이름이 제각각인 문제를 막는 표준이다.
- **선언적 태깅(declarative tagging)** — HTML 마크업에 속성(예: `data-elb=...`)으로 수집 규칙을 직접 새겨, "이 요소가 이 이벤트"라는 매핑이 코드에 드러나게 하는 방식(walker.js/walkerOS). ([walkerOS](https://github.com/elbwalker/walkerOS))
- **소급 분석(retroactive analytics)** — 원시 데이터를 일단 다 모아 두었다가, 나중에 정의를 만들어 과거 데이터까지 거슬러 분석하는 방식. 오토캡처 계열의 강점. ([Heap: 오토캡처 원리](https://www.heap.io/blog/how-autocapture-actually-works))
- **서버사이드 계측(server-side tracking)** — 브라우저·앱이 아니라 서버에서 이벤트를 보내는 방식. 핵심 지표는 이렇게 심는 걸 권장한다는 실무 합의가 있다.
- **하이브리드 계측(hybrid tracking)** — 오토캡처로 기본선을 빠르게 깔고, 핵심 지표 10~20개는 구조화 속성과 함께 수동 계측하는 절충. 2024년 이후 업계가 수렴한 방식. ([Amplitude: 오토캡처 vs 수동](https://amplitude.com/explore/data/autocapture-vs-manual-tracking))

---

## ② 스키마·검증

데이터가 규격에 맞는지 확인하는 장치들.

- **스키마(schema)** — 이벤트의 구조 규격(어떤 속성이 어떤 타입인지, 무엇이 필수인지). 업계 표준 표현이 JSON Schema다.
- **JSON Schema** — 데이터 구조를 기계가 읽을 수 있게 적은 규격. 트래킹 검증의 사실상 표준이다.
- **스키마 레지스트리(schema registry)** — 스키마를 한곳에 저장하고 파이프라인 곳곳에 나눠 주는 창구. Snowplow에선 Iglu가 이 역할을 한다. ([Iglu 소개](https://docs.snowplow.io/docs/api-reference/iglu/))
- **자기기술 이벤트(self-describing event)** — 데이터 안에 "나는 이 스키마를 따른다"는 주소를 함께 담아, 데이터가 자기 규격을 들고 다니게 만든 이벤트. Snowplow가 `iglu:` 주소로 식별한다. ([Self-describing schemas](https://docs.snowplow.io/docs/fundamentals/schemas/))
- **SchemaVer** — 스키마 전용 버전 표기법. `1-0-0`처럼 세 숫자를 하이픈으로 잇고, 깨는 변경=첫 숫자(major), 부분 호환=둘째(minor), 완전 호환=셋째(patch)로 구분한다(Snowplow). ([SchemaVer](https://docs.snowplow.io/docs/fundamentals/schemas/versioning/))
- **스키마 진화(schema evolution)** — 과거 데이터를 깨뜨리지 않으면서 스키마를 바꿔 가는 것(예: 선택 필드 추가). ([Data Contract CLI Changelog](https://cli.datacontract.com/CHANGELOG.html))
- **스키마 검증(schema validation)** — 실제 들어온 이벤트가 규격과 맞는지 대조하는 것. 어긋나면 위반으로 잡는다.
- **컴파일 타임 검증 / 런타임 검증** — 컴파일 타임은 코드를 실행하기 전에 타입 시스템이 오류를 잡는 것, 런타임은 코드가 실제 도는 중에 값·타입·필수 필드 위반을 잡는 것. 코드젠 도구는 대개 두 층을 함께 쓴다.
- **AJV** — 자바스크립트에서 JSON Schema를 런타임에 검사하는 라이브러리. Segment Typewriter의 JS/TS 클라이언트가 잘못된 호출을 크래시 대신 경고로 남기는 데 쓴다.
- **이벤트 스키마·버전(event schema / version)** — 이벤트 하나의 이름·속성·필수 여부 규격. 버전을 매겨 관리하고, 관측 도구가 이 버전과 실제 데이터를 대조한다(Amplitude Observe). ([validate-events](https://amplitude.com/docs/data/validate-events))
- **데이터 플랜·데이터 포인트(data plan / data points)** — mParticle의 트래킹 플랜에 해당. 플랜 하나에 데이터 포인트(검증 단위) 최대 1,000개를 두고, 각 포인트를 JSON Schema로 검증한다. ([Data Plans 가이드](https://docs.mparticle.com/guides/platform-guide/data-planning/))
- **Data Structures(초안→개발→운영 승격)** — Snowplow에서 스키마를 초안(draft)→개발(development)→운영(production)으로 단계 승격시키는 관리 절차. 초안은 검증에 쓰이지 않는다. ([Data Structures](https://docs.snowplow.io/docs/data-product-studio/data-structures/))
- **CI 계측 누락 검사(avo status / ampli status)** — 배포 파이프라인(CI)에 붙여, 플랜에는 있는데 코드에 안 심긴 이벤트가 있으면 오류로 막는 검사. Avo·Amplitude가 제공한다. ([Avo Validate](https://www.avo.app/docs/workflow/validate))

---

## ③ 감지·모니터링·옵저버빌리티

이미 흐르는 데이터가 이상해졌는지 지켜보는 접근들.

- **데이터 옵저버빌리티(data observability)** — 데이터와 파이프라인의 건강 상태를 지속 감시해 사고를 조기에 알리는 접근. 스키마를 미리 강제하지 않고, 이미 쌓인 데이터가 평소와 다르게 행동하는지를 본다. ([Monte Carlo: 데이터 옵저버빌리티란](https://montecarlo.ai/blog-what-is-data-observability))
- **다섯 기둥(five pillars)** — 데이터 건강을 재는 다섯 축: 신선도·볼륨·품질(분포)·스키마·계보. Monte Carlo가 정리한 틀. ([Monte Carlo](https://montecarlo.ai/blog-what-is-data-observability))
- **신선도(freshness)** — 데이터가 얼마나 최신인지, 테이블이 얼마나 자주 갱신되는지. ([Monte Carlo](https://montecarlo.ai/blog-what-is-data-observability))
- **볼륨(volume)** — 데이터 양(행 수)이 갑자기 늘거나 줄었는지, 누락·중복이 있는지 감시하는 축. ([Monte Carlo](https://montecarlo.ai/blog-what-is-data-observability))
- **계보(lineage)** — 데이터가 어디서 와서 어디로 흘러가는지의 연결. 깨졌을 때 영향받는 하류와 원인이 된 상류를 추적한다. 단, 이 계보는 웨어하우스 안까지만 이어지고 앱 코드·화면까지는 못 내려간다. ([Monte Carlo](https://montecarlo.ai/blog-what-is-data-observability))
- **분포·품질(distribution / quality)** — NULL 비율, 고유값 비율, 값이 허용 범위 안에 있는지 등 값 자체의 건강.
- **기준선 학습(ML baseline)** — 머신러닝이 내 데이터의 "정상 패턴"을 자동으로 익혀 정상 범위를 세우고, 벗어나면 알리는 방식. 임계값을 손으로 설정하는 부담을 던다. ([Monte Carlo](https://montecarlo.ai/blog-what-is-data-observability))
- **이상 감지·그레이 밴드(anomaly detection / grey band)** — 들어오는 데이터를 학습한 정상 패턴과 계속 대조해 벗어남을 잡는 것. 계절·캠페인에 따라 정상 범위를 동적으로 넓혀(그레이 밴드) 일시적 변화로 인한 오경보를 줄인다(Trackingplan). ([이상 감지란](https://www.trackingplan.com/blog/what-is-traffic-anomaly-detection-for-marketers-en))
- **알림 피로·오탐(alert fatigue / false positive)** — 쓸모없는 알림이 너무 많아 담당자가 무뎌지는 것(피로), 문제가 없는데 잘못 울리는 알림(오탐). 옵저버빌리티 도입 초기의 대표 과제.
- **스키마 드리프트(schema drift)** — 실제 이벤트 구조가 원래 명세에서 시간이 지나며 벗어나는 현상.
- **트래킹 플랜 드리프트(tracking plan drift)** — 문서상 계획과 실제 구현·발생 이벤트가 어긋나는 것. 스프레드시트 플랜은 표류하고, CI에 연결된 플랜만 유지된다는 지적이 있다.
- **트래픽 청취·수동 관찰(passive monitoring)** — 봇이 화면을 돌아다니지 않고, 실제 이용자가 발생시키는 네트워크 요청을 옆에서 엿듣기만 하는 감시 방식. Trackingplan이 이 방식이다.
- **딥 오딧(deep audit)** — 상시 감시와 별도로, 매일 한 번 세션 단위(깨진 퍼널 순서·중복 발생·도구 간 불일치)를 배치로 점검하는 것(Trackingplan). ([Deep Audits 문서](https://www.trackingplan.com/docs/deep-audits))
- **데이터 품질 점수(data quality score)** — 실패 이벤트 양과 성공 적재량을 비교해 매기는 품질 지표(Snowplow).
- **구현 상태(implementation status)** — 플랜 대비 실제 발생 이벤트가 얼마나 구현·정합되었는지 신호등처럼 표시하는 것(Avo Inspector). 미구현·예상 밖 속성·타입 불일치를 소스별로 보여 준다.

---

## ④ 오토캡처·요소 식별

코드 없이 화면 상호작용을 잡거나, 화면 요소를 이벤트에 연결하는 기술.

- **오토캡처(autocapture)** — 스니펫 하나만 심으면 클릭·페이지뷰·폼 제출 같은 상호작용을 전수 자동 수집하는 방식. Heap이 원조, Amplitude·Mixpanel·PostHog도 도입했다. ([Heap](https://www.heap.io/blog/how-autocapture-actually-works))
- **코드리스 트래킹(codeless tracking)** — 코드를 고치지 않고 이벤트를 정의하는 방식의 총칭.
- **버추얼 이벤트·라벨드 이벤트(virtual / labeled event)** — 원시 오토캡처 데이터를 가리키는, 사람이 읽을 수 있는 이름. 나중에 붙여도 과거 데이터에 소급 적용된다(Heap Virtual Event = Amplitude Labeled Event). ([Heap](https://www.heap.io/blog/how-autocapture-actually-works))
- **비주얼 태깅·비주얼 라벨링(visual tagging / visual labeling)** — 화면 위에서 요소를 클릭해 이벤트를 정의하는 것. 속으로는 CSS 셀렉터를 자동 생성한다. ([Amplitude Visual Labeling](https://amplitude.com/docs/data/visual-labeling))
- **액션(action)** — PostHog에서 셀렉터·텍스트·URL로 사후 매칭해 만드는 이벤트 묶음. 소급 적용된다. ([PostHog Actions](https://posthog.com/docs/data/actions))
- **콤보 이벤트·이벤트 리페어(combo event / event repair)** — 화면 개편으로 기존 정의가 매칭을 멈췄을 때, 구·신 버전을 합치거나(Combo Event) 정의만 갈아 끼워(Event Repair) 코딩 없이 추적을 복원하는 Heap의 장치. ([Heap Event Repair](https://help.heap.io/hc/en-us/articles/37271998625169))
- **CSS 셀렉터(CSS selector)** — 화면의 특정 요소를 지목하는 주소 문법(예: `#buy-button`, `.price`). 마크업이 바뀌면 쉽게 깨진다는 취약성이 오토캡처·태그매니저·감사 도구 모두의 공통 골칫거리다.
- **DOM 스크레이핑(DOM scraping)** — 데이터레이어 없이 CSS 셀렉터로 화면에서 값(가격·상품명 등)을 직접 긁어 오는 우회법. 화면 개편 시 파손된다. ([Analytics Mania: DOM scraping](https://www.analyticsmania.com/post/dom-scraping-with-google-tag-manager/))
- **data-\* 속성(data-\* attribute)** — 개발자가 요소에 미리 붙여 두는 안정적 식별용 표식. 셀렉터가 잘 안 깨지도록 앵커로 삼으라고 여러 도구가 권한다.
- **요소 지문(element fingerprint)** — 한 요소를 여러 속성 묶음(셀렉터·class·name·aria-label·DOM 위치·보이는 텍스트·주변 요소 등)으로 식별해, 화면이 바뀌어도 같은 요소로 인식하는 방식. 취약한 단일 셀렉터보다 튼튼하다. ([ThinkPalm: 자가치유 딥다이브](https://thinkpalm.com/blogs/how-self-healing-test-automation-works-a-technical-deep-dive/))
- **자가치유 셀렉터(self-healing selector)** — 셀렉터가 깨졌을 때 대체 위치 지정자를 자동으로 찾아 잇는 기술. 테스트 자동화 진영(Testim·Healenium 등)에 있고, 태그 감사 도구에는 대체로 없다. ([ThinkPalm](https://thinkpalm.com/blogs/how-self-healing-test-automation-works-a-technical-deep-dive/))
- **속성 안정성 순위** — 요소 식별에 쓰는 신호의 신뢰 순서. 대체로 접근성 속성(ARIA label/role) > 보이는 텍스트 > name/placeholder > CSS 클래스 > DOM 위치 > 자동 생성 ID 순으로 튼튼하다고 본다. ([ThinkPalm](https://thinkpalm.com/blogs/how-self-healing-test-automation-works-a-technical-deep-dive/))
- **신뢰도 점수(confidence scoring)** — 바뀐 화면에서 찾은 후보가 원래 지문과 얼마나 일치하는지 매긴 점수. 높으면 자동 적용하고, 낮으면 사람이 검토하게 한다.
- **결정론적 실행(deterministic execution)** — "AI는 테스트 생성·유지보수만 하고, 실행 자체는 정해진 코드로 한다"는 원칙. 재현성과 비용 통제를 위한 것(Octomind).
- **세션 리플레이(session replay)** — 이용자의 화면 조작을 녹화해 다시 재생해 보는 것. Mixpanel Lexicon은 이벤트에 이 기록을 자동 연결해 맥락 증거로 보여 준다.
- **데드 클릭·레이지 클릭(dead click / rage click)** — 눌러도 아무 반응 없는 클릭(데드), 답답해서 연타하는 클릭(레이지). 오토캡처가 추가로 잡아 주는 UX 신호. ([Mixpanel Autocapture](https://docs.mixpanel.com/docs/tracking-methods/autocapture))
- **크롤링(crawling)** — 봇이 웹페이지 링크를 따라가며 페이지를 자동으로 훑는 방식. ObservePoint·Tag Inspector의 감사 엔진이 쓴다.
- **시나리오 시뮬레이션 / 녹화·재생(record-and-playback)** — 사람이 미리 짠(또는 녹화한) 클릭·입력 순서를 봇이 그대로 재생해 태그 발화를 확인하는 방식. ObservePoint Journeys·DataTrue가 쓴다.
- **미계측 요소(untracked element)** — 클릭 등 상호작용이 되는데 이벤트 태그가 붙어 있지 않은 요소. 이걸 능동적으로 자동 발견하는 도구는 시장에 사실상 없다는 것이 원자료의 결론.

---

## ⑤ 태그매니저

코드 배포 없이 태그를 관리하는 계층(주로 Google Tag Manager).

- **태그·트리거·변수·컨테이너(tag / trigger / variable / container)** — 태그는 실행 단위(예: GA4 이벤트 전송), 트리거는 발화 조건(예: 클릭), 변수는 값 추출기, 컨테이너는 이들을 담는 설정 묶음. ([GTM 변수](https://support.google.com/tagmanager/answer/7182738))
- **데이터레이어(dataLayer)** — 웹페이지가 태그로 보낼 값을 담아 두는 자바스크립트 저장소. 개발자가 구조화된 값을 밀어 넣는 공식 통로이며, "DOM 스크레이핑 대신 데이터레이어 우선"이 실무 권고다. ([DOM scraping vs data layer](https://mixedanalytics.com/blog/dom-scraping-data-layer-gtm-custom-js-variables/))
- **요소 가시성 트리거(element visibility trigger)** — 요소가 화면(뷰포트)에 N%·M초 이상 보이면 발화하는 트리거. 노출 추적에 쓴다. ([GTM 트리거](https://support.google.com/tagmanager/answer/7679410))
- **히스토리 변경 트리거(history change trigger)** — 페이지를 새로 안 불러오는 SPA에서 주소(라우팅) 변경을 감지해 발화하는 트리거. ([GTM 트리거](https://support.google.com/tagmanager/answer/7679410))
- **커스텀 자바스크립트 변수 / DOM 요소 변수** — 데이터레이어에 없는 값을 직접 코드나 셀렉터로 화면에서 긁어 오는 변수. 편하지만 마크업이 바뀌면 멈춘다.
- **프리뷰 모드·태그 어시스턴트(preview mode / Tag Assistant)** — 발행 전에 사람이 직접 페이지를 돌며 태그 발화·데이터레이어 상태를 확인하는 디버깅 세션. 어디까지나 수동이라, 발행 후 상시 자동 감시는 아니다. ([Simo Ahava: GTM 프리뷰](https://www.simoahava.com/analytics/new-preview-mode-google-tag-manager/))
- **컨테이너 부채·태그 비대(container debt / tag bloat)** — 죽은 태그·중복 스크립트·발화 안 되는 태그가 쌓여 방치된 상태. 6개월이면 다시 비대해지는 건 기술이 아니라 거버넌스 문제라는 지적이 있다. ([GTM 컨테이너 청소](https://metricvibes.com/blog/how-to-audit-clean-up-bloated-gtm-container/))
- **동의 정책·PII·피기배킹(consent policy / PII / piggybacking)** — 동의 정책은 지역별로 "수집해도 되는 데이터"를 문서화한 규칙, PII는 개인식별정보, 피기배킹은 서드파티 태그가 몰래 다른 태그를 붙이는 것. 태그 감사 도구(Tag Inspector 등)의 프라이버시 감시 대상이다.

---

## ⑥ 데이터 계약·거버넌스

데이터 품질을 조직 차원에서 약속하고 관리하는 개념들.

- **데이터 거버넌스(data governance)** — 어떤 데이터를 누가·어떻게 수집·관리할지 규칙으로 다스리는 일. 조사한 도구들의 공통 타깃이 "설계 명세와 실제 데이터의 괴리를 없애는" 데이터 품질 거버넌스다.
- **데이터 계약(data contract)** — 데이터를 만드는 쪽과 쓰는 쪽이 스키마·의미·품질·SLA·소유권을 못박은, 버전 관리되는 공식 합의. ([What Are Data Contracts?(DataHub)](https://datahub.com/blog/the-what-why-and-how-of-data-contracts/))
- **생산자·소비자(producer / consumer)** — 데이터를 만들어 내보내는 쪽(생산자)과 받아 쓰는 쪽(소비자). 둘 사이 명시적 합의가 없다는 것이 많은 데이터 사고의 근본 원인으로 지목된다.
- **shift-left(왼쪽으로 당기기)** — 품질 책임을 하류(소비자가 나중에 청소)에서 상류(생산자가 원천에서 보증)로, 즉 파이프라인의 더 앞 단계(코드 리뷰·CI)로 옮기는 것. ([Actian: 데이터 계약 가이드](https://www.actian.com/data-contracts/))
- **ODCS(Open Data Contract Standard)** — 데이터 계약을 적는 업계 표준 서식. Bitol이 관리하는 Linux Foundation 프로젝트(v3.1.0). ([ODCS(Bitol)](https://bitol-io.github.io/open-data-contract-standard/v3.1.0/))
- **dbt model contracts** — dbt가 데이터 모델을 빌드하는 시점에 계약을 검증하는 기능. 데이터가 이미 변환된 뒤라 명백히 사후 검증이다. ([dbt model contracts](https://docs.getdbt.com/docs/collaborate/govern/model-contracts))
- **엔티티·컨텍스트(entity / context)** — 이벤트에 붙는 부가 맥락 정보(사용자·상품·화면 등).
- **CDP(customer data platform)** — 여러 소스의 고객 데이터를 모아 여러 목적지로 배분하는 중계 플랫폼. Segment·mParticle·RudderStack이 여기에 속한다.
- **SLA(서비스 수준 약속)** — 데이터를 언제까지·어느 품질로 제공하겠다는 약속. 데이터 계약이 못박는 항목 중 하나.
- **거버넌스 사전형 장치(Verified Data / Data Standards / Event Approval)** — 유입을 막는 강제 검증이 아니라, 사후에 신뢰도를 표시·검토하는 장치들. Verified Data는 관리자가 손으로 붙이는 신뢰 배지(Mixpanel), Data Standards는 이름 규칙 준수 여부 표시, Event Approval은 신규 이벤트를 일단 숨겨 두고 검토하는 것. ([Mixpanel Lexicon](https://docs.mixpanel.com/docs/data-governance/lexicon))
- **데이터 사전(data dictionary)** — 수집 중인 이벤트·속성의 목록과 뜻풀이를 모아 둔 문서. Mixpanel Lexicon이 대표 사례로, 강제 검증 게이트라기보다 서술적 카탈로그에 가깝다. ([Mixpanel Lexicon](https://docs.mixpanel.com/docs/data-governance/lexicon))

---

## ⑦ 위반 처리·파이프라인 운영

규격을 어긴 데이터를 어떻게 다루고, 파이프라인이 어떻게 돌아가는지에 관한 낱말들.

- **위반(violation)** — 이벤트나 속성이 트래킹 플랜과 어긋난 사건. 흔한 유형은 계획에 없는 이벤트·속성, 타입 불일치, 필수 필드 누락.
- **차단(blocking) / 차단 이벤트(blocked event)** — 위반이라서 파이프라인에서 드롭하는 처리, 또는 그렇게 버려진 이벤트. 따로 격리해 두지 않으면 영구 복구가 안 된다는 경고가 여러 도구에 반복된다.
- **전파(propagate)** — 위반 이벤트를 버리지 않고, 에러 표시를 붙인 채 목적지까지 그대로 흘려보내는 처리. RudderStack의 기본값이라 유실 위험이 낮은 대신 나쁜 데이터가 하류까지 간다. ([RudderStack Violation Management](https://www.rudderstack.com/blog/feature-launch-tracking-plans-for-violation-management/))
- **격리(quarantine)** — 차단·실패한 데이터를 버리지 않고 별도로(예: S3) 보관해 나중에 복구할 수 있게 하는 것. mParticle의 Quarantine Connection이 대표적. ([mParticle Data Plans](https://docs.mparticle.com/guides/platform-guide/data-planning/))
- **실패 이벤트(failed events)** — 스키마 검증·강화 등에서 실패해 깨끗한 테이블에 못 들어가고 별도로 격리·백업되는 이벤트(Snowplow). 나중에 재처리할 수 있다. ([failed events 소개](https://docs.snowplow.io/docs/fundamentals/failed-events/))
- **데드레터 큐(DLQ, dead letter queue)** — 처리에 실패한 메시지를 버리지 않고 따로 모아 두는 대기열. Kafka 등에서 실패 유형별로 구성한다. ([Kafka DLQ FAQ](https://snowplow.io/snowplow-frequently-asked-questions/how-to-route-snowplow-bad-events-to-a-dead-letter-queue-in-kafka))
- **보강·강화(enrichment)** — Snowplow에서 수집한 이벤트를 웨어하우스에 넣기 전에 스키마 검증·부가정보 추가를 하는 파이프라인 단계. 검증이 여기서 이뤄진다.
- **변환(transformation)** — 코드를 고치지 않고 이벤트·속성의 이름이나 값을 바로잡는 처리(Segment). ([Segment Transform](https://segment.com/docs/protocols/transform/))
- **재처리·백필(replay / backfill)** — 재처리는 격리해 둔 실패 이벤트를 파이프라인에 다시 태워 복구하는 것, 백필은 빠졌던 과거 데이터를 나중에 채워 넣는 것. 둘 다 대체로 수동이라 손이 많이 간다.
- **MTU·MAU(월간 추적/활성 이용자)** — 도구 과금의 흔한 기준 단위. MTU(monthly tracked users)는 Segment·Amplitude, MAU(monthly active users)는 Trackingplan 등이 쓴다. 위반을 별도 소스로 전달하면 MTU가 더 소모되기도 한다.

---

*근거: `research/raw/`의 8개 원자료. 출처 URL은 원자료에 링크가 있는 용어만 그대로 이어 붙였고, 링크가 없던 용어는 생략했다. 외부 웹 리서치는 하지 않았다. 정리일: 2026-07-21.*
