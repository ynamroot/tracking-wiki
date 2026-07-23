---
title: Avo
type: competitor
status: current
confidence: high
created: 2026-07-21
updated: 2026-07-23
sources:
  - SRC-20260721-avo
  - SRC-20260721-avo-official-data-design
  - SRC-20260723-amplitude-avo-taxonomy-publishing
---

# Avo

## 현재 종합

Avo는 가장 직접적인 경쟁·참조 제품이다. 트래킹 플랜(tracking plan)을 제품의 데이터 정의서로 삼고, Journeys, Codegen, Inspector, 승인 절차, 하위 도구로의 정의 동기화를 하나로 묶는다. 강점은 설계와 구현 사이를 잇는 운영 규율이고, 남는 공백은 실행 중 화면 동작과 실제로 전송된 이벤트를 자동으로 시각 증빙하는 부분이다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup>

## 근거

- 공식 자료는 Avo Tracking Plan이 코드 생성(codegen)과 검증에 쓰이는 중심 명세임을 확인한다. <sup>[🔗](#source-2)</sup>
- 작업공간(Workspace)의 구성 요소는 Journeys, Events, Properties, Metrics, Publishing, Connection Setup, Codegen, Inspector다. <sup>[🔗](#source-2)</sup>
- 내부 자료는 Codegen이 호출 함수(wrapper)를 만들어 주지만, 개발자가 그 함수를 어디서 언제 부를지는 직접 정해야 한다고 요약한다. <sup>[🔗](#source-1)</sup>
- Free는 $0에 편집자(editor) 2명과 Inspector가 관찰하는 이벤트 100k를 제공하고, Team은 연간 결제 시 $250/month, 월간 결제 시 $300/month다. <sup>[🔗](#source-2)</sup>
- Enterprise는 강제 가능한 승인, 필수 리뷰 자동화, 강제 가능한 표준, Inspector가 관찰하는 이벤트 1M, 단일 로그인(SSO), 우선 지원을 포함한다. <sup>[🔗](#source-2)</sup>
- Publishing 기능은 트래킹 플랜을 Amazon S3, Segment Protocols, Mixpanel Lexicon, RudderStack, Snowplow Data Structures, mParticle Data Master, Amplitude Data, 범용 Webhook 8개 하류 도구로 발행(fan-out)한다. Auto Publishing을 켜면 브랜치 merge 시점에만 자동 발행되고, Source·Destination·Tag로 발행 범위를 좁힐 수 있다. <sup>[🔗](#source-3)</sup>
- 대상 도구마다 충돌 처리 방식이 다르다 — Segment Protocols에는 발행 포함 이벤트를 **덮어쓰고**, Mixpanel Lexicon에는 기존 정의와 **병합**한다. 두 경우 모두 대상 도구에만 있는 이벤트는 건드리지 않는다. <sup>[🔗](#source-3)</sup>

## 작동 방식

Avo는 데이터 설계를 명세로 고정하고, 자동 생성된 함수를 코드로 가져와 구현 방식을 표준화한다. Inspector는 실제 이벤트의 스키마 형태를 관찰해 트래킹 플랜과 비교한다. Journeys는 화면 캡처(screenshot)를 바탕으로 설계 의도를 보여 주지만, 실행 중에 “이 버튼을 누르면 이 이벤트가 이 페이로드(payload, 전송 내용물)로 전송됐다”를 자동 증거로 묶는 계층은 확인되지 않는다.

Publishing은 Avo 트래킹 플랜을 단일 원본으로 두고 여러 하류 스키마 레지스트리에 같은 모양의 스키마를 팬아웃하는 구조다. 이는 Avo가 이미 "설계 원본 → 여러 도구로 동기화"라는 통합 허브 역할을 하고 있음을 보여 준다 — 신규 제품이 Avo와 경쟁하기보다 이 팬아웃 대상 중 하나(Webhook 등)로 연동해 화면 증거를 되돌려 보내는 방향이 더 현실적이다.

## 평가 기준

- 직접 경쟁 강도: 트래킹 플랜, 코드 생성, Inspector 기능이 서로 겹친다.
- 보완 가능성: Avo 트래킹 플랜을 읽어 화면 순회 테스트를 만들 수 있는가.
- 가격 진입 지점(pricing wedge): Avo Team/Enterprise 기능과 비교해 더 작은 팀에도 가치를 줄 수 있는가.
- 증거 공백: Journeys의 설계 산출물과 실행 중 증거 사이를 메울 수 있는가.

## 모순

Avo는 이미 화면 캡처와 Journey를 제공하므로 “시각 연결이 전혀 없다”고 쓰면 부정확하다. 정확한 공백은 설계 시점의 시각 연결과 실행 시점의 행동-이벤트 증거 사이의 차이다.

## 미결 질문

- Avo 고객이 실제로 가장 자주 실패하는 단계는 설계 작성, 구현, 품질 검증(QA), 운영 중 문제 분류 중 어디인가?
- 신규 제품이 Avo와 연동한다면 기준이 되는 원본(source of truth)은 Avo 트래킹 플랜인가, 별도 계획인가?

## 제품 시사점

Avo를 대체하려는 자리 잡기는 위험하다. 초기에는 Avo·Segment·Amplitude의 트래킹 플랜 위에서, 바뀐 화면 경로를 자동으로 순회하고 실행 중 이벤트 증거를 붙이는 보완 계층이 더 현실적이다.

## 관련 문서

- [[codegen-and-tracking-plan-workflow|코드 생성과 트래킹 플랜 흐름]] - Avo/Amplitude 구현 패턴
- [[element-event-evidence|요소-이벤트 증거 모델]] - Avo가 남기는 공백
- [[pricing-and-packaging|가격과 패키징 비교]] - Avo 가격 기준
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-avo|자료 요약: Avo]] - `SRC-20260721-avo`
- <a id="source-2"></a>[[source-avo-official-data-design|자료 요약: Avo 공식 문서와 가격]] - `SRC-20260721-avo-official-data-design`
- <a id="source-3"></a>[[source-amplitude-avo-taxonomy-publishing|자료 요약: Amplitude taxonomy·거버넌스 문서와 Avo Publishing 연동 문서]] - `SRC-20260723-amplitude-avo-taxonomy-publishing`
