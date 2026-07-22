---
title: 자율 순회 평가 기준
type: technology
status: current
confidence: high
created: 2026-07-22
updated: 2026-07-22
sources:
  - SRC-20260721-web-agent-eval-benchmarks
  - SRC-20260721-tag-audit-qa-tools
---

# 자율 순회 평가 기준

## 현재 종합

자율 순회 평가는 웹 에이전트가 과제를 성공했는지(web-agent task success)와 추적이 정확한지(tracking correctness)를 분리해야 한다. Mind2Web, WebArena, VisualWebArena, WorkArena는 에이전트가 웹 과제를 수행하는지 평가하는 대표 벤치마크(primary benchmark)지만, 행동데이터 계측 누락 탐지와 요소 지문의 연속성(continuity)은 이 프로젝트 전용 라벨(label)이 필요하다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup>

## 근거

- Mind2Web는 과제 2,350개, 웹사이트 137개, 도메인 31개를 포함한다. <sup>[🔗](#source-1)</sup>
- WebArena는 독립적으로 직접 호스팅할 수 있는(self-hostable) 웹 환경과 과제·평가 스크립트를 제공한다. <sup>[🔗](#source-1)</sup>
- VisualWebArena는 여러 형태의 입력을 다루는 자율 언어 에이전트(multimodal autonomous language agents)를 실제와 비슷한 시각적 웹 과제로 평가한다. <sup>[🔗](#source-1)</sup>
- WorkArena-L1은 단위 과제(atomic tasks) 33개에서 고유 사례(unique instances) 19,912개를 포함하고, WorkArena++는 여러 단계를 조합한 과제(compositional tasks) 682개를 포함한다. <sup>[🔗](#source-1)</sup>
- 태그 감사(tag audit) Source는 합성 스캔(synthetic scan)과 시나리오 모의 실행(scenario simulation)이 이미 시장에 있음을 보여준다. <sup>[🔗](#source-2)</sup>

## 작동 방식

추적에 특화된 벤치마크(tracking-specific benchmark)는 행동 성공, 기대 이벤트 정확성, 내보낸 전송 내용의 스키마, 요소 지문의 연속성, 증거 기록의 완전성을 따로 점수화해야 한다. 웹 에이전트가 결제 버튼(checkout button)을 누르는 데 성공했어도 분석 이벤트(analytics event)가 누락되면 추적 테스트는 실패다. 반대로 이벤트가 맞아도 엉뚱한 요소에서 발화하면 증거 품질은 낮다.

## 평가 기준

- 경로 성공률(path success rate): 에이전트가 목표한 화면 경로를 완료하는가.
- 이벤트 재현율(event recall): 기대한 이벤트가 빠짐없이 관측되는가.
- 이벤트 정밀도(event precision): 불필요하거나 중복된 이벤트가 없는가.
- 전송 내용 유효성(payload validity): 속성 타입과 필수 필드가 플랜과 맞는가.
- 요소 연속성(element continuity): 화면 변경 전후로 같은 의미의 요소를 이어서 찾는가.
- 재현성(reproducibility): 같은 빌드(build)에서 같은 결과가 재현되는가.

## 모순

벤치마크 과제 성공과 제품 가치가 같지 않다. 실제 고객 문제는 에이전트의 똑똑함보다, 안정적이고 설명 가능하며 반복 가능한 QA일 수 있다.

## 미결 질문

- `OQ-008`: 대표적인 화면 변경 데이터셋(dataset)과 평가 기준을 확정해야 한다.
- 어떤 브라우저 관찰 계층(browser observation layer)을 표준으로 삼을 것인가?
- `OQ-009`: 운영 환경에서 자동 순회가 만드는 합성(봇) 이벤트를 실사용 데이터에서 식별·격리하는 관행과 기준을 확인해야 한다.

## 제품 시사점

시제품(prototype)은 기존 벤치마크를 그대로 쓰지 말고, 통제된 시연용 앱(controlled demo app)과 실제 환경에 가까운 표본 앱(real-world sample app)을 섞어 추적에 특화된 라벨을 만든 뒤 평가해야 한다.

## 관련 문서

- [[element-event-evidence|요소-이벤트 증거 모델]] - tracking-specific label
- [[tracking-qa-workflow|트래킹 QA 운영 흐름]] - 배포 QA 활용 사례
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-web-agent-eval-benchmarks|자료 요약: Web Agent Evaluation Benchmarks]] - `SRC-20260721-web-agent-eval-benchmarks`
- <a id="source-2"></a>[[source-tag-audit-qa-tools|자료 요약: 태그 감사 및 자동 순회 QA 도구]] - `SRC-20260721-tag-audit-qa-tools`
