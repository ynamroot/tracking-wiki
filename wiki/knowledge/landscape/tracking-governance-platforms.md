---
title: 트래킹 거버넌스 플랫폼
type: comparison
status: current
confidence: high
created: 2026-07-21
updated: 2026-07-22
sources:
  - SRC-20260721-tracking-governance-four-tools
  - SRC-20260721-tracking-governance-remaining-tools
  - SRC-20260721-segment-protocols-official
  - SRC-20260721-mparticle-data-planning-official
  - SRC-20260721-rudderstack-tracking-plans-official
---

# 트래킹 거버넌스 플랫폼

## 현재 종합

트래킹 거버넌스 플랫폼은 트래킹 플랜(tracking plan)을 기준으로 이벤트와 속성의 스키마가 어긋나는 현상(schema drift)을 줄인다. Segment, mParticle, RudderStack은 공식 자료로 기능 경계가 보강되었고, 공통적으로 페이로드(payload, 전송 내용물)가 도착한 뒤의 검증에는 강하지만, 아예 빠진 화면 동작이나 이벤트는 별도 계층 없이는 알기 어렵다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup> <sup>[🔗](#source-3)</sup> <sup>[🔗](#source-4)</sup> <sup>[🔗](#source-5)</sup>

## 근거

- Segment Protocols는 Tracking Plan을 데이터 소스에 적용하고, 일치하지 않는 이벤트나 속성을 위반(violation)으로 표시한다. <sup>[🔗](#source-3)</sup>
- Segment의 엄격 제어(strict controls)는 규칙에 맞지 않는 이벤트를 막고, 격리된 Segment 소스로 보낼 수 있다. <sup>[🔗](#source-3)</sup>
- mParticle 데이터 플랜은 최대 1,000 data points를 지원하며, 400개를 넘으면 API나 Builder 사용을 권장한다. <sup>[🔗](#source-4)</sup>
- mParticle이 막을 수 있는 데이터는 계획에 없던 위반(unplanned violations)으로 제한된다. <sup>[🔗](#source-4)</sup>
- RudderStack Tracking Plans는 들어오는 이벤트가 규칙을 어기는지 감시하고 대응하며, Free는 1 plan/5 events, Growth는 unlimited plans/75 events, Enterprise는 unlimited/unlimited의 한도를 둔다. <sup>[🔗](#source-5)</sup>

## 작동 방식

Segment는 고객데이터플랫폼(CDP)의 경계 지점에서 위반 표시와 제어 기능을 제공한다. mParticle은 기업용 데이터 플랜과 API·SDK(개발 도구 모음) 검증 흐름을 강조한다. RudderStack은 Tracking Plans, Data Catalog, Event Audit API, 등급별 위반 관리를 결합한다. 세 제품 모두 이미 들어온 페이로드의 스키마 적합성에는 강하지만, “버튼이 바뀌어 이벤트가 아예 발생하지 않음”은 페이로드가 없으므로 사각지대(blind spot)가 된다.

## 평가 기준

| 기준 | Segment | mParticle | RudderStack |
|---|---|---|---|
| 검증 위치 | source/CDP pipeline | client-before-arrival 및 ingestion | source/event audit |
| 위반 처리 | block/quarantine/transform | unplanned violation block 중심 | Drop 또는 configurable |
| 가격 구조 | Business/CDP optional add-on | 공개 정액 없음 | Free/Growth/Enterprise 제한 공개 |
| 잔여 공백 | 미계측 action | missing event | UI-action proof |

## 모순

2차 자료의 가격과 공식 가격 페이지는 서로 다를 수 있다. 최신 판단에서는 공식 자료를 우선한다.

## 미결 질문

- 기존 고객이 쓰던 도구 묶음(stack)과 함께 쓸 때 어떤 계획을 원본으로 읽어야 하는가?
- 빠진 이벤트를 거버넌스 플랫폼에 어떤 형태의 증거로 전달할 것인가?

## 제품 시사점

제품 연동의 우선순위는 Segment·RudderStack·mParticle의 계획을 가져오고 기대 이벤트 목록을 만드는 일이다. 초기 가치는 페이로드 검증이 아니라, 페이로드가 아예 없는 빠진 동작을 증명하는 데 있다.

## 관련 문서

- [[validation-layer-model|검증 계층 모델]] - payload 존재 전후의 차이
- [[pricing-and-packaging|가격과 패키징 비교]] - 공식 가격/패키징
- [[element-event-evidence|요소-이벤트 증거 모델]] - missing event proof
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-tracking-governance-four-tools|자료 요약: 트래킹 거버넌스 도구 4종]] - `SRC-20260721-tracking-governance-four-tools`
- <a id="source-2"></a>[[source-tracking-governance-remaining-tools|자료 요약: 트래킹 거버넌스 및 인접 도구]] - `SRC-20260721-tracking-governance-remaining-tools`
- <a id="source-3"></a>[[source-segment-protocols-official|자료 요약: Twilio Segment Protocols 공식 문서]] - `SRC-20260721-segment-protocols-official`
- <a id="source-4"></a>[[source-mparticle-data-planning-official|자료 요약: mParticle Data Planning 공식 문서]] - `SRC-20260721-mparticle-data-planning-official`
- <a id="source-5"></a>[[source-rudderstack-tracking-plans-official|자료 요약: RudderStack Tracking Plans 공식 문서]] - `SRC-20260721-rudderstack-tracking-plans-official`
