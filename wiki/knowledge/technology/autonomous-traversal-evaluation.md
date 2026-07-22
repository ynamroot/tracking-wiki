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

## Current Synthesis

자율 순회 평가는 web-agent task success와 tracking correctness를 분리해야 한다. Mind2Web, WebArena, VisualWebArena, WorkArena는 agent가 web task를 수행하는지 평가하는 primary benchmark지만, 행동데이터 계측 누락 탐지와 요소 지문 continuity는 프로젝트 전용 label이 필요하다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup>

## Evidence

- Mind2Web는 2,350 tasks, 137 websites, 31 domains를 포함한다. <sup>[🔗](#source-1)</sup>
- WebArena는 standalone, self-hostable web environment와 tasks/evaluation scripts를 제공한다. <sup>[🔗](#source-1)</sup>
- VisualWebArena는 multimodal autonomous language agents를 realistic visual web tasks로 평가한다. <sup>[🔗](#source-1)</sup>
- WorkArena-L1은 33 atomic tasks에서 19,912 unique instances를 포함하고, WorkArena++는 682 compositional tasks를 포함한다. <sup>[🔗](#source-1)</sup>
- tag audit Source는 synthetic scan과 scenario simulation이 이미 시장에 있음을 보여준다. <sup>[🔗](#source-2)</sup>

## Mechanics

tracking-specific benchmark는 action success, expected event correctness, emitted payload schema, element fingerprint continuity, proof artifact completeness를 따로 점수화해야 한다. web-agent가 checkout button을 누르는 데 성공했어도 analytics event가 누락되면 tracking test는 실패다. 반대로 event가 맞아도 wrong element에서 발화하면 evidence quality는 낮다.

## Evaluation Criteria

- path success rate: agent가 목표 UI path를 완료하는가.
- event recall: expected event가 빠짐없이 관측되는가.
- event precision: 불필요하거나 중복된 event가 없는가.
- payload validity: property type/required field가 plan과 맞는가.
- element continuity: UI 변경 전후 같은 의미의 요소를 매칭하는가.
- reproducibility: 같은 build에서 같은 결과가 재현되는가.

## Contradictions

benchmark task success와 제품 가치가 동일하지 않다. 실제 고객 문제는 agent intelligence보다 stable, explainable, repeatable QA일 수 있다.

## Open Questions

- `OQ-008`: 대표 UI 변경 dataset과 평가 기준을 확정해야 한다.
- 어떤 browser observation layer를 표준으로 삼을 것인가?

## Product Implications

prototype은 기존 benchmark를 그대로 채택하지 말고, controlled demo app과 real-world sample app을 섞어 tracking-specific labels를 만든 뒤 평가해야 한다.

## See Also

- [[element-event-evidence|요소-이벤트 증거 모델]] - tracking-specific label
- [[tracking-qa-workflow|트래킹 QA 운영 workflow]] - release QA use case

## 출처

- <a id="source-1"></a>[[source-web-agent-eval-benchmarks|Source Summary: Web Agent Evaluation Benchmarks]] - `SRC-20260721-web-agent-eval-benchmarks`
- <a id="source-2"></a>[[source-tag-audit-qa-tools|Source Summary: 태그 감사 및 자동 순회 QA 도구]] - `SRC-20260721-tag-audit-qa-tools`
