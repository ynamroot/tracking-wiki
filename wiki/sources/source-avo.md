---
title: "Source Summary: Avo"
type: source-summary
status: current
confidence: medium
created: 2026-07-21
updated: 2026-07-22
sources:
  - SRC-20260721-avo
---

# Source Summary: Avo

## Current Synthesis

Avo는 tracking plan을 single source of truth로 두고 Codegen, Inspector, approval workflow로 설계-구현-검증을 잇는다. 직접 경쟁사 중 가장 제품 가설과 가까운 구조지만, runtime에서 UI 요소와 실발생 이벤트의 인과 증빙을 자동으로 결합하지는 않는다. <sup>[🔗](#source-1)</sup>

## Evidence

- Avo는 tracking plan을 이벤트·속성·metrics·source·destination 정의로 구조화하고 codegen과 runtime validation에 연결한다. <sup>[🔗](#source-1)</sup>
- Codegen은 event function/wrapper를 생성하지만 개발자가 호출 위치와 시점을 직접 결정한다. <sup>[🔗](#source-1)</sup>
- Inspector는 실제 이벤트의 값이 아니라 schema shape/type을 수집해 plan과 대조하는 구조로 요약된다. <sup>[🔗](#source-1)</sup>
- Journeys는 스크린샷 기반 설계 의도 매핑을 제공하지만, runtime click과 emitted event를 자동 증빙하는 것과는 다르다. <sup>[🔗](#source-1)</sup>

## Mechanics

Avo workflow는 plan authoring, branch/review, generated code pull, implementation, manual validation, production Inspector issue triage로 이어진다. 이는 spreadsheet plan보다 훨씬 강한 거버넌스지만, 계측 지점을 코드에 심는 작업과 화면을 눌러 검증하는 작업은 남는다.

## Evaluation Criteria

- authoring depth: event/property/metric/source/destination을 얼마나 구조화하는가.
- implementation enforcement: wrapper, static type, CI status, SDK validation 범위.
- operational enforcement: approval, review, issue routing, downstream registry sync.
- visual evidence: design screenshot, UI action, runtime event를 얼마나 연결하는가.

## Contradictions

내부 보고서는 Avo의 한계를 제품 기회로 해석하지만, 공식 문서가 계속 바뀔 수 있으므로 pricing과 enterprise governance는 primary Source를 기준으로 다시 반영해야 한다.

## Open Questions

- Avo 고객이 가장 크게 느끼는 잔여 수동 작업은 호출 삽입, QA, 운영 triage 중 무엇인가?
- Avo와 공존한다면 Source of truth를 어느 계층에 둘 것인가?

## Product Implications

Avo를 대체하기보다 Avo tracking plan이나 downstream registry와 연동해 “UI 요소-이벤트 실제 증빙”을 추가하는 addon 형태가 초기 진입점일 수 있다.

## See Also

- [[avo|Avo]] - 공식 Source 포함 경쟁사 deep dive
- [[element-event-evidence|요소-이벤트 증거 모델]] - Avo의 빈 공간

## 출처

- <a id="source-1"></a>[[source-avo|Avo 경쟁 분석 리서치]] - `SRC-20260721-avo`
