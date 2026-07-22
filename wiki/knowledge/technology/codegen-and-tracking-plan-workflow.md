---
title: Codegen과 tracking plan workflow
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

# Codegen과 tracking plan workflow

## 현재 종합

Codegen은 tracking plan을 개발자 친화적 API로 바꿔 implementation drift를 줄인다. Avo와 Amplitude 모두 이 패턴을 사용하지만, 생성된 wrapper를 어디서 언제 호출할지는 사람이 결정한다. 따라서 codegen은 schema/type 오류를 줄이는 강한 도구이지만 missing event와 UI semantic correctness를 완전히 해결하지는 않는다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup> <sup>[🔗](#source-3)</sup> <sup>[🔗](#source-4)</sup>

## 근거

- Avo 공식 Source는 Tracking Plan이 codegen과 validation에 사용되는 중심 명세라고 확인한다. <sup>[🔗](#source-2)</sup>
- Avo 내부 Source는 generated function을 개발자가 직접 호출해야 한다고 설명한다. <sup>[🔗](#source-1)</sup>
- Amplitude 공식 Source는 Ampli CLI가 tracking plan schema를 사용해 wrapper를 generate/verify한다고 확인한다. <sup>[🔗](#source-4)</sup>
- Amplitude 내부 Source는 “컴파일 통과”와 “실제 UI 행동에서 올바른 이벤트 발화”를 구분해야 한다고 지적한다. <sup>[🔗](#source-3)</sup>

## 작동 방식

tracking plan에는 event name, properties, allowed types, required fields, source/destination mapping이 있다. codegen은 이를 language-specific function이나 wrapper로 변환한다. static typing과 generated SDK는 잘못된 property name/type을 줄인다. CI/status check는 plan과 code implementation의 drift를 일부 드러낸다. 그러나 code path coverage와 user interaction semantics는 별도 runtime/e2e evidence가 필요하다.

## 평가 기준

- generated artifact: wrapper, type definition, snippet, SDK adapter.
- enforcement: compile-time, CI, runtime schema check 중 어디서 실패하는가.
- missing event detection: plan에 있는 event가 코드에 없거나 UI path에서 호출되지 않는 것을 잡는가.
- developer workflow fit: PR review와 QA automation에 연결되는가.

## 모순

codegen은 “수동 계측을 없애는 것”이 아니라 “수동 계측을 더 안전하게 만드는 것”이다. 문서에서 이 차이를 명확히 해야 한다.

## 미결 질문

- 신규 제품이 wrapper 호출을 자동 제안할 경우 human approval boundary는 어디인가?
- generated code와 browser traversal proof를 어떻게 연결할 것인가?

## 제품 시사점

MVP는 codegen을 직접 만들기보다 기존 Avo/Amplitude/RudderStack plan에서 expected event list를 가져와 browser traversal로 증명하는 경로가 더 빠르다.

## 관련 문서

- [[avo|Avo]] - Avo Codegen/Inspector
- [[amplitude-data|Amplitude Data]] - Ampli workflow
- [[element-event-evidence|요소-이벤트 증거 모델]] - codegen 이후 검증
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-avo|자료 요약: Avo]] - `SRC-20260721-avo`
- <a id="source-2"></a>[[source-avo-official-data-design|자료 요약: Avo 공식 문서와 가격]] - `SRC-20260721-avo-official-data-design`
- <a id="source-3"></a>[[source-amplitude-data-ampli|자료 요약: Amplitude Data 및 Ampli SDK]] - `SRC-20260721-amplitude-data-ampli`
- <a id="source-4"></a>[[source-amplitude-official-data-governance|자료 요약: Amplitude 공식 Data Governance]] - `SRC-20260721-amplitude-official-data-governance`
