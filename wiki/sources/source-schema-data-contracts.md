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

Schema-first collection, data contract, warehouse observability는 데이터 품질 문제를 강하게 다루지만 대부분 event가 이미 생성되었거나 pipeline에 들어온 뒤의 계층이다. 행동데이터 제품 기회는 이 하류 계약을 UI 계층의 계측 의도와 연결하는 데 있다. <sup>[🔗](#source-1)</sup>

## Evidence

- Snowplow 계열은 schema registry와 pipeline validation으로 잘못된 event를 정상 테이블에 넣지 않고 failed event로 격리하는 모델을 제공한다. <sup>[🔗](#source-1)</sup>
- Data contract/dbt/observability 계층은 warehouse/model 단계의 구조·품질·freshness를 감시하지만 “클릭해야 할 버튼에 계측이 없다”는 누락을 직접 알기 어렵다. <sup>[🔗](#source-1)</sup>
- 실패 이벤트 격리와 replay는 hard block의 데이터 유실 위험을 낮추는 안전장치로 참고할 수 있다. <sup>[🔗](#source-1)</sup>

## Mechanics

schema-first 접근은 producer가 event schema를 등록하고 collector/enrichment 단계에서 payload를 검증한다. data contract는 producer-consumer 사이의 dataset shape와 ownership을 명시한다. observability는 warehouse 이후의 freshness, volume, distribution, schema drift를 감시한다. 모두 중요한 안전망이지만 UI path와 event semantics를 직접 보지는 않는다.

## Evaluation Criteria

- contract boundary: SDK payload, ingestion event, enriched event, model output 중 어디를 계약으로 삼는가.
- failure handling: reject, quarantine, DLQ, failed table, replay, alert.
- ownership: schema owner, producer team, consumer team, incident responder.
- pre-event visibility: event가 발생하기 전 누락을 발견할 수 있는가.

## Contradictions

“수집 전 검증”이라는 표현은 code/SDK 단계와 ingestion pipeline 단계를 구분해야 한다. 일부 검증은 사용자 행동 이후지만 warehouse 이전이다.

## Open Questions

- UI 요소 지문이 schema contract와 어떤 identifier로 연결되어야 하는가?
- failed event safety model을 계측 자동 수정에 적용할 수 있는가?

## Product Implications

새 제품은 하류 data contract를 대체하기보다 상류 UI/evidence contract를 추가해야 한다. 하류 contract와 연결하려면 event schema version, UI element fingerprint, route/build version을 함께 기록해야 한다.

## See Also

- [[schema-and-data-contracts|스키마 및 데이터 계약]] - 기술 계층 비교
- [[validation-layer-model|검증 계층 모델]] - 검증 위치별 책임

## 출처

- <a id="source-1"></a>[[source-schema-data-contracts|스키마 및 데이터 계약 계층 조사]] - `SRC-20260721-schema-data-contracts`
