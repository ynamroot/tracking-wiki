---
title: Tracking Wiki
description: 행동데이터 수집과 검증 도구의 문제, 시장, 경쟁 구도, 기술 접근을 연결한 지식 지도
---

# Tracking Wiki

행동데이터 수집과 검증 도구의 문제, 시장, 경쟁 구도, 기술 접근을 연결한 현재 지식 지도다. 외부 사실의 원문은 `raw/sources`가 기준이고, 이 Wiki는 채택된 자료를 사람이 읽기 좋게 풀어 쓴 지식 지도다. 낯선 용어가 나오면 [[key-terms|핵심 용어 해설]]을 먼저 확인한다.

## Wiki에 참여하기

새로운 자료나 검증이 필요한 질문을 공개 GitHub Issue로 등록한다.

<div style="display:flex;flex-wrap:wrap;gap:0.75rem;margin:1rem 0 1.5rem;"><a href="https://github.com/ynamroot/tracking-wiki/issues/new?template=source-submission.yml" target="_blank" rel="noopener noreferrer" style="display:inline-flex;align-items:center;justify-content:center;gap:0.4rem;padding:0.65rem 1rem;border-radius:6px;background:var(--secondary);color:var(--light);font-weight:600;text-decoration:none;">＋ 자료 제보하기</a><a href="https://github.com/ynamroot/tracking-wiki/issues/new?template=research-question.yml" target="_blank" rel="noopener noreferrer" style="display:inline-flex;align-items:center;justify-content:center;gap:0.4rem;padding:0.65rem 1rem;border:1px solid var(--secondary);border-radius:6px;color:var(--secondary);font-weight:600;text-decoration:none;">？ 조사 질문 남기기</a></div>

## 먼저 읽기

- [[overview|프로젝트 지식 개요]] - 전체 결론, 신뢰도, 읽을 순서를 빠르게 파악한다.
- [[key-terms|핵심 용어 해설]] - 이벤트, 스키마, 검증, CDP, SDK 같은 반복 용어를 먼저 풀이한다.
- [[automation-opportunity|행동데이터 자동화 기회]] - 제품 가설과 미검증 위험을 확인한다.
- [[research-confidence-map|연구 신뢰도 지도]] - 어떤 주장이 검증됐고 무엇이 아직 추정인지 확인한다.
- [[open-questions|미결 질문]] - 남은 조사 및 제품 판단 항목을 확인한다.
- [[log|Wiki Log]] - 새 문서, 주요 변경, open question 상태 변화를 확인한다.

## 최근 변경

새 문서가 생기거나 기존 문서의 결론이 바뀌면 이 섹션과 [[log|Wiki Log]]에 남긴다. 자세한 변경 이유와 반영 범위는 Wiki Log의 날짜별 항목을 기준으로 확인한다.

- 2026-07-23 ingest - 익명화한 잠재 고객 인터뷰 2건을 처음 반영해 [[behavioral-data-practitioners|행동데이터 운영 실무자]], [[buyer-and-champion|구매자와 챔피언 가설]], [[automation-opportunity|행동데이터 자동화 기회]]를 갱신하고, 행동데이터·내부 서비스 데이터 결합 요구(`OQ-014`)와 AI 분석 신뢰성 우려(`OQ-015`)를 새로 열었다.
- 2026-07-23 ingest - "4.3 참고 링크" 카탈로그의 신규 URL 24건을 반영해 [[industry-event-governance-practices|실운영 조직의 이벤트 계측 거버넌스 사례]]를 새로 만들고, [[avo|Avo]]·[[amplitude-data|Amplitude Data]]·[[schema-and-data-contracts|스키마 및 데이터 계약]]·[[tracking-governance-platforms|트래킹 거버넌스 플랫폼]]·[[automation-opportunity|행동데이터 자동화 기회]]를 보강했다.
- 2026-07-22 update - 공개 문서의 절 이름을 한국어로 바꾸고(현재 종합·근거·모순·미결 질문·제품 시사점·관련 문서), 비전문가 가독성 규칙과 모든 페이지의 [[key-terms|핵심 용어 해설]] 링크를 도입했다.
- 2026-07-22 review - 비공개 제품 초안을 Wiki 근거로 재검토해 조사 질문 `OQ-009`·`OQ-010`·`OQ-011`을 새로 열고 [[open-questions|미결 질문]]과 [[automation-opportunity|행동데이터 자동화 기회]] 등에 반영했다. 자세한 절차는 [[log|Wiki Log]]와 운영 문서의 "제품 초안 논증" 절을 확인한다.
- 2026-07-22 ingest - 용어집과 역할별 페인포인트 분석을 반영해 [[tracking-terminology|트래킹 상세·벤더 용어 사전]]을 추가하고 [[behavioral-data-practitioners|행동데이터 운영 실무자]]를 외부 자료로 보강했다.
- 2026-07-22 update - [[log|Wiki Log]]를 공개 사이트에 포함하고, 독자용 변경 발견 경로와 탐색 트리 정렬 규칙을 보강했다.
- 2026-07-22 ingest - [[source-commercial-tools-survey|상용 도구 조사]]를 반영하고, [[behavioral-data-quality-landscape|시장 지형]], [[tag-audit-and-qa-tools|태그 감사 및 QA 도구]], [[autocapture-and-tag-manager-layer|오토캡처와 태그매니저 계층]], [[automation-opportunity|자동화 기회]], [[research-confidence-map|연구 신뢰도 지도]]를 갱신했다.
- 2026-07-22 update - [[key-terms|핵심 용어 해설]]을 추가하고, Open Question 동기화 규칙을 보강했다.
- 2026-07-22 ingest - accepted Source 15건을 전체 재-ingest하고, 전문가용 지식 페이지와 Source summary를 확장했다.

