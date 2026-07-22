---
id: SRC-20260722-commercial-tools-official-docs
title: "Commercial tracking and analytics tools official documentation bundle"
status: accepted
source_type: documentation
original_url: "https://help.observepoint.com/en/articles/9099982-creating-audits"
submitted_by: "Research Agent"
submitted_at: 2026-07-22
retrieved_at: 2026-07-22
issue_url: "https://github.com/ynamroot/tracking-wiki/issues/1"
language: en
publisher: "ObservePoint, Trackingplan, Heap, PostHog, Amplitude, Mixpanel, Google"
authors: []
published_at: ""
reliability: primary
content_file: ""
content_sha256: ""
supersedes: []
---

# Commercial tracking and analytics tools official documentation bundle

## Submitter Note

`SRC-20260722-commercial-tools-survey`는 내부 종합 보고서이므로, 기능 경계와 현재 제품 설명을 공식 문서로 보강하기 위해 관련 원자료를 묶었다.

## Research Questions

- 상용 도구 조사의 다섯 갈래 분류가 공식 문서의 기능 설명과 맞는가?
- 태그 감사, 실트래픽 모니터링, 오토캡처, 태그매니저 계층은 어떤 검증 위치와 한계를 갖는가?
- `OQ-007`의 공식 primary Source 확장 범위에 어떤 제품군을 추가할 수 있는가?

## Provenance

- 원문 확보 방법: 각 벤더와 플랫폼의 공식 문서 또는 공식 제품 페이지를 웹에서 직접 조회했다.
- 주요 URL:
  - https://help.observepoint.com/en/articles/9099982-creating-audits
  - https://help.observepoint.com/en/articles/9101987-creating-journeys
  - https://www.trackingplan.com/how-it-works
  - https://www.trackingplan.com/docs/deep-audits
  - https://www.heap.io/platform/event-visualizer
  - https://help.heap.io/hc/en-us/articles/37271998625169-Event-Repair-Flow
  - https://posthog.com/docs/data/actions
  - https://amplitude.com/docs/data/visual-labeling
  - https://docs.mixpanel.com/docs/tracking-methods/autocapture
  - https://support.google.com/tagmanager/answer/7679410
  - https://support.google.com/tagmanager/answer/6107056
- 원문 보존 위치: URL과 retrieval date를 기록한다. 저작권상 원문 전체를 로컬 복제하지 않는다.
- 원문과 record의 차이: record는 조사 질문에 필요한 claim 단위 요약만 포함한다.

## Triage

- 판정: accepted
- 판정자: LLM auto-triage policy-v1
- 판정일: 2026-07-22
- 사유: 모두 공개 공식 문서 또는 공식 제품 페이지이며 provenance를 URL과 retrieval date로 재현할 수 있다. 행동데이터 계측, 태그 감사, 오토캡처, 태그매니저의 경쟁 기능 범위와 직접 관련되고 기존 Source와 exact duplicate가 아니다.

## Extracted Content

- ObservePoint Audits는 사이트를 브라우저에서 방문하고 페이지 로드 중 나가는 태그 요청을 모니터링한다. URL, 위치, 브라우저 수, privacy setting, sitemap, schedule, rule을 설정할 수 있고, On-Page Actions로 버튼 클릭이나 다운로드 링크 같은 행동을 실행할 수 있다.
- ObservePoint Journeys는 웹사이트의 페이지, 폼, funnel에서 사용자 상호작용을 시뮬레이션하고 tag, cookie, console error 등을 보고한다. 핵심 경로 검증에 적합하지만 사람이 정의한 여정과 규칙이 중심이다.
- Trackingplan은 snippet 또는 SDK를 설치해 실제 사용자 트래픽에서 analytics event, property, pixel, UTM pattern, dataLayer structure, consent signal을 발견하고 살아있는 tracking plan을 만든다고 설명한다. Deep Audits는 매일 정해진 검증을 실행하고 실패 세션 샘플과 event sequence를 보여준다.
- Heap Event Visualizer는 자동 수집된 raw event 위에 point-and-click 방식으로 event label을 붙이는 계층이다. Event Repair Flow는 72시간 동안 data가 없는 inactive event를 visual labeling, 새 event label, 기존 event로 수리해 기존 dashboard와 downstream sync 영향을 줄이는 흐름을 제공한다.
- PostHog Actions는 autocapture event, custom event, pageview, screen view를 묶어 분석용 action으로 만든다. Autocapture action은 button/input/form 등 frontend element와 text, URL, CSS selector 조건을 쓴다. 기본 autocapture 범위를 벗어나는 요소는 수동 설정이 필요하다.
- Amplitude Visual Labeling은 Autocapture가 켜진 사이트에서 화면 요소를 클릭해 labeled event를 만들고, 이 정의를 과거 Autocapture data에 소급 적용한다. DOM 변경으로 labeled event reference가 깨질 수 있으며 repair flow는 새 조건을 OR로 추가해 이력을 유지한다.
- Mixpanel Autocapture는 개인정보 보호 기본값으로 input, select, textarea 등 민감 요소를 제외하고 class, name, aria-label, role, title, type 같은 제한된 HTML attribute를 수집한다고 설명한다.
- Google Tag Manager Element Visibility trigger는 ID 또는 CSS selector로 선택한 요소가 viewport에 보일 때 trigger를 발화한다. Preview and debug mode는 컨테이너 초안이 배포된 것처럼 사이트를 탐색하고 어떤 tag가 어떤 순서로 fired 되었는지 사람이 확인하는 세션 기반 debug 흐름이다.

## Revision Notes

- 2026-07-22: Research Agent가 `SRC-20260722-commercial-tools-survey` ingest 보강용 primary Source bundle을 생성하고 Intake Agent가 자동 triage 정책으로 accepted 처리했다.
