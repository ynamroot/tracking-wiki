---
title: "Wiki Audit 2026-07-21: Initial Ingest"
type: audit
status: open
created: 2026-07-21
scope: full
---

# Wiki Audit 2026-07-21: Initial Ingest

## Summary

- 검사 범위: accepted Source 8건, knowledge page 18건, index, log, open questions
- 구조 검사: 오류 없음
- 근거 품질: accepted Source 8건 모두 내부 secondary 보고서
- 즉시 수정: Source summary basename 충돌 제거, index 및 wikilink 정합성 검증
- 제품 결정 차단 요소: 구매자, 지불 의사, MVP outcome, 자율 순회 정확도 미검증

## Contradictions

| Severity | Pages | Sources | Finding | Action |
|---|---|---|---|---|
| Medium | `tracking-governance-platforms` | 거버넌스 Source 2건 | 제품 기능·가격·차단 범위의 세부 서술이 일부 다르다. | 최신 공식 문서를 primary Source로 등록해 claim 단위로 확인한다. |
| Medium | `automation-opportunity` | 태그 QA·오토캡처 Source | 자동 coverage 공백이 존재하지만 Trackingplan과 autocapture가 일부 영역을 이미 해결한다. | 차별화 표현을 절대적 부재가 아닌 결합 공백으로 유지한다. |
| Low | `schema-and-data-contracts` | schema Source | “수집 전 검증” 표현이 실제로는 이벤트 발생 후 pipeline 검증일 수 있다. | 검증 위치를 코드, ingestion, pipeline, warehouse로 구분한다. |

## Stale Claims

| Page | Claim | Last Source | Required Action |
|---|---|---|---|
| `tracking-governance-platforms` | 가격과 tier별 기능 | 2026-07-21 내부 보고서 | 제품 의사결정 직전에 공식 가격·문서를 다시 확인한다. |
| `behavioral-data-quality-landscape` | 경쟁 기능 부재 | 2026-07-21 공개자료 조사 | 신생 제품과 비공개 enterprise 기능을 추가 조사한다. |

## Missing Citations

| Page | Claim | Required Source |
|---|---|---|
| `behavioral-data-practitioners` | 경제적 구매자 후보 | 고객 인터뷰 또는 실제 구매 사례 |
| `automation-opportunity` | 자율 순회와 요소 지문이 운영 비용을 줄임 | prototype evaluation과 현업 UAT |
| `behavioral-data-quality-landscape` | 시장 진입점과 예산 규모 | 시장 보고서, 구매 데이터, 인터뷰 |

## Orphan Pages And Broken Links

없음. 모든 knowledge page는 `wiki/index.md`에 등록됐고 wikilink 검사에 통과했다.

## Research Gaps

| Priority | Question | Suggested Source Type |
|---|---|---|
| P0 | 경제적 구매자와 초기 champion은 누구인가? | 고객 인터뷰, 구매·도입 사례 |
| P0 | 첫 MVP outcome은 무엇인가? | 문제 인터뷰, 현재 workflow 관찰 |
| P0 | 요소 지문과 자율 순회의 정확도·안전성은 충분한가? | prototype evaluation dataset |
| P1 | 경쟁 기능과 가격 정보가 현재도 유효한가? | 공식 문서와 가격 페이지 |
| P1 | 고객의 현재 수동 비용과 파손 대응 시간은 얼마인가? | 인터뷰, incident 기록, 업무 시간 자료 |

## Changes Applied

- `wiki/sources` 파일에 `source-` 접두사를 적용해 entity basename 충돌을 제거했다.
- 구매자, MVP outcome, 기술 검증, primary Source 확장 항목을 `open-questions.md`에 유지했다.
- 의미가 바뀌는 기존 Wiki 주장은 수정하지 않았다.
