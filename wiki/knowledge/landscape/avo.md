---
title: Avo
type: competitor
status: current
confidence: high
created: 2026-07-21
updated: 2026-07-22
sources:
  - SRC-20260721-avo
  - SRC-20260721-avo-official-data-design
---

# Avo

## Current Synthesis

Avo는 가장 직접적인 경쟁/참조 제품이다. tracking plan을 application data definition으로 삼고, Journeys, Codegen, Inspector, approval, downstream registry sync를 결합한다. 강점은 설계와 구현 사이의 운영 규율이고, 남는 공백은 runtime UI action과 emitted event의 자동 시각 증빙이다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup>

## Evidence

- 공식 Source는 Avo Tracking Plan이 codegen과 validation에 사용되는 중심 명세라고 확인한다. <sup>[🔗](#source-2)</sup>
- Workspace 구성 요소는 Journeys, Events, Properties, Metrics, Publishing, Connection Setup, Codegen, Inspector다. <sup>[🔗](#source-2)</sup>
- 내부 Source는 Codegen이 wrapper를 만들지만 개발자가 호출 위치와 시점을 직접 결정해야 한다고 요약한다. <sup>[🔗](#source-1)</sup>
- Free는 $0, 2 editors, 100k Inspector observed events이고 Team은 annual $250/month, monthly $300/month다. <sup>[🔗](#source-2)</sup>
- Enterprise는 enforceable approvals, automated required reviews, enforceable standards, 1M Inspector observed events, SSO, premium support를 포함한다. <sup>[🔗](#source-2)</sup>

## Mechanics

Avo는 data design을 명세로 고정하고, generated function을 코드에 pull해 implementation을 표준화한다. Inspector는 실제 event schema shape를 관찰해 plan과 비교한다. Journeys는 screenshot 기반으로 설계 의도를 시각화하지만, runtime에서 “이 버튼을 누르면 이 event가 이 payload로 전송됐다”를 자동 proof로 묶는 계층은 확인되지 않는다.

## Evaluation Criteria

- 직접 경쟁 강도: tracking plan, codegen, Inspector가 overlap한다.
- 보완 가능성: Avo plan을 읽어 UI traversal test를 생성할 수 있는가.
- pricing wedge: Avo Team/Enterprise feature와 비교해 더 작은 팀에도 value를 줄 수 있는가.
- evidence gap: Journeys design artifact와 runtime proof 사이를 메울 수 있는가.

## Contradictions

Avo는 이미 screenshot/Journey를 제공하므로 “시각 매핑이 전혀 없다”고 쓰면 부정확하다. 정확한 공백은 design-time visual mapping과 runtime action-event evidence의 차이다.

## Open Questions

- Avo 고객이 실제로 가장 자주 실패하는 단계는 authoring, implementation, QA, production triage 중 어디인가?
- 신규 제품이 Avo와 통합할 수 있다면 source of truth는 Avo plan인가 별도 plan인가?

## Product Implications

Avo 대체 포지션은 위험하다. 초기에는 Avo/Segment/Amplitude plan 위에서 changed UI path를 자동 순회하고 runtime event proof를 붙이는 보완 계층이 더 현실적이다.

## See Also

- [[codegen-and-tracking-plan-workflow|Codegen과 tracking plan workflow]] - Avo/Amplitude 구현 패턴
- [[element-event-evidence|요소-이벤트 증거 모델]] - Avo가 남기는 공백
- [[pricing-and-packaging|가격과 패키징 비교]] - Avo 가격 기준

## 출처

- <a id="source-1"></a>[[source-avo|Source Summary: Avo]] - `SRC-20260721-avo`
- <a id="source-2"></a>[[source-avo-official-data-design|Source Summary: Avo 공식 문서와 가격]] - `SRC-20260721-avo-official-data-design`
