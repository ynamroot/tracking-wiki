---
title: 미결 질문
description: 아직 해결되지 않은 조사 질문, Source 간 모순, 제품 판단 대기 항목
---

# 미결 질문

해결되지 않은 조사 질문, Source 간 모순, 제품 판단 대기 항목을 관리한다.

## 운영 원칙

- 이 페이지가 Open Question의 단일 기준이다.
- 각 지식 문서의 `Open Questions` 절은 이 페이지의 `OQ-NNN`을 참조하는 지역 목록이다.
- 자동 동기화는 없다. 질문이 추가, 부분 해소, 해소될 때 Agent가 이 페이지와 관련 문서, `wiki/log.md`를 같은 변경에서 갱신한다.
- 상태 표기는 `[ ]` 열림, `[~]` 부분 해소, `[x]` 해소를 사용한다.
- 해소된 질문도 삭제하지 않고 근거 Source, 반영 문서, 해소일을 남긴다.

## 조사 범위

- [ ] `OQ-001` 경제적 구매자와 초기 champion은 데이터 운영자, analytics engineer, PM, QA 중 누구인가?
- [ ] `OQ-002` 첫 MVP outcome은 배포 전 회귀 검증, 운영 파손 경보, 자동 계측 제안 중 무엇인가?
- [ ] `OQ-003` Value Proposition을 검증할 고객 인터뷰와 행동 증거의 최소 기준은 무엇인가?
- [ ] `OQ-004` 현재 수동 QA·파손 대응·계측 구현에 쓰는 시간과 비용은 얼마인가?
- [ ] `OQ-005` 요소 지문과 자율 순회가 실제 제품 개편에서 달성해야 할 정확도와 안전 기준은 무엇인가?
- [ ] `OQ-006` 기존 Avo, Amplitude, Segment, GTM과 공존할지 일부를 대체할지 결정해야 한다.
- [~] `OQ-007` 제품 방향을 지지하는 핵심 주장과 가격 정보를 공식 primary Source record로 확장해야 한다. 2026-07-22 기준 Avo, Amplitude, Segment, mParticle, RudderStack, Snowplow/dbt, web-agent benchmark는 primary Source가 추가됐지만 최신성 재확인과 고객 구매 증거는 남아 있다.
- [ ] `OQ-008` 자율 순회와 요소 지문 가설을 검증할 대표 UI 변경 dataset과 평가 기준은 무엇인가?

## Source Contradictions

- 거버넌스 도구의 기능·가격·차단 범위는 2026-07-22 재-ingest에서 공식 Source로 일부 보정했다. 다만 vendor 가격·tier는 수시로 바뀌므로 제품 의사결정 직전 재확인이 필요하다.
- 경쟁 기능 부재 주장은 공개 자료에 기반하므로 신생 및 비공개 기능 조사가 필요하다.
- 벤더 블로그가 인용한 정량 데이터는 원 조사까지 provenance를 확장해야 한다.
- web-agent benchmark는 자율 순회 task success를 평가하지만 tracking-specific event correctness와 element continuity를 직접 평가하지 않는다.

## Product Decisions Pending

- `PD 제안` 초기 ICP와 구매자
- `PD 제안` MVP의 단일 핵심 outcome
- `PD 제안` 기존 tracking plan·tag manager와의 통합 경계
- `PD 제안` 자동 수정 없이 증빙 중심으로 시작할지 여부

## 다음 Research Loop

- 고객 인터뷰: `buyer-and-champion`, `tracking-qa-workflow`, `mvp-outcome-options`의 low-confidence claim을 검증한다.
- Prototype evaluation: `autonomous-traversal-evaluation`의 기준으로 controlled UI-change dataset을 만든다.
- 공식 문서 재확인: 가격·tier·feature gate는 제품 결정 직전 다시 확인한다.

## 해소 기록

- 2026-07-22: `OQ-007`은 부분 해소로 전환했다. 공식 Source가 추가되고 `pricing-and-packaging`, `tracking-governance-platforms`, `research-confidence-map`에 반영됐지만 고객 구매 증거와 최신성 재확인은 남아 있다.
