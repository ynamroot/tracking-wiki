---
title: 스키마 및 데이터 계약
type: technology
status: current
confidence: high
created: 2026-07-21
updated: 2026-07-23
sources:
  - SRC-20260721-schema-data-contracts
  - SRC-20260721-snowplow-dbt-data-quality-official
  - SRC-20260723-data-contract-ecosystem
---

# 스키마 및 데이터 계약

## 현재 종합

스키마와 데이터 계약은 행동데이터 품질을 지키는 하류 안전망이다. Snowplow는 파이프라인 실패를 유형별로 나눈 분류 체계(pipeline failure taxonomy)와 실패 이벤트(failed event) 격리를 제공하고, dbt 계약(dbt contract)은 데이터 모델이 내놓는 결과 형태(model output shape)를 빌드(build) 시점에 강제한다. Bitol 프로젝트는 ODCS(Open Data Contract Standard) 스펙 하나가 아니라 릴리스 이력이 있는 저장소와 데이터 제품 표준(ODPS)까지 아우르는 더 넓은 표준화 프로젝트다. 하지만 이 모두 화면 요소가 빠졌거나 사용자 행동(user action)이 이벤트로 연결되지 않은 문제를 직접 보지는 못한다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup> <sup>[🔗](#source-3)</sup>

## 근거

- Snowplow 실패 이벤트(failed events)는 파이프라인 처리 중 생긴 문제를 폭넓게 담으며, 실패 단계를 수집(collection), 검증(validation), 보강(enrichment), 적재(loading)로 구분한다. <sup>[🔗](#source-2)</sup>
- 흔한 검증·보강 실패는 데이터 창고나 데이터 레이크(lake)의 별도 테이블로 계속 실어 나를 수 있다. <sup>[🔗](#source-2)</sup>
- 재처리 복구(replay recovery)는 복잡하고 모든 경우에 가능하지 않다. <sup>[🔗](#source-2)</sup>
- dbt 모델 계약(model contract)은 내놓을 데이터셋의 형태를 정의하고, 맞지 않으면 모델 빌드가 되지 않는다. <sup>[🔗](#source-2)</sup>
- 내부 Source는 데이터 창고 관찰(warehouse observability)만으로는 화면 계측 누락을 직접 알기 어렵다고 정리한다. <sup>[🔗](#source-1)</sup>
- Bitol은 ODCS(YAML 기반, 버전 관리·강제용) 외에 Open Data Product Standard(ODPS, v1.0.0)도 함께 유지하며, ODCS 스펙은 3.1.0(2025-12-08)까지 총 7회 릴리스된 실제 릴리스 주기를 가진다. <sup>[🔗](#source-3)</sup>
- 데이터 컨트랙트 버저닝은 추가적·하위 호환 변경을 우선하고, 파괴적 변경에는 신구 버전이 공존하는 전환 기간을 두는 것이 업계 관행이다. 컨트랙트는 "배포 파이프라인에서 검증돼야만 강제력이 있고, 문서로만 남으면 강제력이 없다." <sup>[🔗](#source-3)</sup>
- Snowplow의 Iglu 스키마 버전(major-minor-patch)은 같은 변경이라도 대상 데이터 창고에 따라 파괴적 여부가 달라질 수 있다 — 예를 들어 필드를 필수에서 선택으로 바꾸는 변경은 Snowflake·BigQuery에서는 비파괴적이지만 Redshift에서는 파괴적이다. <sup>[🔗](#source-3)</sup>

## 작동 방식

스키마를 먼저 강제하는 파이프라인(schema-first pipeline)은 전송 내용(payload)이 들어온 뒤 정상 경로와 실패 경로를 나눈다. 실패 경로는 데이터 유실을 줄이고 재처리 가능성을 남기지만, 운영 복잡도와 담당 소유권(ownership)을 요구한다. dbt 계약은 변환 단계(transform layer)에서 소비자가 보게 될 데이터 형태를 지키는 데 강하다. 행동데이터 화면 검증 제품은 이 하류 계약보다 앞에서 기대한 이벤트(expected event)가 생성됐는지를 봐야 한다.

데이터 컨트랙트 생태계는 표준 계층(무엇을 어떻게 적을지 정의하는 ODCS·ODPS·Iglu 스키마 형식)과 강제 계층(배포 파이프라인 검증, 대상 창고별 파괴 여부 판단)으로 나뉜다. 표준만 채택하고 강제 계층을 붙이지 않으면 컨트랙트는 문서로만 남는다.

## 평가 기준

- 계약 대상(contract subject): 이벤트 전송 내용(event payload), 보강된 이벤트(enriched event), 테이블 행(table row), 모델 출력(model output) 중 무엇인가.
- 실패 격리(failure isolation): 잘못된 이벤트를 버리는가, 격리(quarantine)하는가, 재처리(replay)가 가능한가.
- 계보(lineage): 화면 행동부터 데이터 창고 행까지 추적할 수 있는가.
- 강제 비용(enforcement cost): 엄격한 차단(strict block)이 데이터 유실을 만들지 않는가.

## 모순

하류 검증이 강할수록 데이터 품질이 좋아지지만, 아예 빠진 이벤트(missing event)는 검증할 대상 자체가 없다. 이 차이를 문서에서 계속 분리해야 한다.

## 미결 질문

- 화면 요소 지문(UI element fingerprint)과 이벤트 스키마 버전(event schema version)을 어떤 계약으로 묶을 것인가?
- 실패 이벤트 모델을 빠진 이벤트 증명(missing event proof)에도 적용할 수 있는가?

## 제품 시사점

제품은 하류 계약을 대체하지 않고 상류 증거 계약(upstream evidence contract)을 추가해야 한다. 스키마 레지스트리(schema registry)와 연동하려면 이벤트 이름과 속성뿐 아니라 화면 경로(route), 화면 요소 지문(UI fingerprint), 빌드 버전(build version)도 기록해야 한다. 처음부터 새 컨트랙트 형식을 만들기보다 ODCS 같은 기존 표준의 확장 필드를 활용할 수 있는지 검토할 가치가 있고, "배포 파이프라인 검증이 있어야 강제력이 있다"는 점은 신규 제품이 지속적 통합(CI) 단계에 개입하는 검증 지점을 가져야 함을 시사한다.

## 관련 문서

- [[validation-layer-model|검증 계층 모델]] - contract 위치
- [[element-event-evidence|요소-이벤트 증거 모델]] - 상류 증거
- [[industry-event-governance-practices|실운영 조직의 이벤트 계측 거버넌스 사례]] - Iglu 스키마 레지스트리 운영 사례
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-schema-data-contracts|자료 요약: 스키마 및 데이터 계약 계층]] - `SRC-20260721-schema-data-contracts`
- <a id="source-2"></a>[[source-snowplow-dbt-data-quality-official|자료 요약: Snowplow와 dbt 공식 데이터 품질 문서]] - `SRC-20260721-snowplow-dbt-data-quality-official`
- <a id="source-3"></a>[[source-data-contract-ecosystem|자료 요약: 데이터 컨트랙트 거버넌스·버저닝 생태계]] - `SRC-20260723-data-contract-ecosystem`
