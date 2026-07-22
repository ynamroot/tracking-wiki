---
title: "자료 요약: Snowplow와 dbt 공식 데이터 품질 문서"
type: source-summary
status: current
confidence: high
created: 2026-07-22
updated: 2026-07-22
sources:
  - SRC-20260721-snowplow-dbt-data-quality-official
---

# 자료 요약: Snowplow와 dbt 공식 데이터 품질 문서

## 현재 종합

Snowplow와 dbt 공식 Source는 validation/failure handling이 pipeline과 transform layer에서 어떻게 작동하는지 확인한다. 이 Source는 UI 요소 지문 기준 자체를 주지는 않지만, 실패 격리와 contract enforcement 설계의 참고 기준을 제공한다. <sup>[🔗](#source-1)</sup>

## 근거

- Snowplow failed events는 pipeline processing problem이 발생한 events를 포괄한다. <sup>[🔗](#source-1)</sup>
- failure stage는 collection, validation, enrichment, loading으로 구분된다. <sup>[🔗](#source-1)</sup>
- common validation/enrichment failures는 warehouse/lake 별도 table로 continuous loading할 수 있다. <sup>[🔗](#source-1)</sup>
- replay recovery는 복잡하고 모든 경우에 가능하지 않다. <sup>[🔗](#source-1)</sup>
- dbt model contract는 returned dataset의 shape를 정의하고, 맞지 않으면 model build가 되지 않는 구조다. <sup>[🔗](#source-1)</sup>

## 작동 방식

Snowplow는 event가 pipeline에 들어온 후 schema validation과 enrichment를 수행하고 실패를 normal table이 아닌 별도 경로로 보낸다. dbt contract는 transform 결과 shape를 build 시점에 검사한다. 둘 다 downstream 안전망이지만 UI 행동이 빠졌는지는 직접 관찰하지 않는다.

## 평가 기준

- failure taxonomy: collection, validation, enrichment, loading 중 어디서 실패했는가.
- isolation: failed table/object storage/DLQ에 무엇을 남기는가.
- recovery: replay 가능성과 운영 비용.
- contract strictness: build-time enforcement와 platform limitation.

## 모순

이 Source는 UI 요소 지문 정확도 기준을 직접 제공하지 않는다. prototype evaluation dataset과 연결해야 한다.

## 미결 질문

- 요소 지문 실패도 failed event처럼 격리·재처리할 수 있는가?
- UI evidence contract를 dbt/Snowplow schema와 어떻게 연결할 것인가?

## 제품 시사점

제품의 safety model은 “자동 수정”보다 “증거, 격리, 재검증, replay 가능성”을 우선해야 한다. 하류 data quality tooling과 연결하려면 실패 stage taxonomy를 맞춰야 한다.

## 관련 문서

- [[schema-and-data-contracts|스키마 및 데이터 계약]] - 하류 품질 계층
- [[validation-layer-model|검증 계층 모델]] - pipeline과 UI 검증 연결
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-snowplow-dbt-data-quality-official|Snowplow and dbt official docs: failed events and model contracts]] - `SRC-20260721-snowplow-dbt-data-quality-official`
