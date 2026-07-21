---
title: "행동데이터 수집 및 검증 패턴"
type: technology
status: current
confidence: medium
created: 2026-07-21
updated: 2026-07-21
sources:
  - SRC-20260721-autocapture-tag-managers
  - SRC-20260721-tag-audit-qa-tools
  - SRC-20260721-tracking-governance-remaining-tools
  - SRC-20260721-schema-data-contracts
---

# 행동데이터 수집 및 검증 패턴

## Current Synthesis

행동데이터 품질은 수집 방식과 검증 시점의 조합으로 결정된다. 오토캡처와 명시 계측은 수집 축이고, 크롤링·시나리오·실트래픽 관측은 검증 축이다. 각 방식은 서로 다른 사각지대를 가지므로 하나의 엔진으로 모든 품질 문제를 해결하기 어렵다.

## Evidence

- 오토캡처는 DOM 상호작용 커버리지와 소급성을 제공하지만 비즈니스 의미와 커스텀 속성이 약하다. [SRC-20260721-autocapture-tag-managers]
- 명시 계측과 dataLayer는 의미와 속성을 통제하지만 구현·배포·QA에 사람이 개입한다. [SRC-20260721-autocapture-tag-managers]
- 크롤링은 URL 범위를 넓게 탐색하지만 실제 사용자 상태와 복잡한 상호작용을 놓칠 수 있다. [SRC-20260721-tag-audit-qa-tools]
- 시나리오 재생은 요소와 이벤트를 인과적으로 검증하지만 경로와 selector 유지가 병목이다. [SRC-20260721-tag-audit-qa-tools]
- 실트래픽 청취는 운영 이탈을 상시 감지하지만 미발생 경로와 미계측 요소를 발견하지 못한다. [SRC-20260721-tag-audit-qa-tools]
- schema-first pipeline은 도착한 payload를 강하게 검증하지만 이벤트 자체가 발생하지 않은 이유는 알 수 없다. [SRC-20260721-tracking-governance-remaining-tools] [SRC-20260721-schema-data-contracts]

## Contradictions

- 자동 수집이 명시 계측보다 비용 효율적인지는 이벤트 볼륨, 저장 정책, 분석 목적에 따라 달라진다.
- 자율 순회가 실트래픽보다 넓은 커버리지를 제공하더라도 인증, 상태 공간, 비결정성 때문에 운영 비용이 커질 수 있다.

## Open Questions

- MVP에서 능동 순회, 실트래픽 관측, schema 검증 중 무엇을 먼저 구현해야 하는가?
- 요소 지문의 신뢰도 임계값과 사람 검토 기준은 어떻게 정의할 것인가?
- 개인정보와 인증 상태를 침해하지 않고 순회 커버리지를 확장할 방법은 무엇인가?

## Product Implications

안정적인 제품 구조는 deterministic 실행과 증빙을 기본으로 두고, LLM은 경로 생성·원인 설명·수정안 제안에 제한적으로 사용하는 방향을 검토해야 한다.

## See Also

- [[source-autocapture-tag-managers|오토캡처와 태그매니저 Source 요약]] - 수집 방식 비교
- [[tag-audit-and-qa-tools|태그 감사 및 QA 도구]] - 검증 방식 비교
- [[schema-and-data-contracts|스키마 및 데이터 계약]] - schema-first 검증 계층
