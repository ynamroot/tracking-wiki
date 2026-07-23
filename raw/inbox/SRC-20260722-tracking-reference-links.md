---
id: SRC-20260722-tracking-reference-links
title: 트래킹 플랜 자동화 연구 참고 링크 모음 (4.3 참고 링크)
status: deferred
source_type: other
original_url: ""
submitted_by: ynamroot
submitted_at: 2026-07-22
retrieved_at: 2026-07-22
issue_url: ""
language: ko
publisher: ""
authors: []
published_at: ""
reliability: unreviewed
content_file: ""
content_sha256: ""
supersedes: []
---

# 트래킹 플랜 자동화 연구 참고 링크 모음 (4.3 참고 링크)

## Submitter Note

사용자가 어떤 문서(트래킹 플랜 자동화 관련 연구 문서로 추정)의 "4.3 참고 링크" 절을 그대로 붙여넣고
ingest를 요청했다. 6개 범주로 묶인 URL 목록이며, 개별 원문은 첨부되지 않았다.

## Research Questions

- 이 목록의 어떤 링크가 이미 저장소의 accepted Source가 인용 중인 자료인가?
- 어떤 링크가 아직 Wiki에 반영되지 않은 신규 자료인가?
- (미해결) 이 목록은 정확히 어느 문서의 "4.3절"인가?

## Provenance

- 원문 확보 방법: 사용자가 대화 중 텍스트로 붙여넣음(파일 첨부 없음).
- 원문 보존 위치: 없음. 이 record의 Extracted Content가 유일한 사본이다.
- 원문과 record의 차이: 원문 순서·범주·URL을 그대로 보존했다. 각 URL 옆에 이 저장소 기준
  기존 인용 여부를 조사해 매핑 주석을 추가했다(원문에는 없던 부가 정보).
- 출처 가정: 이 목록의 URL 29건 중 4건이 이미 저장소의 accepted Source(`SRC-20260721-avo-official-data-design`,
  `SRC-20260721-schema-data-contracts` 등)가 인용 중인 링크와 정확히 일치한다. 이 겹침은 이 목록이
  **기존 연구 corpus를 만든 문서의 참고문헌(4.3) 절**일 가능성을 뒷받침한다. 다만 어느 특정 문서인지는
  확인되지 않았으므로 사용자가 원문서를 밝히면 정정한다.

## Triage

- 판정: `deferred` (카탈로그 방식 — 사용자 결정)
- 판정자: LLM auto-triage policy-v1 (Wiki Compiler 역할, 2026-07-22 대화 중 사용자와 합의)
- 판정일: 2026-07-22
- 사유: `OPERATIONS.md` §2의 exact-duplicate 검사를 URL 단위로 수행한 결과, 29건 중 4건이 기존
  accepted Source의 인용과 정확히 일치해 **중복 provenance**로 분류하고 별도 조치를 취하지 않는다.
  나머지 25건은 신규 URL이나, 원문 fetch·claim 분해 없이 목록만 정리하는 카탈로그 방식을 사용자가
  선택했으므로 이번 ingest에서는 `raw/inbox`에 `deferred`로 남기고 위키를 갱신하지 않는다. 신규 URL은
  향후 필요 시 개별 Source 제출(`source:new` Issue) 또는 일괄 조사 대상으로 재검토한다.

## Extracted Content

원문은 저작권 있는 외부 문서 모음이 아니라 사용자가 직접 정리해 붙여넣은 링크 목록이므로 전체를 보존한다.
각 URL 옆 대괄호는 이 저장소 기준 매핑 결과다 — `[기존: SRC-...]`는 해당 Source가 이미 이 URL을
인용 중임을 뜻하고, `[신규]`는 저장소 어디에도 아직 인용되지 않은 URL임을 뜻한다(2026-07-22 grep 기준).

### Amplitude

- https://amplitude.com/docs/data/data-planning-playbook `[반영: SRC-20260723-amplitude-avo-taxonomy-publishing]`
- https://amplitude.com/explore/data/event-taxonomy `[반영: SRC-20260723-amplitude-avo-taxonomy-publishing]`
- https://amplitude.com/blog/data-governance-framework `[반영: SRC-20260723-amplitude-avo-taxonomy-publishing]`
- https://amplitude.com/blog/analytics-tracking-practices `[반영: SRC-20260723-amplitude-avo-taxonomy-publishing]`

### Avo

- https://www.avo.app/docs/data-design/avo-tracking-plan `[기존: SRC-20260721-avo-official-data-design, SRC-20260721-avo, SRC-20260722-commercial-tools-survey, SRC-20260722-tracking-glossary]`
- https://www.avo.app/docs/workspace/tracking-plan/publishing `[반영: SRC-20260723-amplitude-avo-taxonomy-publishing]`
- https://www.avo.app/docs/publishing/integrations `[반영: SRC-20260723-amplitude-avo-taxonomy-publishing]`
- https://www.avo.app/docs/publishing/publishing/segment-protocols `[반영: SRC-20260723-amplitude-avo-taxonomy-publishing]`
- https://www.avo.app/docs/publishing/publishing/mixpanel-lexicon `[반영: SRC-20260723-amplitude-avo-taxonomy-publishing]`

### Snowplow/Iglu

