---
id: SRC-20260723-amplitude-avo-taxonomy-publishing
title: "Amplitude taxonomy/governance docs and Avo publishing integration docs"
status: accepted
source_type: documentation
original_url: "https://amplitude.com/docs/data/data-planning-playbook"
submitted_by: "Research Agent"
submitted_at: 2026-07-23
retrieved_at: 2026-07-23
issue_url: ""
language: en
publisher: "Amplitude, Avo"
authors: []
published_at: ""
reliability: primary
content_file: ""
content_sha256: ""
supersedes: []
---

# Amplitude taxonomy/governance docs and Avo publishing integration docs

## Submitter Note

`SRC-20260722-tracking-reference-links`(4.3 참고 링크 카탈로그)의 신규 URL 중 Amplitude 4건과 Avo 4건을 공식 문서로 확보해 기존 `amplitude-data`, `avo` 지식 페이지를 보강한다.

## Research Questions

- Amplitude의 taxonomy 설계 방법론과 데이터 거버넌스 프레임워크는 기존 Ampli codegen 이해를 어떻게 확장하는가?
- Amplitude가 이미 AI 에이전트 기반 계측 워크플로를 제공하는가? 그렇다면 신규 제품의 차별화 지점에 어떤 영향을 주는가?
- Avo Publishing 기능은 트래킹 플랜을 어떤 하류 도구에 어떤 방식으로 동기화하는가?

## Provenance

- 원문 확보 방법: 각 벤더 공식 문서/블로그를 웹에서 직접 조회했다.
- 주요 URL:
  - https://amplitude.com/docs/data/data-planning-playbook
  - https://amplitude.com/explore/data/event-taxonomy
  - https://amplitude.com/blog/data-governance-framework
  - https://amplitude.com/blog/analytics-tracking-practices
  - https://www.avo.app/docs/workspace/tracking-plan/publishing
  - https://www.avo.app/docs/publishing/integrations
  - https://www.avo.app/docs/publishing/publishing/segment-protocols
  - https://www.avo.app/docs/publishing/publishing/mixpanel-lexicon
- 원문 보존 위치: URL과 retrieval date를 기록한다. 저작권상 원문 전체를 로컬 복제하지 않는다.
- 원문과 record의 차이: record는 조사 질문에 필요한 claim 단위 요약만 포함한다.

## Triage

- 판정: accepted
- 판정자: LLM auto-triage policy-v1
- 판정일: 2026-07-23
- 사유: 모두 공개 공식 문서 또는 공식 블로그이며 provenance를 URL과 retrieval date로 재현할 수 있다. 기존 Amplitude Data·Avo 경쟁사 페이지와 직접 관련되고 기존 Source와 exact duplicate가 아니다(원문 8건 중 `avo-tracking-plan` 1건만 기존 인용 URL이라 이번 배치에서 제외했다).

## Extracted Content

### Amplitude — taxonomy 설계와 거버넌스

