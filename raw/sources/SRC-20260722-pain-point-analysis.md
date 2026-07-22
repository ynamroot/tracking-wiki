---
id: SRC-20260722-pain-point-analysis
title: "행동데이터 생애주기 — 역할별 페인포인트 분석"
status: accepted
source_type: report
original_url: ""
submitted_by: "PO"
submitted_at: 2026-07-22
retrieved_at: 2026-07-22
issue_url: ""
language: ko
publisher: "2607_tracking-plan internal research"
authors: []
published_at: "2026-07-21"
reliability: secondary
content_file: "raw/assets/SRC-20260722-pain-point-analysis.md"
content_sha256: "853d884706488c3f06235af59ee5ac6cb11a5cf7640d9dc8241274846fec1767"
supersedes: []
---

# 행동데이터 생애주기 — 역할별 페인포인트 분석

## Submitter Note

기존 `2607_tracking-plan` 프로젝트에서 AI와 함께 정리한 조사 산출물이다. 트래킹 플랜 자동화 도구 PRD의 문제 정의를 뒷받침하기 위해, 데이터매니저·기획자/PM·프론트엔드 개발자의 고통을 외부 1차 자료(실무 블로그·업계 리포트·도구사 조사, 출처 URL 표기)와 내부 실증(가치제안 문서)으로 교차 분석한 문서다.

## Research Questions

- `OQ-001` 경제적 구매자와 초기 champion은 데이터 운영자, PM, 개발자, QA 중 누구인가?
- `OQ-003` Value Proposition을 검증할 고객 인터뷰와 행동 증거의 최소 기준은 무엇인가?
- `OQ-004` 현재 수동 QA·파손 대응·계측 구현에 쓰는 시간과 비용은 얼마인가?

## Provenance

- 원문 확보 방법: 로컬 프로젝트의 Markdown 조사 문서를 직접 복사.
- 원본 위치: `C:/Users/NY/orca/projects/2607_tracking-plan/research/03-페인포인트-분석.md`
- 원문 보존 위치: `raw/assets/SRC-20260722-pain-point-analysis.md`
- 원문과 record의 차이: 원문은 byte-for-byte 복사했으며 이 record는 provenance만 추가한다.
- 인용된 외부 자료: 이 분석은 Trackingplan, RudderStack 창업자(LinkedIn), House of Martech, incident.io, 원티드랩 기술블로그, Mixpanel 블로그(HBR·Forrester 재인용), The Analytics Tax(Medium), 브런치·티스토리·변성윤 블로그 등 외부 URL을 claim 단위로 인용한다. 이 record와 Wiki는 해당 URL과 인용을 그대로 재현하지 않고, 이 secondary 보고서가 그것을 인용했다는 사실만 추적한다. 원문 검증은 별도 primary 확보가 필요하다.
- AI 보조 산출물 주의: 이 문서는 "기존 문서를 AI와 함께 리포팅한" 자료다. 따라서 인용된 외부 출처와 인용문이 실제로 존재하고 표현대로인지는 이번 intake에서 확인하지 않았다. Wiki가 이 자료를 "문제 일반성의 보강"으로 쓸 때는 이 한계를 전제로 하며, 확정 근거로 승격하려면 대표 출처(예: Trackingplan 블로그) 최소 1건을 primary로 재확보해야 한다.

## Triage

- 판정: accepted
- 판정자: LLM auto-triage policy-v1
- 판정일: 2026-07-22
- 사유: 원본과 hash가 보존됐고 조사 범위(고객 문제 정의)와 직접 관련된 내부 분석 보고서다. 기존 `SRC-20260721-practitioner-pain-points`(같은 프로젝트의 raw 페인포인트 조사)의 파생 분석으로, 외부 출처 URL과 내부 실증을 새로 연결하므로 exact duplicate가 아니다.

## Extracted Content

원문 전체는 `content_file`을 참조한다. 가장 자주 확인된 고통 톱5는 ① 태그 파손을 대시보드 이상으로 뒤늦게 발견, ② 명명 규칙 난립과 문서-실제 괴리, ③ 계측 리드타임, ④ 수동 QA·스프레드시트 수작업, ⑤ 데이터 신뢰 상실이다. 저자는 이 다섯을 독립 문제가 아니라 하나의 사슬(수작업 의존 → 커버리지·품질 제한 → 파손 방치 → 신뢰 상실)로 본다.

## Revision Notes

- 2026-07-22: 최초 intake.
