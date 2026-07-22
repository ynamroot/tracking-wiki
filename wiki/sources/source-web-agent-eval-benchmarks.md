---
title: "자료 요약: Web Agent Evaluation Benchmarks"
type: source-summary
status: current
confidence: high
created: 2026-07-22
updated: 2026-07-22
sources:
  - SRC-20260721-web-agent-eval-benchmarks
---

# 자료 요약: Web Agent Evaluation Benchmarks

## 현재 종합

Mind2Web, WebArena, VisualWebArena, WorkArena는 에이전트가 사람 없이 웹을 돌아다니며 브라우저 작업을 수행하는 능력을 평가하는 대표 벤치마크(benchmark)다. 이 프로젝트의 자율 순회 평가에는 유용하지만, 행동데이터 계측이 빠졌는지 찾아내는 일이나 화면 요소를 계속 같은 것으로 알아보는 요소 지문의 연속성은 직접 측정하지 않는다. <sup>[🔗](#source-1)</sup>

## 근거

- Mind2Web는 웹 작업 2,350개, 웹사이트 137개, 분야 31개를 포함하는 범용 웹 에이전트 평가 데이터셋(dataset)이다. <sup>[🔗](#source-1)</sup>
- WebArena는 자율 에이전트를 위해 독립적으로 직접 호스팅할 수 있는 웹 환경과 작업, 평가 스크립트를 제공한다. <sup>[🔗](#source-1)</sup>
- VisualWebArena는 여러 형태의 입력을 함께 다루는(멀티모달) 자율 언어 에이전트를 실제와 비슷한 시각적 웹 작업으로 평가한다. <sup>[🔗](#source-1)</sup>
- WorkArena는 ServiceNow 플랫폼 기반의 브라우저 작업으로 지식 근로자의 업무 흐름 자동화 능력을 평가한다. <sup>[🔗](#source-1)</sup>
- WorkArena-L1은 기본 단위 작업 33개에서 나온 고유 사례 19,912개를 포함하고, WorkArena++는 여러 작업을 합친 복합 작업 682개를 포함한다. <sup>[🔗](#source-1)</sup>

## 작동 방식

이 벤치마크들은 에이전트가 지시를 이해하고 웹 화면에서 정해진 동작을 순서대로 수행하는지 평가한다. 일부는 미리 준비한 가상 환경을 제공하고, 일부는 실제 웹사이트에서 사용자가 조작한 기록을 포함한다. 그러나 계측을 검증하는 제품에는 기대하는 분석 이벤트, 요소 지문, 화면 구조(DOM)나 빌드의 변경 차이, 실제로 전송한 내용물(페이로드) 검증 같은 별도의 정답 라벨(label)이 필요하다.

## 평가 기준

- 작업의 현실성: 실제 소프트웨어 서비스(SaaS)나 전자상거래 업무 흐름과 얼마나 가까운가.
- 환경 통제: 직접 호스팅한 환경에서 다시 재생(replay)하고 결과가 항상 같은 평가가 가능한가.
- 관찰 방식: 화면 구조(DOM), 화면 캡처, 접근성 트리, 네트워크 이벤트를 사용할 수 있는가.
- 계측 전용 라벨: 기대 이벤트, 페이로드, 요소 지문 라벨을 붙일 수 있는가.

## 모순

벤치마크 작업 성공률과 분석 계측의 정확성은 서로 다른 측정 지표다. 웹 에이전트가 최고 수준(SOTA) 성능을 내더라도 계측 검증 제품의 정확도를 보장하지는 않는다.

## 미결 질문

- 어떤 벤치마크를 출발점(seed)으로 삼아 계측 전용 데이터셋을 만들 것인가?
- 동작 성공, 이벤트 정확성, 요소 연속성을 하나의 점수로 묶을 수 있는가?

## 제품 시사점

시제품(prototype) 평가는 기존 벤치마크를 그대로 쓰기보다, 통제된 앱을 바꾸기 전후의 동작 기록, 기대 이벤트, 실제 전송한 페이로드, 요소 지문 일치 여부를 함께 기록하는 프로젝트 전용 데이터셋으로 설계해야 한다.

## 관련 문서

- [[autonomous-traversal-evaluation|자율 순회 평가 기준]] - 제품 평가 데이터셋 설계
- [[element-event-evidence|요소-이벤트 증거 모델]] - 계측 전용 라벨
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-web-agent-eval-benchmarks|Primary web agent evaluation benchmarks: Mind2Web, WebArena, VisualWebArena, WorkArena]] - `SRC-20260721-web-agent-eval-benchmarks`
