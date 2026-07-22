---
title: "자료 요약: Avo 공식 문서와 가격"
type: source-summary
status: current
confidence: high
created: 2026-07-22
updated: 2026-07-22
sources:
  - SRC-20260721-avo-official-data-design
---

# 자료 요약: Avo 공식 문서와 가격

## 현재 종합

공식 Source는 Avo가 tracking plan, Journeys, Codegen, Inspector, approval, schema registry sync를 하나의 workspace로 묶는다는 점을 확인한다. 가격과 feature gate도 공식적으로 확인되어 기존 secondary claim을 보정한다. <sup>[🔗](#source-1)</sup>

## 근거

- Avo Tracking Plan은 application data definition이고 codegen과 validation에 사용되는 중심 명세다. <sup>[🔗](#source-1)</sup>
- Workspace 구성 요소에는 Journeys, Tracking Plan Events, Properties, Metrics, Publishing, Connection Setup, Codegen, Inspector가 포함된다. <sup>[🔗](#source-1)</sup>
- Free는 $0, 2 editors, 100k Inspector observed events, editors용 Codegen, 1 downstream schema registry sync를 포함한다. <sup>[🔗](#source-1)</sup>
- Team은 annual 기준 $250/month, monthly 기준 $300/month, 5 editors 포함이다. <sup>[🔗](#source-1)</sup>
- Enterprise는 enforceable approvals, automated required reviews, enforceable standards, 1M Inspector observed events, SSO, premium support를 포함한다. <sup>[🔗](#source-1)</sup>

## 작동 방식

공식 문서는 Avo를 plan authoring tool이 아니라 data design workspace로 위치시킨다. Journeys는 product screenshot 기반 시각 설계를 돕고, Codegen은 implementation artifact를 만들며, Inspector는 deployed event schema를 관찰한다. 이 세 축은 사람이 설계한 plan을 더 강하게 운용하게 하지만, runtime UI action proof 자체를 자동 생성한다는 증거는 없다.

## 평가 기준

- price gate: Free/Team/Enterprise별 governance 기능 차이.
- visual design depth: screenshot/Journey가 runtime evidence와 연결되는지.
- integration: downstream registry sync와 existing CDP coexistence.
- buyer signal: customer index가 실제 구매자 역할을 말해주는지.

## 모순

고객 사례 index는 buyer/champion lead일 뿐 구매자 역할을 확정하는 인터뷰 원문이 아니다.

## 미결 질문

- Avo customer case에서 실제 sponsor와 champion을 추출할 수 있는가?
- Avo를 대체할지 보완할지 결정해야 한다.

## 제품 시사점

Avo 공식 가격과 기능을 기준으로 초기 제품은 Avo Team/Enterprise customer의 보완재 또는 Avo 미도입 팀의 lightweight evidence layer로 포지셔닝할 수 있다.

## 관련 문서

- [[avo|Avo]] - 경쟁사 deep dive
- [[pricing-and-packaging|가격과 패키징 비교]] - 공식 가격 기준 비교
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-avo-official-data-design|Avo official docs: tracking plan, pricing, and customer story index]] - `SRC-20260721-avo-official-data-design`
