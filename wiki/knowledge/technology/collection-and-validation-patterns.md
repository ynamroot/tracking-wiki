---
title: 행동데이터 수집 및 검증 패턴
type: technology
status: current
confidence: medium
created: 2026-07-21
updated: 2026-07-22
sources:
  - SRC-20260721-autocapture-tag-managers
  - SRC-20260721-tag-audit-qa-tools
  - SRC-20260721-tracking-governance-four-tools
  - SRC-20260721-tracking-governance-remaining-tools
---

# 행동데이터 수집 및 검증 패턴

## 현재 종합

행동데이터 검증 패턴은 `autocapture`, `manual instrumentation`, `tracking plan/codegen`, `synthetic scan`, `passive monitoring`, `ingestion validation`, `warehouse contract`로 나뉜다. 하나의 패턴이 모든 문제를 해결하지 않으며, 제품 설계는 각 패턴의 blind spot을 명확히 구분해야 한다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup> <sup>[🔗](#source-3)</sup> <sup>[🔗](#source-4)</sup>

## 근거

- 오토캡처는 interaction coverage를 높이지만 semantic curation이 필요하다. <sup>[🔗](#source-1)</sup>
- tag audit 도구는 scan과 monitoring으로 tag firing을 점검한다. <sup>[🔗](#source-2)</sup>
- governance 도구는 plan/codegen/ingestion validation을 조합하지만 수동 계측 전제를 유지한다. <sup>[🔗](#source-3)</sup>
- 인접 도구 조사에서는 검증 위치가 코드/PR, 수집, pipeline, warehouse로 나뉜다고 정리한다. <sup>[🔗](#source-4)</sup>

## 작동 방식

manual instrumentation은 business semantics에 강하고 누락에 약하다. autocapture는 coverage에 강하고 의미/속성에 약하다. codegen은 type mismatch를 줄이고 where/when semantic에는 약하다. synthetic scan은 release gate에 적합하고 scenario coverage에 약하다. passive monitoring은 real traffic에 강하고 post-hoc이다. ingestion/warehouse validation은 payload quality에 강하고 missing UI action에는 약하다.

## 평가 기준

- 발견 시점: 배포 전인가, 사용자 행동 후인가.
- 관찰 단위: UI action, SDK call, network payload, ingestion event, warehouse row.
- false negative: 아예 발생하지 않은 event를 잡는가.
- 운영 대응: alert만 하는가, proof와 fix verification까지 제공하는가.

## 모순

“수집 전”이라는 표현은 code compile/PR과 ingestion-before-warehouse를 혼동하기 쉽다. 검증 위치를 항상 명시해야 한다.

## 미결 질문

- 첫 제품은 어떤 검증 위치를 primary surface로 삼을 것인가?
- passive와 synthetic을 결합할 최소 구조는 무엇인가?

## 제품 시사점

초기 아키텍처는 deterministic traversal와 evidence capture를 기본으로 하고, LLM은 path suggestion, failure explanation, fix suggestion에 제한적으로 쓰는 방향이 안전하다.

## 관련 문서

- [[validation-layer-model|검증 계층 모델]] - 더 상세한 계층 분해
- [[autonomous-traversal-evaluation|자율 순회 평가 기준]] - synthetic traversal 검증
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-autocapture-tag-managers|자료 요약: 오토캡처와 태그매니저]] - `SRC-20260721-autocapture-tag-managers`
- <a id="source-2"></a>[[source-tag-audit-qa-tools|자료 요약: 태그 감사 및 자동 순회 QA 도구]] - `SRC-20260721-tag-audit-qa-tools`
- <a id="source-3"></a>[[source-tracking-governance-four-tools|자료 요약: 트래킹 거버넌스 도구 4종]] - `SRC-20260721-tracking-governance-four-tools`
- <a id="source-4"></a>[[source-tracking-governance-remaining-tools|자료 요약: 트래킹 거버넌스 및 인접 도구]] - `SRC-20260721-tracking-governance-remaining-tools`