## 문제 이해

- [[behavioral-data-practitioners|행동데이터 운영 실무자]] - PM, 데이터, 개발, QA가 나눠 갖는 어려움을 정리한다.
- [[buyer-and-champion|구매자와 챔피언 가설]] - 예산을 승인하는 사람과 내부 도입을 밀 사람을 구분한다.
- [[tracking-qa-workflow|트래킹 QA 운영 흐름]] - 배포 전후의 검증과 문제 대응 흐름을 설명한다.

## 시장과 경쟁 구도

- [[behavioral-data-quality-landscape|행동데이터 품질 시장 지형]] - 자동 수집, 코드 생성, 고객데이터플랫폼, 태그 감사, 데이터 계약 계층을 조망한다.
- [[tracking-governance-platforms|트래킹 거버넌스 플랫폼]] - Segment, mParticle, RudderStack 등 수집 규칙 관리 제품을 비교한다.
- [[avo|Avo]] - 트래킹 플랜, 코드 생성, 실제 데이터 검사 기능을 가진 직접 경쟁사다.
- [[amplitude-data|Amplitude Data]] - Amplitude Data와 Ampli의 업무 흐름을 정리한다.
- [[tag-audit-and-qa-tools|태그 감사 및 QA 도구]] - 웹 순회, 시나리오 검사, 실제 트래픽 감시 제품군을 비교한다.
- [[autocapture-and-tag-manager-layer|오토캡처와 태그매니저 계층]] - 자동 행동 수집과 태그 설정 도구의 장단점을 정리한다.
- [[pricing-and-packaging|가격과 패키징 비교]] - 공식 자료 기준 가격, 요금 구간, 추가 기능 구조를 비교한다.

## 기술 접근

- [[collection-and-validation-patterns|행동데이터 수집 및 검증 패턴]] - 수집과 검증 방식의 장단점을 비교한다.
- [[key-terms|핵심 용어 해설]] - 반복되는 기술 용어를 쉬운 말로 설명한다.
- [[tracking-terminology|트래킹 상세·벤더 용어 사전]] - 스키마·옵저버빌리티·거버넌스·파이프라인의 상세·벤더 용어를 도메인별로 정리한다.
- [[validation-layer-model|검증 계층 모델]] - 코드 검토, 실행 중 검사, 수집 지점, 데이터 창고, 화면 증거 계층을 분리한다.
- [[schema-and-data-contracts|스키마 및 데이터 계약]] - Snowplow, dbt, data contract 관점의 하류 안전망을 설명한다.
- [[codegen-and-tracking-plan-workflow|코드 생성과 트래킹 플랜 흐름]] - 트래킹 플랜에서 코드를 자동 생성하는 패턴을 정리한다.
- [[element-event-evidence|요소-이벤트 증거 모델]] - 화면 요소, 사용자 행동, 이벤트, 전송 내용을 연결하는 핵심 개념이다.
- [[autonomous-traversal-evaluation|자율 순회 평가 기준]] - 웹 자동화 평가와 행동데이터 검증 평가의 차이를 정리한다.
- [[industry-event-governance-practices|실운영 조직의 이벤트 계측 거버넌스 사례]] - GitLab, Wikimedia, Naver Series가 실제로 이벤트 정의를 강제하는 방식을 비교한다.

