---
title: 프로젝트 지식 개요
type: overview
status: current
confidence: medium
created: 2026-07-21
updated: 2026-07-21
sources:
  - SRC-20260721-practitioner-pain-points
  - SRC-20260721-amplitude-data-ampli
  - SRC-20260721-avo
  - SRC-20260721-autocapture-tag-managers
  - SRC-20260721-tag-audit-qa-tools
  - SRC-20260721-tracking-governance-four-tools
  - SRC-20260721-tracking-governance-remaining-tools
  - SRC-20260721-schema-data-contracts
---

# 프로젝트 지식 개요

## Current Synthesis

행동데이터 운영의 반복 문제는 늦은 파손 발견, tracking plan과 실제 구현의 drift, 수동 QA, 불명확한 ownership, 데이터 신뢰 상실이다. 기존 시장은 plan·codegen, ingestion schema 검증, tag audit, autocapture, warehouse observability로 분절돼 있다. 조사 범위에서 가장 일관된 공백은 UI 요소와 실제 이벤트 발생의 인과 증빙, 자동 coverage 확장, 개편 후 이력 계승, 승인 기반 수리 loop다.

## Evidence

- 역할별 페인포인트와 반복 빈도는 내부 조사 보고서가 여러 공개 자료를 종합했다. [SRC-20260721-practitioner-pain-points]
- Avo·Amplitude와 주요 CDP는 codegen과 schema 검증을 제공하지만 수동 호출 구현을 전제로 한다. [SRC-20260721-avo] [SRC-20260721-amplitude-data-ampli] [SRC-20260721-tracking-governance-four-tools]
- tag audit 도구는 crawl, scenario, 실트래픽 관측을 사용하지만 coverage·self-healing·수정 실행을 모두 자동화하지 않는다. [SRC-20260721-tag-audit-qa-tools]
- schema와 observability 계층은 UI 계층의 미계측 요소를 직접 볼 수 없다. [SRC-20260721-tracking-governance-remaining-tools] [SRC-20260721-schema-data-contracts]

## Contradictions

- 기존 도구에 기능이 없다는 주장은 공개 자료 기준이며 비공개 기능이나 최신 변경을 놓칠 수 있다.
- 가격, 사용자 불만, 일부 정량 수치는 제3자 집계와 벤더 자료가 섞여 있어 1차 출처 검증이 필요하다.
- 자동 순회와 self-healing이 실제 운영 비용을 낮춘다는 가설은 아직 검증되지 않았다.

## Open Questions

- 경제적 구매자와 초기 champion은 누구인가?
- 첫 MVP outcome은 배포 전 검증, 운영 경보, 자동 계측 제안 중 무엇인가?
- 요소 지문과 자율 순회의 정확도·안전성을 어떻게 검증할 것인가?
- 고객 인터뷰와 공식 원문 검증으로 어떤 가설을 먼저 반증해야 하는가?

## See Also

- [[open-questions|미결 질문]] - 조사와 의사결정에 필요한 질문 목록
- [[automation-opportunity|행동데이터 자동화 기회]] - 근거에서 도출한 제품 가설과 위험
- [[behavioral-data-quality-landscape|행동데이터 품질 시장 지형]] - 경쟁 계층과 공백
