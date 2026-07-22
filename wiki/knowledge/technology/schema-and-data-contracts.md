---
title: 스키마 및 데이터 계약
type: technology
status: current
confidence: high
created: 2026-07-21
updated: 2026-07-22
sources:
  - SRC-20260721-schema-data-contracts
  - SRC-20260721-snowplow-dbt-data-quality-official
---

# 스키마 및 데이터 계약

## 현재 종합

스키마와 데이터 계약은 행동데이터 품질의 하류 안전망이다. Snowplow는 pipeline failure taxonomy와 failed event 격리를 제공하고, dbt contract는 model output shape를 build 시점에 강제한다. 하지만 둘 다 UI 요소가 빠졌거나 user action이 event로 연결되지 않은 문제를 직접 보지는 못한다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup>

## 근거

- Snowplow failed events는 pipeline processing problem을 포괄하며 failure stage를 collection, validation, enrichment, loading으로 구분한다. <sup>[🔗](#source-2)</sup>
- common validation/enrichment failures는 warehouse/lake의 별도 table로 continuous loading할 수 있다. <sup>[🔗](#source-2)</sup>
- replay recovery는 복잡하고 모든 경우에 가능하지 않다. <sup>[🔗](#source-2)</sup>
- dbt model contract는 returned dataset shape를 정의하고 맞지 않으면 model build가 되지 않는다. <sup>[🔗](#source-2)</sup>
- 내부 Source는 warehouse observability가 UI 계측 누락을 직접 알기 어렵다고 정리한다. <sup>[🔗](#source-1)</sup>

## 작동 방식

schema-first pipeline은 payload가 들어온 뒤 정상/실패 경로를 나눈다. 실패 경로는 데이터 유실을 줄이고 재처리 가능성을 남기지만, 운영 복잡도와 ownership을 요구한다. dbt contract는 transform layer의 consumer-facing shape를 지키는 데 강하다. 행동데이터 UI 검증 제품은 이 하류 contract보다 앞에서 expected event가 생성됐는지를 봐야 한다.

## 평가 기준

- contract subject: event payload, enriched event, table row, model output 중 무엇인가.
- failure isolation: bad event를 버리는가, quarantine하는가, replay 가능한가.
- lineage: UI action부터 warehouse row까지 추적할 수 있는가.
- enforcement cost: strict block이 데이터 유실을 만들지 않는가.

## 모순

하류 validation이 강할수록 데이터 품질이 좋아지지만, missing event는 validation 대상 자체가 없다. 이 차이를 문서에서 계속 분리해야 한다.

## 미결 질문

- UI element fingerprint와 event schema version을 어떤 contract로 묶을 것인가?
- failed event model을 missing event proof에도 적용할 수 있는가?

## 제품 시사점

제품은 하류 contract를 대체하지 않고 upstream evidence contract를 추가해야 한다. schema registry와 연동하려면 event name/property뿐 아니라 route, UI fingerprint, build version도 기록해야 한다.

## 관련 문서

- [[validation-layer-model|검증 계층 모델]] - contract 위치
- [[element-event-evidence|요소-이벤트 증거 모델]] - upstream evidence
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-schema-data-contracts|자료 요약: 스키마 및 데이터 계약 계층]] - `SRC-20260721-schema-data-contracts`
- <a id="source-2"></a>[[source-snowplow-dbt-data-quality-official|자료 요약: Snowplow와 dbt 공식 데이터 품질 문서]] - `SRC-20260721-snowplow-dbt-data-quality-official`
