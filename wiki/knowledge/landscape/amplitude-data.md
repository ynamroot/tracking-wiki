---
title: "Amplitude Data"
type: competitor
status: current
confidence: medium
created: 2026-07-21
updated: 2026-07-21
sources:
  - SRC-20260721-amplitude-data-ampli
---

# Amplitude Data

## Current Synthesis

Amplitude Data는 Amplitude 분석 생태계 안에서 플랜, codegen, CI, 유입 데이터 관측과 autocapture를 결합한다. 기존 고객에게 통합된 선택지라는 강점이 있지만 Ampli의 코드 계측과 Visual Labeling의 UI 계층은 분리돼 있다.

## Evidence

- Ampli는 타입 안전 API와 CI status 검사를 제공한다. [SRC-20260721-amplitude-data-ampli]
- Observe는 유입 schema의 current, invalid, out-of-date 상태를 구분한다. [SRC-20260721-amplitude-data-ampli]
- 코드 계측에서는 개발자가 정확한 호출 위치를 선택해야 한다. [SRC-20260721-amplitude-data-ampli]
- UI 요소 매핑은 별도 Autocapture와 Visual Labeling 영역이다. [SRC-20260721-amplitude-data-ampli]

## Contradictions

- Amplitude의 여러 기능을 하나의 end-to-end workflow로 평가하려면 실제 플랜 간 연결성과 티어별 제공 범위를 검증해야 한다.

## Open Questions

- Ampli와 Visual Labeling 사이의 실제 workflow 단절이 고객 문제로 인식되는가?
- Observe 경고 이후 평균 수정 시간과 담당자는 누구인가?

## Product Implications

Amplitude와 공존하려면 기존 event taxonomy를 import하고 UI 검증 결과를 Amplitude workflow로 돌려주는 통합이 중요하다.

## See Also

- [[source-amplitude-data-ampli|Amplitude Data 및 Ampli SDK Source 요약]] - 기능과 한계
- [[tracking-governance-platforms|트래킹 거버넌스 플랫폼]] - 경쟁사 비교
