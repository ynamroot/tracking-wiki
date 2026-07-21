---
id: SRC-20260721-snowplow-dbt-data-quality-official
title: "Snowplow and dbt official docs: failed events and model contracts"
status: accepted
source_type: documentation
original_url: "https://docs.snowplow.io/docs/fundamentals/failed-events/"
submitted_by: "Research Agent"
submitted_at: 2026-07-21
retrieved_at: 2026-07-21
issue_url: ""
language: en
publisher: "Snowplow; dbt Labs"
authors: []
published_at: ""
reliability: primary
content_file: ""
content_sha256: ""
supersedes: []
---

# Snowplow and dbt official docs: failed events and model contracts

## Submitter Note

Open questions require primary source expansion for validation placement: collection, validation, enrichment, warehouse, and transform-time contract enforcement.

## Research Questions

- `OQ-005` 요소 지문과 자율 순회가 실제 제품 개편에서 달성해야 할 정확도와 안전 기준은 무엇인가?
- `OQ-007` 제품 방향을 지지하는 핵심 주장과 가격 정보를 공식 primary Source record로 확장해야 한다.

## Provenance

- 원문 확보 방법: Snowplow와 dbt 공식 documentation을 웹에서 직접 조회.
- 주요 URL:
  - https://docs.snowplow.io/docs/fundamentals/failed-events/
  - https://docs.snowplow.io/docs/monitoring/exploring-failed-events/
  - https://docs.getdbt.com/docs/mesh/govern/model-contracts
  - https://docs.getdbt.com/reference/resource-configs/contract
- 원문 보존 위치: URL과 retrieval date를 기록한다. 저작권상 원문 전체를 로컬 복제하지 않는다.
- 원문과 record의 차이: record는 조사 질문에 필요한 claim 단위 요약만 포함한다.

## Triage

- 판정: accepted
- 판정자: LLM auto-triage policy-v1
- 판정일: 2026-07-21
- 사유: 공식 기술 문서이며 provenance를 URL과 retrieval date로 재현할 수 있고, data quality validation layer 및 안전 기준 조사 범위와 직접 관련된다. 기존 secondary report와 exact duplicate가 아니다.

## Extracted Content

- Snowplow failed events는 pipeline processing problem이 발생한 events를 포괄하는 용어다.
- Snowplow 문서는 failure stage를 collection, validation, enrichment, loading으로 구분한다.
- Common failures에는 schema mismatch로 인한 validation failures와 enrichment failures가 포함된다.
- Failed events는 atomic events table에 쓰이지 않고, common validation/enrichment failures는 warehouse/lake의 별도 table로 continuous loading할 수 있다.
- Snowplow는 AWS/GCP에서 failed events를 object storage에 backup한다고 설명하지만, replay recovery는 복잡하고 모든 경우에 가능하지 않다.
- dbt model contract는 returned dataset의 shape를 정의하고, model logic 또는 input data가 shape에 맞지 않으면 model build가 되지 않는 구조다.
- dbt contract enforcement는 warehouse/platform별 제약이 있으며, 일부 constraints는 build-time enforcement가 제한될 수 있다.
- 이 Source는 validation 위치와 사후 복구 trade-off를 확인하지만, UI 요소 지문 정확도 기준 자체는 별도 prototype evaluation dataset이 필요하다.

## Revision Notes

- 2026-07-21: Research Agent가 공식 primary source 보강용으로 최초 생성하고 Intake Agent가 자동 triage 정책으로 accepted 처리.
