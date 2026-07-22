---
title: 행동데이터 품질 시장 지형
type: market
status: current
confidence: medium
created: 2026-07-21
updated: 2026-07-22
sources:
  - SRC-20260721-practitioner-pain-points
  - SRC-20260721-autocapture-tag-managers
  - SRC-20260721-tag-audit-qa-tools
  - SRC-20260721-tracking-governance-four-tools
  - SRC-20260721-schema-data-contracts
---

# 행동데이터 품질 시장 지형

## Current Synthesis

시장은 다섯 계층으로 분절되어 있다: autocapture/tag manager, tracking plan/codegen, CDP ingestion governance, tag audit/QA, warehouse/data contract/observability. 각 계층은 다른 실패를 잡지만, UI 요소와 실제 이벤트 발화 사이의 인과 증빙은 일관되게 약하다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup> <sup>[🔗](#source-3)</sup> <sup>[🔗](#source-4)</sup> <sup>[🔗](#source-5)</sup>

## Evidence

- 오토캡처는 raw interaction coverage를 높이지만 의미 부여와 verification이 남는다. <sup>[🔗](#source-2)</sup>
- tracking governance platform은 plan, codegen, ingestion validation을 제공하지만 수동 계측 전제를 유지한다. <sup>[🔗](#source-4)</sup>
- tag audit/QA 도구는 scan과 monitoring을 제공하지만 coverage 설계와 수정 실행이 남는다. <sup>[🔗](#source-3)</sup>
- schema/data contract 계층은 pipeline/warehouse 품질을 강화하지만 UI 미계측 요소를 직접 보지 못한다. <sup>[🔗](#source-5)</sup>

## Mechanics

상류 계층은 사용자 행동과 UI 구조에 가깝고, 하류 계층은 데이터 계약과 운영 안정성에 강하다. 신규 제품이 방향을 잃지 않으려면 어떤 계층을 대체할지보다 어떤 계층 사이의 증거 공백을 메울지 정의해야 한다. 현재 가장 명확한 공백은 `UI element -> user action -> emitted event -> schema/destination` chain을 한 번에 보여주는 것이다.

## Evaluation Criteria

- 계층: UI, tag manager, code, SDK, ingestion, warehouse 중 어디에서 개입하는가.
- 시간: 배포 전, 배포 직후, 실트래픽 후, downstream incident 후 중 언제 발견하는가.
- 행위: detect, explain, assign owner, suggest fix, verify fix 중 어디까지 하는가.
- 증거: screenshot/DOM/network/schema/destination을 연결하는가.

## Contradictions

경쟁 기능 부재 주장은 공개 Source 기준이다. 신생 도구와 enterprise-only 기능은 계속 조사해야 한다.

## Open Questions

- `OQ-006`: 기존 tool stack과 공존할지 대체할지 결정해야 한다.
- `OQ-007`: 핵심 claim을 계속 primary Source로 보강해야 한다.

## Product Implications

시장 지도상 wedge는 “새 CDP”나 “새 analytics platform”이 아니라, 기존 plan/CDP/tag audit이 공유하지 못하는 UI-action evidence layer다.

## See Also

- [[tracking-governance-platforms|트래킹 거버넌스 플랫폼]] - plan/codegen/CDP 계층
- [[tag-audit-and-qa-tools|태그 감사 및 QA 도구]] - scan/monitoring 계층
- [[validation-layer-model|검증 계층 모델]] - 기술 계층별 책임

## 출처

- <a id="source-1"></a>[[source-practitioner-pain-points|Source Summary: 행동데이터 운영 실무자 페인포인트]] - `SRC-20260721-practitioner-pain-points`
- <a id="source-2"></a>[[source-autocapture-tag-managers|Source Summary: 오토캡처와 태그매니저]] - `SRC-20260721-autocapture-tag-managers`
- <a id="source-3"></a>[[source-tag-audit-qa-tools|Source Summary: 태그 감사 및 자동 순회 QA 도구]] - `SRC-20260721-tag-audit-qa-tools`
- <a id="source-4"></a>[[source-tracking-governance-four-tools|Source Summary: 트래킹 거버넌스 도구 4종]] - `SRC-20260721-tracking-governance-four-tools`
- <a id="source-5"></a>[[source-schema-data-contracts|Source Summary: 스키마 및 데이터 계약 계층]] - `SRC-20260721-schema-data-contracts`
