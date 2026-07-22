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

공식 Source는 Amplitude tracking plan과 Ampli가 instrumentation 전에 schema를 정하고 generated wrapper로 구현을 돕는 흐름임을 확인한다. Free plan의 이벤트 볼륨과 Growth/Enterprise custom pricing도 공식 기준으로 보정된다. <sup>[🔗](#source-1)</sup>

## 근거

- Amplitude tracking plan은 event/property, 수집 이유, emitting source를 정의하는 명세다. <sup>[🔗](#source-1)</sup>
- 문서는 analyst, PM, engineer가 instrumentation 전에 같은 schema에서 협업하는 흐름을 제시한다. <sup>[🔗](#source-1)</sup>
- Ampli는 tracking plan과 SDK source를 필요로 하며 CLI가 schema 정보를 사용해 wrapper를 generate/verify한다. <sup>[🔗](#source-1)</sup>
- Free plan은 2 million events/month를 포함하고, Growth와 Enterprise는 volume/feature requirement 기반 custom-priced다. <sup>[🔗](#source-1)</sup>

## 작동 방식

Amplitude는 analytics platform 안에 data governance를 붙이는 접근이다. tracking plan이 Ampli wrapper와 연결되고, implementation 상태를 verify할 수 있다. 그러나 공식 Source만으로는 UI 요소, user journey, emitted event를 하나의 visual proof로 묶는 기능은 확인되지 않는다.

## 평가 기준

- ecosystem lock-in: Amplitude 고객에게는 강하지만 비고객에게는 도입 장벽이 있는가.
- implementation check: wrapper generation/verify가 누락 이벤트를 어디까지 잡는가.
- pricing exposure: Free event volume 이후 Growth/Enterprise custom pricing이 구매 장벽인가.

## 모순

공식 가격은 Free event volume과 custom pricing을 확인하지만, 제3자 계약 규모 claim은 이 Source로 확정할 수 없다.

## 미결 질문

- Amplitude 고객은 Data/Ampli와 Autocapture/Visual Labeling 중 어떤 조합을 실제로 쓰는가?
- Amplitude 외부 stack에도 같은 value proposition이 성립하는가?

## 제품 시사점

Amplitude가 이미 governance를 제공하므로 신규 제품은 Amplitude data plane을 대체하기보다 UI change regression evidence 또는 pre-release path validation으로 분리해야 한다.

## 관련 문서

- [[amplitude-data|Amplitude Data]] - 공식 Source 포함 경쟁사 deep dive
- [[codegen-and-tracking-plan-workflow|Codegen과 tracking plan workflow]] - wrapper 기반 구현 보조
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-amplitude-official-data-governance|Amplitude official docs: tracking plan, Ampli SDK, and pricing]] - `SRC-20260721-amplitude-official-data-governance`
