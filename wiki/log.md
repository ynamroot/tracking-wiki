---
title: Wiki Log
description: Tracking Wiki의 공개 변경 이력
---

# Wiki Log

이 파일은 append-only다. 형식은 `## [YYYY-MM-DD] action | 설명`을 사용한다.

허용 action: `ingest`, `query`, `audit`, `update`, `decision`, `freeze`, `review`.

독자는 이 페이지에서 새 문서, 의미 있는 내용 변경, Open Question 상태 변화, 배포 구조 변경을 확인한다. 최신 변경은 아래쪽에 추가된다.

## [2026-07-21] update | Wiki 운영 골격 생성

Source, Wiki, 제품 및 기술 문서의 스키마와 Agent 권한을 정의했다.

## [2026-07-21] ingest | 페인포인트, 오토캡처, 태그 QA 자료 3건 통합

`SRC-20260721-practitioner-pain-points`, `SRC-20260721-autocapture-tag-managers`, `SRC-20260721-tag-audit-qa-tools`를 ingest했다. 역할별 고객 문제, 수집·검증 기술 패턴, 태그 감사 경쟁 구도를 생성했으며 정량 주장과 경쟁사 비교의 독립 검증 필요성을 기록했다.

## [2026-07-21] update | Source 자동 triage 정책 적용

provenance, 관련성, 접근성, 중복 여부를 통과한 Source를 자동 채택하고 예외만 PO에게 escalation하도록 운영 규칙을 변경했다. 기존 8개 내부 조사 보고서를 `secondary`로 자동 채택했다.

## [2026-07-21] ingest | 거버넌스, schema, 경쟁사 자료 5건 통합

`SRC-20260721-amplitude-data-ampli`, `SRC-20260721-avo`, `SRC-20260721-tracking-governance-four-tools`, `SRC-20260721-tracking-governance-remaining-tools`, `SRC-20260721-schema-data-contracts`를 ingest했다. 거버넌스 경쟁사, schema·data contract 계층, 시장 지형, 자동화 기회 종합을 생성했다.

## [2026-07-21] audit | 초기 ingest 전체 검사

accepted Source 8건과 knowledge page 18건을 검사했다. 구조·index·wikilink 오류는 없으며, 모든 근거가 secondary라는 점과 구매자·MVP outcome·요소 지문 정확도에 대한 1차 검증 부재를 핵심 연구 공백으로 기록했다.

## [2026-07-22] update | Wiki 탐색 구조와 공개 웹 경로 개편

지식 페이지를 `knowledge/problem`, `knowledge/landscape`, `knowledge/technology`, `knowledge/synthesis`로 재배치했다. 사람이 먼저 읽을 순서로 index를 재작성하고 GitHub 시작 안내와 Quartz 기반 공개 사이트 경로를 추가했다. 기존 지식의 의미와 Source 연결은 변경하지 않았다.

## [2026-07-22] update | 본문 Source 인용을 이모지 각주로 개편

공개 Wiki 본문에 반복 노출되던 Source ID를 `🔗` 앵커로 바꾸고, 전체 Source ID와 Source summary 링크를 각 문서 최하단 `출처` 절로 이동했다. Schema, ingest 절차, Wiki Compiler 규칙과 validator도 같은 표기 방식을 따르도록 갱신했다.

## [2026-07-23] ingest | "4.3 참고 링크" 카탈로그 신규 URL 24건 반영

`SRC-20260722-tracking-reference-links`(참고 링크 카탈로그)의 신규 URL 25건 중 24건을 4개 Source로 확보해 ingest했다: `SRC-20260723-amplitude-avo-taxonomy-publishing`(Amplitude taxonomy·거버넌스 문서, Avo Publishing 하류 발행 8종), `SRC-20260723-data-contract-ecosystem`(Bitol 프로젝트 범위, 데이터 컨트랙트 버저닝 관행, Snowplow Iglu 운영), `SRC-20260723-commercial-tools-commentary`(Mixpanel Lexicon, mParticle 연동, RudderStack×Avo, PostHog 경쟁군 비교), `SRC-20260723-industry-event-governance-practices`(GitLab·Wikimedia·Naver Series의 실제 이벤트 정의 강제·실패 사례). Toss(`toss.tech`)는 관련 사례를 찾지 못해 이번 ingest에 포함하지 않았다 — 후속 조사가 필요하다.

