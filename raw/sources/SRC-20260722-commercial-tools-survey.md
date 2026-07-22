---
id: SRC-20260722-commercial-tools-survey
title: "상용 도구 조사 — 행동 데이터 계측·거버넌스 도구 지형"
status: accepted
source_type: report
original_url: "https://github.com/user-attachments/files/30250092/01-.-.md"
submitted_by: "ynamroot"
submitted_at: 2026-07-22
retrieved_at: 2026-07-22
issue_url: "https://github.com/ynamroot/tracking-wiki/issues/1"
language: ko
publisher: "internal contributor"
authors:
  - "ynamroot"
published_at: ""
reliability: secondary
content_file: "raw/assets/SRC-20260722-commercial-tools-survey.md"
content_sha256: "C200F54E58E8984D5F9F05A0171C79B1C41501667D6BE1F1A8956C671ACF87EE"
supersedes: []
---

# 상용 도구 조사 — 행동 데이터 계측·거버넌스 도구 지형

## Submitter Note

제출자가 별도 한 줄 의견을 남기지 않았다.

## Research Questions

- 행동 데이터 계측·거버넌스 상용 도구는 어떤 갈래로 나뉘는가?
- 각 도구군은 어떤 문제를 풀고, 어떤 공백을 남기는가?
- 수동 계측, UI와 이벤트의 시각적 연결, 관측과 실행의 단절, 자가치유 부재는 기존 도구에서 어떻게 남아 있는가?

## Provenance

- 원문 확보 방법: GitHub Issue `#1` 첨부 파일 다운로드
- 원문 보존 위치: `raw/assets/SRC-20260722-commercial-tools-survey.md`
- 원문과 record의 차이: record는 provenance, triage, 조사 질문만 정규화했다. 원문 내용은 보존 파일을 기준으로 한다.

## Triage

- 판정: accepted
- 판정자: LLM auto-triage policy-v1
- 판정일: 2026-07-22
- 사유: 제출 Issue에서 공개·재배포 가능성과 민감정보 부재가 확인됐다. 원문 첨부 파일을 확보했고 SHA-256을 기록했다. 행동 데이터 계측, 트래킹 플랜 거버넌스, 태그 감사, 오토캡처, 태그 매니저, 스키마·데이터 계약 도구를 다루므로 현재 프로젝트 조사 범위와 직접 관련된다. 기존 accepted Source와 주제는 겹치지만 SHA-256 기준 exact duplicate는 아니다.

## Extracted Content

원문 전문은 `raw/assets/SRC-20260722-commercial-tools-survey.md`에 보존한다.

핵심 범위:

- 트래킹 플랜 거버넌스: Avo, Amplitude Data/Ampli, Segment Protocols, Mixpanel Lexicon, mParticle Data Master, RudderStack Data Governance
- 태그 감사·자동 순회 QA: ObservePoint, Trackingplan.com, DataTrue, Tag Inspector
- 오토캡처·리트로액티브 분석: Heap, PostHog, Amplitude/Mixpanel Autocapture, Fullstory, Pendo
- 태그 매니저: Google Tag Manager, Tealium iQ, Adobe Launch
- 스키마·데이터 계약 계층: Snowplow, ODCS/data contract, Monte Carlo 등 데이터 옵저버빌리티 도구
- 종합 공백: 개발자 수동 계측 전제, UI 요소와 이벤트의 시각적 연결 부재, 관측과 실행의 단절, 자가치유 부재

## Revision Notes

- 2026-07-22: GitHub Issue `#1` 첨부 파일을 accepted Source로 정규화했다. Wiki ingest는 별도 Wiki Compiler 단계에서 수행한다.