- `data-planning-playbook`: taxonomy 설계 3단계(사업 목표 정의 → 핵심 지표 분해 → 이벤트·속성 최적화)를 제시하며, "트래킹 플랜을 손으로 설계하거나 기존 플랜을 감사할 때" 쓰라고 안내한다.
- 명명 규칙 축 3가지: 대소문자 일관성(`Song Played` ≠ `song played`), 어순 일관성(`Song Played` ≠ `Played Song`), 행위 주체 일관성(사용자 발생 vs 시스템 발생). 기본 규칙은 Title Case + `[명사] + [과거형 동사]`.
- `amplitude:taxonomy`라는 "skill"을 "명명 규칙·속성 표준·점수화 프레임워크·폐기 절차의 단일 진실 원천"으로 설명한다. `.amplitude/instrumentation-agent.yaml`(프로젝트 매핑), `.amplitude/instrumentation-agent-context.md`(규칙 문서) 같은 설정 파일과 `amplitude:add-analytics-instrumentation`이라는 "자동 계측 파이프라인"이 코드 내 정확한 삽입 위치, 추천 이벤트 이름·설명·카테고리·속성을 생성한다고 설명한다. 이는 기존에 문서화된 Ampli CLI/codegen과 다른 메커니즘 — **AI 에이전트가 코드에 직접 계측을 삽입**하는 방식이다.
- `event-taxonomy`: 이벤트 taxonomy를 이벤트·이벤트 속성·사용자 속성 3요소로 정의하고, 명명 규칙으로 소문자+언더스코어+동사_명사(`button_clicked`)를 제시한다. **이는 data-planning-playbook과 analytics-tracking-practices가 제시하는 Title Case 규칙과 정면으로 다르다** — Amplitude 자체 공식 자료 안에서 명명 규칙이 문서마다 엇갈린다.
- `event-taxonomy` 거버넌스 역할 구조: 이벤트 요청자(제안) → 데이터 스튜어드(명명·중복 검토) → 도메인 오너(제품 영역 내 승인) → 기술 구현자(코드 반영). 이벤트는 proposed/active/deprecated/removed 생애주기 라벨을 가지며 변경 이력(무엇을·언제·왜·누가 승인)을 기록한다.
- `event-taxonomy` 실패 유형: 명명 표류로 인한 중복 이벤트(`sign-up` vs `sign_up` vs `user_sign_up`), 조용히 깨지는 속성 변경, 저가치 데이터 과다 수집(마우스 이동 등)으로 인한 노이즈.
- `data-governance-framework`: 거버넌스 프레임워크를 교육(표준 문서화·공유)·계측(표준 정의와 적용 방법)·유지보수(소유·갱신 책임) 3축으로 정의하고, "Data Governor" 역할(개인 또는 교차 기능 팀)이 거버넌스 질문을 담당한다고 설명한다. Gartner 조사를 인용해 데이터 품질 저하로 조직이 연간 1,500만 달러 손실을 본다고 언급한다(Gartner 재인용, secondary 수치).
- `analytics-tracking-practices`: 목표→지표→이벤트→속성으로 이어지는 계단식 설계 구조를 제시하며, 여기서는 이벤트 Title Case·속성 snake_case를 명명 규칙으로 쓴다(Object-Action 프레임워크). 서버사이드 계측이 필수 이벤트에 더 안정적이라며 클라이언트 사이드는 광고 차단기와 Safari ITP·Firefox ETP 같은 브라우저 추적 방지 기능에 제약받는다고 명시한다. 개발/운영 환경 데이터 분리, 코드 배포 파이프라인(CI/CD)에서 스펙 대조 검증을 권장하며, 트래킹 플랜 소유를 제품팀에 두고 Jira 티켓 단위로 계측 요구사항·테스트·검증을 명시하라고 권장한다.

### Avo — Publishing(하류 동기화) 메커니즘

