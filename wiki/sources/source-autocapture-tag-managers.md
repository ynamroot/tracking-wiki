---
title: "Source Summary: 오토캡처와 태그매니저"
type: source-summary
status: current
confidence: medium
created: 2026-07-21
updated: 2026-07-22
sources:
  - SRC-20260721-autocapture-tag-managers
---

# Source Summary: 오토캡처와 태그매니저

## Current Synthesis

오토캡처는 수동 계측의 누락 문제를 완화하지만 의미 부여, 검증, 데이터 모델링을 없애지는 못한다. 태그매니저는 배포 없이 태그 설정을 바꿀 수 있게 하지만 DOM 스크레이핑, dataLayer 품질, preview 중심 수동 검증이라는 취약성을 남긴다. <sup>[🔗](#source-1)</sup>

## Evidence

- Heap/PostHog/Amplitude/Mixpanel 계열 오토캡처는 클릭·페이지뷰·폼 제출 같은 UI 신호를 자동 수집하고 나중에 사람이 이벤트 의미를 정의하는 모델을 제공한다. <sup>[🔗](#source-1)</sup>
- 오토캡처 원조 계열에서도 verification 또는 curation 단계가 남아 있어 “수집 자동화 = 분석 신뢰 자동화”는 아니다. <sup>[🔗](#source-1)</sup>
- GTM류 태그매니저는 preview/debug workflow가 있지만 상시 production 검증이나 plan-config-real event 자동 대조는 기본 기능이 아니다. <sup>[🔗](#source-1)</sup>

## Mechanics

오토캡처는 원시 interaction stream을 쌓고, 사람이 selector나 visual labeling으로 의미 있는 action을 지정한다. 이 구조는 정의를 나중에 바꿔도 과거 raw interaction을 재해석할 수 있다는 장점이 있지만, 비즈니스 속성이나 서버 계산값은 자동으로 얻기 어렵다. 태그매니저는 dataLayer와 DOM selector를 이용해 tag를 발화하지만, selector와 page structure drift가 생기면 설정이 조용히 깨질 수 있다.

## Evaluation Criteria

- coverage: 자동으로 잡는 interaction 종류와 빠지는 custom business property.
- durability: DOM/class/name/aria/title 변경에서 label 또는 selector가 살아남는 정도.
- governance: 누가 label을 승인하고, 누가 stale definition을 청소하는가.
- evidence: UI 요소, user action, emitted event, destination delivery가 한 증거 묶음으로 남는가.

## Contradictions

오토캡처는 수동 계측 비판자와 지지자 모두에게 다른 결론을 준다. 빠른 coverage와 retrospective labeling은 강점이지만, 핵심 KPI는 여전히 명시 계측과 schema 관리가 필요하다는 하이브리드 결론으로 수렴한다.

## Open Questions

- `OQ-006`: 기존 tag manager와 공존할지 대체할지 결정해야 한다.
- `OQ-008`: 요소 지문과 자율 순회 평가 기준이 필요하다.

## Product Implications

차별화 기회는 “오토캡처냐 수동 계측이냐”의 선택지가 아니라, UI 요소와 이벤트 의미를 자동 증빙하고 drift가 생긴 뒤 사람이 무엇을 고쳐야 하는지 좁혀주는 계층이다.

## See Also

- [[autocapture-and-tag-manager-layer|오토캡처와 태그매니저 계층]] - 하이브리드 수집 모델
- [[element-event-evidence|요소-이벤트 증거 모델]] - 시각 증빙 기회

## 출처

- <a id="source-1"></a>[[source-autocapture-tag-managers|오토캡처 진영과 태그매니저 계층 조사]] - `SRC-20260721-autocapture-tag-managers`
