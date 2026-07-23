---
id: SRC-20260723-data-contract-ecosystem
title: "Data contract governance and versioning ecosystem (Atlan, datasops, Bitol, Snowplow Iglu management)"
status: accepted
source_type: documentation
original_url: "https://bitol.io/"
submitted_by: "Research Agent"
submitted_at: 2026-07-23
retrieved_at: 2026-07-23
issue_url: ""
language: en
publisher: "Atlan, datasops, Bitol/LF AI & Data, Snowplow"
authors: []
published_at: ""
reliability: secondary
content_file: ""
content_sha256: ""
supersedes: []
---

# 데이터 컨트랙트 거버넌스·버저닝 생태계 (Atlan, datasops, Bitol, Snowplow Iglu 운영)

## Submitter Note

`SRC-20260722-tracking-reference-links` 카탈로그의 데이터 컨트랙트 범주 신규 URL 4건과 Snowplow Iglu 운영 페이지 1건을 확보해 기존 [[schema-and-data-contracts|스키마 및 데이터 계약]] 페이지를 보강한다.

## Research Questions

- 데이터 컨트랙트를 채택하는 이유와 버저닝 관행은 무엇인가?
- Bitol 프로젝트(조직·표준 묶음)는 이미 인용된 ODCS v3.1.0 스펙 문서와 어떻게 다른가?
- Snowplow의 "Iglu 관리"(레지스트리 운영)는 이미 인용된 "Iglu란 무엇인가" 소개 문서와 어떻게 다른가?

## Provenance

- 원문 확보 방법: 공식/준공식 웹 문서를 직접 조회했다.
- 주요 URL:
  - https://atlan.com/data-contracts/ (벤더 블로그, Emily Winks, 2023-04-20 작성/2025-12-05 갱신)
  - https://www.datasops.com/blog/data-contracts-versioning (개인/소규모 블로그, 2026-05-26)
  - https://github.com/bitol-io/open-data-contract-standard (Bitol 공식 GitHub 저장소, Apache 2.0)
  - https://bitol.io/ (Bitol 프로젝트 공식 홈, Linux Foundation AI & Data 산하)
  - https://docs.snowplow.io/docs/data-product-studio/data-structures/manage/iglu/ (Snowplow 공식 문서)
- 원문 보존 위치: URL과 retrieval date를 기록한다. 저작권상 원문 전체를 로컬 복제하지 않는다.
- 원문과 record의 차이: record는 조사 질문에 필요한 claim 단위 요약만 포함한다.

## Triage

- 판정: accepted
- 판정자: LLM auto-triage policy-v1
- 판정일: 2026-07-23
- 사유: 공개 문서이며 provenance를 URL과 retrieval date로 재현할 수 있다. 기존 [[schema-and-data-contracts|스키마 및 데이터 계약]] 페이지와 직접 관련되고 기존 accepted Source(ODCS v3.1.0 스펙 문서, Iglu 소개 문서)와 exact duplicate가 아니다. `atlan.com`, `datasops.com`은 벤더/개인 블로그로 1차 자료보다 신뢰도가 낮아 `reliability: secondary`로 표기한다.

## Extracted Content

### 데이터 컨트랙트 채택 이유와 버저닝 관행 (Atlan, datasops)

- Atlan은 데이터 컨트랙트를 "생산자와 소비자 사이의 스키마를 정의·강제하는 공식 합의"로 정의하며 스키마 구조·비즈니스 의미·가용성 보장·거버넌스 규칙·접근 통제를 포괄한다고 설명한다. 채택 이유는 하류 장애 예방과, 데이터가 만들어지는 시점에 품질을 검사하는 "shift left"다.
- Atlan의 버저닝 권장안: 추가적이고 하위 호환되는 변경을 우선하고, 필드 삭제·이름 변경 같은 비호환 변경은 피하며, 불가피하면 신구 버전이 공존하는 전환 기간을 둔 "구조화된 버저닝과 이관 패턴"을 쓴다. 거버넌스는 생산자(스키마·의미·생성 로직 소유)·소비자(요구사항 검증과 변경 요청)·거버넌스팀(자동 검증과 버저닝 운영)의 3자 공동 책임으로 나눈다.
- datasops는 Kafka Schema Registry의 호환성 모드(BACKWARD·FORWARD·FULL·FULL_TRANSITIVE)를 기준으로, 대부분의 운영 topic에는 재생(replay) 소비자가 모든 과거 버전을 읽을 수 있는 BACKWARD_TRANSITIVE를 기본값으로 권장한다.
- datasops의 비파괴적 변경 예: 기본값이 있는 선택적 필드 추가는 하위 호환되지만 "그 기본값은 Avro 스키마 자체에 명시돼야 하며 애플리케이션 코드에 맡길 수 없다." 필드 이름 변경은 Avro alias로 강제 전환 없이 이관 기간을 준다.
- datasops의 파괴적 변경(enum 값 제거, 필드 타입 변경, 레코드 구조 변경) 처리: 새 topic/subject를 만들고, 신구 버전에 동시에 쓰는 dual-write producer로 데이터 유실을 막은 뒤, 소비자를 점진적으로 이관하고 기존 topic을 폐기한다.
- datasops는 컨트랙트가 "배포 파이프라인에서 검증돼야만 강제력이 있고, 위키에 문서로만 적어 두면 강제력이 없다"고 강조하며 GitHub Actions로 비호환 스키마 배포를 막는 게이트 예시를 제시한다.

