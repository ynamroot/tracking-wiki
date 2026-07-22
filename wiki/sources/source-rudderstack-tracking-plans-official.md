---
title: "Source Summary: RudderStack Tracking Plans 공식 문서"
type: source-summary
status: current
confidence: high
created: 2026-07-22
updated: 2026-07-22
sources:
  - SRC-20260721-rudderstack-tracking-plans-official
---

# Source Summary: RudderStack Tracking Plans 공식 문서

## Current Synthesis

RudderStack 공식 Source는 Tracking Plans가 incoming event data의 non-compliance를 monitor하고 act on하는 기능이며, Free/Growth/Enterprise별 plan/event limit과 violation management 차이가 있음을 확인한다. <sup>[🔗](#source-1)</sup>

## Evidence

- Tracking Plans는 predefined plans 기반으로 incoming event data의 non-compliance를 monitor하고 act on한다. <sup>[🔗](#source-1)</sup>
- 기능은 `track`, `identify`, `page`, `screen`, `group` event rules, required property/attribute, data type 정의를 포함한다. <sup>[🔗](#source-1)</sup>
- Tracking plan feature는 Free, Growth, Enterprise plans에서 지원된다. <sup>[🔗](#source-1)</sup>
- plan limit은 Free 1 plan/5 events per plan, Growth unlimited plans/75 events per plan, Enterprise unlimited plans/unlimited events per plan이다. <sup>[🔗](#source-1)</sup>
- violation management는 Free에서 Drop Events, Growth/Enterprise에서 Configurable로 표시된다. <sup>[🔗](#source-1)</sup>

## Mechanics

RudderStack은 CDP source boundary에서 inbound event를 tracking plan과 대조하고, plan/config에 따라 violation을 처리한다. Data Catalog API와 dashboard 관리가 함께 제공되어 code/API driven governance로 이동하는 경향이 있다.

## Evaluation Criteria

- free viability: 1 plan/5 events 제한이 실제 pilot에 충분한가.
- violation policy: Drop-only와 configurable의 운영 차이.
- event coverage: alias 미지원 같은 excluded call이 제품 설계에 미치는 영향.

## Contradictions

기존 secondary Source의 Growth 가격과 공식 price page의 최신 표시가 달라질 수 있다. 공식 Source를 우선한다.

## Open Questions

- RudderStack 고객에게 pre-release UI path 검증이 Data Catalog/Tracking Plan과 어떤 관계를 가지는가?
- configurable violation management가 실제로 어느 tier에서 구매되는가?

## Product Implications

RudderStack은 Free tier에도 governance 맛보기를 제공하므로, 신규 제품은 free pilot에서 차별화 가능한 visual proof 또는 changed-route regression을 보여줘야 한다.

## See Also

- [[tracking-governance-platforms|트래킹 거버넌스 플랫폼]] - RudderStack 비교
- [[pricing-and-packaging|가격과 패키징 비교]] - tier별 제한

## 출처

- <a id="source-1"></a>[[source-rudderstack-tracking-plans-official|RudderStack official docs: Tracking Plans and pricing limits]] - `SRC-20260721-rudderstack-tracking-plans-official`
