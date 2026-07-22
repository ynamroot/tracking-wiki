---
title: Amplitude Data
type: competitor
status: current
confidence: high
created: 2026-07-21
updated: 2026-07-22
sources:
  - SRC-20260721-amplitude-data-ampli
  - SRC-20260721-amplitude-official-data-governance
---

# Amplitude Data

## 현재 종합

Amplitude Data와 Ampli는 분석 플랫폼 안에서 트래킹 플랜(tracking plan), 코드 생성(codegen), 구현 검증을 연결한다. 공식 자료는 트래킹 플랜과 Ampli의 호출 함수(wrapper) 흐름, Free 등급의 이벤트 허용량, Growth/Enterprise의 맞춤 견적(custom pricing)을 확인한다. 신규 제품의 차별화 지점은 Amplitude 생태계 바깥에서의 화면 동작 증거와 출시 전 검증이다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup>

## 근거

- Amplitude 트래킹 플랜은 이벤트와 속성, 수집 이유, 이벤트를 보내는 위치(emitting source)를 정의한다. <sup>[🔗](#source-2)</sup>
- Ampli는 트래킹 플랜과 SDK(개발 도구 모음) 소스가 있어야 하며, 명령줄 도구(CLI)가 호출 함수를 생성하고 검증한다. <sup>[🔗](#source-2)</sup>
- 내부 자료는 Ampli가 타입 안전 API를 생성하지만 그 함수를 어디서 호출할지는 자동으로 정하지 않는다고 요약한다. <sup>[🔗](#source-1)</sup>
- Free 등급은 2 million events/month를 포함하고, Growth/Enterprise는 맞춤 견적이다. <sup>[🔗](#source-2)</sup>

## 작동 방식

Amplitude는 트래킹 플랜을 구현 산출물로 바꿔 개발자 실수를 줄인다. 계획 변경, 자동 생성 코드, 지속적 통합(CI)의 상태 점검, Observe의 운영 감시가 하나의 플랫폼 경험으로 이어진다. Autocapture와 Visual Labeling은 별도의 축에서 원시 행동(raw interaction)과 사후 라벨링(retrospective labeling)을 다루지만, Ampli의 수동 계측 방식과 완전히 같은 문제를 풀지는 않는다.

## 평가 기준

- 생태계 종속성: Amplitude 고객에게만 자연스러운가.
- 구현 의미: 자동 생성된 호출 함수가 “어디서·언제 호출하는지”까지 검증하는가.
- 가격 문턱: Free 이후 거버넌스 도입이 Growth/Enterprise 맞춤 견적에 묶이는가.
- 시각 증거: Visual Labeling과 코드 기반 계측의 경계.

## 모순

내부 자료에는 제3자가 언급한 가격이나 불만 주장이 포함되어 있지만, 공식 자료로 확정되는 것은 Free 등급의 이벤트 허용량과 맞춤 견적 구조다.

## 미결 질문

- Amplitude 고객은 Autocapture·Visual Labeling과 Ampli를 어떤 기준으로 함께 쓰는가?
- 신규 제품이 Amplitude를 목적지로 삼아 증거를 보낼 수 있는가?

## 제품 시사점

Amplitude 고객에게는 “Amplitude Data 대체”보다 “출시 전에 화면 경로가 기대한 Amplitude 이벤트를 실제로 내는지 자동으로 증명”하는 쪽이 더 선명하다.

## 관련 문서

- [[autocapture-and-tag-manager-layer|오토캡처와 태그매니저 계층]] - Visual Labeling과 retrospective 정의
- [[codegen-and-tracking-plan-workflow|코드 생성과 트래킹 플랜 흐름]] - Ampli wrapper
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-amplitude-data-ampli|자료 요약: Amplitude Data 및 Ampli SDK]] - `SRC-20260721-amplitude-data-ampli`
- <a id="source-2"></a>[[source-amplitude-official-data-governance|자료 요약: Amplitude 공식 Data Governance]] - `SRC-20260721-amplitude-official-data-governance`