## 제품 종합

- [[automation-opportunity|행동데이터 자동화 기회]] - 현재 가장 강한 제품 기회와 위험.
- [[mvp-outcome-options|MVP outcome 선택지]] - 배포 전 회귀 검증, 운영 경보, 자동 계측 제안 비교.
- [[research-confidence-map|연구 신뢰도 지도]] - 다음 research loop의 우선순위.

## 자료 요약

- [[source-practitioner-pain-points|행동데이터 운영 실무자 페인포인트]] - 역할별 pain과 조사 한계.
- [[source-autocapture-tag-managers|오토캡처와 태그매니저]] - raw interaction, visual labeling, tag manager 취약성.
- [[source-tag-audit-qa-tools|태그 감사 및 자동 순회 QA 도구]] - synthetic scan, scenario test, passive monitoring.
- [[source-avo|Avo 내부 경쟁 분석]] - Avo의 codegen/Inspector와 runtime proof 공백.
- [[source-avo-official-data-design|Avo 공식 문서와 가격]] - Avo 공식 기능·가격·고객 lead.
- [[source-amplitude-data-ampli|Amplitude Data 및 Ampli SDK 내부 분석]] - Ampli workflow와 한계.
- [[source-amplitude-official-data-governance|Amplitude 공식 Data Governance]] - 공식 tracking plan, Ampli, pricing.
- [[source-tracking-governance-four-tools|트래킹 거버넌스 도구 4종]] - Segment, Mixpanel, mParticle, RudderStack 비교.
- [[source-tracking-governance-remaining-tools|트래킹 거버넌스 및 인접 도구]] - validation spectrum과 PRD 기회.
- [[source-segment-protocols-official|Twilio Segment Protocols 공식 문서]] - Protocols와 add-on packaging.
- [[source-mparticle-data-planning-official|mParticle Data Planning 공식 문서]] - data plan limits와 validation SDK.
- [[source-rudderstack-tracking-plans-official|RudderStack Tracking Plans 공식 문서]] - tracking plan limits와 violation management.
- [[source-schema-data-contracts|스키마 및 데이터 계약 계층 내부 분석]] - Snowplow, data contract, observability.
- [[source-snowplow-dbt-data-quality-official|Snowplow와 dbt 공식 데이터 품질 문서]] - failed events와 model contracts.
- [[source-web-agent-eval-benchmarks|Web Agent Evaluation Benchmarks]] - Mind2Web, WebArena, VisualWebArena, WorkArena.
- [[source-commercial-tools-survey|상용 도구 조사]] - 거버넌스, 태그 감사, 오토캡처, 태그매니저, 데이터 계약 계층의 종합 지도.
- [[source-commercial-tools-official-docs|상용 도구 공식 문서 보강]] - ObservePoint, Trackingplan, Heap, PostHog, Amplitude, Mixpanel, GTM 공식 문서 확인.
- [[source-tracking-glossary|트래킹 플랜 자동화 용어집]] - 7개 축의 기술·벤더 용어 교차 정리.
- [[source-pain-point-analysis|역할별 페인포인트 분석]] - 외부 자료와 내부 실증으로 교차 검증한 역할별 고통과 사슬 구조.
- [[source-amplitude-avo-taxonomy-publishing|Amplitude taxonomy·거버넌스 문서와 Avo Publishing 연동 문서]] - Amplitude AI 계측 에이전트와 Avo의 하류 도구 발행 메커니즘.
- [[source-data-contract-ecosystem|데이터 컨트랙트 거버넌스·버저닝 생태계]] - Bitol 프로젝트 범위와 컨트랙트 버저닝·강제 관행.
- [[source-commercial-tools-commentary|상용 도구 3자 코멘터리와 연동 문서]] - Mixpanel Lexicon, mParticle 연동, RudderStack×Avo, PostHog 경쟁군 비교.
- [[source-industry-event-governance-practices|실운영 조직의 이벤트 계측 거버넌스 사례]] - GitLab, Wikimedia, Naver Series의 이벤트 정의 강제·실패 사례.
- [[source-prospect-interview-marketing-stack-review|잠재 고객 인터뷰 — 마케팅·분석 SaaS 스택 현황]] - 익명화한 고객사 A의 도구 학습 난도, 비용 상한, AI 분석 신뢰성 우려.
- [[source-prospect-interview-behavior-data-fusion|잠재 고객 인터뷰 — 행동데이터와 내부 서비스 데이터 결합 요구]] - 익명화한 고객사 B의 결합 분석 요구와 자체 구축 전환 조건.
