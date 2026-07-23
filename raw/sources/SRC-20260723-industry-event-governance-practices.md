---
id: SRC-20260723-industry-event-governance-practices
title: "Real-world internal event instrumentation governance practices (GitLab, Wikimedia, Naver Series)"
status: accepted
source_type: documentation
original_url: "https://docs.gitlab.com/development/internal_analytics/internal_event_instrumentation/event_definition_guide/"
submitted_by: "Research Agent"
submitted_at: 2026-07-23
retrieved_at: 2026-07-23
issue_url: ""
language: "en, ko"
publisher: "GitLab, Wikimedia Foundation, Martinee (문소윤/soxxun)"
authors: []
published_at: ""
reliability: secondary
content_file: ""
content_sha256: ""
supersedes: []
---

# 실운영 조직의 내부 이벤트 계측 거버넌스 사례 (GitLab, Wikimedia, Naver Series)

## Submitter Note

`SRC-20260722-tracking-reference-links` 카탈로그의 "실운영 사례" 범주 URL 7건 중 6건에서 실제 사례 내용을 확보했다. 이 저장소가 지금까지 다룬 자료는 전부 상용 벤더 제품이었고, 실제 엔지니어링 조직이 자체적으로 이벤트 계측 거버넌스를 어떻게 운영하는지는 다루지 않았다 — 이번 자료가 그 공백을 처음 채운다.

## Research Questions

- 실제 엔지니어링 조직은 이벤트 이름 중복·표류를 어떤 규칙과 도구로 막는가?
- 이벤트가 배포되기 전에 어떤 승인·검토 절차를 거치는가?
- 이벤트 정의의 소유권은 어느 팀·역할에 있는가?
- 마케터·기획자·엔지니어 사이의 요구사항 불일치는 실제로 어떤 실패로 이어지는가?

## Provenance

- 원문 확보 방법: 공식 엔지니어링 문서(GitLab, Wikimedia)와 실무자 블로그(Martinee/Naver Series)를 웹에서 직접 조회했다.
- 주요 URL:
  - https://docs.gitlab.com/development/internal_analytics/internal_event_instrumentation/event_definition_guide/ (GitLab 공식 문서)
  - https://docs.gitlab.com/development/internal_analytics/internal_event_instrumentation/internal_events_payload/ (GitLab 공식 문서)
  - https://wikitech.wikimedia.org/wiki/Event_Platform/Onboarding (Wikimedia 공식 내부 엔지니어링 위키)
  - https://gitlab.wikimedia.org/repos/data-engineering/schemas-event-primary (저장소 UI는 로드되지 않아 `/-/raw/master/README.md`로 원문을 확보함)
  - https://blog.martinee.io/post/designing-perfect-event-taxonomy-naver-series (Martinee, 문소윤/soxxun, 2024-05-30, 1편)
  - https://brunch.co.kr/@soxxun/8 (같은 저자의 브런치 2편, 2024-05-30 — 1편과 2편은 같은 필자의 같은 연재글이며 독립된 두 출처가 아니다)
  - https://toss.tech/ — 홈페이지만 확인됨. 이벤트 트래킹·로깅·거버넌스 관련 아티클이 노출 목록에 없어 **사례를 찾지 못했다.** 특정 Toss 아티클을 지목한 검색이 필요하며, 이번 record에는 Toss 사례를 포함하지 않는다(추측·발명 금지).
- 원문 보존 위치: URL과 retrieval date를 기록한다. 저작권상 원문 전체를 로컬 복제하지 않는다.
- 원문과 record의 차이: record는 조사 질문에 필요한 claim 단위 요약만 포함한다.

## Triage

- 판정: accepted
- 판정자: LLM auto-triage policy-v1
- 판정일: 2026-07-23
- 사유: GitLab·Wikimedia 문서는 공식 1차 엔지니어링 문서로 provenance가 명확하다. Naver Series 자료는 한 실무자(문소윤/soxxun, Martinee Growth Engineer)의 2편짜리 단일 저자 연재 블로그로, 독립 검증되지 않은 2차 사례 서술이다 — 혼합 신뢰도이므로 record 전체를 `reliability: secondary`로 보수적으로 표기하고, 본문에서 공식 문서 유래 claim과 단일 저자 사례 서술을 구분한다. Toss는 사례를 찾지 못해 포함하지 않았다(원본 카탈로그의 "신규" 표시 중 이 1건만 미해결로 남는다).

