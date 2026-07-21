---
id: SRC-20260721-avo-official-data-design
title: "Avo official docs: tracking plan, pricing, and customer story index"
status: accepted
source_type: documentation
original_url: "https://www.avo.app/docs/data-design/avo-tracking-plan"
submitted_by: "Research Agent"
submitted_at: 2026-07-21
retrieved_at: 2026-07-21
issue_url: ""
language: en
publisher: "Avo"
authors: []
published_at: ""
reliability: primary
content_file: ""
content_sha256: ""
supersedes: []
---

# Avo official docs: tracking plan, pricing, and customer story index

## Submitter Note

Open questions require primary source expansion for competitor capabilities, pricing, and buyer/champion signals. This Source record captures official Avo pages retrieved on 2026-07-21.

## Research Questions

- `OQ-001` 경제적 구매자와 초기 champion은 데이터 운영자, analytics engineer, PM, QA 중 누구인가?
- `OQ-006` 기존 Avo, Amplitude, Segment, GTM과 공존할지 일부를 대체할지 결정해야 한다.
- `OQ-007` 제품 방향을 지지하는 핵심 주장과 가격 정보를 공식 primary Source record로 확장해야 한다.

## Provenance

- 원문 확보 방법: 공식 Avo 문서, 가격 페이지, 고객 사례 index를 웹에서 직접 조회.
- 주요 URL:
  - https://www.avo.app/docs/data-design/avo-tracking-plan
  - https://www.avo.app/pricing
  - https://www.avo.app/customers
- 원문 보존 위치: URL과 retrieval date를 기록한다. 저작권상 원문 전체를 로컬 복제하지 않는다.
- 원문과 record의 차이: record는 조사 질문에 필요한 claim 단위 요약만 포함한다.

## Triage

- 판정: accepted
- 판정자: LLM auto-triage policy-v1
- 판정일: 2026-07-21
- 사유: 공식 벤더 문서와 가격 페이지이며 provenance를 URL과 retrieval date로 재현할 수 있고, 행동데이터 tracking plan/검증/경쟁 조사 범위와 직접 관련된다. 기존 secondary report와 exact duplicate가 아니다.

## Extracted Content

- Avo Tracking Plan은 애플리케이션 데이터 정의를 담고 codegen과 validation에 사용되는 중심 명세다.
- Avo workspace 구성 요소로 Journeys, Tracking Plan Events, Properties, Metrics, Publishing, Connection Setup, Codegen, Inspector가 제시된다.
- Journeys는 product screenshot 기반 시각 설계와 AI-powered suggestions를 포함한다.
- Pricing page 기준 Free는 $0, 2 editors, 100k Inspector observed events, editors용 Codegen, 1 downstream schema registry sync를 포함한다.
- Team은 annual 기준 $250/month, monthly 기준 $300/month, 5 editors 포함, 추가 editor는 annual $50/month/editor 또는 monthly $60/month/editor다.
- Enterprise는 공개 정액이 없고 "Let's talk"로 표기되며 enforceable approvals, automated required reviews, enforceable standards, 1M Inspector observed events, SSO, premium support 등을 포함한다.
- 고객 사례 index는 Delivery Hero, Wolt, OneFootball, Fender, Joybird, Rapchat, Rebank, Doodle, Rappi, Termius, Patreon, Teatime 등을 나열한다. 이는 구매자/champion 가설의 lead일 뿐 실제 고객 인터뷰 원문은 아니다.

## Revision Notes

- 2026-07-21: Research Agent가 공식 primary source 보강용으로 최초 생성하고 Intake Agent가 자동 triage 정책으로 accepted 처리.