### Bitol 프로젝트 자체 (스펙 문서와 구분)

- GitHub 저장소(`bitol-io/open-data-contract-standard`)는 스펙 렌더링 페이지와 별개로 문서 원문, JSON Schema 검증 파일, 예제 컨트랙트, 도구 스크립트를 담고 있다. JSON Schema는 IntelliJ·VS Code 같은 IDE에 가져와 ODCS YAML을 인라인 검증하는 데 쓸 수 있다.
- 현재 버전은 3.1.0(2025-12-08 릴리스)이며 지금까지 총 7회 릴리스됐다 — 스펙이 단발성 문서가 아니라 실제 릴리스 주기를 가진다.
- `bitol.io` 공식 홈은 Bitol을 "데이터 컨트랙트, 데이터 프로덕트 등을 정의하는 표준을 만드는" 프로젝트로 소개하며, 데이터 정규화·문서 최신성·서비스 수준 기대·도구 통합·제품 지향 데이터 접근을 다룬다고 설명한다. Bitol은 ODCS(YAML 기반, 버전 관리·강제용) 외에 **Open Data Product Standard(ODPS, v1.0.0)**도 유지한다 — "데이터 제품을 정의·거버넌스·확장하기 위한 통합 개방형 프레임워크." 즉 Bitol의 범위는 ODCS 하나보다 넓다.
- Bitol은 자원봉사자로 구성된 Technical Steering Committee(TSC)가 운영하며 최근 TSC에 신규 위원 2명이 합류했다. Linux Foundation AI & Data 산하 인큐베이션 프로젝트이고 Apache 2.0 라이선스다.
- Bitol 홈은 "데이터 거버넌스가 상위 시스템이며, ODCS·ODPS가 조직 안에서 실제로 채택·강제되는 방식을 결정한다"고 명시한다 — 표준 자체는 Bitol이 제공하지만 강제는 조직의 책임으로 남긴다.

### Snowplow Iglu 관리(운영) — "Iglu란 무엇인가" 소개 문서와 구분

- 자체 호스팅(self-hosted) Snowplow 고객은 Iglu Server를 운영하거나 정적(static) Iglu 레지스트리를 직접 호스팅해 스키마를 관리할 수 있다.
- 스키마는 `vendor/name/format/version` 고정 디렉터리 구조로 배치하며, 파일명은 확장자 없이 버전 문자열(예: `1-0-0`) 그대로 써야 한다.
- 발행은 Igluctl CLI로 하며(예: `igluctl static push --public <local path> <server endpoint> <api_key>`), 스키마 업로드에는 `iglu_super_api_key` 인증이 필요하다 — 역할·권한 기반 접근 통제가 있음을 뜻한다.
- 스키마 버전은 major-minor-patch 모델을 따르며 patch·minor는 비파괴적, major는 파괴적 변경에 쓴다. 다만 **파괴적 여부는 대상 데이터 창고에 따라 달라진다** — 예를 들어 필드를 필수에서 선택으로 바꾸는 변경은 Snowflake·BigQuery에서는 비파괴적이지만 Redshift에서는 파괴적이다. 즉 같은 스키마 수정이라도 대상 창고에 따라 버전 처리(bump)가 달라질 수 있다.

## Revision Notes

- 2026-07-23: Research Agent가 `SRC-20260722-tracking-reference-links` 카탈로그의 데이터 컨트랙트·Iglu 운영 URL 5건을 fetch해 Source record를 생성하고 자동 triage 정책으로 accepted 처리했다.
