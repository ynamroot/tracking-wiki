---
title: "Source Summary: Web Agent Evaluation Benchmarks"
type: source-summary
status: current
confidence: high
created: 2026-07-22
updated: 2026-07-22
sources:
  - SRC-20260721-web-agent-eval-benchmarks
---

# Source Summary: Web Agent Evaluation Benchmarks

## Current Synthesis

Mind2Web, WebArena, VisualWebArena, WorkArena는 자율 웹 순회와 browser task 수행 능력을 평가하는 primary benchmark다. 프로젝트의 자율 순회 평가에 유용하지만, 행동데이터 계측 누락 탐지와 요소 지문 continuity를 직접 측정하지는 않는다. <sup>[🔗](#source-1)</sup>

## Evidence

- Mind2Web는 2,350 tasks, 137 websites, 31 domains를 포함하는 web generalist agent 평가 dataset이다. <sup>[🔗](#source-1)</sup>
- WebArena는 autonomous agents를 위한 standalone, self-hostable web environment와 tasks/evaluation scripts를 제공한다. <sup>[🔗](#source-1)</sup>
- VisualWebArena는 multimodal autonomous language agents를 realistic visual web tasks로 평가한다. <sup>[🔗](#source-1)</sup>
- WorkArena는 ServiceNow platform 기반 browser tasks로 knowledge worker workflow 자동화 능력을 평가한다. <sup>[🔗](#source-1)</sup>
- WorkArena-L1은 33 atomic tasks에서 19,912 unique instances를 포함하고, WorkArena++는 682 compositional tasks를 포함한다. <sup>[🔗](#source-1)</sup>

## Mechanics

이 benchmark들은 agent가 instruction을 이해하고 web UI에서 action sequence를 수행하는지 평가한다. 일부는 hosted/synthetic environment를 제공하고, 일부는 real website interaction trace를 포함한다. 그러나 tracking verification 제품에는 expected analytics event, element fingerprint, DOM/build diff, emitted payload validation이라는 별도 label이 필요하다.

## Evaluation Criteria

- task realism: 실제 SaaS/e-commerce workflow와 얼마나 가까운가.
- environment control: self-hosted replay와 deterministic evaluation이 가능한가.
- observation modality: DOM, screenshot, accessibility tree, network events를 사용할 수 있는가.
- tracking-specific labels: expected event/payload/fingerprint label을 붙일 수 있는가.

## Contradictions

benchmark task success와 analytics tracking correctness는 다른 metric이다. web-agent SOTA가 높아도 계측 검증 제품의 정확도를 보장하지 않는다.

## Open Questions

- 어떤 benchmark를 seed로 삼아 tracking-specific dataset을 만들 것인가?
- action success, event correctness, element continuity를 하나의 score로 묶을 수 있는가?

## Product Implications

prototype evaluation은 기존 benchmark를 그대로 쓰기보다, controlled app 변화 전후의 action trace, expected event, emitted payload, element fingerprint match를 함께 기록하는 프로젝트 전용 dataset으로 설계해야 한다.

## See Also

- [[autonomous-traversal-evaluation|자율 순회 평가 기준]] - 제품 평가 dataset 설계
- [[element-event-evidence|요소-이벤트 증거 모델]] - tracking-specific label

## 출처

- <a id="source-1"></a>[[source-web-agent-eval-benchmarks|Primary web agent evaluation benchmarks: Mind2Web, WebArena, VisualWebArena, WorkArena]] - `SRC-20260721-web-agent-eval-benchmarks`
