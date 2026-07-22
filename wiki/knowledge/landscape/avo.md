---
title: "Avo"
type: competitor
status: current
confidence: medium
created: 2026-07-21
updated: 2026-07-22
sources:
  - SRC-20260721-avo
---

# Avo

## Current Synthesis

Avo는 트래킹 플랜을 제품·데이터·개발팀의 협업 계약으로 만들고 codegen과 Inspector로 구현 drift를 줄이는 직접 경쟁 제품이다. 강점은 설계 workflow와 타입 안전성이며 사각지대는 실제 UI 동작과 runtime event 사이의 자동 인과 검증이다.

## Evidence

- 플랜 branch, review, merge workflow가 변경 거버넌스를 제공한다. <sup>[🔗](#source-1)</sup>
- Codegen은 여러 분석 목적지를 감싼 이벤트 함수를 생성한다. <sup>[🔗](#source-1)</sup>
- Inspector는 값 대신 schema를 관측해 privacy 부담을 줄인다. <sup>[🔗](#source-1)</sup>
- 사람이 플랜을 작성하고 호출 위치를 구현하며 화면을 눌러 검증한다. <sup>[🔗](#source-1)</sup>

## Contradictions

- Journeys의 시각 매핑은 강한 인접 기능이지만 설계 의도이며 실제 발생 증빙과는 다르다.

## Open Questions

- Avo와 통합할 때 가져올 수 있는 plan, branch, event metadata 범위는 무엇인가?
- 고객은 Avo의 잔여 수동 QA를 별도 제품으로 해결하려 하는가?

## Product Implications

Avo와 정면으로 plan authoring을 경쟁하기보다 런타임 UI 증빙과 자동 순회 결과를 연결하는 보완 전략을 검토한다.

## See Also

- [[source-avo|Avo Source 요약]] - 기능과 근거 상세
- [[tracking-governance-platforms|트래킹 거버넌스 플랫폼]] - 경쟁사 비교

## 출처

- <a id="source-1"></a>[[source-avo|Source Summary: Avo]] - `SRC-20260721-avo`
