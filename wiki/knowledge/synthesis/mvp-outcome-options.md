---
title: MVP outcome 선택지
type: synthesis
status: current
confidence: low
created: 2026-07-22
updated: 2026-07-22
sources:
  - SRC-20260721-practitioner-pain-points
  - SRC-20260721-tag-audit-qa-tools
  - SRC-20260721-web-agent-eval-benchmarks
  - SRC-20260721-tracking-governance-remaining-tools
---

# MVP outcome 선택지

## Current Synthesis

MVP 후보는 세 가지다: 배포 전 회귀 검증, 운영 파손 경보, 자동 계측 제안. 현재 Source 기준으로 가장 방어적인 순서는 배포 전 회귀 검증, 운영 파손 경보, 자동 계측 제안이다. 자동 계측 제안은 매력적이지만 정확도·안전성 근거가 가장 부족하다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup> <sup>[🔗](#source-3)</sup> <sup>[🔗](#source-4)</sup>

## Evidence

- 실무 pain은 수동 QA와 늦은 파손 발견을 반복 문제로 제시한다. <sup>[🔗](#source-1)</sup>
- tag audit 도구는 운영 감시와 scan이 이미 경쟁군임을 보여준다. <sup>[🔗](#source-2)</sup>
- web-agent benchmark는 traversal automation의 seed를 제공하지만 tracking-specific evaluation은 별도 설계가 필요하다. <sup>[🔗](#source-3)</sup>
- 인접 도구 Source는 배포 전 검증과 요소-이벤트 증빙을 공백으로 제시한다. <sup>[🔗](#source-4)</sup>

## Mechanics

배포 전 회귀 검증은 PR/build에서 changed route를 돌고 expected event proof를 만든다. 운영 파손 경보는 production traffic baseline과 anomaly를 감지한다. 자동 계측 제안은 UI 요소와 business intent를 추론해 새 event 또는 code insertion을 제안한다. 세 단계는 maturity ladder로 볼 수 있다.

## Evaluation Criteria

| 후보 | 강점 | 위험 |
|---|---|---|
| 배포 전 회귀 검증 | proof-first, release workflow에 명확 | traversal coverage와 expected event set 필요 |
| 운영 파손 경보 | 실제 traffic 기반 | 이미 사고 후이며 기존 tag audit과 겹침 |
| 자동 계측 제안 | value가 큼 | false positive, privacy, 승인 경계 위험 |

## Contradictions

고객에 따라 운영 경보가 더 급할 수 있다. Source만으로 MVP를 확정하면 안 되고 인터뷰로 release pain과 incident pain을 비교해야 한다.

## Open Questions

- `OQ-002`: 첫 MVP outcome은 무엇인가?
- `OQ-003`: value proposition 검증 기준은 무엇인가?

## Product Implications

우선순위 제안은 `배포 전 회귀 검증 -> 운영 경보 -> 자동 계측 제안`이다. 자동 계측은 proof와 approval loop가 검증된 뒤 확장해야 한다.

## See Also

- [[automation-opportunity|행동데이터 자동화 기회]] - 전체 기회
- [[tracking-qa-workflow|트래킹 QA 운영 workflow]] - release use case

## 출처

- <a id="source-1"></a>[[source-practitioner-pain-points|Source Summary: 행동데이터 운영 실무자 페인포인트]] - `SRC-20260721-practitioner-pain-points`
- <a id="source-2"></a>[[source-tag-audit-qa-tools|Source Summary: 태그 감사 및 자동 순회 QA 도구]] - `SRC-20260721-tag-audit-qa-tools`
- <a id="source-3"></a>[[source-web-agent-eval-benchmarks|Source Summary: Web Agent Evaluation Benchmarks]] - `SRC-20260721-web-agent-eval-benchmarks`
- <a id="source-4"></a>[[source-tracking-governance-remaining-tools|Source Summary: 트래킹 거버넌스 및 인접 도구]] - `SRC-20260721-tracking-governance-remaining-tools`
