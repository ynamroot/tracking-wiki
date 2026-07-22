---
title: "Source Summary: Amplitude Data 및 Ampli SDK"
type: source-summary
status: current
confidence: medium
created: 2026-07-21
updated: 2026-07-22
sources:
  - SRC-20260721-amplitude-data-ampli
---

# Source Summary: Amplitude Data 및 Ampli SDK

## Current Synthesis

Amplitude Data는 트래킹 플랜, Ampli codegen, CI status 검사, Observe 런타임 관측을 연결해 설계와 실제 데이터의 drift를 줄인다. 타입과 스키마 정합성은 여러 단계에서 검증하지만 이벤트 호출 위치 선정과 실제 UI 상호작용에서의 발화는 개발자와 수동 QA에 남는다.

## Evidence

- Ampli는 플랜에서 타입 안전 wrapper를 생성해 필수 속성과 enum 오류를 컴파일 또는 런타임에 잡는다. <sup>[🔗](#source-1)</sup>
- `ampli status`는 코드의 Ampli 호출과 플랜을 대조해 미구현 이벤트를 CI에서 표시한다. <sup>[🔗](#source-1)</sup>
- Observe는 유입 이벤트를 Unexpected, Valid, Invalid, Out of Date로 분류하고 경고·차단·변환을 지원한다. <sup>[🔗](#source-1)</sup>
- 생성된 함수를 코드의 정확한 위치에서 호출하고 검증 경고를 운영하는 일은 사람에게 남는다. <sup>[🔗](#source-1)</sup>
- Ampli 자체에는 UI 요소와 실제 이벤트 발화의 시각적 인과 증빙이 없다. <sup>[🔗](#source-1)</sup>

## Contradictions

- 가격 비교와 고객 불만 일부는 제3자 집계에 의존해 독립 검증이 필요하다.
- “end-to-end governance”라는 제품 범위와 업스트림에서 차단·변환된 데이터를 Observe가 볼 수 없다는 제약 사이에 관측 경계가 있다.

## Open Questions

- Ampli status가 코드 스캔만으로 놓치는 동적 호출과 실제 UI 발화 오류의 비율은 어느 정도인가?
- 기존 Amplitude 고객이 별도 UI-이벤트 검증 제품에 비용을 지불할 가능성이 있는가?

## Product Implications

Amplitude 생태계를 대체하기보다 플랜과 실제 UI 발화를 연결하는 증빙 계층으로 보완할 가능성을 검토할 수 있다.

## See Also

- [[amplitude-data|Amplitude Data]] - 제품 관점 경쟁 분석
- [[tracking-governance-platforms|트래킹 거버넌스 플랫폼]] - 주요 제품 비교

## 출처

- <a id="source-1"></a>[[source-amplitude-data-ampli|Source Summary: Amplitude Data 및 Ampli SDK]] - `SRC-20260721-amplitude-data-ampli`
