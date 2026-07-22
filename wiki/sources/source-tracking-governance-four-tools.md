---
title: "Source Summary: 트래킹 거버넌스 도구 4종"
type: source-summary
status: current
confidence: medium
created: 2026-07-21
updated: 2026-07-22
sources:
  - SRC-20260721-tracking-governance-four-tools
---

# Source Summary: 트래킹 거버넌스 도구 4종

## Current Synthesis

Segment, Mixpanel, mParticle, RudderStack은 tracking plan과 실제 데이터의 불일치를 각기 다른 위치에서 다룬다. 공통점은 사람이 무엇을 계측할지 정하고 개발자가 구현한다는 전제를 유지한다는 점이다. 차이는 검증 위치와 위반 처리 철학이다. <sup>[🔗](#source-1)</sup>

## Evidence

- Segment Protocols는 tracking plan과 source validation을 연결하고, 일부 위반을 block/omit/allow할 수 있다. <sup>[🔗](#source-1)</sup>
- Mixpanel Lexicon은 사후 dictionary/governance 성격이 강하며, 강제 게이트보다는 정리·문서화에 가깝다. <sup>[🔗](#source-1)</sup>
- mParticle Data Planning은 plan schema와 ingestion validation을 강하게 결합하고, 차단/격리 trade-off가 중요하다. <sup>[🔗](#source-1)</sup>
- RudderStack은 tracking plan, Data Catalog, RudderTyper, PR/CI 검증, ingestion validation을 조합한다. <sup>[🔗](#source-1)</sup>

## Mechanics

검증 시점은 compile/codegen, PR/CI, client/runtime, ingestion pipeline, post-ingestion dictionary로 나뉜다. 앞단일수록 수정 비용은 낮지만 실제 사용자 행동을 보지 못하고, 뒷단일수록 실제 데이터를 보지만 이미 손상이 발생했을 수 있다.

## Evaluation Criteria

- validation placement: compile, PR, runtime, ingestion, warehouse 중 어디인가.
- violation disposition: allow, block, omit, transform, quarantine, propagate.
- developer dependency: SDK call과 plan version tag를 누가 심는가.
- visual/action evidence: UI 요소와 event claim을 연결하는가.

## Contradictions

이 Source는 일부 공식 문서와 제3자 가격/리뷰 요약을 함께 사용한다. 가격과 기능 tier는 공식 primary Source로 보강된 페이지에서 우선 해석해야 한다.

## Open Questions

- 경쟁사별 최신 pricing과 feature gate를 claim 단위로 업데이트해야 한다.
- UI 요소 증빙 부재가 실제 구매 이유가 될 만큼 중요한가?

## Product Implications

경쟁 포지션은 “새 tracking plan platform”보다 “기존 plan/CDP가 보지 못하는 UI-action evidence와 pre-release drift detection”으로 잡는 편이 차별화가 분명하다.

## See Also

- [[tracking-governance-platforms|트래킹 거버넌스 플랫폼]] - 통합 비교
- [[validation-layer-model|검증 계층 모델]] - 검증 위치별 trade-off

## 출처

- <a id="source-1"></a>[[source-tracking-governance-four-tools|트래킹 플랜 거버넌스 도구 4종 조사]] - `SRC-20260721-tracking-governance-four-tools`