신규 페이지 [[industry-event-governance-practices|실운영 조직의 이벤트 계측 거버넌스 사례]]를 만들었고, [[avo|Avo]](Publishing 메커니즘), [[amplitude-data|Amplitude Data]](AI 계측 에이전트, 명명 규칙 모순), [[schema-and-data-contracts|스키마 및 데이터 계약]](데이터 컨트랙트 생태계), [[tracking-governance-platforms|트래킹 거버넌스 플랫폼]](RudderStack×Avo, Mixpanel-mParticle), [[automation-opportunity|행동데이터 자동화 기회]](경쟁 신호, 실제 조직 증거), [[buyer-and-champion|구매자와 챔피언 가설]](Naver Series 실패 사례 연결)를 갱신했다. `OQ-012`, `OQ-013`을 새로 등록했다.

## [2026-07-22] update | GitHub Issue 참여 경로 추가

Wiki 첫 화면과 사이트 footer에 자료 제보 및 조사 질문 Issue 버튼을 추가했다. Issue Form은 저장소 소유자에게 자동 할당되며, GitHub 라벨은 현재 상태 표시용이고 LLM ingest 실행은 아직 별도 runner가 필요하다는 운영 경계를 기록했다.

## [2026-07-22] ingest | accepted Source 15건 전체 재-ingest 및 전문가용 Wiki 확장

accepted Source 15건을 새 ingest quality bar에 맞춰 다시 통합했다. Source summary를 15건으로 확장하고, 지식 페이지를 문제·시장·기술·종합 축의 세부 문서 19건으로 재구성했다. Avo, Amplitude, Segment, mParticle, RudderStack, Snowplow/dbt, web-agent benchmark의 primary Source를 반영해 기능·가격·평가 기준의 신뢰도를 높였고, 구매자·MVP outcome·요소 지문 정확도·고객 비용은 계속 open question으로 유지했다.

## [2026-07-22] update | 용어 해설과 Open Question 동기화 규칙 추가

반복되는 외래어와 전문용어를 설명하는 `key-terms` 문서를 추가하고, index·overview·핵심 기술 문서 일부의 문장을 더 설명적으로 다듬었다. Open Question은 자동 동기화가 아니라 `OQ-NNN` 기반 수동 동기화임을 명시하고, 질문 추가·부분 해소·해소 시 `open-questions.md`, 관련 문서, `log.md`를 함께 갱신하도록 운영 규칙을 보강했다.

## [2026-07-22] update | Wiki log 공개와 독자용 탐색 순서 정렬

`wiki/log.md`를 Quartz 공개 사이트에 포함하고, `wiki/index.md`에 최근 변경 확인 섹션을 추가했다. 공개 탐색 트리는 index의 읽기 흐름에 맞춰 `overview`, `open-questions`, `log`, `knowledge`, `sources` 순서와 knowledge 하위의 문제·시장·기술·종합 순서를 우선하도록 설정했다.

## [2026-07-22] update | 탐색 목록 Home 항목 추가

Quartz가 `wiki/index.md`를 사이트 루트로 처리해 좌측 탐색 목록에는 별도 index 항목이 보이지 않았다. 독자가 현재 위치와 홈 복귀 경로를 바로 알 수 있도록 탐색 목록 최상단에 `Home` 링크를 추가했다.

## [2026-07-22] update | 탐색 목록 Home 렌더링 오류 수정

탐색 목록에 추가한 `Home` 항목이 Explorer 내부 트리 노드와 같은 메서드를 갖지 않아, 브라우저 렌더링 중 전체 좌측 목록이 비는 문제가 있었다. `Home` 항목을 Explorer 트리 순회와 정렬을 통과할 수 있는 노드 형태로 보강했다.

## [2026-07-22] update | 탐색 목록 Home 노드 생성 방식 수정

브라우저에서 실행되는 Explorer callback은 문자열로 직렬화되므로 함수 프로퍼티를 직접 넣은 Home 노드가 다시 렌더링 오류를 만들 수 있었다. Home 항목을 Explorer의 실제 노드 생성자로 만들도록 바꿔, 폴더 페이지에서도 좌측 목록이 유지되게 수정했다.

## [2026-07-22] update | 탐색 목록 Home 정렬 수정