## Extracted Content

### GitLab — 이벤트 정의 규칙과 소유권

- 이벤트 정의는 `config/events`, `ee/config/events` 아래 YAML 파일이며 JSON Schema로 검증된다. 필수 필드는 `description`, `action`, `product_group`, `tiers`다.
- `action` 명명 규칙: `<동작>_<대상>_<맥락>` 형식이며 소문자·숫자·언더스코어만 허용한다. 예: `publish_go_module_to_the_registry_from_pipeline`(동작=publish, 대상=go_module, 맥락=to_the_registry_from_pipeline).
- **중복 방지 규칙**: YAML 파일명이 `action` 이름과 반드시 일치해야 한다 — "혼동을 피하기 위해"라고 명시한다.
- `product_group` 필드가 각 이벤트를 소유 팀(제품 그룹)에 연결한다 — 소유권이 별도 분석팀이 아니라 제품 팀에 있다.
- 폐기 절차: 제거된 이벤트는 `/removed` 하위 폴더로 옮기고 `milestone_removed`, `removed_by_url`, `status: removed`를 기록한다 — 삭제가 아니라 감사 추적을 남기는 이동이다.
- 페이로드는 Snowplow tracker 프로토콜을 기반으로 하며 `e` 파라미터로 4가지 이벤트 유형(`ue` self-describing, `pv` pageview, `pp` page ping, `se` structured)을 구분한다. 스키마 레지스트리는 Iglu이며 `gitlab-org/iglu` 저장소에 사전 정의 스키마가 있다 — YAML 이벤트 정의 가이드와는 별개의 상호보완 계층이다.
- `gitlab_standard`라는 공통 컨텍스트가 모든 이벤트에 공유 필드를 주입해 일관성을 강제한다.
- 이 트래킹 데이터는 GitLab 내부 전용이며 제3자와 공유하지 않는다고 명시한다.

### Wikimedia — 온보딩 절차와 티어 분리

- 새 이벤트 스트림을 추가하는 5단계 온보딩: (1) 앱을 Docker화해 내부 레지스트리에 배포 (2) 스키마 작성 — 사용자에게 직접 영향을 주는 기능은 `schemas-event-primary`, 그렇지 않으면 `schemas-event-secondary`로 **영향도 기준 이원화** (3) `EventStreamConfig` MediaWiki extension에 Gerrit 변경으로 스트림 설정 선언 (4) 리소스 사양·SLO 문서·Alertmanager 연동과 함께 Kubernetes 배포 (5) 스트림을 공개하기 전 **필수 보안·개인정보(Security and Privacy) 검토**.
- 스키마는 모노레포로 관리되며 `https://schema.wikimedia.org`로 노출된다.
- 도구: `eventutilities-python`의 cookiecutter 템플릿으로 스키마 번들을 만들고 `jsonschema-tools`로 검증·관리한다.
- 이해관계자: Event Platform 팀(코드 리뷰·스키마 검증), SRE(배포·모니터링), Security & Privacy 팀(필수 게이트).
- `schemas-event-primary` 저장소(README 원문): 이 저장소는 사용자에게 직접 영향을 주는 "tier 1" 스키마를 담고, 그렇지 않은 스키마는 "tier 2"(`schemas-event-secondary`)에 둔다.
- 파일 대부분이 `jsonschema-tools`로 **자동 생성**되며 "최초 생성 이후 손으로 고치면 안 된다"고 명시한다 — 생성물은 불변 산출물로 취급한다.
- 버저닝: `current.yaml`이 작업 중 초안이고, 수정 시 스키마 `$id`를 올린 뒤 빌드 명령(`npm run build-modified`)으로 버전이 매겨진 `latest.yaml`/JSON을 생성한다.
- 기여 절차: `jsonschema/<namespace>/` 아래 새 하위 디렉터리를 만들고 `current.yaml` 초안 작성 → 빌드 실행 → 코드 리뷰 제출. 수정도 같은 편집→빌드→리뷰 순환을 따른다.
- 거버넌스: tier 1(primary) 저장소는 tier 2(secondary)보다 **병합 권한이 더 제한적**이다 — 사용자 영향도에 비례해 소유권을 조인다.
- 리뷰 방식: 리뷰어는 원시 git diff 대신 의미 기반 YAML diff 도구(`dyff`)로 `latest.yaml`을 비교해 의미 있는 스키마 변경만 짚어낸다.
- 이탈 방지: CI가 기본적으로 스키마 삭제를 막고, 삭제하려면 사유와 함께 수동으로 우회해야 한다.

