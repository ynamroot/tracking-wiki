---
title: 프로젝트 지식 개요
type: overview
status: current
confidence: medium
created: 2026-07-21
updated: 2026-07-22
sources:
  - SRC-20260721-practitioner-pain-points
  - SRC-20260721-autocapture-tag-managers
  - SRC-20260721-tag-audit-qa-tools
  - SRC-20260721-avo-official-data-design
  - SRC-20260721-amplitude-official-data-governance
  - SRC-20260721-segment-protocols-official
  - SRC-20260721-mparticle-data-planning-official
  - SRC-20260721-rudderstack-tracking-plans-official
  - SRC-20260721-snowplow-dbt-data-quality-official
  - SRC-20260721-web-agent-eval-benchmarks
  - SRC-20260722-commercial-tools-survey
  - SRC-20260722-commercial-tools-official-docs
---

# 프로젝트 지식 개요

## 현재 종합

행동데이터 품질 문제는 단순히 “이벤트의 규칙(스키마)이 틀렸다”는 것보다 범위가 넓다. 실제 고객 업무에서는 측정 의도, 화면 요소, 수집 도구 호출, 전송 내용(payload), 수집 지점 검증, 데이터 창고의 분석 모델이 서로 따로 관리된다. 현재 채택된 자료 17건을 종합하면 가장 선명한 기회는 기존 트래킹 플랜(무엇을 수집할지 정한 약속), 코드 생성, 고객데이터플랫폼(CDP), 태그 감사, 오토캡처, 태그매니저, 데이터 계약 사이에서 빠지는 `화면 행동 -> 기대 이벤트 -> 실제 전송 내용` 증거 계층이다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup> <sup>[🔗](#source-3)</sup> <sup>[🔗](#source-4)</sup> <sup>[🔗](#source-5)</sup> <sup>[🔗](#source-11)</sup> <sup>[🔗](#source-12)</sup>

## 근거

- 실무자의 어려움은 수동 QA, 늦은 파손 발견, 역할 간 넘겨주기, 트래킹 플랜과 실제 구현이 어긋나는 문제에 집중된다. <sup>[🔗](#source-1)</sup>
- Avo와 Amplitude 공식 자료는 트래킹 플랜, 코드 생성(codegen), 검증(validation)이 이미 제품화되어 있음을 확인한다. <sup>[🔗](#source-4)</sup> <sup>[🔗](#source-5)</sup>
- Segment, mParticle, RudderStack 공식 자료는 고객데이터플랫폼(CDP)의 수집 지점 관리가 전송 내용 검증과 위반 처리까지 다룬다는 점을 확인한다. <sup>[🔗](#source-6)</sup> <sup>[🔗](#source-7)</sup> <sup>[🔗](#source-8)</sup>
- Snowplow와 dbt 공식 자료는 실패 이벤트 격리와 데이터 모델 계약 검사를 통해 하류 안전망을 제공하지만, 화면에서 계측되지 않은 행동은 직접 보지 못한다. <sup>[🔗](#source-9)</sup>
- 웹 에이전트 평가 자료는 자율 순회 평가 재료를 제공하지만, 행동데이터 검증에 맞춘 정답 표시는 별도로 필요하다. <sup>[🔗](#source-10)</sup>
- 상용 도구 조사와 공식 문서 보강은 자동 순회, 실트래픽 관찰, 오토캡처, 태그매니저가 이미 시장에 있음을 확인한다. 따라서 신규 제품의 차별화는 단순 자동화가 아니라 화면 요소, 기대 이벤트, 실제 전송 내용을 연결한 증거에 있어야 한다. <sup>[🔗](#source-11)</sup> <sup>[🔗](#source-12)</sup>

## 작동 방식

현재 지식 구조는 네 축으로 나뉜다. `problem`은 누가 어떤 업무 흐름에서 어려움을 겪는지 정리한다. `landscape`는 경쟁사와 가격, 시장 계층을 비교한다. `technology`는 수집, 검증, 증거, 평가 모델을 설명한다. `synthesis`는 제품 기회, 첫 제품 범위, 연구 신뢰도를 종합한다.

## 평가 기준

이 Wiki의 결론은 주장 유형(claim)별로 신뢰도를 다르게 봐야 한다. 벤더 기능과 공개 가격은 직접 자료(primary source)가 보강되어 비교적 신뢰도가 높다. 구매자, 지불 의사, 고객의 실제 비용, 요소 지문 정확도는 아직 신뢰도가 낮다. 제품 결정은 `research-confidence-map`과 `open-questions`를 함께 확인해야 한다.

## 모순

- 경쟁사 기능 공백은 공개 문서 기준이다. 기업 전용(enterprise-only) 기능, 신생 도구, 공식 문서 접근이 불안정한 제품은 계속 조사해야 한다.
- 공식 문서는 기능과 가격에는 강하지만 실제 고객의 어려움과 구매 이유에는 약하다.
- 자동 순회와 요소 지문이 운영 비용을 낮춘다는 가설은 아직 시제품 평가(prototype)와 사용자 인수 테스트(UAT)가 없다.

## 미결 질문

- `OQ-001`: 예산을 승인할 구매자와 내부 도입을 밀어줄 champion은 누구인가?
- `OQ-002`: 첫 최소기능제품(MVP)이 반드시 만들어야 할 결과는 무엇인가?
- `OQ-005`: 요소 지문과 자율 순회의 정확도·안전성 기준은 무엇인가?
- `OQ-008`: 대표 화면 변경 데이터셋과 평가 기준은 무엇인가?

## 제품 시사점

가장 방어적인 제품 방향은 자동 수정이나 새 분석 플랫폼이 아니다. 기존 트래킹 플랜, 고객데이터플랫폼, 스키마를 읽고, 배포 전에 바뀐 화면 경로에서 기대한 이벤트가 실제로 발생하는지 증거를 만드는 것이다. 이 방향은 Avo, Amplitude, Segment, RudderStack을 대체하지 않고 보완한다.

## 관련 문서

- [[automation-opportunity|행동데이터 자동화 기회]] - 제품 기회 종합
- [[behavioral-data-quality-landscape|행동데이터 품질 시장 지형]] - 시장 지도
- [[key-terms|핵심 용어 해설]] - 반복 용어 풀이
- [[element-event-evidence|요소-이벤트 증거 모델]] - 핵심 차별화 후보
- [[research-confidence-map|연구 신뢰도 지도]] - 검증 수준
- [[source-commercial-tools-survey|자료 요약: 상용 도구 조사]] - 새 상용 도구 지형 종합

## 출처

- <a id="source-1"></a>[[source-practitioner-pain-points|자료 요약: 행동데이터 운영 실무자 페인포인트]] - `SRC-20260721-practitioner-pain-points`
- <a id="source-2"></a>[[source-autocapture-tag-managers|자료 요약: 오토캡처와 태그매니저]] - `SRC-20260721-autocapture-tag-managers`
- <a id="source-3"></a>[[source-tag-audit-qa-tools|자료 요약: 태그 감사 및 자동 순회 QA 도구]] - `SRC-20260721-tag-audit-qa-tools`
- <a id="source-4"></a>[[source-avo-official-data-design|자료 요약: Avo 공식 문서와 가격]] - `SRC-20260721-avo-official-data-design`
- <a id="source-5"></a>[[source-amplitude-official-data-governance|자료 요약: Amplitude 공식 Data Governance]] - `SRC-20260721-amplitude-official-data-governance`
- <a id="source-6"></a>[[source-segment-protocols-official|자료 요약: Twilio Segment Protocols 공식 문서]] - `SRC-20260721-segment-protocols-official`
- <a id="source-7"></a>[[source-mparticle-data-planning-official|자료 요약: mParticle Data Planning 공식 문서]] - `SRC-20260721-mparticle-data-planning-official`
- <a id="source-8"></a>[[source-rudderstack-tracking-plans-official|자료 요약: RudderStack Tracking Plans 공식 문서]] - `SRC-20260721-rudderstack-tracking-plans-official`
- <a id="source-9"></a>[[source-snowplow-dbt-data-quality-official|자료 요약: Snowplow와 dbt 공식 데이터 품질 문서]] - `SRC-20260721-snowplow-dbt-data-quality-official`
- <a id="source-10"></a>[[source-web-agent-eval-benchmarks|자료 요약: Web Agent Evaluation Benchmarks]] - `SRC-20260721-web-agent-eval-benchmarks`
- <a id="source-11"></a>[[source-commercial-tools-survey|자료 요약: 상용 도구 조사]] - `SRC-20260722-commercial-tools-survey`
- <a id="source-12"></a>[[source-commercial-tools-official-docs|자료 요약: 상용 도구 공식 문서 보강]] - `SRC-20260722-commercial-tools-official-docs`
