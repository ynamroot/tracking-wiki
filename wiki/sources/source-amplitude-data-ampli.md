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

Amplitude Data와 Ampli는 트래킹 플랜(tracking plan, 무엇을 언제 수집할지 정한 약속 문서)을 실제 구현 작업에 연결해, 설계와 계측(instrumentation)이 어긋나는 문제(drift)를 줄인다. 그러나 이 도구가 만들어 주는 것은 타입 안전 래퍼(wrapper) 함수와 코드 통합 자동 검사(CI) 및 상태 점검일 뿐, 화면(UI)의 어느 지점에서 언제 이벤트를 호출해야 하는지는 여전히 사람이 정한다. <sup>[🔗](#source-1)</sup>

## 근거

- 내부 보고서는 Amplitude Data를 설계 화면, Ampli의 코드 생성(codegen), CI 검증, Observe 운영 감시라는 네 겹 구조로 요약한다. <sup>[🔗](#source-1)</sup>
- Ampli는 래퍼 함수를 생성하지만, 그 래퍼를 코드의 적절한 위치에서 직접 호출하는 일은 개발자 몫이다. <sup>[🔗](#source-1)</sup>
- 코드가 “컴파일된다”는 사실이, 실제 사용자가 화면을 눌렀을 때 올바른 이벤트가 발생한다는 의미상의 정확성까지 보장하지는 않는다. <sup>[🔗](#source-1)</sup>

## 작동 방식

Amplitude 계열은 트래킹 플랜을 코드 결과물(code artifact)로 바꿔 개발자 실수를 줄인다. Ampli 명령줄 도구(CLI)는 플랜을 내려받아 래퍼를 생성하고, 상태·점검 흐름은 구현 상태와 플랜-구현 어긋남을 일부 드러낸다. 런타임(실행 시점)과 사후 관측은 이미 들어온 이벤트 흐름(event stream)을 기준으로 이상을 찾는다.

## 평가 기준

- 코드 생성 적용 범위: 이벤트 이름, 속성 타입, 필수 항목(required field), 목적지(destination) 호출을 얼마나 강제하는가.
- 의미 검증 범위: “어떤 화면 행동이 어떤 이벤트를 내야 하는가”를 확인하는가.
- 생애주기 적용 범위: 설계, 구현, CI, 런타임, 운영 관측(observe) 중 어디까지 이어지는가.
- 전환 비용: 기존 Amplitude 생태계(ecosystem) 안팎에서 도입할 수 있는가.

## 모순

내부 보고서의 가격·계약 규모 주장(claim)에는 공식 가격 외에 제3자 집계가 섞여 있다. 최신 가격과 거버넌스 기능(governance feature)은 공식 자료로 보강해 해석해야 한다.

## 미결 질문

- Amplitude 고객은 코드 생성보다 비주얼 라벨링(visual labeling)이나 오토캡처(autocapture) 쪽에서 어떤 어려움(pain)을 더 크게 느끼는가?
- Amplitude 생태계 밖 고객에게도 같은 작업 흐름(workflow)을 팔 수 있는가?

## 제품 시사점

Amplitude와 직접 경쟁하려면 분석 도구 묶음(analytics suite)이 아니라, 화면 행동에 대한 증거(evidence)와 배포 전 검증(pre-release verification)을 제공해야 한다. Ampli가 강한 “타입 안전 구현”이 아니라, Ampli가 약한 “어디서·언제 호출하는가에 대한 의미 검증”을 파고드는 편이 낫다.

## 관련 문서

- [[amplitude-data|Amplitude Data]] - 공식 자료를 포함한 경쟁사 심층 분석
- [[codegen-and-tracking-plan-workflow|코드 생성과 트래킹 플랜 작업 흐름]] - 개발자 구현 계층
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-amplitude-data-ampli|Amplitude Data / Ampli SDK 경쟁 분석 리서치]] - `SRC-20260721-amplitude-data-ampli`
