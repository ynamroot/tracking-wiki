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

- [ ] `OQ-001` 경제적 구매자와 초기 champion은 데이터 운영자, analytics engineer, PM, QA 중 누구인가? 2026-07-22~23 잠재 고객 인터뷰 2건에서 기획·마케팅 담당자가 인터뷰이였다는 정황이 처음 나왔으나, AI 요약본이고 예산 승인자는 확인되지 않아 여전히 미해결이다.
- [ ] `OQ-002` 첫 MVP outcome은 배포 전 회귀 검증, 운영 파손 경보, 자동 계측 제안 중 무엇인가?
- [ ] `OQ-003` Value Proposition을 검증할 고객 인터뷰와 행동 증거의 최소 기준은 무엇인가? 2026-07-22~23 잠재 고객 인터뷰 2건이 처음 도착했으나 AI 요약본이고 참가자 동의 범위가 별도 문서화되지 않아, 이 사례만으로 최소 기준을 정립하지는 못했다.
- [ ] `OQ-004` 현재 수동 QA·파손 대응·계측 구현에 쓰는 시간과 비용은 얼마인가? 2026-07-22 역할별 페인포인트 분석이 문제의 존재와 일반성을 이름 있는 외부 자료(Trackingplan, RudderStack, House of Martech, incident.io, 원티드랩)로 보강했으나, 타깃 고객의 실제 시간·비용 수치는 여전히 미해결이다. 2026-07-23 잠재 고객 인터뷰 1건에서 이벤트 종량제 요금 상한이 실질적 비용 제약이 된다는 정황이 나왔지만, 익명화를 위해 구체 수치를 기록하지 않았고 표본이 1건이라 여전히 열려 있다.
- [ ] `OQ-005` 요소 지문과 자율 순회가 실제 제품 개편에서 달성해야 할 정확도와 안전 기준은 무엇인가? 특히 서로 다른 요소를 같다고 잘못 잇는 오병합의 허용 상한을 어떻게 정하는가?
- [ ] `OQ-006` 기존 Avo, Amplitude, Segment, GTM과 공존할지 일부를 대체할지 결정해야 한다.
- [~] `OQ-007` 제품 방향을 지지하는 핵심 주장과 가격 정보를 공식 primary Source record로 확장해야 한다. 2026-07-22 기준 Avo, Amplitude, Segment, mParticle, RudderStack, Snowplow/dbt, web-agent benchmark에 더해 ObservePoint, Trackingplan, Heap, PostHog, Amplitude Visual Labeling, Mixpanel Autocapture, Google Tag Manager의 공식 Source가 추가됐다. 다만 가격·tier 최신성, enterprise-only 기능, 공식 접근이 안정적이지 않았던 DataTrue/Tag Inspector 세부 claim, 고객 구매 증거는 남아 있다.
- [ ] `OQ-008` 자율 순회와 요소 지문 가설을 검증할 대표 UI 변경 dataset과 평가 기준은 무엇인가? 명시적 요소, 클릭 핸들러가 붙은 요소, 펼침(스크롤·탭·모달) 내부 요소의 계층별 발견율은 어떤 기준으로 측정하는가?
- [ ] `OQ-009` 운영 환경에서 자동 순회가 만드는 합성(봇) 이벤트를 실사용 분석 데이터에서 식별·격리하는 업계 관행과 요구 기준은 무엇인가?
- [ ] `OQ-010` 화면 증거(스크린샷) 기반 검증에서 개인정보 마스킹과 보존 기한의 업계 관행·규제 요구는 무엇인가?
- [ ] `OQ-011` 자동 발견·초안 생성 도구에서 사람 승인 대기열이 새 병목이 되는 규모와 이를 다룬 사례는 무엇인가?
- [ ] `OQ-012` Amplitude의 AI 기반 계측 에이전트(`amplitude:taxonomy`, `instrumentation-agent`)는 실제 운영 환경에서 어느 정도 정확도로 이벤트 이름·삽입 위치를 제안하는가? 자율 순회 기반 계측 제안과 경쟁하거나 보완하는 지점은 무엇인가?
- [ ] `OQ-013` GitLab·Wikimedia 수준의 CI 강제(파일명 일치, 삭제 방지, tier별 권한 분리)를 상용 트래킹 플랜 도구(Avo, Amplitude 등)를 쓰는 조직에도 이식할 수 있는가, 아니면 자체 이벤트 카탈로그를 가진 조직에만 적용 가능한가?
- [ ] `OQ-014` 행동데이터와 내부 서비스·비즈니스 데이터(개인정보 포함 가능)를 결합 분석하려는 고객 요구가 확인됐다. 외부망 행동 분석 도구와 내부망 서비스 데이터 사이의 결합을 개인정보·보안 요구를 지키며 구현하는 기술적·정책적 방법은 무엇인가?
- [ ] `OQ-015` AI 기반 분석 결과의 신뢰성(할루시네이션 우려)에 실무자가 자동화된 교차 검증 없이 사람이 직접 확인하고 있다는 정황이 나왔다. 업계에서 이 신뢰성 문제에 쓰는 자동 교차 검증 방법이나 관행은 무엇인가?

