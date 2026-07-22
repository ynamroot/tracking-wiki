---
title: 코드 생성과 트래킹 플랜 흐름
type: technology
status: current
confidence: high
created: 2026-07-22
updated: 2026-07-22
sources:
  - SRC-20260721-avo
  - SRC-20260721-avo-official-data-design
  - SRC-20260721-amplitude-data-ampli
  - SRC-20260721-amplitude-official-data-governance
---

# 코드 생성과 트래킹 플랜 흐름

## 현재 종합

코드 생성(codegen)은 트래킹 플랜(tracking plan)을 개발자가 쓰기 쉬운 API로 바꿔, 계획과 실제 구현이 어긋나는 정도(implementation drift)를 줄인다. Avo와 Amplitude 모두 이 방식을 쓰지만, 생성된 래퍼(wrapper) 함수를 어디서 언제 호출할지는 사람이 결정한다. 따라서 코드 생성은 스키마와 타입 오류를 줄이는 강한 도구이지만, 빠진 이벤트(missing event)와 화면에서 이벤트의 의미가 맞는지(UI semantic correctness)를 완전히 해결하지는 않는다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup> <sup>[🔗](#source-3)</sup> <sup>[🔗](#source-4)</sup>

## 근거

- Avo 공식 Source는 트래킹 플랜이 코드 생성과 검증에 함께 쓰이는 중심 명세라고 확인한다. <sup>[🔗](#source-2)</sup>
- Avo 내부 Source는 생성된 함수를 개발자가 직접 호출해야 한다고 설명한다. <sup>[🔗](#source-1)</sup>
- Amplitude 공식 Source는 Ampli 명령줄 도구(CLI)가 트래킹 플랜 스키마를 사용해 래퍼를 생성하고 검증한다고 확인한다. <sup>[🔗](#source-4)</sup>
- Amplitude 내부 Source는 “컴파일 통과”와 “실제 화면 행동에서 올바른 이벤트가 발화되는 것”을 구분해야 한다고 지적한다. <sup>[🔗](#source-3)</sup>

## 작동 방식

트래킹 플랜에는 이벤트 이름, 속성, 허용 타입, 필수 필드, 출발지와 목적지 연결(source/destination mapping)이 담긴다. 코드 생성은 이를 특정 언어의 함수나 래퍼로 변환한다. 정적 타입 검사(static typing)와 생성된 SDK는 잘못된 속성 이름이나 타입을 줄인다. 배포 파이프라인의 상태 점검(CI/status check)은 플랜과 실제 코드 구현이 어긋난 부분을 일부 드러낸다. 그러나 코드가 실제로 실행되는 경로를 얼마나 덮는지(code path coverage)와 사용자 상호작용의 의미는 실행 중(runtime)이나 종단 간(end-to-end) 검사에서 얻는 별도 증거가 필요하다.

## 평가 기준

- 생성 산출물(generated artifact): 래퍼, 타입 정의(type definition), 코드 조각(snippet), SDK 어댑터.
- 강제 지점(enforcement): 컴파일 시점, 배포 파이프라인(CI), 실행 중 스키마 검사 중 어디서 실패하는가.
- 빠진 이벤트 탐지(missing event detection): 플랜에는 있는데 코드에 없거나 화면 경로에서 호출되지 않는 이벤트를 잡는가.
- 개발자 업무 흐름 적합성(developer workflow fit): 풀리퀘스트(PR) 검토와 QA 자동화에 연결되는가.

## 모순

코드 생성은 “수동 계측을 없애는 것”이 아니라 “수동 계측을 더 안전하게 만드는 것”이다. 문서에서 이 차이를 명확히 해야 한다.

## 미결 질문

- 신규 제품이 래퍼 호출을 자동으로 제안한다면, 사람이 승인해야 하는 경계(human approval boundary)는 어디인가?
- 생성된 코드와 브라우저 순회 증거(browser traversal proof)를 어떻게 연결할 것인가?

## 제품 시사점

최소기능제품(MVP)은 코드 생성을 직접 만들기보다, 기존 Avo·Amplitude·RudderStack 플랜에서 기대 이벤트 목록을 가져와 브라우저 순회로 증명하는 경로가 더 빠르다.

## 관련 문서

- [[avo|Avo]] - Avo Codegen/Inspector
- [[amplitude-data|Amplitude Data]] - Ampli 업무 흐름
- [[element-event-evidence|요소-이벤트 증거 모델]] - 코드 생성 이후 검증
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-avo|자료 요약: Avo]] - `SRC-20260721-avo`
- <a id="source-2"></a>[[source-avo-official-data-design|자료 요약: Avo 공식 문서와 가격]] - `SRC-20260721-avo-official-data-design`
- <a id="source-3"></a>[[source-amplitude-data-ampli|자료 요약: Amplitude Data 및 Ampli SDK]] - `SRC-20260721-amplitude-data-ampli`
- <a id="source-4"></a>[[source-amplitude-official-data-governance|자료 요약: Amplitude 공식 Data Governance]] - `SRC-20260721-amplitude-official-data-governance`
