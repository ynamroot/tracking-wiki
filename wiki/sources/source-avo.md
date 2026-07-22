---
title: "Source Summary: Avo"
type: source-summary
status: current
confidence: medium
created: 2026-07-21
updated: 2026-07-22
sources:
  - SRC-20260721-avo
---

# Source Summary: Avo

## Current Synthesis

Avo는 협업형 트래킹 플랜, 타입 안전 codegen, 브랜치 승인, Inspector 런타임 schema 관측을 결합한다. 설계 의도를 코드 계약으로 전달하는 데 강하지만, 이벤트 함수를 어디서 호출할지와 화면 동작이 실제 이벤트를 발생시켰는지 확인하는 일은 개발자와 수동 QA에 남는다.

## Evidence

- Tracking Plan은 이벤트·속성·소스·목적지를 공통 명세로 관리한다. <sup>[🔗](#source-1)</sup>
- Codegen은 분석 SDK를 감싼 타입 안전 함수를 생성해 컴파일 및 런타임 제약을 적용한다. <sup>[🔗](#source-1)</sup>
- Inspector는 실제 값 대신 schema 형태를 수집해 플랜과 대조한다. <sup>[🔗](#source-1)</sup>
- 브랜치와 승인 workflow가 플랜 변경을 격리하고 리뷰하도록 돕는다. <sup>[🔗](#source-1)</sup>
- Journeys는 설계 화면과 이벤트를 연결하지만 런타임 UI 동작과 이벤트 발화의 자동 증빙은 아니다. <sup>[🔗](#source-1)</sup>

## Contradictions

- 일부 사용자 불만은 검색 요약 또는 리뷰 집계에 의존한다.
- Inspector의 개인정보 최소화는 값이 아닌 schema만 수집하는 장점이지만 값 수준 품질 오류는 그 범위 밖이다.

## Open Questions

- Avo 고객이 가장 크게 느끼는 잔여 수동 작업은 호출 삽입, QA, 운영 triage 중 무엇인가?
- Avo Journeys와 실제 런타임 증빙을 연결하는 통합이 가능한가?

## Product Implications

경쟁 우위는 더 나은 플랜 UI가 아니라 실제 UI 상태, 계측 호출, 네트워크 이벤트를 자동 연결하는 실행·증빙 계층에서 찾아야 한다.

## See Also

- [[avo|Avo]] - 제품 관점 경쟁 분석
- [[tracking-governance-platforms|트래킹 거버넌스 플랫폼]] - 주요 제품 비교

## 출처

- <a id="source-1"></a>[[source-avo|Source Summary: Avo]] - `SRC-20260721-avo`
