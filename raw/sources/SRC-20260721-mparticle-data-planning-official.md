---
id: SRC-20260721-mparticle-data-planning-official
title: "mParticle official docs: Data Plans, Data Planning API, and validation SDK"
status: accepted
source_type: documentation
original_url: "https://docs.mparticle.com/guides/platform-guide/data-planning/"
submitted_by: "Research Agent"
submitted_at: 2026-07-21
retrieved_at: 2026-07-21
issue_url: ""
language: en
publisher: "mParticle"
authors: []
published_at: ""
reliability: primary
content_file: ""
content_sha256: ""
supersedes: []
---

# mParticle official docs: Data Plans, Data Planning API, and validation SDK

## Submitter Note

Open questions require official confirmation of mParticle Data Planning limits, enforcement behavior, and developer workflow integration.

## Research Questions

- `OQ-006` 기존 Avo, Amplitude, Segment, GTM과 공존할지 일부를 대체할지 결정해야 한다.
- `OQ-007` 제품 방향을 지지하는 핵심 주장과 가격 정보를 공식 primary Source record로 확장해야 한다.

## Provenance

- 원문 확보 방법: mParticle 공식 documentation과 official GitHub repository를 웹에서 직접 조회.
- 주요 URL:
  - https://docs.mparticle.com/guides/platform-guide/data-planning/
  - https://docs.mparticle.com/developers/apis/dataplanning-api/
  - https://github.com/mParticle/data-planning-node
- 원문 보존 위치: URL과 retrieval date를 기록한다. 저작권상 원문 전체를 로컬 복제하지 않는다.
- 원문과 record의 차이: record는 조사 질문에 필요한 claim 단위 요약만 포함한다.

## Triage

- 판정: accepted
- 판정자: LLM auto-triage policy-v1
- 판정일: 2026-07-21
- 사유: 공식 제품 문서와 official GitHub repository이며 provenance를 URL과 retrieval date로 재현할 수 있고, Data Plan 경쟁 범위와 직접 관련된다. 기존 secondary report와 exact duplicate가 아니다.

## Extracted Content

- mParticle Data Plan은 수집 데이터의 extent와 shape에 대한 codified expectations로 설명된다.
- 공식 문서 기준 data plan은 최대 1,000 data points를 지원한다.
- 400개 초과 data point는 UI 관리가 어려울 수 있어 Data Plan Builder 또는 Data Planning API 사용을 권장한다.
- 공식 문서 기준 block 가능한 data는 unplanned violations, 즉 data plan schema와 이름이 다른 events 또는 attributes로 제한된다.
- Data Planning API는 Data Plans CRUD, source-controlled data model, compile-time and runtime data quality verification 통합을 사용 사례로 제시한다.
- official Node SDK repository는 Data Plan/Version fetch와 event/batch validation before arrival을 목적으로 설명한다.
- 이 Source만으로는 mParticle의 공개 정액 가격이나 고객별 지불 의사를 확정할 수 없다.

## Revision Notes

- 2026-07-21: Research Agent가 공식 primary source 보강용으로 최초 생성하고 Intake Agent가 자동 triage 정책으로 accepted 처리.
