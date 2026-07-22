---
title: 트래킹 QA 운영 workflow
type: customer
status: current
confidence: medium
created: 2026-07-22
updated: 2026-07-22
sources:
  - SRC-20260721-practitioner-pain-points
  - SRC-20260721-tag-audit-qa-tools
  - SRC-20260721-autocapture-tag-managers
---

# 트래킹 QA 운영 workflow

## Current Synthesis

트래킹 QA는 release 전 수동 검증과 release 후 운영 감시로 나뉜다. 기존 도구는 debug view, tag scan, scenario test, traffic monitoring을 제공하지만, 변경된 UI 요소와 expected event를 자동으로 연결해 “이 release에서 무엇을 다시 검증해야 하는지”를 좁히는 능력은 약하다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup> <sup>[🔗](#source-3)</sup>

## Evidence

- 내부 pain Source는 수동 QA, 늦은 파손 발견, role handoff를 반복 문제로 본다. <sup>[🔗](#source-1)</sup>
- tag audit Source는 crawl, scenario simulation, realtime/passive monitoring 방식이 각각 coverage와 timeliness trade-off를 가진다고 요약한다. <sup>[🔗](#source-2)</sup>
- tag manager Source는 preview/debug가 사람이 직접 돌리는 session 기반 검증이며 production 상시 검증이 아니라는 한계를 지적한다. <sup>[🔗](#source-3)</sup>

## Mechanics

운영 workflow는 `계획 수립 -> 구현 -> 릴리즈 전 smoke test -> 배포 -> 실트래픽 관측 -> incident triage -> plan/config/code 수정 -> 재검증`으로 반복된다. 제품이 개입할 수 있는 지점은 네 가지다: 변경된 UI path 탐지, expected event 생성, synthetic traversal 실행, runtime traffic drift 감지.

## Evaluation Criteria

- release blocking 가능성: 배포 전 실패를 confidence 있게 말할 수 있는가.
- false positive cost: QA/개발자를 불필요하게 호출하지 않는가.
- coverage explanation: 검증하지 못한 path와 consent/auth/region 조건을 명시하는가.
- proof artifact: screenshot, DOM locator, network payload, destination evidence가 남는가.

## Contradictions

passive monitoring은 실제 사용자 데이터를 보지만 배포 후 신호이고, synthetic QA는 배포 전 검증이 가능하지만 사람이 scenario를 정의해야 한다. MVP 방향 선택이 필요하다.

## Open Questions

- `OQ-002`: 첫 MVP outcome은 배포 전 회귀 검증인가, 운영 파손 경보인가?
- `OQ-008`: representative UI 변경 dataset이 필요하다.

## Product Implications

초기 제품은 “모든 태그를 감시”보다 “변경된 UI path에서 기대 이벤트가 여전히 발화하는지 증거로 보여주는 release QA”로 좁히면 value proof가 선명하다.

## See Also

- [[mvp-outcome-options|MVP outcome 선택지]] - 배포 전/운영 후 선택
- [[autonomous-traversal-evaluation|자율 순회 평가 기준]] - traversal 검증

## 출처

- <a id="source-1"></a>[[source-practitioner-pain-points|Source Summary: 행동데이터 운영 실무자 페인포인트]] - `SRC-20260721-practitioner-pain-points`
- <a id="source-2"></a>[[source-tag-audit-qa-tools|Source Summary: 태그 감사 및 자동 순회 QA 도구]] - `SRC-20260721-tag-audit-qa-tools`
- <a id="source-3"></a>[[source-autocapture-tag-managers|Source Summary: 오토캡처와 태그매니저]] - `SRC-20260721-autocapture-tag-managers`
