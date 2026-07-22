---
title: "트래킹 거버넌스 플랫폼"
type: comparison
status: current
confidence: medium
created: 2026-07-21
updated: 2026-07-22
sources:
  - SRC-20260721-amplitude-data-ampli
  - SRC-20260721-avo
  - SRC-20260721-tracking-governance-four-tools
  - SRC-20260721-tracking-governance-remaining-tools
---

# 트래킹 거버넌스 플랫폼

## Current Synthesis

주요 거버넌스 플랫폼은 plan authoring, codegen, CI, ingestion validation, catalog 중 일부를 조합한다. 검증 위치와 위반 처리 철학은 다르지만 사람이 무엇을 계측할지 정하고 호출을 구현한다는 전제는 공통이다.

## Evidence

| 제품 | 설계·코드 | 검증 위치 | 위반 처리 | UI 인과 증빙 |
|---|---|---|---|---|
| Avo | Plan, branch, Codegen | compile, CI, runtime schema | issue 표시 | 설계 Journey만 부분 지원 |
| Amplitude Data | Plan, Ampli | compile, CI, ingestion Observe | 경고, 변환, 차단 | 별도 Visual Labeling |
| Segment Protocols | Plan, Typewriter | client, ingestion | allow, block, omit, transform | 없음 |
| RudderStack | Plan, RudderTyper | compile, PR, ingestion | propagate, drop, reroute | 없음 |
| mParticle | Data Plan, Smartype | compile, ingestion | allow, block, quarantine | 없음 |
| Mixpanel Lexicon | Catalog 중심 | 주로 사후 | hide, manual block, review | autocapture 맥락만 부분 지원 |
| Snowplow | Schema, Snowtype | enrich pipeline | failed event 격리 및 replay | 수동 screenshot attachment |

표는 네 accepted Source의 교차 종합이다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup> <sup>[🔗](#source-3)</sup> <sup>[🔗](#source-4)</sup>

## Contradictions

- 같은 제품의 차단 범위와 가격이 두 거버넌스 Source에서 다르게 상세화돼 최신 공식 문서 검증이 필요하다.
- codegen이 “미구현 이벤트”를 탐지하는 범위는 제품과 언어에 따라 다르다.

## Open Questions

- 초기 고객이 이미 사용하는 tracking plan 또는 CDP는 무엇인가?
- 기존 platform 연동과 독립 plan authoring 중 어느 진입 전략이 빠른가?
- violation을 자동 수정할 때 고객이 허용하는 승인 경계는 어디인가?

## Product Implications

경쟁 기준을 schema 기능 수로 잡으면 대형 플랫폼과 겹친다. UI에서 실제 발생까지의 provenance와 수리 loop를 독립 가치로 증명해야 한다.

## See Also

- [[avo|Avo]] - 설계와 codegen 중심 경쟁사
- [[amplitude-data|Amplitude Data]] - 분석 생태계 통합 경쟁사
- [[schema-and-data-contracts|스키마 및 데이터 계약]] - 검증 인프라 계층
- [[automation-opportunity|행동데이터 자동화 기회]] - 제품 차별화 가설

## 출처

- <a id="source-1"></a>[[source-amplitude-data-ampli|Source Summary: Amplitude Data 및 Ampli SDK]] - `SRC-20260721-amplitude-data-ampli`
- <a id="source-2"></a>[[source-avo|Source Summary: Avo]] - `SRC-20260721-avo`
- <a id="source-3"></a>[[source-tracking-governance-four-tools|Source Summary: 트래킹 거버넌스 도구 4종]] - `SRC-20260721-tracking-governance-four-tools`
- <a id="source-4"></a>[[source-tracking-governance-remaining-tools|Source Summary: 트래킹 거버넌스 및 인접 도구]] - `SRC-20260721-tracking-governance-remaining-tools`
