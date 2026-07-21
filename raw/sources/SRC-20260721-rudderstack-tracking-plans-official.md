---
id: SRC-20260721-rudderstack-tracking-plans-official
title: "RudderStack official docs: Tracking Plans and pricing limits"
status: accepted
source_type: documentation
original_url: "https://www.rudderstack.com/docs/data-governance/tracking-plans/"
submitted_by: "Research Agent"
submitted_at: 2026-07-21
retrieved_at: 2026-07-21
issue_url: ""
language: en
publisher: "RudderStack"
authors: []
published_at: ""
reliability: primary
content_file: ""
content_sha256: ""
supersedes: []
---

# RudderStack official docs: Tracking Plans and pricing limits

## Submitter Note

Open questions require official confirmation of RudderStack tracking plan capabilities, pricing limits, and violation handling.

## Research Questions

- `OQ-006` 기존 Avo, Amplitude, Segment, GTM과 공존할지 일부를 대체할지 결정해야 한다.
- `OQ-007` 제품 방향을 지지하는 핵심 주장과 가격 정보를 공식 primary Source record로 확장해야 한다.

## Provenance

- 원문 확보 방법: RudderStack 공식 documentation과 pricing page를 웹에서 직접 조회.
- 주요 URL:
  - https://www.rudderstack.com/docs/data-governance/tracking-plans/
  - https://www.rudderstack.com/pricing/
- 원문 보존 위치: URL과 retrieval date를 기록한다. 저작권상 원문 전체를 로컬 복제하지 않는다.
- 원문과 record의 차이: record는 조사 질문에 필요한 claim 단위 요약만 포함한다.

## Triage

- 판정: accepted
- 판정자: LLM auto-triage policy-v1
- 판정일: 2026-07-21
- 사유: 공식 제품 문서와 가격 페이지이며 provenance를 URL과 retrieval date로 재현할 수 있고, RudderStack tracking plan 경쟁 범위와 직접 관련된다. 기존 secondary report와 exact duplicate가 아니다.

## Extracted Content

- RudderStack Tracking Plans는 predefined plans 기반으로 incoming event data의 non-compliance를 monitor하고 act on하는 기능이다.
- 기능은 `track`, `identify`, `page`, `screen`, `group` event rules, required property/attribute, data type 정의를 포함한다.
- Event Audit API는 inbound events와 metadata를 tracking plans와 비교하는 기능으로 설명된다.
- Tracking Plans는 dashboard 또는 Data Catalog API로 생성/관리할 수 있고 versioning system을 제공한다.
- 공식 FAQ 기준 tracking plan feature는 Free, Growth, Enterprise plans에서 지원된다.
- 공식 FAQ 기준 plan limit은 Free 1 plan/5 events per plan, Growth unlimited plans/75 events per plan, Enterprise unlimited plans/unlimited events per plan이다.
- Pricing page 기준 violation management는 Free에서 Drop Events, Growth/Enterprise에서 Configurable로 표시된다.
- alias call은 tracking plan supported event에 포함되지 않는다.

## Revision Notes

- 2026-07-21: Research Agent가 공식 primary source 보강용으로 최초 생성하고 Intake Agent가 자동 triage 정책으로 accepted 처리.
