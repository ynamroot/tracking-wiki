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

Amplitude Data와 Ampli는 analytics platform 안에서 tracking plan, codegen, implementation verification을 연결한다. 공식 Source는 tracking plan과 Ampli wrapper 흐름, Free event volume, Growth/Enterprise custom pricing을 확인한다. 신규 제품의 차별화 지점은 Amplitude ecosystem 바깥의 UI action proof와 pre-release verification이다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup>

## 근거

- Amplitude tracking plan은 event/property, 수집 이유, emitting source를 정의한다. <sup>[🔗](#source-2)</sup>
- Ampli는 tracking plan과 SDK source를 필요로 하며 CLI가 wrapper를 generate/verify한다. <sup>[🔗](#source-2)</sup>
- 내부 Source는 Ampli가 타입 안전 API를 생성하지만 호출 위치를 자동으로 결정하지 않는다고 요약한다. <sup>[🔗](#source-1)</sup>
- Free plan은 2 million events/month를 포함하고 Growth/Enterprise는 custom-priced다. <sup>[🔗](#source-2)</sup>

## 작동 방식

Amplitude는 plan을 implementation artifact로 변환해 developer error를 줄인다. plan 변경, generated code, CI/status check, Observe 운영 감시가 하나의 platform experience로 이어진다. Autocapture/Visual Labeling은 별도 축에서 raw interaction과 retrospective labeling을 다루지만, Ampli의 manual instrumentation track과 완전히 같은 문제를 풀지는 않는다.

## 평가 기준

- ecosystem dependency: Amplitude customer에게만 자연스러운가.
- implementation semantics: generated wrapper가 “where/when”까지 검증하는가.
- pricing threshold: Free 이후 governance adoption이 Growth/Enterprise custom pricing에 묶이는가.
- visual evidence: Visual Labeling과 code-based tracking의 경계.

## 모순

내부 Source에는 제3자 가격/불만 claim이 포함되어 있지만, 공식 Source로 확정되는 것은 Free event volume과 custom pricing 구조다.

## 미결 질문

- Amplitude customer가 Autocapture/Visual Labeling과 Ampli를 어떤 기준으로 병행하는가?
- 신규 제품이 Amplitude destination으로 proof를 보낼 수 있는가?

## 제품 시사점

Amplitude 고객에게는 “Amplitude Data 대체”보다 “release 전 UI path가 expected Amplitude events를 내는지 자동 증명”이 더 선명하다.

## 관련 문서

- [[autocapture-and-tag-manager-layer|오토캡처와 태그매니저 계층]] - Visual Labeling과 retrospective 정의
- [[codegen-and-tracking-plan-workflow|Codegen과 tracking plan workflow]] - Ampli wrapper
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-amplitude-data-ampli|자료 요약: Amplitude Data 및 Ampli SDK]] - `SRC-20260721-amplitude-data-ampli`
- <a id="source-2"></a>[[source-amplitude-official-data-governance|자료 요약: Amplitude 공식 Data Governance]] - `SRC-20260721-amplitude-official-data-governance`
