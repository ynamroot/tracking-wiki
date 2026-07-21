# Wiki Log

이 파일은 append-only다. 형식은 `## [YYYY-MM-DD] action | 설명`을 사용한다.

허용 action: `ingest`, `query`, `audit`, `update`, `decision`, `freeze`.

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