Home 항목이 루트 링크가 아니라 `home` slug로 정렬되어 목록 최상단에 오지 않는 문제가 있었다. Home 노드를 루트 slug로 만들고, Explorer 정렬표의 첫 항목으로 처리되게 수정했다. Quartz emitter가 병렬 출력 중 디렉터리 생성 순서에 따라 실패할 수 있어 공개 사이트 빌드는 `--concurrency 1`로 고정했다.

## [2026-07-22] ingest | 상용 도구 조사 및 공식 문서 보강 반영

`SRC-20260722-commercial-tools-survey`를 ingest하고, `SRC-20260722-commercial-tools-official-docs`를 Research Agent 보강 Source로 추가했다. 새 Source summary `source-commercial-tools-survey`, `source-commercial-tools-official-docs`를 만들고, 시장 지형, 태그 감사 및 QA 도구, 오토캡처와 태그매니저 계층, 요소-이벤트 증거 모델, 행동데이터 자동화 기회, 프로젝트 지식 개요, 연구 신뢰도 지도, 핵심 용어 해설을 갱신했다. `OQ-007`은 더 넓은 공식 Source로 부분 해소했지만 DataTrue/Tag Inspector 세부 claim, 가격·tier 최신성, 고객 구매 증거는 남겨 두었다.

## [2026-07-22] ingest | 용어집과 역할별 페인포인트 분석 통합

`2607_tracking-plan`에서 AI와 함께 정리한 조사 산출물 2건을 intake·ingest했다. `SRC-20260722-tracking-glossary`(7개 축의 기술·벤더 용어집)와 `SRC-20260722-pain-point-analysis`(외부 1차 자료와 내부 실증으로 교차 검증한 역할별 페인포인트)를 secondary로 자동 채택하고 원문을 hash와 함께 `raw/assets`에 보존했다. 두 자료의 근거 원자료는 이미 accepted Source로 추적 가능하다. Source summary `source-tracking-glossary`, `source-pain-point-analysis`를 만들고, 새 지식 페이지 `tracking-terminology`(핵심 용어 해설의 기본 용어를 전제로 한 상세·벤더 용어 사전)를 추가했으며 `key-terms`와 상호 연결했다. `behavioral-data-practitioners`에는 파손의 침묵·수동 QA 부담·무인지 파손이 이름 있는 복수 외부 자료에서 독립 재확인된다는 점과 고통의 사슬(수작업 의존 → 커버리지·품질 제한 → 파손 방치 → 신뢰 상실)을 보강했다. 정량 수치(3% HBR, 40% Forrester)는 벤더 블로그의 secondary 재인용으로 표기했다. `OQ-004`는 문제 일반성이 보강됐으나 타깃 고객의 실제 비용은 미해결이라 열림 상태로 유지했다.

## [2026-07-22] update | 제품 초안 논증 루프 도입

비공개 제품 초안을 Wiki 근거로 반복 검증하는 "제품 초안 논증" 절차를 운영 문서에 정의했다. `OPERATIONS.md`에 6절 "제품 초안 논증"을 추가하고 이후 절을 재번호했으며, `AGENTS.md`에 초안 검토 Agent 역할과 비공개 초안 비밀 유지 규칙, `AGENT_PLAYBOOKS.md`에 해당 플레이북, `PROJECT_CONTEXT.md`에 비공개 제품 초안 소절, `SCHEMA.md`와 이 log에 `review` action을 추가했다. 판정 보고서 템플릿 `templates/draft-review.md`를 만들었다. 초안 원문과 판정 보고서는 이 공개 저장소 밖 비공개 작업 공간에 두고, 저장소에는 일반화된 조사 질문과 검토 기록만 남긴다.

## [2026-07-22] review | 비공개 제품 초안 2회차 검토

비공개 제품 초안 한 건을 현재 Wiki(commit 57fd430)를 근거로 재검토했다. Wiki로 판정할 수 없는 항목을 조사 질문으로 등록했다 — `OQ-009`(운영 환경 자동 순회의 합성 이벤트 식별·격리 관행), `OQ-010`(화면 증거의 개인정보 마스킹·보존 관행), `OQ-011`(자동 발견·초안 생성의 승인 병목 규모)을 신규로 열고, `OQ-005`(오병합 허용 상한)와 `OQ-008`(계층별 발견율 기준)의 범위를 넓혔다. 새 질문은 `autonomous-traversal-evaluation`, `element-event-evidence`, `automation-opportunity`의 미결 질문 절에 미러링했다. 초안 내용은 저장소에 기록하지 않았다.

