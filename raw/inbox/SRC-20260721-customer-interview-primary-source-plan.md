---
id: SRC-20260721-customer-interview-primary-source-plan
title: "Customer interview primary-source intake plan"
status: needs-verification
source_type: issue
original_url: ""
submitted_by: "Research Agent"
submitted_at: 2026-07-21
retrieved_at: 2026-07-21
issue_url: ""
language: ko
publisher: "tracking-wiki internal research"
authors: []
published_at: "2026-07-21"
reliability: unreviewed
content_file: ""
content_sha256: ""
supersedes: []
---

# Customer interview primary-source intake plan

## Submitter Note

고객 인터뷰는 실제 녹취, 메모, 동의 범위, 익명화 기준이 있어야 primary Source로 승격할 수 있다. 현재는 실제 고객 인터뷰 원문이 없으므로 `needs-verification` 상태로 보존한다.

## Research Questions

- `OQ-001` 경제적 구매자와 초기 champion은 데이터 운영자, analytics engineer, PM, QA 중 누구인가?
- `OQ-002` 첫 MVP outcome은 배포 전 회귀 검증, 운영 파손 경보, 자동 계측 제안 중 무엇인가?
- `OQ-003` Value Proposition을 검증할 고객 인터뷰와 행동 증거의 최소 기준은 무엇인가?
- `OQ-004` 현재 수동 QA·파손 대응·계측 구현에 쓰는 시간과 비용은 얼마인가?

## Provenance

- 원문 확보 방법: 아직 없음. 인터뷰 수행 후 녹취록, 요약 메모, 동의 범위, 인터뷰 일시, 참가자 역할, 익명화 ID를 별도 Source record로 추가해야 한다.
- 원문 보존 위치: 아직 없음.
- 원문과 record의 차이: 이 파일은 증거 Source가 아니라 인터뷰 Source intake 준비 항목이다.

## Triage

- 판정: needs-verification
- 판정자: LLM auto-triage policy-v1
- 판정일: 2026-07-21
- 사유: 조사 범위와 직접 관련되지만 실제 원문과 provenance가 없으므로 accepted Source로 승격할 수 없다.

## Extracted Content

인터뷰가 수행되기 전에는 외부 사실로 인용하지 않는다.

최소 수집 기준:

- 참가자 역할: economic buyer, budget owner, data/analytics owner, PM, engineer, QA 중 해당 항목.
- 조직 맥락: 제품 유형, event volume 대략 범위, analytics/CDP/tool stack, release cadence.
- 현재 workflow: tracking plan 작성자, 구현자, reviewer, QA 담당자, incident 대응자.
- 정량 증거: 최근 3개월 기준 계측 QA 시간, 파손 발견 지연, incident 수, 재작업 시간, downstream 영향.
- 구매 증거: 기존 도구 지출, 구매 승인자, 예산 출처, 대체재 평가 경험.
- MVP outcome 선호: 배포 전 회귀 검증, 운영 파손 경보, 자동 계측 제안 중 실제로 비용을 줄일 가능성이 높은 항목.
- 증거 보존: 원문 녹취 또는 인터뷰 메모, 참가자 동의 범위, 익명화 방식.

## Revision Notes

- 2026-07-21: Research Agent가 customer interview primary-source 수집 전제와 최소 intake 기준을 기록.
- 2026-07-23: 잠재 고객 인터뷰 2건(`SRC-20260723-prospect-interview-marketing-stack-review`, `SRC-20260722-prospect-interview-behavior-data-fusion`)이 이 계획에서 예고한 대로 처음 도착했다. 다만 이번 인터뷰는 이 문서가 요구한 동의 범위 문서화 없이 PO 판단으로 ingest됐고, 원문이 AI 자동 회의록이라 `reliability: secondary`로만 승격했다. 이 계획이 전제한 "동의 범위, 익명화 기준"은 여전히 정비되지 않은 채로 남아 있다(`wiki/open-questions.md`의 "다음 Research Loop" 참고).
