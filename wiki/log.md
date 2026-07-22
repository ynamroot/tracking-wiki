---
title: Wiki Log
description: Tracking Wiki의 공개 변경 이력
---

# Wiki Log

이 파일은 append-only다. 형식은 `## [YYYY-MM-DD] action | 설명`을 사용한다.

허용 action: `ingest`, `query`, `audit`, `update`, `decision`, `freeze`.

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
