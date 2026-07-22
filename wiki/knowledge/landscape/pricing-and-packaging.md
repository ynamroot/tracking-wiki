---
title: 가격과 패키징 비교
type: comparison
status: current
confidence: high
created: 2026-07-22
updated: 2026-07-22
sources:
  - SRC-20260721-avo-official-data-design
  - SRC-20260721-amplitude-official-data-governance
  - SRC-20260721-segment-protocols-official
  - SRC-20260721-rudderstack-tracking-plans-official
  - SRC-20260721-mparticle-data-planning-official
---

# 가격과 패키징 비교

## 현재 종합

공식 자료 기준으로 가격을 공개하는 정도는 제품마다 크게 다르다. Avo는 Free·Team 가격을 명확히 공개하고 Enterprise는 맞춤 견적(custom)으로 둔다. Amplitude는 Free 등급의 이벤트 허용량을 공개하고 Growth·Enterprise는 맞춤 견적으로 둔다. Segment Protocols와 mParticle은 핵심 거버넌스 가격이 공개된 정액이 아니며, RudderStack은 Free·Growth·Enterprise별 트래킹 플랜(tracking plan) 한도를 비교적 명확히 공개한다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup> <sup>[🔗](#source-3)</sup> <sup>[🔗](#source-4)</sup> <sup>[🔗](#source-5)</sup>

## 근거

- Avo Free는 $0에 편집자(editor) 2명과 Inspector가 관찰하는 이벤트 100k를 제공하고, Team은 연간 결제 시 $250/month, 월간 결제 시 $300/month다. <sup>[🔗](#source-1)</sup>
- Avo Enterprise는 강제 가능한 승인, 필수 리뷰 자동화, 강제 가능한 표준, Inspector가 관찰하는 이벤트 1M, 단일 로그인(SSO), 우선 지원을 포함한다. <sup>[🔗](#source-1)</sup>
- Amplitude Free 등급은 2 million events/month를 포함하고, Growth·Enterprise는 맞춤 견적이다. <sup>[🔗](#source-2)</sup>
- Segment Protocols는 Customer Data Pipeline Business plan과 고객데이터플랫폼(CDP) 등급에서 선택으로 추가하는 옵션(optional add-on)이다. <sup>[🔗](#source-3)</sup>
- RudderStack Tracking Plans는 Free는 1 plan/5 events, Growth는 unlimited plans/75 events, Enterprise는 unlimited/unlimited로 제한된다. <sup>[🔗](#source-4)</sup>
- mParticle 공식 자료는 공개된 정액 가격을 확정하지 못하며, Data Plan 기능과 API·SDK(개발 도구 모음) 흐름을 설명한다. <sup>[🔗](#source-5)</sup>

## 작동 방식

가격은 제품이 어떤 자리를 노리는지 보여 준다. Avo는 편집자 수와 관찰한 이벤트 수를 중심으로 데이터 설계 작업공간을 판다. Amplitude는 분석 이벤트 사용량과 플랫폼 등급이 중심이다. Segment와 mParticle은 기업용 데이터 파이프라인에 얹는 추가 기능(add-on) 성격이 강하다. RudderStack은 거버넌스 기능을 낮은 등급에도 보여 주지만, 한도를 두어 상위 등급으로 올라가도록 유도한다.

## 평가 기준

- 직접 도입(self-serve) 가능성: 공개된 가격과 무료 등급이 소규모 시범 도입(pilot)을 가능하게 하는가.
- 사용량 기준: 편집자 수, 이벤트 사용량, 월간 추적 이용자(MTU), 계획·이벤트 수 중 무엇을 과금 기준으로 삼는가.
- 거버넌스 문턱: 승인, 표준, 위반 관리가 어느 등급부터 의미 있게 제공되는가.
- 도입 비용: 기존 분석 도구나 CDP 지출 위에 추가 예산을 요구하는가.

## 모순

2차 자료의 제3자 계약 규모와 공식 가격은 비교하려는 목적이 다르다. 제품 판단에는 공식 가격을 우선하고, 실제로 돈을 낼 의향은 인터뷰나 구매 사례로 검증해야 한다.

## 미결 질문

- 신규 제품의 과금 기준은 경로 실행 횟수(route/run), 추적한 이벤트 수, 팀 좌석 수, 연결된 목적지 수 중 무엇이 적절한가?
- 구매자(buyer)가 이미 CDP나 분석 도구 비용을 내고 있다면 추가 예산을 만들 수 있는가?

## 제품 시사점

초기 상품 구성은 기업용 거버넌스 묶음이 아니라, 출시 검증 실행이나 프로젝트별 증거 자동화로 직접 도입 시범(self-serve pilot)을 가능하게 해야 한다.

## 관련 문서

- [[avo|Avo]] - Avo pricing details
- [[tracking-governance-platforms|트래킹 거버넌스 플랫폼]] - governance 기능 비교
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-avo-official-data-design|자료 요약: Avo 공식 문서와 가격]] - `SRC-20260721-avo-official-data-design`
- <a id="source-2"></a>[[source-amplitude-official-data-governance|자료 요약: Amplitude 공식 Data Governance]] - `SRC-20260721-amplitude-official-data-governance`
- <a id="source-3"></a>[[source-segment-protocols-official|자료 요약: Twilio Segment Protocols 공식 문서]] - `SRC-20260721-segment-protocols-official`
- <a id="source-4"></a>[[source-rudderstack-tracking-plans-official|자료 요약: RudderStack Tracking Plans 공식 문서]] - `SRC-20260721-rudderstack-tracking-plans-official`
- <a id="source-5"></a>[[source-mparticle-data-planning-official|자료 요약: mParticle Data Planning 공식 문서]] - `SRC-20260721-mparticle-data-planning-official`