- https://docs.snowplow.io/docs/fundamentals/schemas/ `[기존: SRC-20260721-schema-data-contracts, SRC-20260721-tracking-governance-remaining-tools, SRC-20260722-tracking-glossary]`
- https://docs.snowplow.io/docs/api-reference/iglu/ `[기존: SRC-20260721-schema-data-contracts, SRC-20260721-tracking-governance-remaining-tools, SRC-20260722-tracking-glossary]`
- https://docs.snowplow.io/docs/data-product-studio/data-structures/manage/iglu/ `[반영: SRC-20260723-data-contract-ecosystem]`

### 데이터 컨트랙트

- https://atlan.com/data-contracts/ `[반영: SRC-20260723-data-contract-ecosystem]`
- https://www.datasops.com/blog/data-contracts-versioning `[반영: SRC-20260723-data-contract-ecosystem]`
- https://bitol-io.github.io/open-data-contract-standard/v3.1.0/ `[기존: SRC-20260721-schema-data-contracts, SRC-20260722-commercial-tools-survey, SRC-20260722-tracking-glossary]`
- https://github.com/bitol-io/open-data-contract-standard `[반영: SRC-20260723-data-contract-ecosystem]`
- https://bitol.io/ `[반영: SRC-20260723-data-contract-ecosystem]`

### 실운영 사례

- https://docs.gitlab.com/development/internal_analytics/internal_event_instrumentation/event_definition_guide/ `[반영: SRC-20260723-industry-event-governance-practices]`
- https://docs.gitlab.com/development/internal_analytics/internal_event_instrumentation/internal_events_payload/ `[반영: SRC-20260723-industry-event-governance-practices]`
- https://wikitech.wikimedia.org/wiki/Event_Platform/Onboarding `[반영: SRC-20260723-industry-event-governance-practices]`
- https://gitlab.wikimedia.org/repos/data-engineering/schemas-event-primary `[반영: SRC-20260723-industry-event-governance-practices — 저장소 UI는 로드되지 않아 raw README로 원문 확보]`
- https://brunch.co.kr/@soxxun/8 `[반영: SRC-20260723-industry-event-governance-practices — Naver Series 연재 2편]`
- https://blog.martinee.io/post/designing-perfect-event-taxonomy-naver-series `[반영: SRC-20260723-industry-event-governance-practices — Naver Series 연재 1편]`
- https://toss.tech/ `[미해결 — 홈페이지만 확인됨, 이벤트 트래킹 관련 아티클이 노출 목록에 없어 사례를 찾지 못함. 특정 아티클을 지목한 후속 조사가 필요하다.]`

### 기타

- https://www.optizent.com/blog/mixpanel-lexicon-the-feature-that-keeps-your-analytics-implementation-from-falling-apart/ `[반영: SRC-20260723-commercial-tools-commentary]`
- https://docs.mixpanel.com/docs/tracking-methods/integrations/mparticle `[반영: SRC-20260723-commercial-tools-commentary]`
- https://www.rudderstack.com/blog/rudderstack-x-avo/ `[반영: SRC-20260723-commercial-tools-commentary]`
- https://posthog.com/blog/best-open-source-analytics-tools `[반영: SRC-20260723-commercial-tools-commentary — 위키에는 반영하지 않음, 근거는 해당 Source의 한계 절 참고]`
- https://e-cens.com/blog/garbage-in-garbage-out-a-strategic-playbook-for-data-governance-quality-in-amplitude/ `[반영: SRC-20260723-commercial-tools-commentary]`

### 요약

- 전체 29건 중 기존 인용 4건(Avo tracking plan 공식 문서, Snowplow schemas·Iglu 소개, ODCS/bitol v3.1.0) —
  모두 [[schema-and-data-contracts|스키마 및 데이터 계약]]·[[avo|Avo]] 계열 지식 페이지의 근거로 이미 반영돼 있었다.
- 2026-07-23 fetch-and-ingest에서 신규 25건 중 24건을 4개 accepted Source(`SRC-20260723-amplitude-avo-taxonomy-publishing`,
  `SRC-20260723-data-contract-ecosystem`, `SRC-20260723-commercial-tools-commentary`,
  `SRC-20260723-industry-event-governance-practices`)로 확보하고 위키 지식 페이지에 반영했다.
  Toss(`toss.tech`) 1건만 사례를 찾지 못해 미해결로 남았다.

## Revision Notes

- 2026-07-22: `raw/inbox`에서 카탈로그 형태로 최초 작성. 원문 fetch나 위키 반영 없이 URL 목록과
  기존 인용 여부 매핑만 기록했다(사용자 결정: 카탈로그 방식). 위키(`wiki/`), `log.md`, `index.md`,
  `open-questions.md`는 이번 변경에서 건드리지 않았다.
- 2026-07-23: 사용자가 "전체 진행해"로 fetch-and-ingest를 요청해, 신규 URL 25건 중 24건을 4개
  accepted Source로 확보하고 관련 지식 페이지에 반영했다. 이 카탈로그 record 자체는 `raw/sources`로
  승격하지 않고 `raw/inbox`에 `deferred`로 유지한다 — 실질 콘텐츠는 4개 신규 Source가 담고, 이 record는
  원문 목록과 매핑 이력만 보존하는 인덱스 역할로 남긴다. Toss 1건은 미해결로 남아 후속 조사가 필요하다.
