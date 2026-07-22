---
title: 검증 계층 모델
type: technology
status: current
confidence: high
created: 2026-07-22
updated: 2026-07-22
sources:
  - SRC-20260721-tracking-governance-remaining-tools
  - SRC-20260721-segment-protocols-official
  - SRC-20260721-mparticle-data-planning-official
  - SRC-20260721-rudderstack-tracking-plans-official
  - SRC-20260721-snowplow-dbt-data-quality-official
---

# 검증 계층 모델

## Current Synthesis

행동데이터 검증은 한 지점에서 끝나는 일이 아니라 여러 계층에서 나눠 일어나는 일이다. 코드 검토와 풀리퀘스트(PR)는 배포 전에 오류를 막는 데 강하다. SDK와 실행 중 검사는 실제 전송 내용에 가깝다. 수집 지점과 데이터 파이프라인 검사는 잘못된 데이터가 아래 단계로 퍼지는 것을 막는다. 데이터 창고와 모델 계약은 분석가가 보는 데이터 모양을 지킨다. 화면 행동 증거는 이 모든 계층보다 앞에서 “이 행동이 아예 수집됐는가”를 확인하는 계층이다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup> <sup>[🔗](#source-3)</sup> <sup>[🔗](#source-4)</sup> <sup>[🔗](#source-5)</sup>

## Evidence

- Segment Protocols는 데이터가 들어오는 곳에 트래킹 플랜을 적용해 규칙 위반을 만들고, 차단이나 격리 기능을 제공한다. <sup>[🔗](#source-2)</sup>
- mParticle Node SDK는 데이터 플랜과 버전을 가져와 이벤트 묶음을 수집 지점에 도착하기 전에 검증하는 것을 목적으로 한다. <sup>[🔗](#source-3)</sup>
- RudderStack Event Audit API는 들어오는 이벤트와 부가 정보를 트래킹 플랜과 비교한다. <sup>[🔗](#source-4)</sup>
- Snowplow는 collection, validation, enrichment, loading failure stage를 구분한다. <sup>[🔗](#source-5)</sup>
- 인접 도구 Source는 검증 위치를 코드/PR, 수집, pipeline, warehouse로 배열한다. <sup>[🔗](#source-1)</sup>

## Mechanics

계층별 질문이 다르다. 코드 생성은 “정의된 이벤트 함수를 올바른 타입으로 호출했나”를 묻는다. 실행 중 검사와 수집 지점 검사는 “도착한 전송 내용이 계획과 맞나”를 묻는다. 데이터 창고 계약은 “분석가가 기대한 데이터 모양이 맞나”를 묻는다. 화면 증거 계층은 “사용자가 수행한 행동에서 기대 이벤트가 실제로 발생했나”를 묻는다.

## Evaluation Criteria

| 계층 | 볼 수 있는 것 | 못 보는 것 |
|---|---|---|
| Code/PR | 코드에서 정해진 함수를 쓰는지, 타입이 맞는지 | 실제 사용자 행동 |
| SDK/runtime | 실행 중 발생한 전송 내용 | 아예 빠진 행동 |
| Ingestion/pipeline | 목적지로 가기 전 잘못된 데이터 | 화면 맥락 |
| Warehouse/model | 분석용 데이터 모양과 최신성 | 배포에서 생긴 원인 |
| UI evidence | 화면 행동과 이벤트의 증거 | 장기 데이터 창고 품질 |

## Contradictions

“before arrival”은 payload가 생성된 뒤 collector 도착 전일 수 있다. 제품 문서에서는 사전/사후를 사용자 action 기준, 배포 기준, pipeline 기준으로 구분해야 한다.

## Open Questions

- MVP가 어느 계층에서 가장 빠르게 신뢰를 얻을 수 있는가?
- UI evidence layer의 output을 existing governance violation으로 변환할 수 있는가?

## Product Implications

기술 설계는 계층별 output contract를 명확히 해야 한다. UI traversal result가 Segment/RudderStack/mParticle plan violation, Snowplow failed-event-like artifact, 또는 자체 issue 중 무엇으로 표현될지 결정해야 한다.

## See Also

- [[collection-and-validation-patterns|행동데이터 수집 및 검증 패턴]] - 패턴 개요
- [[key-terms|핵심 용어 해설]] - 검증 계층 용어 풀이
- [[element-event-evidence|요소-이벤트 증거 모델]] - upstream 검증 계층

## 출처

- <a id="source-1"></a>[[source-tracking-governance-remaining-tools|Source Summary: 트래킹 거버넌스 및 인접 도구]] - `SRC-20260721-tracking-governance-remaining-tools`
- <a id="source-2"></a>[[source-segment-protocols-official|Source Summary: Twilio Segment Protocols 공식 문서]] - `SRC-20260721-segment-protocols-official`
- <a id="source-3"></a>[[source-mparticle-data-planning-official|Source Summary: mParticle Data Planning 공식 문서]] - `SRC-20260721-mparticle-data-planning-official`
- <a id="source-4"></a>[[source-rudderstack-tracking-plans-official|Source Summary: RudderStack Tracking Plans 공식 문서]] - `SRC-20260721-rudderstack-tracking-plans-official`
- <a id="source-5"></a>[[source-snowplow-dbt-data-quality-official|Source Summary: Snowplow와 dbt 공식 데이터 품질 문서]] - `SRC-20260721-snowplow-dbt-data-quality-official`
