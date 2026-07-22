---
title: "자료 요약: Amplitude Data 및 Ampli SDK"
type: source-summary
status: current
confidence: medium
created: 2026-07-21
updated: 2026-07-22
sources:
  - SRC-20260721-amplitude-data-ampli
---

# 자료 요약: Amplitude Data 및 Ampli SDK

## 현재 종합

Amplitude Data와 Ampli는 tracking plan을 implementation workflow에 연결해 설계와 계측 drift를 줄인다. 그러나 생성되는 것은 타입 안전 wrapper와 CI/status 검증이며, UI의 어느 지점에서 언제 호출해야 하는지는 여전히 사람이 결정한다. <sup>[🔗](#source-1)</sup>

## 근거

- 내부 보고서는 Amplitude Data를 설계 UI, Ampli code generation, CI 검증, Observe 운영 감시의 4겹 구조로 요약한다. <sup>[🔗](#source-1)</sup>
- Ampli는 wrapper를 생성하지만 개발자가 그 wrapper를 코드의 적절한 위치에 직접 호출해야 한다. <sup>[🔗](#source-1)</sup>
- “컴파일된다”는 사실은 실제 사용자가 UI를 눌렀을 때 올바른 이벤트가 발화된다는 의미론적 정확성을 보장하지 않는다. <sup>[🔗](#source-1)</sup>

## 작동 방식

Amplitude 계열은 tracking plan을 code artifact로 변환해 개발자 오류를 줄인다. Ampli CLI는 plan을 pull해 wrapper를 생성하고, status/check 흐름은 구현 상태와 plan drift를 일부 드러낸다. 런타임/사후 관측은 이미 들어온 event stream을 기준으로 이상을 찾는다.

## 평가 기준

- codegen coverage: 이벤트명, 속성 타입, required field, destination 호출을 얼마나 강제하는가.
- semantic coverage: “어떤 UI 행동이 어떤 이벤트를 내야 하는가”를 검증하는가.
- lifecycle coverage: 설계, 구현, CI, runtime, observe 중 어디까지 이어지는가.
- migration cost: 기존 Amplitude ecosystem 안팎에서 도입 가능한가.

## 모순

내부 보고서의 가격·계약 규모 claim은 공식 가격 외 제3자 집계를 포함한다. 최신 가격과 governance feature는 공식 Source로 보강해 해석해야 한다.

## 미결 질문

- Amplitude 고객은 codegen보다 visual labeling/autocapture 쪽에서 어떤 pain을 더 크게 느끼는가?
- Amplitude ecosystem 밖 고객에게 같은 workflow를 팔 수 있는가?

## 제품 시사점

Amplitude와 직접 경쟁하려면 analytics suite가 아니라 UI-action evidence와 pre-release verification을 제공해야 한다. Ampli가 강한 “타입 안전 구현”이 아니라 약한 “where/when 호출 의미 검증”을 파고드는 편이 낫다.

## 관련 문서

- [[amplitude-data|Amplitude Data]] - 공식 Source를 포함한 경쟁사 deep dive
- [[codegen-and-tracking-plan-workflow|Codegen과 tracking plan workflow]] - 개발자 구현 계층
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-amplitude-data-ampli|Amplitude Data / Ampli SDK 경쟁 분석 리서치]] - `SRC-20260721-amplitude-data-ampli`