### Naver Series (Martinee, 문소윤/soxxun, 2024-05-30 연재 2편)

- Taxonomy 3요소: 이벤트 유형(Event Category), 이벤트(Event), 이벤트 속성(Property). 예시 이벤트: `sign_up`, `charge_cookie`(쿠키 충전/결제), `purchase_completed`, `view_episode`(회차 열람).
- 8단계 설계 절차: (1) 목적·방향성 수립 (2) 주요 지표 설정 (3) 사용자 여정 스케치 (4) 이벤트·속성 설계 (5) 마케터 협의(반복) (6) 개발자 협의 (7) QA 테스트 — "담당자와 최종 협의된 논리적 설계에 따라 데이터 로그가 올바르게 적재되는지 확인" (8) 최종 수정.
- 역할 분담: 마케터/기획자(요구사항 정의) — 엔지니어/데이터분석가(택소노미 설계) — 개발자(구현 가능성 판단) — QA(검증).
- **문서화된 실패 사례**: 마케터가 정의한 "전환"(결제 시점, `charge_cookie`)과 실제 설계자가 본 소비 시점(`view_episode`)이 서로 달랐고, 마케터 관점만으로 설계한 택소노미는 나중에 "개발 불가능" 판정을 받아 완전히 새로 다시 설계해야 했다. 원문 인용: "마케터는 엔지니어가 필요한 정보를 알 수 없고, 엔지니어도 마케터의 분석 요구사항을 모를 수 있다."
- 명명 규칙, 원문 인용: "네이밍 컨벤셔닝은 선택이 아닌 필수입니다" — 소문자+언더바(snake_case) 권장. 예: `click_item`, `view_item`.
- 소유권: 마케터·개발자·택소노미 설계자가 협업하고 기획자/MD도 참여할 수 있다. 마케터가 이벤트 정의의 "결정권자"이자 "당사자"로 서술된다.
- 검토 주기: 마케터와는 초기·진행·완료 단계별 정기 회의와 실시간 공유되는 Daily Check List. 개발자와는 "1차 설계안 대략 설계 → 구체화" 방식.
- 도구: 설계·명세 문서는 Figma와 Google Sheets로 작성. 분석 플랫폼은 GA4 또는 자체 분석 스택(둘 다 쓰기도 함) — 이 사례에서 Amplitude·Avo·Segment 같은 상용 거버넌스 도구는 언급되지 않는다.
- 데이터 모델: Event Property와 User Property를 구분한다.
- 표류·중복 방지: 속성으로 경로를 간소화해 유사 페이지뷰/클릭 이벤트를 통합하고, "Critical Path에 따른 필수 이벤트만 설계"해 계측 범위를 제한한다.
- 비용 최적화 사례: 회차별 이벤트 발화를 배치 처리해(100회차 → 250회 로그였던 것을 10회차 단위 배치로 → 25회 로그) 로그 쓰기를 90% 줄였다.
- 개발팀 전달 산출물: Event Property Sheet와 User Property Sheet를 분리하고 각각 이벤트 이름·트리거·데이터 타입·값 예시·분석 목적 열을 둔다.
- **문서화된 교훈**, 원문 인용: "개발팀과의 협의 없이 마케터의 모든 요구사항을 즉시 반영하려다 택소노미를 전면 수정하는 참사"를 피해야 한다.

## Revision Notes

- 2026-07-23: Research Agent가 `SRC-20260722-tracking-reference-links` 카탈로그의 "실운영 사례" URL 7건 중 6건을 fetch해 Source record를 생성하고 자동 triage 정책으로 accepted 처리했다. Toss(`toss.tech`)는 사례를 찾지 못해 이번 record에 포함하지 않았으며, 후속 조사가 필요하다.
