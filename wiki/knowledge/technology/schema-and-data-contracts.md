---
title: "스키마 및 데이터 계약"
type: technology
status: current
confidence: medium
created: 2026-07-21
updated: 2026-07-22
sources:
  - SRC-20260721-schema-data-contracts
  - SRC-20260721-tracking-governance-four-tools
  - SRC-20260721-tracking-governance-remaining-tools
---

# 스키마 및 데이터 계약

## Current Synthesis

행동데이터 품질 검증은 코드·PR, 수집 SDK, ingestion pipeline, warehouse 순서의 연속선에 놓인다. 앞단일수록 수정 비용을 줄이지만 실제 발생 전에는 runtime 상태를 모르고, 뒷단일수록 실제 데이터를 보지만 이미 손상이 발생했다. 격리와 replay는 hard block의 유실 위험을 낮추는 공통 안전장치다.

## Evidence

- JSON Schema 계열은 Segment, mParticle, Snowplow 등에서 tracking plan 또는 event contract의 기반으로 사용된다. <sup>[🔗](#source-1)</sup>
- Snowplow는 event가 참조하는 schema를 registry에서 해결하고 pipeline에서 검증한다. <sup>[🔗](#source-2)</sup>
- data contract는 schema뿐 아니라 품질, SLA, ownership을 생산자·소비자 합의로 형식화한다. <sup>[🔗](#source-2)</sup>
- warehouse observability는 freshness, volume, distribution, schema, lineage 이상을 사후 감지한다. <sup>[🔗](#source-2)</sup>
- hard block은 복구 불가능한 유실을 만들 수 있어 propagate, quarantine, failed-event replay 방식이 병행된다. <sup>[🔗](#source-3)</sup> <sup>[🔗](#source-1)</sup>

## Contradictions

- “shift-left”가 항상 우월한 것은 아니다. compile-time 검사는 실제 환경과 UI 동작을 보지 못하며 runtime 검사를 대체하지 못한다.
- schema 호환성 규칙은 destination warehouse와 도구별 구현에 따라 다르다.

## Open Questions

- MVP의 canonical event contract를 직접 정의할지 외부 plan을 참조할지 결정해야 한다.
- failed event의 보존 기간, 개인정보, replay 책임을 어떻게 설계할 것인가?
- UI 요소 변경을 schema version과 연결할 별도 version model이 필요한가?

## Product Implications

제품은 schema registry가 아니라 UI-to-event evidence contract를 소유하고 기존 schema 시스템과 adapter로 연결하는 구조가 적합해 보인다.

## See Also

- [[source-schema-data-contracts|스키마 및 데이터 계약 Source 요약]] - Snowplow와 observability 근거
- [[tracking-governance-platforms|트래킹 거버넌스 플랫폼]] - 제품별 적용
- [[collection-and-validation-patterns|행동데이터 수집 및 검증 패턴]] - 브라우저 검증 방식

## 출처

- <a id="source-1"></a>[[source-tracking-governance-remaining-tools|Source Summary: 트래킹 거버넌스 및 인접 도구]] - `SRC-20260721-tracking-governance-remaining-tools`
- <a id="source-2"></a>[[source-schema-data-contracts|Source Summary: 스키마 및 데이터 계약 계층]] - `SRC-20260721-schema-data-contracts`
- <a id="source-3"></a>[[source-tracking-governance-four-tools|Source Summary: 트래킹 거버넌스 도구 4종]] - `SRC-20260721-tracking-governance-four-tools`
