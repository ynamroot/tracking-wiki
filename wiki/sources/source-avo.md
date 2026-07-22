---
title: "자료 요약: Avo"
type: source-summary
status: current
confidence: medium
created: 2026-07-21
updated: 2026-07-22
sources:
  - SRC-20260721-avo
---

# 자료 요약: Avo

## 현재 종합

Avo는 트래킹 플랜(tracking plan)을 단일 기준점(single source of truth)으로 삼고, Codegen(코드 생성), Inspector, 승인 흐름(approval workflow)으로 설계-구현-검증을 잇는다. 직접 경쟁사 중 제품 가설과 가장 가까운 구조지만, 실행 시점(runtime)에 화면 요소와 실제로 발생한 이벤트 사이의 인과 증빙을 자동으로 묶어 주지는 않는다. <sup>[🔗](#source-1)</sup>

## 근거

- Avo는 트래킹 플랜을 이벤트·속성·지표(metrics)·출처(source)·목적지(destination) 정의로 구조화하고, 코드 생성과 실행 시점 검증(runtime validation)에 연결한다. <sup>[🔗](#source-1)</sup>
- Codegen은 이벤트 함수와 래퍼(wrapper)를 생성하지만, 어디서 언제 호출할지는 개발자가 직접 정한다. <sup>[🔗](#source-1)</sup>
- Inspector는 실제 이벤트의 값이 아니라 스키마의 형태·타입(schema shape/type)을 모아 플랜과 대조하는 구조로 요약된다. <sup>[🔗](#source-1)</sup>
- Journeys는 스크린샷을 바탕으로 설계 의도를 연결해 주지만, 실행 시점의 클릭과 실제 발생한 이벤트를 자동으로 증빙하는 것과는 다르다. <sup>[🔗](#source-1)</sup>

## 작동 방식

Avo 작업 흐름은 플랜 작성, 브랜치·리뷰(branch/review), 생성된 코드 내려받기, 구현, 수동 검증, 운영 환경에서 Inspector가 잡은 문제 분류(issue triage)로 이어진다. 이는 스프레드시트로 만든 플랜보다 훨씬 강한 거버넌스(governance)지만, 계측 지점을 코드에 심는 작업과 화면을 직접 눌러 검증하는 작업은 여전히 남는다.

## 평가 기준

- 작성 깊이(authoring depth): 이벤트·속성·지표·출처·목적지를 얼마나 구조화하는가.
- 구현 강제(implementation enforcement): 래퍼, 정적 타입(static type), CI(코드 통합 자동 검사) 상태, SDK(개발자가 앱에 붙이는 수집 도구) 검증이 미치는 범위.
- 운영 강제(operational enforcement): 승인, 리뷰, 문제 배정(issue routing), 하류 레지스트리 동기화(downstream registry sync).
- 시각 증거(visual evidence): 설계 스크린샷, 화면 행동, 실행 시점 이벤트를 얼마나 연결하는가.

## 모순

내부 보고서는 Avo의 한계를 제품 기회로 해석하지만, 공식 문서가 계속 바뀔 수 있으므로 가격(pricing)과 엔터프라이즈 거버넌스는 1차 자료(primary Source)를 기준으로 다시 반영해야 한다.

## 미결 질문

- Avo 고객이 가장 크게 느끼는 남은 수동 작업은 호출 코드 삽입, 품질검사(QA), 운영 문제 분류 중 무엇인가?
- Avo와 공존한다면 기준점(source of truth)을 어느 계층에 둘 것인가?

## 제품 시사점

Avo를 대체하기보다, Avo 트래킹 플랜이나 하류 레지스트리와 연동해 “화면 요소-이벤트 실제 증빙”을 더해 주는 부가 기능(addon) 형태가 초기 진입점일 수 있다.

## 관련 문서

- [[avo|Avo]] - 공식 자료 포함 경쟁사 심층 분석
- [[element-event-evidence|요소-이벤트 증거 모델]] - Avo의 빈 공간
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-avo|Avo 경쟁 분석 리서치]] - `SRC-20260721-avo`
