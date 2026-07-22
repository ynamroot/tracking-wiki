---
title: "Source Summary: 스키마 및 데이터 계약 계층"
type: source-summary
status: current
confidence: medium
created: 2026-07-21
updated: 2026-07-22
sources:
  - SRC-20260721-schema-data-contracts
---

# Source Summary: 스키마 및 데이터 계약 계층

## Current Synthesis

Snowplow의 schema-first 파이프라인, 형식화된 data contract, warehouse observability는 각각 다른 지점에서 데이터 품질을 관리한다. 이들은 도착한 데이터의 구조·신선도·볼륨·계보를 검증하지만, UI 변경으로 호출이 사라졌거나 애초에 계측되지 않은 행동은 직접 발견할 수 없다.

## Evidence

- Snowplow는 self-describing event와 Iglu schema registry를 사용해 Enrich 단계에서 이벤트를 검증한다. <sup>[🔗](#source-1)</sup>
- 검증 실패 이벤트는 정상 테이블과 분리해 보존하고 재처리할 수 있다. <sup>[🔗](#source-1)</sup>
- data contract는 생산자와 소비자 사이의 schema, 품질, SLA, ownership 합의를 형식화한다. <sup>[🔗](#source-1)</sup>
- data observability는 warehouse의 freshness, volume, schema, distribution, lineage 이상을 감지한다. <sup>[🔗](#source-1)</sup>
- 어느 접근도 이벤트가 전혀 생성되지 않은 원인을 UI와 코드까지 거슬러 자동 설명하지 못한다. <sup>[🔗](#source-1)</sup>

## Contradictions

- schema 검증이 “수집 전”인지 “이벤트 발생 후 파이프라인 단계”인지는 관점에 따라 표현이 달라지므로 정확한 경계를 유지해야 한다.
- data contract 표준과 도구 생태계는 변화 가능성이 높아 기술 채택 전 최신 공식 사양 검증이 필요하다.

## Open Questions

- 제품이 자체 schema registry를 가져야 하는가, 기존 계약을 import해야 하는가?
- UI 증빙과 schema violation을 하나의 incident 모델로 연결할 수 있는가?

## Product Implications

제품은 schema validation을 대체하기보다 UI 요소, 코드 호출, 발생 payload, downstream schema를 잇는 provenance를 제공해야 한다.

## See Also

- [[schema-and-data-contracts|스키마 및 데이터 계약]] - 계층별 검증 위치와 한계
- [[collection-and-validation-patterns|행동데이터 수집 및 검증 패턴]] - 브라우저부터 warehouse까지의 방식

## 출처

- <a id="source-1"></a>[[source-schema-data-contracts|Source Summary: 스키마 및 데이터 계약 계층]] - `SRC-20260721-schema-data-contracts`
