---
title: "자료 요약: Amplitude 공식 Data Governance"
type: source-summary
status: current
confidence: high
created: 2026-07-22
updated: 2026-07-22
sources:
  - SRC-20260721-amplitude-official-data-governance
---

# 자료 요약: Amplitude 공식 Data Governance

## 현재 종합

공식 자료는 Amplitude 트래킹 플랜(tracking plan)과 Ampli가 계측(instrumentation) 전에 스키마(schema, 이벤트·속성이 가져야 할 이름과 타입 규칙)를 먼저 정하고, 생성된 래퍼(wrapper) 함수로 구현을 돕는 흐름임을 확인한다. Free 요금제의 이벤트 처리량과 Growth·Enterprise 맞춤 가격(custom pricing)도 공식 기준으로 보정된다. <sup>[🔗](#source-1)</sup>

## 근거

- Amplitude 트래킹 플랜은 이벤트·속성, 수집 이유, 이벤트를 내보내는 출처(emitting source)를 정의하는 명세다. <sup>[🔗](#source-1)</sup>
- 문서는 분석가(analyst), 기획자(PM), 개발자(engineer)가 계측 전에 같은 스키마 위에서 협업하는 흐름을 제시한다. <sup>[🔗](#source-1)</sup>
- Ampli는 트래킹 플랜과 SDK(개발자가 앱에 붙이는 수집 도구) 소스가 있어야 하며, 명령줄 도구(CLI)가 스키마 정보를 이용해 래퍼를 생성·검증한다. <sup>[🔗](#source-1)</sup>
- Free 요금제는 월 200만 이벤트(2 million events/month)를 포함하고, Growth와 Enterprise는 처리량·기능 요구에 따라 맞춤 가격이 매겨진다. <sup>[🔗](#source-1)</sup>

## 작동 방식

Amplitude는 분석 플랫폼(analytics platform) 안에 데이터 거버넌스(data governance)를 붙이는 방식이다. 트래킹 플랜이 Ampli 래퍼와 연결되고, 구현 상태를 검증할 수 있다. 그러나 공식 자료만으로는 화면 요소(UI 요소), 사용자 여정(user journey), 실제 발생한 이벤트를 하나의 시각 증거(visual proof)로 묶는 기능은 확인되지 않는다.

## 평가 기준

- 생태계 종속(ecosystem lock-in): Amplitude 고객에게는 강하지만, 고객이 아닌 곳에는 도입 장벽이 되는가.
- 구현 점검: 래퍼 생성·검증이 빠진 이벤트를 어디까지 잡아내는가.
- 가격 부담: Free 이벤트 처리량을 넘어선 뒤의 Growth·Enterprise 맞춤 가격이 구매 장벽인가.

## 모순

공식 가격은 Free 이벤트 처리량과 맞춤 가격을 확인해 주지만, 제3자가 집계한 계약 규모 주장은 이 자료로는 확정할 수 없다.

## 미결 질문

- Amplitude 고객은 Data·Ampli와 오토캡처(Autocapture)·비주얼 라벨링(Visual Labeling) 중 어떤 조합을 실제로 쓰는가?
- Amplitude 밖의 기술 구성(stack)에도 같은 가치 제안(value proposition)이 성립하는가?

## 제품 시사점

Amplitude가 이미 거버넌스를 제공하므로, 신규 제품은 Amplitude 데이터 처리 계층(data plane)을 대체하기보다 화면 변경에 대한 회귀 검증 증거(UI change regression evidence)나 배포 전 경로 검증(pre-release path validation)으로 방향을 나눠야 한다.

## 관련 문서

- [[amplitude-data|Amplitude Data]] - 공식 자료 포함 경쟁사 심층 분석
- [[codegen-and-tracking-plan-workflow|코드 생성과 트래킹 플랜 작업 흐름]] - 래퍼 기반 구현 보조
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-amplitude-official-data-governance|Amplitude official docs: tracking plan, Ampli SDK, and pricing]] - `SRC-20260721-amplitude-official-data-governance`
