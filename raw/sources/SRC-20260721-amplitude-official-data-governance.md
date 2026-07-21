---
id: SRC-20260721-amplitude-official-data-governance
title: "Amplitude official docs: tracking plan, Ampli SDK, and pricing"
status: accepted
source_type: documentation
original_url: "https://amplitude.com/docs/data/create-tracking-plan"
submitted_by: "Research Agent"
submitted_at: 2026-07-21
retrieved_at: 2026-07-21
issue_url: ""
language: en
publisher: "Amplitude"
authors: []
published_at: ""
reliability: primary
content_file: ""
content_sha256: ""
supersedes: []
---

# Amplitude official docs: tracking plan, Ampli SDK, and pricing

## Submitter Note

Open questions require official confirmation of Amplitude Data, Ampli SDK, governance boundaries, and pricing claims.

## Research Questions

- `OQ-006` 기존 Avo, Amplitude, Segment, GTM과 공존할지 일부를 대체할지 결정해야 한다.
- `OQ-007` 제품 방향을 지지하는 핵심 주장과 가격 정보를 공식 primary Source record로 확장해야 한다.

## Provenance

- 원문 확보 방법: Amplitude 공식 문서와 가격 페이지를 웹에서 직접 조회.
- 주요 URL:
  - https://amplitude.com/docs/data/create-tracking-plan
  - https://amplitude.com/docs/sdks/ampli
  - https://amplitude.com/pricing
- 원문 보존 위치: URL과 retrieval date를 기록한다. 저작권상 원문 전체를 로컬 복제하지 않는다.
- 원문과 record의 차이: record는 조사 질문에 필요한 claim 단위 요약만 포함한다.

## Triage

- 판정: accepted
- 판정자: LLM auto-triage policy-v1
- 판정일: 2026-07-21
- 사유: 공식 제품 문서와 가격 페이지이며 provenance를 URL과 retrieval date로 재현할 수 있고, Amplitude Data/Ampli 경쟁 범위와 직접 관련된다. 기존 secondary report와 exact duplicate가 아니다.

## Extracted Content

- Amplitude의 tracking plan은 수집할 event/property, 수집 이유, emitting source를 정의하는 명세다.
- Amplitude 문서는 tracking plan을 instrumentation 전에 만들고 analyst, PM, engineer가 같은 schema에서 협업하는 흐름으로 설명한다.
- Amplitude Data의 plan 변경은 instrumentation, governance, Ampli code generator와 연결된다.
- Ampli는 Amplitude Data tracking plan과 SDK source를 필요로 하며, Ampli CLI가 schema 정보를 사용해 project 안의 Ampli Wrapper를 generate/verify한다.
- Pricing page 기준 Free plan은 2 million events/month를 포함하며, no credit card/no time limit로 설명된다.
- Growth와 Enterprise는 volume과 feature requirements 기반 custom-priced로 설명된다.
- 이 Source만으로는 고객별 경제적 구매자나 실제 지불 의사를 확정할 수 없다.

## Revision Notes

- 2026-07-21: Research Agent가 공식 primary source 보강용으로 최초 생성하고 Intake Agent가 자동 triage 정책으로 accepted 처리.
