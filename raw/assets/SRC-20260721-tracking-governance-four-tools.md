# 트래킹 플랜 거버넌스 도구 4종 조사 (원자료)

> 대상: Segment Protocols · Mixpanel Lexicon · mParticle Data Master · RudderStack Data Governance
> 이미 조사한 Avo·Amplitude Data와 중복 조사는 피하고, 필요할 때만 비교로 언급한다.
> 조사 관점(도구마다): 푸는 문제 / 해결 방식 / 기술(검증 시점·방식) / 한계·미해결 / 가격 / 공통 질문 3개.
> 용어 풀이 — **트래킹 플랜(tracking plan)**: 어떤 이벤트·속성을 어떻게 수집할지 정한 명세. **스키마 드리프트(schema drift)**: 명세와 실제 데이터가 시간이 지나며 어긋나는 현상. **수집 시점(ingestion)**: 데이터가 서버로 들어오는 순간. **코드젠(codegen)**: 명세에서 계측용 코드를 자동 생성하는 것.

---

# 1. Segment Protocols

> 참고: segment.com 공식 문서는 직접 크롤링이 차단(403)되어, 동일 내용을 담은 공식 문서 미러(segment-docs.netlify.app)와 문서 저장소 기반 DeepWiki로 원문을 확인했다.

## 1.1 푸는 문제

Protocols가 겨냥하는 핵심 문제는 **설계와 실제 구현 사이의 간극**, 즉 트래킹 플랜에 정의한 스펙과 실제로 들어오는 이벤트가 시간이 지나며 어긋나는 스키마 드리프트와 데이터 품질 저하다.

