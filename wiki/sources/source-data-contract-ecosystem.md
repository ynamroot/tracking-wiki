---
title: "자료 요약: 데이터 컨트랙트 거버넌스·버저닝 생태계"
type: source-summary
status: current
confidence: medium
created: 2026-07-23
updated: 2026-07-23
sources:
  - SRC-20260723-data-contract-ecosystem
---

# 자료 요약: 데이터 컨트랙트 거버넌스·버저닝 생태계

## 현재 종합

Bitol 프로젝트는 이미 인용된 ODCS(Open Data Contract Standard) v3.1.0 스펙 문서 하나가 아니라, 릴리스 이력이 있는 오픈소스 저장소와 Open Data Product Standard(ODPS)까지 포괄하는 더 넓은 표준화 프로젝트다. 데이터 컨트랙트 버저닝은 하위 호환 변경과 파괴적 변경을 구분해 다루는 것이 업계 관행이며, Snowplow의 스키마 버전 규칙은 대상 데이터 창고에 따라 같은 변경도 파괴적 여부가 달라질 수 있다. <sup>[🔗](#source-1)</sup>

## 근거

- Bitol은 ODCS(YAML 기반, 버전 관리·강제용) 외에 데이터 제품 정의·거버넌스·확장을 위한 Open Data Product Standard(ODPS, v1.0.0)도 함께 유지한다. <sup>[🔗](#source-1)</sup>
- ODCS 스펙은 3.1.0(2025-12-08)까지 총 7회 릴리스됐고, GitHub 저장소는 렌더링된 스펙 문서와 별개로 JSON Schema 검증 파일과 예제 컨트랙트를 제공한다. <sup>[🔗](#source-1)</sup>
- Atlan은 데이터 컨트랙트 버저닝에서 추가적·하위 호환 변경을 우선하고, 불가피한 파괴적 변경에는 신구 버전이 공존하는 전환 기간을 두라고 권장한다. <sup>[🔗](#source-1)</sup>
- datasops는 Kafka Schema Registry 기준으로 대부분의 운영 topic에 BACKWARD_TRANSITIVE 호환성 모드를 기본값으로 권장하고, 컨트랙트는 "배포 파이프라인에서 검증돼야만 강제력이 있다"고 강조한다. <sup>[🔗](#source-1)</sup>
- Snowplow의 Iglu 스키마 버전은 major-minor-patch 모델을 따르지만, 같은 변경(예: 필드를 필수에서 선택으로 바꾸는 것)도 Snowflake·BigQuery에서는 비파괴적이고 Redshift에서는 파괴적일 수 있어 파괴 여부가 대상 창고에 따라 달라진다. <sup>[🔗](#source-1)</sup>

## 작동 방식

데이터 컨트랙트 생태계는 두 층으로 나뉜다. 표준 계층(Bitol의 ODCS·ODPS, Snowplow의 Iglu 스키마 형식)은 컨트랙트를 어떤 형태로 적을지 정의한다. 강제 계층(배포 파이프라인 검증, Schema Registry 호환성 모드, 대상 창고별 파괴 여부 판단)은 그 표준을 실제로 지키게 만든다. 표준만 채택하고 배포 파이프라인 검증을 붙이지 않으면 datasops가 지적하듯 문서로만 남는다.

## 한계

Atlan과 datasops는 벤더/개인 블로그로 1차 표준 문서보다 신뢰도가 낮다(`reliability: secondary`). datasops는 Kafka 생태계 특유의 사례(Avro, Schema Registry)에 치우쳐 있어 이 프로젝트가 다루는 이벤트 트래킹 스키마에 그대로 적용되지 않을 수 있다.

## 모순

없음 — 기존 [[schema-and-data-contracts|스키마 및 데이터 계약]] 페이지의 결론과 상충하지 않고 범위를 넓힌다.

## 미결 질문

- 이 프로젝트가 만들 화면 요소-이벤트 증거 스키마에 ODCS나 ODPS 같은 기존 표준을 그대로 쓸 수 있는가, 별도 형식이 필요한가? (`OQ-005`, `OQ-008`과 연결되는 후속 질문이나 현재 별도 OQ로 등록하지는 않는다.)

## 제품 시사점

신규 제품이 화면 증거 스키마를 설계할 때, 처음부터 새 표준을 만들기보다 ODCS 같은 기존 컨트랙트 표준의 확장 필드를 활용할 수 있는지 검토할 가치가 있다. 또한 "컨트랙트는 배포 파이프라인에서 검증돼야 강제력이 있다"는 datasops의 지적은, 신규 제품이 지속적 통합(CI) 단계에 개입하는 검증 지점을 가져야 함을 시사한다.

## 관련 문서

- [[schema-and-data-contracts|스키마 및 데이터 계약]] - 반영 대상 지식 페이지
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-data-contract-ecosystem|자료 요약: 데이터 컨트랙트 거버넌스·버저닝 생태계]] - `SRC-20260723-data-contract-ecosystem`
