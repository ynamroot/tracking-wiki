---
title: "Source Summary: 오토캡처와 태그매니저"
type: source-summary
status: current
confidence: medium
created: 2026-07-21
updated: 2026-07-21
sources:
  - SRC-20260721-autocapture-tag-managers
---

# Source Summary: 오토캡처와 태그매니저

## Current Synthesis

오토캡처는 커버리지와 소급 분석을 얻는 대신 의미 부여·노이즈 제거·프라이버시·정의 수리를 뒤로 미룬다. 명시 계측과 태그매니저는 의미와 커스텀 속성을 앞에서 통제하지만 개발 리소스와 수동 QA에 의존한다. 시장은 두 방식 중 하나를 고르기보다 오토캡처 베이스라인과 핵심 이벤트 명시 계측을 결합하는 방향으로 수렴한다.

## Evidence

- Heap, PostHog, Fullstory, Pendo 계열은 DOM 상호작용을 먼저 모으고 이벤트 의미를 사후 정의한다. [SRC-20260721-autocapture-tag-managers]
- 사후 정의도 CSS selector와 화면 구조에 의존해 UI 변경 시 깨지며, 현재 제품은 대체로 사람이 정의를 수리한다. [SRC-20260721-autocapture-tag-managers]
- GTM은 Tag, Trigger, Variable, dataLayer로 명시 계측을 구성하지만 preview는 사람이 수행하는 배포 전 디버깅이다. [SRC-20260721-autocapture-tag-managers]
- DOM scraping과 selector 기반 trigger는 오토캡처 정의와 동일한 UI 변경 취약성을 가진다. [SRC-20260721-autocapture-tag-managers]
- 오토캡처는 커스텀 비즈니스 속성에 한계가 있고 명시 계측은 소급성과 커버리지에 한계가 있다. [SRC-20260721-autocapture-tag-managers]

## Contradictions

- 오토캡처의 비용과 품질 평가는 벤더별 제품 범위와 이해관계에 따라 상반된다.
- “핵심 이벤트 10~20개” 같은 실무 권고는 보편적 기준이라기보다 조사 자료의 종합으로 취급해야 한다.

## Open Questions

- 자동 수집 범위와 개인정보 위험을 제품 정책으로 어떻게 제한할 것인가?
- selector 대신 요소 지문을 사용해 어느 수준까지 개편 내성을 확보할 수 있는가?
- 태그매니저 설정을 읽기만 할지, 승인 후 수정까지 수행할지 결정해야 한다.

## Product Implications

기회는 전수 수집 자체보다 플랜·설정·실발생을 연결하고, UI 변경을 감지해 요소 이력을 계승하며, 수정 후보를 승인 대기열에 올리는 데 있다.

## See Also

- [[collection-and-validation-patterns|수집 및 검증 패턴]] - 시장의 주요 기술 접근
- [[tag-audit-and-qa-tools|태그 감사 및 QA 도구]] - 배포 후 검증 제품군