- Protocols는 여러 도구에서 수집되는 고객 데이터가 깨끗하고 일관되며 신뢰할 수 있도록 보장하는 것을 목표로 하며, "데이터 수집이 *어떻게 동작해야 하는가*와 *실제로 어떻게 동작하는가* 사이의 단절"을 정면으로 다룬다([Protocols Overview 미러](https://segment-docs.netlify.app/docs/protocols/)).
- 트래킹 플랜은 제품·엔지니어링·분석·비즈니스 팀을 위한 **단일 진실 공급원(single source of truth)** 역할을 하며, 구현 *이전에* 기대 이벤트·속성을 문서화해 불일치를 예방한다([Protocols Overview 미러](https://segment-docs.netlify.app/docs/protocols/)).

## 1.2 해결 방식

공식적으로 **4단계 흐름**으로 정리된다: ① Align(팀 표준 정렬) → ② Validate(들어오는 데이터를 표준과 대조, 위반 표시) → ③ Enforce(비순응 이벤트 차단) → ④ Transform(코드 변경 없이 데이터 수정)([Protocols Overview 미러](https://segment-docs.netlify.app/docs/protocols/)).

- **스키마 선언(Tracking Plan)**: 이벤트 정의(예: "Order Completed"), 속성 스키마(데이터 타입·필수/선택·값 제약), identify/group용 trait 스키마, 검증 규칙을 정의한다. 수동 작성뿐 아니라 과거 이벤트 패턴에서 자동 추론도 된다([DeepWiki: Protocols & Schema Validation](https://deepwiki.com/segmentio/segment-docs/4.3-protocols-and-schema-validation)).
- **위반 처리(Schema Controls) — 차단 vs 허용 vs 속성 제거**:
  - Track(허용): 위반을 기록하되 이벤트는 통과
  - Block(차단): 플랜에 없는 이벤트를 파이프라인 진입 전에 드롭. 트래킹 플랜에 정의된(allowlist된) 콜만 목적지로 흐르게 함
  - Omit Properties(속성 제거): 이벤트는 통과시키되 스키마에 없는 속성만 제거
  - 제어는 전역 기본값 → 트래킹 플랜 → 소스 수준 → 목적지별 규칙 계층으로 적용([DeepWiki](https://deepwiki.com/segmentio/segment-docs/4.3-protocols-and-schema-validation), [Block event recipe](https://segment.com/recipes/tracking-plan-block-event-violation-slack-notification/)).
- **위반 전달(Forward Violations)**: 비순응 데이터를 별도 Segment 소스로 "Violation Generated" 이벤트 형태로 보내 알림·대시보드에 활용. 단 워크스페이스에 **MTU 1개가 추가로 발생**하고 API 요금제는 볼륨 증가분이 과금된다([Forward Violations 미러](https://segment-docs.netlify.app/docs/protocols/validate/forward-violations/)).
- **Typewriter 코드젠**: 트래킹 플랜에서 강타입 분석 라이브러리 코드를 자동 생성해, 개발자가 스펙과 어긋난 이벤트를 처음부터 덜 심게 한다([Typewriter 미러](https://segment-docs.netlify.app/docs/protocols/apis-and-extensions/typewriter/), [segmentio/typewriter GitHub](https://github.com/segmentio/typewriter)).

## 1.3 기술 — 검증은 언제·어떻게

**두 지점**에서 서로 다른 방식으로 검증한다.

**(A) 개발 단계 — Typewriter (컴파일 타임 + 클라이언트 런타임)**: TypeScript·Swift·Kotlin·Java 등 정적 타입 언어용으로 **컴파일 타임 타입 안정성**을 제공(누락 속성·잘못된 enum 값을 컴파일 시 표시). JS/TS 클라이언트는 **런타임에 AJV**로 JSON Schema를 검증하고, ES6 Proxy로 잘못된 호출을 잡아 크래시 대신 경고를 남긴다([Typewriter 미러](https://segment-docs.netlify.app/docs/protocols/apis-and-extensions/typewriter/)).

**(B) 데이터 수집 단계 — 서버 측 검증(ingestion)**: Tracking API가 이벤트를 받은 직후, identity resolution·목적지 전달 이전 단계에서 검증한다. 이 이른 배치로 잘못된 데이터를 파이프라인 진입 전에 거른다([DeepWiki](https://deepwiki.com/segmentio/segment-docs/4.3-protocols-and-schema-validation)). 위반 이벤트에는 `violationType`(Unplanned Event, Invalid Property Type, Missing Required Property 등), 기대값 대 실제값, 적용 조치(`schemaControl`: blocked/allowed/omitted_properties)가 담긴다. 위반은 소스 Schema 탭에 묶여 표시되고, 일일 요약·차단 알림·90일 감사 로그·이메일/Slack 웹훅을 제공([DeepWiki](https://deepwiki.com/segmentio/segment-docs/4.3-protocols-and-schema-validation)).

## 1.4 한계·미해결

**공식 문서 인정 제약:**
- **디바이스 모드는 차단이 통하지 않음**: 모바일 device-mode 이벤트는 차단되지 않고 목적지로 전달된다(Business 티어는 destination filters로 우회)([Protocols FAQ 미러](https://segment-docs.netlify.app/docs/protocols/faq/)).
- **버전 관리 수동성**: 소스 스키마는 "가장 오래된 이벤트 버전"만 검증하며, breaking change 시 개발자가 `context.protocols.event_version`을 track 콜에 **수동으로** 넣어야 한다([Protocols FAQ 미러](https://segment-docs.netlify.app/docs/protocols/faq/)).
- 한 소스는 트래킹 플랜 1개만 연결, 삭제 플랜 복구 불가, 변경 반영에 10~15분 지연, 차단 이벤트 보관 30일([Protocols FAQ 미러](https://segment-docs.netlify.app/docs/protocols/faq/)).
- **가용성**: Connections Business 티어 add-on 전용([Protocols Overview 미러](https://segment-docs.netlify.app/docs/protocols/)).

**실사용자 불만(리뷰 원문은 403 차단, 리뷰 집계 매체 기준):**
- **거버넌스 인력 없으면 오히려 부담**: 트래킹 플랜 정의·검증에 상당한 초기 투자가 필요해, 전담 인력 없는 팀은 설정 부담만 늘어난다([SalesHive Segment Review](https://saleshive.com/vendors/segment)).
- **엔지니어 종속·가파른 학습 곡선**: 데이터 엔지니어 대상 설계라 제품 리더·마케터는 지원 없이 어려움을 겪는다([Try or Bye: Segment Problems](https://www.tryorbye.com/products/segment), [SalesHive](https://saleshive.com/vendors/segment)).
- **MTU 기반 가격 급증**: 규모가 커지면 빠르게 비싸져 RudderStack 등으로 이탈하는 사례([Try or Bye](https://www.tryorbye.com/products/segment)).

## 1.5 가격

Protocols는 **Connections Business 요금제·CDP 요금제의 유료 add-on**이며 정가 비공개, MTU 볼륨·요건별 맞춤 견적이다([Segment Pricing](https://segment.com/pricing/), [Protocols Overview 미러](https://segment-docs.netlify.app/docs/protocols/)). Connections는 Free $0, Team 월 $120부터, Business는 맞춤 가격(Protocols는 Business에서만 제공)([Spendflo Segment Pricing Guide](https://www.spendflo.com/blog/segment-pricing-guide)). 전체 계약 규모는 연 $25,000~$200,000 범위로 보고된다([Spendflo](https://www.spendflo.com/blog/segment-pricing-guide)).

## 1.6 공통 질문 답변

- **Q1. 수동 계측 전제 유지?** — **유지한다.** Protocols는 스펙을 선언·검증할 뿐 계측을 대신하지 않는다. Typewriter가 타입 지정 함수를 생성해 보일러플레이트를 줄이지만, 개발자가 그 함수를 앱 코드에서 여전히 직접 호출해야 한다([Typewriter 미러](https://segment-docs.netlify.app/docs/protocols/apis-and-extensions/typewriter/)).
- **Q2. 감지 시점 — 사전 차단 vs 사후 발견?** — **하이브리드.** 개발 시점에 Typewriter가 컴파일 타임(정적 언어)·클라이언트 런타임(JS/TS AJV)에 잡고, 수집 시점에 서버가 검증한다. "Block Event" 설정 시 사전 차단(진입 전 드롭), Track 모드면 통과 후 위반 리포트로 사후 발견. 다만 배포된 코드가 보낸 데이터를 수집 시점에 잡는 구조라 근본적으로 "이미 계측·배포된 후"를 전제하며, device-mode 이벤트는 사후 발견만 가능([DeepWiki](https://deepwiki.com/segmentio/segment-docs/4.3-protocols-and-schema-validation), [Protocols FAQ 미러](https://segment-docs.netlify.app/docs/protocols/faq/)).
- **Q3. UI 요소↔이벤트 시각 매핑?** — **없다.** 트래킹 플랜은 표 형태의 스키마/스펙 산출물이며, 화면 요소(버튼·화면)와 이벤트를 시각적으로 연결하는 기능은 문서에 없다. 증거는 위반 리포트(기대값 대 실제값)와 디버거로 제공되는 데이터 레벨 증거뿐이다([Protocols Overview 미러](https://segment-docs.netlify.app/docs/protocols/), [Review & Resolve Violations](https://segment.com/docs/protocols/validate/review-violations/)). (참고: Avo의 Journeys 같은 시각 매핑이 여기엔 없다.)

---

# 2. Mixpanel Lexicon

## 2.1 푸는 문제

Lexicon은 이벤트·속성의 **의미를 팀이 공유하지 못해 생기는 혼란**을 해결하려는 데이터 사전이다. 공식 문서는 "이벤트·속성 정의가 팀 전체가 데이터 의미를 이해하도록 도와 모두가 같은 이해 위에 있게 한다"고 명시한다([Lexicon 공식 문서](https://docs.mixpanel.com/docs/data-governance/lexicon)). Mixpanel은 "잘못 이름 붙은 이벤트 하나가 대시보드 지표 전체를 망가뜨리고, 거버넌스가 없으면 퍼널·리텐션·행동 리포트를 신뢰할 수 없다"고 문제를 규정한다([Data Governance 문서](https://docs.mixpanel.com/docs/data-governance)). 즉 문서화 부재, 이름 규칙 불일치, 크로스팀 발견성 저하, 데이터 신뢰 상실이 타깃이다.

## 2.2 해결 방식

Lexicon은 추적 데이터(이벤트·이벤트 속성·프로필 속성)와 계산 데이터(코호트·커스텀 이벤트·룩업 테이블 등)를 관리한다([Lexicon 공식 문서](https://docs.mixpanel.com/docs/data-governance/lexicon)).

- **메타데이터 부여**: 표시 이름·설명·예시 값·태그·소유자·커스텀 이미지를 붙인다. 원본 데이터는 수집 후 이름 변경 불가이며, 표시 이름은 프런트엔드에서만 렌더링되고 원본은 바꾸지 않는다.
- **숨기기(Hide)**: UI 드롭다운/쿼리 결과에서만 감춤. **데이터는 계속 수집되고 사용량에 포함**된다(순전히 표시용, 되돌릴 수 있음).
- **차단(Block)**: 신규 데이터를 실제로 저장하지 않는 유일한 강제 기능. **비가역적**이며 프로젝트 소유자만 가능, 반영에 수 시간 소요.
- **드롭(Drop)**: 커스텀 이벤트 수집 중단. `$`로 시작하는 내장 이벤트는 드롭 불가, 숨기기만 가능.
- **병합(Merge)**: 이름만 다른 동일 이벤트를 합침. 단 프로필 속성·autocapture 이벤트는 병합 불가([Lexicon 공식 문서](https://docs.mixpanel.com/docs/data-governance/lexicon)).
- **트래킹 플랜 개념**: Lexicon Schemas API는 "내부 데이터 사전 또는 트래킹 플랜을 Schema로 Mixpanel과 동기화하라"고 표현한다([Lexicon Schemas API](https://docs.mixpanel.com/reference/lexicon-schemas-api)). CSV 및 Segment Protocols·Avo(양방향)·mParticle Data Plan(JSON) 연동 임포트를 지원한다([Lexicon 공식 문서](https://docs.mixpanel.com/docs/data-governance/lexicon)).
- **Data Standards(2025년 3월 출시)**: 이름 규칙(snake_case 등)·필수 설명·소유자 지정 등 규칙을 정의하고 위반 이벤트를 식별한다([Data Standards 문서](https://docs.mixpanel.com/docs/data-governance/data-standards), [출시 changelog](https://docs.mixpanel.com/changelogs/2025-03-27-data-standards)).

## 2.3 기술 — 검증은 언제·어떻게

**핵심: Lexicon은 대부분 서술적(descriptive) 카탈로그·메타데이터 계층이며, 들어오는 이벤트를 실시간 검증·차단하는 강제 게이트가 아니다.**

- **Data Standards 검증은 "수집 이후"에 일어난다.** 이벤트 메타데이터를 규칙과 대조해 "준수(Compliancy)" 상태를 부여·표시할 뿐 유입을 막지 않는다. 관리자가 비준수 이벤트를 사후에 수정한다([Data Standards 문서](https://docs.mixpanel.com/docs/data-governance/data-standards)).
- **Event Approval도 차단이 아니라 사후 검토·검역**이다. 신규 이벤트를 기본 숨김 처리하고 관리자에게 알리지만 **데이터는 계속 수집**된다([Event Approval 문서](https://docs.mixpanel.com/docs/data-governance/event-approval)).
- **유일하게 유입을 막는 것은 Block**인데, 스키마 검증이 아니라 특정 이벤트/속성을 수동으로 영구 차단하는 것이며 반영에 수 시간 소요(실시간 검증 아님)([Lexicon 공식 문서](https://docs.mixpanel.com/docs/data-governance/lexicon)).
- **코드젠은 제공하지 않는다(확인됨).** Schemas API는 스키마 동기화·조회 용도에 그친다([Lexicon Schemas API](https://docs.mixpanel.com/reference/lexicon-schemas-api)). (코드젠은 Avo·Segment Typewriter의 영역이며, Mixpanel은 Avo와 임포트 연동만 함.)

## 2.4 한계·미해결

**공식 문서 제약:**
- **Schemas API가 Lexicon UI와 1:1이 아님**: 스키마가 연결된 이벤트만 반환, 완전한 내보내기는 CSV 권고([Lexicon Schemas API](https://docs.mixpanel.com/reference/lexicon-schemas-api)).
- 프로필 속성·autocapture 이벤트 병합 불가, `$` 내장 이벤트 드롭 불가, 차단은 비가역적([Lexicon 공식 문서](https://docs.mixpanel.com/docs/data-governance/lexicon)).

**실사용자 불만:**
- "설정·구현 학습 곡선이 가파르고", "새 이벤트마다 개발팀이 필요한 경우가 많다"([Hackceleration 리뷰](https://hackceleration.com/labs/review/mixpanel)).
- "이벤트 이름을 미리 계획하지 않으면 데이터가 지저분해진다", "추적 코드 한 줄 쓰기 전 반나절 동안 사용자 행동을 매핑해야 했다"([Hackceleration 리뷰](https://hackceleration.com/labs/review/mixpanel)).
- 가격 예측성·지원 품질·구현 복잡성·거버넌스가 반복 지적되며, "추적에 필요한 엔지니어링 노력"이 부담([TrustRadius Mixpanel 리뷰](https://www.trustradius.com/products/mixpanel/reviews)). (G2 페이지는 403 차단.)

## 2.5 가격

Free / Growth / Enterprise 3단계, 월간 이벤트 기준 과금. Free는 월 100만 이벤트 무료, Enterprise는 대개 연 $25,000~$30,000부터([Mixpanel 가격 문서](https://docs.mixpanel.com/docs/pricing), [Usercall 가격 정리](https://www.usercall.co/post/mixpanel-pricing)).
- **기본 Lexicon과 Autocapture는 전 플랜 이용 가능**([28 Mixpanel facts 블로그](https://mixpanel.com/blog/mixpanel-facts/)).
- **고급 거버넌스는 Enterprise 전용**: Data Standards([문서](https://docs.mixpanel.com/docs/data-governance/data-standards)), Event Approval([문서](https://docs.mixpanel.com/docs/data-governance/event-approval)), Data Views·민감 데이터 분류([가격 문서](https://docs.mixpanel.com/docs/pricing)), Lexicon 소유자 지정·Verified 배지([Lexicon 문서](https://docs.mixpanel.com/docs/data-governance/lexicon)).

## 2.6 공통 질문 답변

- **Q1. 수동 계측 전제 유지? 코드젠은?** — **수동 계측 전제 유지, 코드젠 없음.** Mixpanel은 "코드리스·자동 수집 모델을 버렸다"며 개발자가 의미 있는 비즈니스 이벤트를 직접 코드로 심을 것을 권장해 왔다([Codeless analytics 블로그](https://mixpanel.com/blog/codeless-analytics-problems/)). 이후 Autocapture로 클릭·페이지뷰 등 일부를 완화했으나([Autocapture 블로그](https://mixpanel.com/blog/autocapture-analytics/)), 정교한 이벤트는 여전히 수동 몫이고 스키마→코드 생성 기능은 없다([Lexicon Schemas API](https://docs.mixpanel.com/reference/lexicon-schemas-api)).
- **Q2. 감지 시점 — 사전 차단 vs 사후 발견?** — **압도적으로 사후 발견.** Data Standards는 준수 상태를 사후 표시할 뿐 유입을 막지 않고([Data Standards 문서](https://docs.mixpanel.com/docs/data-governance/data-standards)), Event Approval도 수집·숨김 후 배치 검토다([Event Approval 문서](https://docs.mixpanel.com/docs/data-governance/event-approval)). 유일한 사전 차단은 수동 Block(개별 항목 영구 차단, 반영 수 시간). Mixpanel 스스로 코드리스의 약점으로 "UI 변경 시 추적이 알림 없이 조용히 깨진다"고 인정한다([Codeless analytics 블로그](https://mixpanel.com/blog/codeless-analytics-problems/)).
- **Q3. UI 요소↔이벤트 시각 매핑?** — **부분적으로 그렇다.** Autocapture가 클릭·페이지뷰를 자동 수집하고 `[Auto] Element Click` 등 라벨로 표시하며, 이를 **UI에서 포인트앤클릭으로 Custom Event로 정의**할 수 있다([Autocapture 블로그](https://mixpanel.com/blog/autocapture-analytics/)). Lexicon은 이벤트 메타데이터에 **세션 리플레이(session replay)를 자동 연결**해 맥락 증거를 보여준다([Lexicon 공식 문서](https://docs.mixpanel.com/docs/data-governance/lexicon)). 다만 완전한 UI↔이벤트 매핑 다이어그램은 아니고, autocapture 이벤트는 Lexicon에서 병합조차 불가하다.

---

# 3. mParticle Data Master

> 조사 방식: 공식 문서(docs.mparticle.com), 마케팅 페이지, GitHub 문서 원본, 리뷰 집계 사이트를 직접 열람.

## 3.1 푸는 문제

Data Master는 **나쁜 데이터가 하류 도구로 흘러가는 것**을 정면으로 겨냥한다. 핵심은 "나쁜 데이터를 소스에서 막는다(stopping bad data at the source)"로, 잘못된·계획에 없는 데이터가 마케팅/분석 도구로 전달되기 전에 거르는 것이다([Data Master 소개](https://www.mparticle.com/platform/detail/data-master/)). 고객 데이터가 하류로 전달되기 전에 "정확하고 완전하고 일관되게" 유지하는 것이 목표이며, 주 타깃은 데이터 거버넌스 팀이다([데이터 거버넌스](https://www.mparticle.com/platform/data-governance/)).

## 3.2 해결 방식

**Data Plan은 "수집 데이터의 범위·형태에 대한 기대치를 코드화한 것"**, 즉 데이터와 mParticle 사이의 **계약(contract)**이다([Data Plans 가이드](https://docs.mparticle.com/guides/platform-guide/data-planning/)).

- 구성: **Catalog**(데이터 포인트 저장소) · **Plan**(협업형 데이터 스키마) · **Live Stream**(실시간 모니터링·위반 통계) · **Validation**(품질 강제 규칙)([Data Master 소개](https://www.mparticle.com/platform/detail/data-master/)).
- 플랜 구조: 이름·불변 ID·버전·설명·**데이터 포인트(Data Points)**로 구성(플랜당 최대 1,000개). 각 데이터 포인트 검증 스키마는 **JSON Schema 객체**. 검증 대상은 Custom Events·Screen Events·Commerce Events([Data Plans 가이드](https://docs.mparticle.com/guides/platform-guide/data-planning/)).
- 위반 유형: 계획에 없는 이벤트/속성, 값·타입이 틀린 속성, 계획에 없는 유저 속성/식별자.
- **"나쁜 데이터 차단(Block bad data)"**: 플랜에 없는 데이터를 차단할 수 있고, 차단 시 프로필 저장 전에 드롭된다([Data Plans 가이드](https://docs.mparticle.com/guides/platform-guide/data-planning/)).

## 3.3 기술 — 검증은 언제·어떻게 (핵심 차별점: 유입 시점 차단)

**검증 시점: 서버측 유입(ingestion) 파이프라인.** 문서상 순서는 "규칙 처리 → **플랜 검증 및 차단** → 프로필 저장"이다. 배치에 플랜 ID·환경을 태깅해야 검증된다([Data Plans 가이드](https://docs.mparticle.com/guides/platform-guide/data-planning/)).

mParticle의 핵심 차별점은 **유입 시점에 비순응 데이터를 실제로 "차단(block)"할 수 있다**는 점이다. 단순 경고/리포트가 아니라 프로필·하류로 저장·전달되기 전에 드롭한다(차단 데이터도 Live Stream에는 계속 표시)([Data Plans 가이드](https://docs.mparticle.com/guides/platform-guide/data-planning/)).

- **차단 가능**: 계획에 없는 커스텀 이벤트/속성, 계획에 없는 유저 속성/식별자, **값이 잘못된 속성값**.
- **차단 불가**: 잘못된 데이터 **타입**, 계획에 없는 식별자, `user_attribute_change`, 클라이언트측 kit의 `custom_attributes` 외 속성([Data Plans 가이드](https://docs.mparticle.com/guides/platform-guide/data-planning/)).
- **CI/API 관리 있음**: **Data Planning API**로 플랜 CRUD·배치 검증을 프로그래밍 방식으로 수행. "데이터 플랜을 소스코드에 저장하고 자체 SDLC·승인 프로세스로 데이터 모델을 정의하라"는 CI/CD 유스케이스를 명시하며, "compile-time and runtime data quality verification"을 지원한다. mParticle CLI·Data Planning Node SDK 제공([Data Planning API 문서 원본](https://github.com/mparticle/docs/blob/development/src/pages/developers/dataplanning-api/index.md), [Data Planning Node SDK](https://github.com/mParticle/data-planning-node)).
- **코드젠 있음 — Smartype**: Data Plan(JSON Schema)을 **type-safe 코드로 생성**하는 오픈소스 도구. JVM·iOS·Web(TS/JS)·React Native 지원, IDE 자동완성·린팅 제공. "타입 안전 라이브러리가 들어오면 Data Plan에 부합하지 않는 데이터를 수집하는 게 사실상 불가능"([Smartype 문서](https://docs.mparticle.com/developers/tools/smartype/), [Smartype GitHub](https://github.com/mParticle/smartype), [Smartype 블로그](https://www.mparticle.com/blog/smartype/)).

즉 mParticle은 개발 시점(Smartype 코드젠/린팅)과 유입 시점(서버측 검증·실시간 차단) **양쪽**을 제공한다.

## 3.4 한계·미해결

**공식 문서 제약:**
- 플랜당 데이터 포인트 최대 1,000개, 검증 대상 이벤트 유형 제한(세션·앱 상태 전이·어트리뷰션 이벤트 미지원).
- **차단 불가 항목** 존재(잘못된 타입, 계획에 없는 식별자, `user_attribute_change` 등).
- 배치에 플랜 ID·환경 미태깅 시 검증 안 됨. 차단 데이터는 UI 재전송 불가(Quarantine Connection으로 S3 보관해야 백필 가능)([Data Plans 가이드](https://docs.mparticle.com/guides/platform-guide/data-planning/)).

**실사용자 불만(엔터프라이즈 CDP 특유의 복잡성·비용):**
- **가파른 학습 곡선/복잡성**: 부정 리뷰의 40~50%가 집중. 비기술 팀이 독립적으로 쓰기까지 6~8주 소요, UI가 마케터 아닌 엔지니어 지향([checkthat.ai 리뷰 종합](https://checkthat.ai/brands/mparticle/reviews)).
- **구현 부담**: 전담 4~5명 구현 + 상시 1~2 FTE, 구현 기간 5~7개월([CDP Institute](https://www.cdpinstitute.org/mparticle/improve-data-quality-with-mparticles-data-planning-infrastructure/), [checkthat.ai](https://checkthat.ai/brands/mparticle/reviews)).
- 통합 이슈(조용한 동기화 실패·지연), API 레이트 리밋 백로그, Rokt 인수(2025.1) 후 중립성 우려([checkthat.ai 리뷰 종합](https://checkthat.ai/brands/mparticle/reviews)). 평점: G2 4.3~4.4/5, TrustRadius 8.3/10([G2 리뷰](https://www.g2.com/products/mparticle/reviews)).

## 3.5 가격

**공개 가격 없음(오파크)**, 영업 접촉 필요([CDP.com: What is mParticle](https://cdp.com/articles/what-is-mparticle/)). 집계 추정: 평균 연간 계약 약 **$156,000**(컴포저블 CDP 대안의 약 3배), 엔터프라이즈 구현 연 $375,000~$1,000,000+, 첫해 총비용 통상 $200K~$300K+([checkthat.ai 리뷰 종합](https://checkthat.ai/brands/mparticle/reviews)). Data Master 자체의 별도 단가는 비공개(CDP 계약에 포함).

## 3.6 공통 질문 답변

- **Q1. 수동 계측 전제 유지?** — **유지한다.** SDK 계측 전제이며, Smartype가 Data Plan에서 type-safe 코드를 생성해 부담을 줄이지만 여전히 개발자가 생성 라이브러리로 코드를 작성한다. 자동 계측이 아니라 "스키마 기반 수동 계측 + 검증"([Smartype 문서](https://docs.mparticle.com/developers/tools/smartype/), [Data Plans 가이드](https://docs.mparticle.com/guides/platform-guide/data-planning/)).
- **Q2. 감지 시점 — 사전 차단 vs 사후 발견?** — **선제적 차단이 핵심 차별점.** 검증이 유입 파이프라인에서 프로필 저장 이전에 수행되어 비순응 데이터를 **실시간 차단**하고 드롭한다(사후 리포트가 아님). 추가로 Smartype 린팅으로 개발(컴파일) 시점에도 잡는다. 단 차단 불가 항목(잘못된 타입 등)은 위반 기록만 되어 사후 모니터링 영역으로 남는다([Data Plans 가이드](https://docs.mparticle.com/guides/platform-guide/data-planning/), [Smartype 문서](https://docs.mparticle.com/developers/tools/smartype/)).
- **Q3. UI 요소↔이벤트 시각 매핑?** — **없다.** 제공하는 것은 스키마 기반 Catalog(데이터 포인트 목록), JSON Schema 기반 Plan, Live Stream의 실시간 위반 통계로 모두 데이터/스키마 수준 뷰다. "이 버튼이 이 이벤트를 발생시킨다"는 시각 매핑은 mParticle의 코드 중심 접근과 다르다([Data Master 소개](https://www.mparticle.com/platform/detail/data-master/), [Data Plans 가이드](https://docs.mparticle.com/guides/platform-guide/data-planning/)).

---

# 4. RudderStack Data Governance

> 참고: rudderstack.com/docs 문서는 자바스크립트 렌더링이라 WebFetch로 본문 수집이 제한되어, GitHub README·블로그·지식베이스·가격 페이지 등 서버 렌더링 본문을 근거로 삼고, 문서 페이지에만 있는 세부는 "검색으로 확인된 문서 내용"으로 명시했다. G2·TrustRadius 리뷰는 403 차단으로 검색 요약 기준.

## 4.1 푸는 문제

RudderStack이 겨냥하는 핵심은 **잘못된 이벤트가 하류(분석·웨어하우스·AI 모델)로 흘러가 이미 손상을 일으키는 상황**이다. 공식 블로그는 "나쁜 데이터는 웨어하우스가 아니라 계측 시점에 시작된다(Bad data starts at instrumentation time, not at the warehouse)", "잘못된 이벤트가 도구에 도달할 때쯤이면 피해는 이미 발생한 뒤다"라고 못 박는다([Rudder AI Reviewer 블로그](https://www.rudderstack.com/blog/rudder-ai-reviewer-pr-tracking-validation/)). "고객 데이터는 본질적으로 지저분하다"는 전제에서, 정의를 맞춰도 일부 데이터는 그 정의를 위반한다고 인정한다([Violation Management 블로그](https://www.rudderstack.com/blog/feature-launch-tracking-plans-for-violation-management/)).

## 4.2 해결 방식 — Tracking Plans + Data Catalog + RudderTyper

- **Tracking Plans**: 미리 정의한 계획에 따라 소스로 들어오는 비순응 이벤트를 능동적으로 모니터링·조치한다. 스키마는 이벤트 정의(원하는 track 이름)와 속성 정의(필수/선택, 데이터 타입)로 구성. 생성은 (a) 스프레드시트 직접 작성, (b) Data Governance API로 유입 이벤트에서 자동 생성(Enterprise)([Tracking Plans 시작 가이드](https://www.rudderstack.com/knowledge-base/get-started-with-tracking-plans/), [Tracking Plans 문서](https://www.rudderstack.com/docs/data-governance/tracking-plans/)). 시스템은 "들어오는 모든 이벤트를 표준에 대해 자동 평가하고 위반을 표시"한다([Violation Management 블로그](https://www.rudderstack.com/blog/feature-launch-tracking-plans-for-violation-management/)).
- **Data Catalog**: 유입된 모든 이벤트로부터 이벤트 카탈로그를 자동 구축해 표준화된 정의를 설정한다. CLI로 Data Catalog·Tracking Plan을 "코드로(as code)" 관리하는 워크플로 제공([가격 페이지](https://www.rudderstack.com/pricing/), [CLI 기반 관리 문서](https://www.rudderstack.com/docs/dev-tools/rudder-cli/data-catalog-and-tracking-plans/)).
- **RudderTyper (Segment Typewriter 대응품)**: 트래킹 플랜 명세 기반으로 **강타입 분석 라이브러리를 생성**해 유효한 이벤트·속성만 쓰도록 강제한다([RudderTyper GitHub README](https://raw.githubusercontent.com/rudderlabs/rudder-typer/master/README.md)). Segment Typewriter를 포크/계승한 개념으로, "매우 유사하며 유일한 차이는 RudderTyper가 모든 요금제에서 제공된다"([RudderStack vs Segment 비교](https://www.rudderstack.com/competitors/rudderstack-vs-segment/), [rudder-typer GitHub](https://github.com/rudderlabs/rudder-typer)).

## 4.3 기술 — 검증은 언제·어떻게 (3개 층위)

**(a) 컴파일 타임 — RudderTyper (개발 시점, 사전 차단형)**: 생성 클라이언트가 컴파일 타임 오류와 인텔리센스를 제공해 배포 전 계측 오류를 잡는다. JS·TS·Objective-C·Swift·Java 지원(2.0은 TS·Swift·Kotlin 바인딩), 명령어 `init`/`update`/`build`/`prod`([RudderTyper GitHub README](https://raw.githubusercontent.com/rudderlabs/rudder-typer/master/README.md)).

**(b) PR/CI 타임 — Rudder AI Reviewer (병합 전, 사전 차단형)**: PR에서 새로/수정된 이벤트를 계획에 대해 검증한다. "계획에 없는 이벤트, 타입 틀린 속성, 빠진 필수 필드"가 **병합 전에** 드러난다([Rudder AI Reviewer 블로그](https://www.rudderstack.com/blog/rudder-ai-reviewer-pr-tracking-validation/)).

**(c) 런타임 수집(ingestion) — Tracking Plan 검증 (이벤트 발생 후, 하류 차단형)**: 이벤트가 소스로 들어올 때 서버 측에서 계획에 대해 평가한다. **이미 발생한 뒤**지만 하류 유출을 막거나 격리한다. 위반 처리 옵션:
- **드롭(Drop)**: "Propagate errors"를 끄면 오류 이벤트를 폐기
- **오류 전파(Propagate errors)**: 켜면 오류를 이벤트 context 객체에 담아 하류로 전달해 자체 필터링 가능
- **분리 라우팅(Route)**: 위반 이벤트를 데이터 레이크로만 보내 격리
- ([Violation Management 블로그](https://www.rudderstack.com/blog/feature-launch-tracking-plans-for-violation-management/), [Tracking Plans 시작 가이드](https://www.rudderstack.com/knowledge-base/get-started-with-tracking-plans/))
- 위반 유형은 블로그상 "계획에 없는 이벤트, 잘못된 키/값 속성, 빠진 필수 필드"이며, 문서 라벨은 `Unplanned-Event`·`Additional-Properties`·`Required-Missing`·`Datatype-Mismatch`로 검색상 확인(문서 본문 직접 열람은 제한)([Violation Management 문서](https://www.rudderstack.com/docs/data-governance/tracking-plans/violation-management/)). 대시보드 Monitor 섹션에서 통과·위반 이벤트를 관찰한다([Observability 문서](https://www.rudderstack.com/docs/data-governance/tracking-plans/observability/)).

## 4.4 한계·미해결

**공식 문서 제약:**
- 지원 이벤트 타입 제한 추정: identify·track·page·screen·group은 지원하나 **alias는 미지원**(검색 요약 기준, 직접 열람 본문엔 미명시)([Tracking Plans 문서](https://www.rudderstack.com/docs/data-governance/tracking-plans/)).
- 기능의 티어 제한: Free는 극히 제한, Violation Management 구성·Data Catalog는 Growth 이상([가격 페이지](https://www.rudderstack.com/pricing/)).

**실사용자 불만(G2·TrustRadius 403 차단 → 검색 요약·열람 가능 리뷰 기준):**
- 고급 기능의 학습 곡선, 일부 기능이 기술 지식을 요구해 비개발 팀에 진입장벽([firstsales 리뷰](https://firstsales.io/brand-review/rudderstack/)).
- 문서 불충분으로 통합·온보딩 어려움, 커스터마이징 제한, 비기술 문의 지원 지연(검색 요약)([G2 리뷰](https://www.g2.com/products/rudderstack/reviews)).
- "추적 계획이 이벤트를 일관되게 유지해주지만 실패 이벤트 디버깅에 시간이 걸린다"(검색 요약), 상위 티어 비용·엔터프라이즈 도입 1~2개월([firstsales 리뷰](https://firstsales.io/brand-review/rudderstack/)).

## 4.5 가격

오픈소스 코어 + 이벤트/MTU 기반 클라우드 티어. 거버넌스는 Growth 이상에서 실효([가격 페이지](https://www.rudderstack.com/pricing/)):
- **Free ($0, 25만 이벤트/월)**: Tracking Plan 1개·이벤트 5개로 제한, Data Catalog 미포함.
- **Growth ($265/월~, 100만 이벤트/월)**: Tracking Plan 무제한 계획·이벤트 75개, Data Catalog 포함, Violation Management 구성 가능.
- **Enterprise (맞춤 견적)**: Tracking Plan·이벤트 무제한, 소스 자동 계획 생성용 Data Governance API 포함.
- RudderTyper는 "모든 요금제 제공"이지만 Free의 Tracking Plan이 5개 이벤트로 극히 제한되어 실질 거버넌스는 Growth 이상에서 의미([vs Segment 비교](https://www.rudderstack.com/competitors/rudderstack-vs-segment/), [Vendr 가격](https://www.vendr.com/marketplace/rudderstack)).

## 4.6 공통 질문 답변

- **Q1. 수동 계측 전제 유지?** — **유지한다(코드 우선).** 개발자가 SDK로 계측하는 전제이며, RudderTyper는 그 수동 계측을 타입 안전 코드 생성으로 도울 뿐 계측을 없애지 않는다. AI Reviewer도 사람이 내린 계측 결정을 PR에서 검토하자는 발상이다([Rudder AI Reviewer 블로그](https://www.rudderstack.com/blog/rudder-ai-reviewer-pr-tracking-validation/), [RudderTyper README](https://raw.githubusercontent.com/rudderlabs/rudder-typer/master/README.md)). (click/submit 자동 수집 autotrack SDK는 보조 기능([rudder-sdk-js-autotrack](https://github.com/rudderlabs/rudder-sdk-js-autotrack)).)
- **Q2. 감지 시점 — 사전 차단 vs 사후 발견?** — **층위별 공존.** 개발 시점(RudderTyper 컴파일 타임)=사전 차단, 병합 전(AI Reviewer PR/CI)=사전 차단, 런타임 수집(Tracking Plan 검증)=사후 성격이지만 드롭·라우팅으로 하류 오염 차단. 앞단에서 막고 뒷단에서 방어하는 구조다([Rudder AI Reviewer 블로그](https://www.rudderstack.com/blog/rudder-ai-reviewer-pr-tracking-validation/), [Violation Management 블로그](https://www.rudderstack.com/blog/feature-launch-tracking-plans-for-violation-management/)).
- **Q3. UI 요소↔이벤트 시각 매핑?** — **공식 자료에서 확인 못함(코드 우선).** 화면 요소를 클릭해 이벤트에 대응시키는 점-클릭 비주얼 매퍼는 확인되지 않았다. 있는 것은 규칙 기반 autotrack SDK와 디버깅용 Events Tracking Assistant뿐이며, 둘 다 UI↔이벤트 시각 매핑 증거 도구가 아니다([rudder-sdk-js-autotrack](https://github.com/rudderlabs/rudder-sdk-js-autotrack), [Events Tracking Assistant 문서](https://www.rudderstack.com/docs/sources/event-streams/sdks/rudderstack-javascript-sdk/events-tracking-assistant/)). 이 부재 자체가 시각 태깅 도구 대비 개발자 중심 워크플로라는 차별점이다.

---

# 5. 4종 요약 비교

| 항목 | Segment Protocols | Mixpanel Lexicon | mParticle Data Master | RudderStack |
|---|---|---|---|---|
| 코드젠 | Typewriter (O) | 없음 (X) | Smartype (O) | RudderTyper (O) |
| 수집 시점 차단 | O (Block, device-mode 예외) | 제한적 (수동 Block만) | **O (실시간 차단, 핵심 차별점)** | O (Drop/Route) |
| 검증 성격 | 하이브리드(컴파일+수집) | 대부분 사후 발견 | 개발+유입 양쪽 | 3층(컴파일·PR·수집) |
| UI↔이벤트 시각 매핑 | X | 부분(Autocapture+리플레이) | X | X |
| 수동 계측 전제 | 유지 | 유지 | 유지 | 유지 |
| 가격 | Business add-on(비공개) | Free~Enterprise, 고급 거버넌스는 Enterprise | 비공개, 연 $150K+ | OSS+티어, Growth $265/월~ |

- **공통점**: 네 도구 모두 **수동 계측 전제를 유지**하고, 코드젠(Mixpanel 제외)으로 개발 단계를 보조하되 "어디서/언제" 이벤트를 심을지는 사람 몫이다. UI 요소와 이벤트를 시각적으로 연결·증빙하는 기능은 **모두 약하거나 없다**(Mixpanel의 Autocapture+세션 리플레이가 가장 근접). 이는 Avo의 Journeys 같은 시각 매핑이 여전히 드문 사각지대임을 보여준다.
- **차별점**: mParticle은 **유입 시점 실시간 차단**이 가장 강하고, RudderStack은 **PR/CI 단계 검증(AI Reviewer)**까지 앞당긴 점이 특징이며, Mixpanel은 실질적으로 **검증 게이트가 아닌 서술적 사전(dictionary)**에 가깝다.