## Source Contradictions

- 거버넌스 도구의 기능·가격·차단 범위는 2026-07-22 재-ingest에서 공식 Source로 일부 보정했다. 다만 vendor 가격·tier는 수시로 바뀌므로 제품 의사결정 직전 재확인이 필요하다.
- 경쟁 기능 부재 주장은 공개 자료에 기반하므로 신생 및 비공개 기능 조사가 필요하다.
- 벤더 블로그가 인용한 정량 데이터는 원 조사까지 provenance를 확장해야 한다. 역할별 페인포인트 분석의 "품질 좋은 데이터 3%(HBR)", "분석가 시간 40%(Forrester)"도 Mixpanel 블로그가 제3자를 재인용한 secondary 수치다.
- web-agent benchmark는 자율 순회 task success를 평가하지만 tracking-specific event correctness와 element continuity를 직접 평가하지 않는다.
- DataTrue와 Tag Inspector의 세부 기능·가격은 제출된 상용 도구 조사와 기존 secondary Source에는 있으나, 이번 official bundle에서는 claim-level로 확정하지 않았다. 제품 판단에 쓰려면 별도 primary Source 보강이 필요하다.
- Amplitude 공식 문서 안에서도 이벤트 명명 규칙이 Title Case와 snake_case로 엇갈린다(`data-planning-playbook`/`analytics-tracking-practices` vs `event-taxonomy`). 어느 쪽이 최신 공식 권장인지 확인되지 않았다.
- Naver Series 실패 사례([[industry-event-governance-practices|실운영 조직의 이벤트 계측 거버넌스 사례]])는 한 실무자의 단일 저자 연재 블로그로, 독립 검증된 회사 공식 사례가 아니다.

## Product Decisions Pending

- `PD 제안` 초기 ICP와 구매자
- `PD 제안` MVP의 단일 핵심 outcome
- `PD 제안` 기존 tracking plan·tag manager와의 통합 경계
- `PD 제안` 자동 수정 없이 증빙 중심으로 시작할지 여부

## 다음 Research Loop

- 고객 인터뷰: `buyer-and-champion`, `tracking-qa-workflow`, `mvp-outcome-options`의 low-confidence claim을 검증한다.
- Prototype evaluation: `autonomous-traversal-evaluation`의 기준으로 controlled UI-change dataset을 만든다.
- 공식 문서 재확인: 가격·tier·feature gate는 제품 결정 직전 다시 확인한다. DataTrue와 Tag Inspector는 공식 원자료 접근을 별도 루프로 보강한다.
- Toss 사례 조사: `toss.tech` 홈페이지에는 이벤트 트래킹·로깅·거버넌스 관련 아티클이 노출되지 않았다. 특정 아티클을 지목한 검색이나 다른 경로로 Toss의 실제 이벤트 계측 운영 사례를 찾는 후속 조사가 필요하다.
- 고객 인터뷰 intake 절차 정비: 2026-07-22~23 잠재 고객 인터뷰 2건은 참가자 동의 범위와 익명화 방식이 사전에 문서화되지 않은 채 ingest됐다. 향후 인터뷰가 늘어나면 동의 범위 기록, 검증 가능한 원문(녹취·메모) 확보를 intake 표준 절차로 정비해야 한다.

## 해소 기록

- 2026-07-22: `OQ-007`은 부분 해소로 전환했다. 공식 Source가 추가되고 `pricing-and-packaging`, `tracking-governance-platforms`, `research-confidence-map`에 반영됐지만 고객 구매 증거와 최신성 재확인은 남아 있다.
- 2026-07-22: 상용 도구 조사 ingest에서 ObservePoint, Trackingplan, Heap, PostHog, Amplitude Visual Labeling, Mixpanel Autocapture, Google Tag Manager의 공식 문서 보강을 추가했다. `OQ-007`의 공식 Source 범위는 넓어졌지만 DataTrue/Tag Inspector의 세부 claim과 가격·tier 최신성은 남아 있다.