- `publishing`(개요): 두 배포 방식 — Push(Avo가 다른 스키마 레지스트리로 직접 발행)와 Pull(CI/CD에서 CLI로 스키마를 가져옴). Publishing 연동 대상 8곳: Amazon S3, Segment Protocols, Mixpanel Lexicon, RudderStack, Snowplow Data Structures, mParticle Data Master, Amplitude Data, 범용 Webhook.
- Auto Publishing을 켜면 브랜치의 모든 변경이 **브랜치 merge 시점에** 자동 발행된다(개발 중에는 발행하지 않음). Publishing 연동은 Source·Destination·Tag로 범위를 좁힐 수 있고, Webhook은 "변경된 이벤트만 전송" 옵션이 추가로 있다(merge된 브랜치에서 source에 영향을 준 이벤트만 payload에 포함).
- 여러 source로 필터링하면 속성 존재 여부는 "최소공배수(lowest common denominator)"로 계산한다 — 해당 source들 모두에 공통으로 필요한 속성만 필수로 표시.
- `integrations`(개요): 동일한 7개 하류 동기화 대상을 "analytics schema를 하류로 동기화"한다고 설명한다. Webhook은 "JSON 스키마를 임의 endpoint에 POST"하는 범용 통로로, 프로덕션 검증이나 SQL 테이블 기록 같은 커스텀 사례에 쓰인다고 명시한다. 별도로 워크플로 연동(Publishing과는 다른 카테고리)으로 Jira 자동 티켓 생성과 GitHub 자동 PR 생성이 "Coming Soon"(미출시)이고, Slack 알림은 이미 제공된다.
- `segment-protocols`: 연동 설정에 Segment Workspace Slug, Protocols Tracking Plan ID(`rs_` 또는 `tp_` 접두), "Protocol Admin" 권한의 Segment Access Token 3가지가 필요하다. 발행은 수동 버튼 또는 merge 시 자동. **덮어쓰기 방식**: "Avo에서 발행에 포함된 이벤트는 Protocols의 기존 정의를 모두 덮어쓴다." 동기화 필드 — 이벤트: 이름(매핑 가능)·설명(트리거 정보 포함)·Avo 태그를 `key:value` 형식에 `:avo` 접미사를 붙여 Protocols 라벨로 발행. 이벤트 속성: 이름(매핑)·설명·타입(JSON Schema로 변환)·필수 여부(Avo에서 "Always sent"로 표시된 경우만). 사용자 속성: 포함된 source에 연결된 모든 속성의 identify trait을 기본 동기화하되, **Protocols에만 정의된 사용자 속성은 덮어쓰지 않는다**. 명시된 한계: 그룹 속성과 카테고리는 발행되지 않고, Protocols에만 있고 Avo에 없는 이벤트는 그대로 두며, 이벤트별 이름 매핑은 사용자 속성에는 적용되지 않는다.
- `mixpanel-lexicon`: 연동 설정에 Mixpanel Project ID, Mixpanel Service Account 사용자명·시크릿, EU 데이터 거주지 토글, "카테고리를 태그로 발행"(Lexicon에 카테고리 필드가 없어 "Category:" 접두사를 붙임) 옵션이 필요하다. 발행은 수동 또는 자동. **병합 방식**: Avo 트래킹 플랜이 기존 Lexicon 이벤트와 병합되며, Avo의 변경이 Lexicon에서 직접 수정된 중간 편집분을 덮어쓴다. 명시된 한계(원문 인용): "Lexicon에만 정의됐거나 Avo의 Lexicon 연동에 아직 추가되지 않은 이벤트에는 영향을 주지 않는다." 동기화 필드 — 이벤트: 이름·설명·필수 속성 플래그·중첩 속성(이름/설명/타입/메타데이터)·태그. 사용자 속성: 이름·설명·타입.

### 교차 관찰

- Amplitude 공식 자료 안에서 이벤트 명명 규칙이 문서마다 다르다(Title Case vs snake_case). 어느 한쪽을 정답으로 채택하지 않고 "Amplitude 스스로도 문서 간 규칙이 엇갈린다"로 남긴다.
- Avo의 Publishing은 Segment Protocols에는 **덮어쓰기(override)**, Mixpanel Lexicon에는 **병합(merge)** 방식을 쓰는 등 대상마다 덮어쓰기/병합 의미가 다르다. 두 경우 모두 "대상 도구에만 있는 이벤트는 건드리지 않는다"는 원칙은 공통이다.
- Amplitude의 `amplitude:taxonomy`/`instrumentation-agent` 워크플로는 기존에 문서화된 Ampli CLI/codegen과 별개로, AI 에이전트가 코드 삽입 위치까지 제안하는 방식이다. 이는 신규 제품이 내세우려는 "자동 계측 제안" 가설과 직접 겹치는 경쟁 신호다.

## Revision Notes

- 2026-07-23: Research Agent가 `SRC-20260722-tracking-reference-links` 카탈로그의 신규 URL 8건을 fetch해 Source record를 생성하고 자동 triage 정책으로 accepted 처리했다.
