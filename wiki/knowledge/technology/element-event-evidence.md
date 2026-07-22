---
title: 요소-이벤트 증거 모델
type: concept
status: current
confidence: medium
created: 2026-07-22
updated: 2026-07-22
sources:
  - SRC-20260721-avo
  - SRC-20260721-amplitude-data-ampli
  - SRC-20260721-autocapture-tag-managers
  - SRC-20260721-tracking-governance-remaining-tools
  - SRC-20260721-snowplow-dbt-data-quality-official
---

# 요소-이벤트 증거 모델

## Current Synthesis

요소-이벤트 증거 모델은 이 프로젝트의 핵심 차별화 후보이다. 목표는 화면 요소, 사용자 행동, 실제 발생한 이벤트, 전송 내용의 규칙, 도착한 분석 도구, 배포 버전 정보를 하나의 증거 묶음으로 연결하는 것이다. 기존 도구는 이 사슬의 일부만 본다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup> <sup>[🔗](#source-3)</sup> <sup>[🔗](#source-4)</sup>

## Evidence

- Avo Journeys는 설계 단계의 화면 이미지와 행동 매핑을 제공하지만, 실제 실행 중 이벤트가 발생했다는 증거와는 다르다. <sup>[🔗](#source-1)</sup>
- Amplitude Visual Labeling은 자동 수집된 원시 클릭과 화면 구조를 바탕으로 이름표를 붙이는 별도 흐름이다. <sup>[🔗](#source-2)</sup>
- 오토캡처 도구는 원시 행동을 수집하지만, 그 행동이 어떤 사업적 의미를 갖는지 정하고 검증하는 일은 남는다. <sup>[🔗](#source-3)</sup>
- 인접 도구 Source는 요소↔이벤트 시각 매핑·증빙이 거의 모두 약하다고 정리한다. <sup>[🔗](#source-4)</sup>
- Snowplow/dbt Source는 failure artifact와 contract enforcement의 safety model을 참고하게 해준다. <sup>[🔗](#source-5)</sup>

## Mechanics

증거 묶음은 최소한 다음 정보를 가져야 한다: 화면 경로와 배포 버전, 요소 지문, 화면 요소를 찾는 단서, 화면 캡처, 행동 종류, 기대 이벤트, 실제 네트워크 요청이나 SDK가 보낸 내용, 스키마 검증 결과, 목적지 도착 여부, 시간, 재실행 명령. 요소 지문은 선택자(selector) 하나만 쓰면 쉽게 깨진다. 역할, 텍스트, 위치, 화면 구조, 시각적 단서를 함께 조합해야 한다.

## Evaluation Criteria

- 안정성: 화면 구조, 문구, CSS class, 레이아웃이 바뀌어도 같은 요소를 찾는가.
- 구별력: 비슷한 버튼을 서로 혼동하지 않는가.
- 설명 가능성: 실패했을 때 어떤 요소와 어떤 기대 이벤트가 맞지 않았는지 사람이 이해할 수 있는가.
- 안전성: 자동 수정 전에 사람이 승인할 만큼 증거가 충분한가.

## Contradictions

요소 지문이 정확하다는 실증 Source는 아직 없다. 이 페이지는 제품 가설이지 검증된 사실이 아니다.

## Open Questions

- `OQ-005`: 실제 제품 개편에서 달성해야 할 정확도와 안전 기준은 무엇인가?
- `OQ-008`: 대표 UI 변경 dataset을 어떻게 구성할 것인가?

## Product Implications

초기 제품은 자동 수정보다 proof-first로 시작해야 한다. 사람에게 “이 요소가 이 이벤트를 내야 하는데 이번 build에서 안 나왔다”를 재현 가능하게 보여주는 것이 우선이다.

## See Also

- [[autonomous-traversal-evaluation|자율 순회 평가 기준]] - 증거 수집 자동화
- [[schema-and-data-contracts|스키마 및 데이터 계약]] - downstream contract 연결
- [[key-terms|핵심 용어 해설]] - 요소 지문과 증거 용어 풀이

## 출처

- <a id="source-1"></a>[[source-avo|Source Summary: Avo]] - `SRC-20260721-avo`
- <a id="source-2"></a>[[source-amplitude-data-ampli|Source Summary: Amplitude Data 및 Ampli SDK]] - `SRC-20260721-amplitude-data-ampli`
- <a id="source-3"></a>[[source-autocapture-tag-managers|Source Summary: 오토캡처와 태그매니저]] - `SRC-20260721-autocapture-tag-managers`
- <a id="source-4"></a>[[source-tracking-governance-remaining-tools|Source Summary: 트래킹 거버넌스 및 인접 도구]] - `SRC-20260721-tracking-governance-remaining-tools`
- <a id="source-5"></a>[[source-snowplow-dbt-data-quality-official|Source Summary: Snowplow와 dbt 공식 데이터 품질 문서]] - `SRC-20260721-snowplow-dbt-data-quality-official`
