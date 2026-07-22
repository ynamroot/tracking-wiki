---
title: 오토캡처와 태그매니저 계층
type: comparison
status: current
confidence: medium
created: 2026-07-22
updated: 2026-07-22
sources:
  - SRC-20260721-autocapture-tag-managers
  - SRC-20260721-amplitude-data-ampli
---

# 오토캡처와 태그매니저 계층

## Current Synthesis

오토캡처와 태그매니저는 모두 “코드 배포 없이 더 많이/더 빨리 수집”하려는 계층이지만, 신뢰 문제를 제거하지 않는다. 오토캡처는 raw interaction을 확보한 뒤 의미를 나중에 붙이고, 태그매니저는 설정 변경의 속도를 높이지만 selector/dataLayer drift를 남긴다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup>

## Evidence

- Heap/PostHog 계열은 클릭, pageview, form submit 같은 interaction을 자동 수집하고 Virtual Event/Action으로 의미를 붙인다. <sup>[🔗](#source-1)</sup>
- Amplitude Visual Labeling은 DOM 변경이 요소 참조를 깨뜨릴 수 있지만 raw autocapture data가 남아 있어 label 정의를 갱신할 수 있다는 모델을 제시한다. <sup>[🔗](#source-1)</sup>
- Amplitude 내부 Source는 Visual Labeling이 code-based Ampli track과는 별도 축이라고 설명한다. <sup>[🔗](#source-2)</sup>
- GTM의 DOM scraping은 page structure에 의존하고 preview는 session-based manual debug다. <sup>[🔗](#source-1)</sup>

## Mechanics

오토캡처는 “먼저 수집, 나중에 의미 부여”이고, tracking plan/codegen은 “먼저 의미 정의, 그 다음 구현”이다. 태그매니저는 marketing/analytics tag orchestration을 빠르게 하지만, dataLayer와 selector 품질이 낮으면 검증 공백을 키운다. 세 접근은 대체 관계보다 하이브리드 관계다.

## Evaluation Criteria

- retrospective power: 과거 raw data를 재라벨링할 수 있는가.
- semantic richness: business property와 server-side context를 얻을 수 있는가.
- selector durability: DOM/class/name 변화에 견디는가.
- governance: 누가 정의를 승인하고 stale label을 정리하는가.

## Contradictions

오토캡처는 coverage 공백을 줄이지만 privacy, data volume, semantic quality 문제를 만든다. 수동 계측은 정확한 business context를 줄 수 있지만 누락과 구현 지연을 만든다.

## Open Questions

- 어떤 고객에게 오토캡처 complement가 아니라 대체재로 인식되는가?
- 요소 지문은 selector보다 얼마나 안정적인가?

## Product Implications

제품은 오토캡처를 부정하지 말고, raw interaction과 manual tracking event를 같은 proof graph로 묶는 계층을 검토해야 한다.

## See Also

- [[element-event-evidence|요소-이벤트 증거 모델]] - raw interaction과 event 연결
- [[amplitude-data|Amplitude Data]] - Ampli와 Visual Labeling의 경계

## 출처

- <a id="source-1"></a>[[source-autocapture-tag-managers|Source Summary: 오토캡처와 태그매니저]] - `SRC-20260721-autocapture-tag-managers`
- <a id="source-2"></a>[[source-amplitude-data-ampli|Source Summary: Amplitude Data 및 Ampli SDK]] - `SRC-20260721-amplitude-data-ampli`