## [2026-07-22] update | 절 이름 한국어 전환과 가독성 규칙 도입

공개 Wiki 41개 페이지의 영어 절 이름을 한국어로 바꿨다(`Current Synthesis`→`현재 종합`, `Evidence`→`근거`, `Contradictions`→`모순`, `Open Questions`→`미결 질문`, `Product Implications`→`제품 시사점`, `See Also`→`관련 문서`, `Mechanics`→`작동 방식`, `Context`→`배경`, `Evaluation Criteria`→`평가 기준`). Quartz 목차도 한국어로 렌더링된다. 자료 요약 제목 접두사를 `Source Summary:`에서 `자료 요약:`으로 통일했다. 모든 지식 페이지와 자료 요약의 `관련 문서`에 [[key-terms|핵심 용어 해설]] 링크를 넣었다. `SCHEMA.md` 문장 작성 원칙에 비전문가·전문가 이중 독자 정의, 한영 혼용 금지, 약어 첫 등장 풀이, claim 옆 앵커, `status` 운영 규칙, 핵심 논지 단일 canonical 페이지 규칙을 추가하고, `wiki/AGENTS.md`는 이를 참조만 하도록 정리했다. `AGENTS.md`에 Query Agent 역할, `AGENT_PLAYBOOKS.md`에 Query Agent 플레이북과 Wiki Compiler·Auditor의 가독성 점검, `OPERATIONS.md` Ingest Workflow에 가독성 자기 점검 단계와 audit 체크리스트 가독성 항목을 추가했다. `Validate-Wiki.ps1`은 한국어 필수 절(제품 시사점 포함) 검사, key-terms 링크 검사, 미해설 약어·영어 비율 경고를 추가했다. 지식의 의미와 Source 연결은 바꾸지 않았다.

## [2026-07-22] update | 전체 페이지 본문 한영 혼용 제거

공개 Wiki 39개 지식 페이지와 자료 요약의 본문 문장을 비전문가가 읽을 수 있게 다듬었다. 한 문장 안의 한국어·영어 혼용을 없애고, 외래어와 약어를 첫 등장 시 쉬운 한국어로 풀었으며(예: `고객데이터플랫폼(CDP)`, `수집 도구(SDK)`, `품질 검증(QA)`), 문서마다 한 용어를 한 표현으로 통일했다. 제품·기능·벤치마크 이름, 가격, 수치, 표 데이터, 모든 `🔗` 출처 앵커와 위키링크 대상, `OQ`/`SRC` ID는 그대로 두어 주장과 근거의 연결은 바꾸지 않았다. 영어가 남은 세 페이지 제목(`champion`, `workflow`, `Codegen`)을 `챔피언`, `흐름`, `코드 생성`으로 바꾸고 index 표기도 맞췄다. 남은 영어 비율·약어 경고는 대부분 제품 고유명과 첫 등장 원어 병기에서 오는 것으로, 오류가 아니라 검토용 신호다.

## [2026-07-23] ingest | 잠재 고객 인터뷰 2건 최초 반영

`SRC-20260723-prospect-interview-marketing-stack-review`와 `SRC-20260722-prospect-interview-behavior-data-fusion`을 ingest했다. 두 인터뷰 모두 회사명과 식별 가능한 구체 수치(비용, 이용자 규모 등)를 익명화했고, 제출자가 신빙성을 의심한 회의록의 "결정" 단정 문장은 제외했다. `reliability: secondary`로 분류했다 — AI 자동 회의록이고 참가자 동의 범위가 별도 문서화되지 않았기 때문이다. [[behavioral-data-practitioners|행동데이터 운영 실무자]], [[buyer-and-champion|구매자와 챔피언 가설]], [[automation-opportunity|행동데이터 자동화 기회]], [[mvp-outcome-options|MVP outcome 선택지]], [[research-confidence-map|연구 신뢰도 지도]]를 갱신했다. 행동데이터와 내부 서비스 데이터의 결합 분석 요구(`OQ-014` 신규)와 AI 분석 결과 신뢰성 우려(`OQ-015` 신규)를 새 조사 질문으로 열었다. `OQ-001`, `OQ-003`, `OQ-004`는 첫 정황을 얻었지만 표본이 적고 검증되지 않아 열림 상태를 유지했다.
