---
title: "자료 요약: RudderStack Tracking Plans 공식 문서"
type: source-summary
status: current
confidence: high
created: 2026-07-22
updated: 2026-07-22
sources:
  - SRC-20260721-rudderstack-tracking-plans-official
---

# 자료 요약: RudderStack Tracking Plans 공식 문서

## 현재 종합

RudderStack 공식 자료는 Tracking Plans가 들어오는 이벤트 데이터의 규칙 위반(non-compliance)을 감시하고 대응하는 기능임을 확인한다. 또한 Free, Growth, Enterprise 요금제별로 플랜 수와 이벤트 수 제한, 위반 처리 방식에 차이가 있음을 확인한다. <sup>[🔗](#source-1)</sup>

## 근거

- Tracking Plans는 미리 정의한 플랜을 기준으로 들어오는 이벤트 데이터의 규칙 위반을 감시하고 대응한다. <sup>[🔗](#source-1)</sup>
- 이 기능은 `track`, `identify`, `page`, `screen`, `group` 이벤트 규칙과 필수 속성, 데이터 타입 정의를 포함한다. <sup>[🔗](#source-1)</sup>
- Tracking Plans 기능은 Free, Growth, Enterprise 요금제에서 지원된다. <sup>[🔗](#source-1)</sup>
- 플랜 제한은 Free가 플랜 1개에 플랜당 이벤트 5개, Growth가 플랜 무제한에 플랜당 이벤트 75개, Enterprise가 플랜 무제한에 이벤트 무제한이다. <sup>[🔗](#source-1)</sup>
- 위반 처리는 Free에서 이벤트 버림(Drop Events), Growth와 Enterprise에서 설정 가능(Configurable)으로 표시된다. <sup>[🔗](#source-1)</sup>

## 작동 방식

RudderStack은 고객데이터플랫폼(CDP)의 소스 경계에서 들어오는 이벤트를 트래킹 플랜과 대조하고, 플랜과 설정에 따라 위반을 처리한다. Data Catalog API와 대시보드 관리가 함께 제공되어, 코드와 API로 다루는 거버넌스(governance) 쪽으로 이동하는 경향이 있다.

## 평가 기준

- 무료 요금제의 실효성: 플랜 1개에 이벤트 5개 제한이 실제 시범 도입(pilot)에 충분한가.
- 위반 정책: 버림만 가능한 방식과 설정 가능한 방식의 운영 차이.
- 이벤트 범위: `alias` 미지원처럼 제외되는 호출이 제품 설계에 미치는 영향.

## 모순

기존 2차 자료의 Growth 가격과 공식 가격 페이지의 최신 표시가 다를 수 있다. 공식 자료를 우선한다.

## 미결 질문

- RudderStack 고객에게 배포 전 UI 경로 검증이 Data Catalog나 Tracking Plans와 어떤 관계를 가지는가?
- 설정 가능한 위반 처리가 실제로 어느 요금제 등급에서 구매되는가?

## 제품 시사점

RudderStack은 무료 등급에서도 거버넌스를 맛볼 수 있게 하므로, 신규 제품은 무료 시범 도입 단계에서 차별화할 수 있는 시각적 증거나 변경된 경로의 회귀 검증을 보여줘야 한다.

## 관련 문서

- [[tracking-governance-platforms|트래킹 거버넌스 플랫폼]] - RudderStack 비교
- [[pricing-and-packaging|가격과 패키징 비교]] - 등급별 제한
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-rudderstack-tracking-plans-official|RudderStack official docs: Tracking Plans and pricing limits]] - `SRC-20260721-rudderstack-tracking-plans-official`
