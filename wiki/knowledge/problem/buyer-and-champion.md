---
title: 구매자와 champion 가설
type: customer
status: current
confidence: low
created: 2026-07-22
updated: 2026-07-22
sources:
  - SRC-20260721-practitioner-pain-points
  - SRC-20260721-avo-official-data-design
  - SRC-20260721-amplitude-official-data-governance
---

# 구매자와 champion 가설

## 현재 종합

현재 Source만으로 경제적 구매자를 확정할 수 없다. 가장 방어적인 가설은 champion은 analytics engineer, data/analytics owner, PM, QA 중 release pain을 직접 겪는 사람이고, buyer는 analytics/data leader 또는 product/engineering leader라는 것이다. Avo 고객 사례 index와 Amplitude 협업 문서는 lead를 제공하지만, 실제 구매 증거는 아니다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup> <sup>[🔗](#source-3)</sup>

## 근거

- 내부 pain Source는 PM, 개발자, 데이터 담당자 사이의 handoff와 반복 QA 비용을 핵심 문제로 다룬다. <sup>[🔗](#source-1)</sup>
- Avo 공식 customer index는 Delivery Hero, Wolt, OneFootball, Fender 등 고객 lead를 나열하지만 구매자 역할은 확정하지 않는다. <sup>[🔗](#source-2)</sup>
- Amplitude 공식 문서는 analyst, PM, engineer 협업 흐름을 제시하지만 구매 승인자 정보는 제공하지 않는다. <sup>[🔗](#source-3)</sup>

## 작동 방식

구매자와 champion은 분리해서 조사해야 한다. champion은 현재 workflow의 friction을 느끼고 pilot을 밀 수 있는 사람이다. buyer는 예산을 승인하고 vendor risk를 감수할 수 있는 사람이다. 행동데이터 품질 제품은 analytics budget, CDP budget, QA automation budget, developer productivity budget 중 어디에 걸리는지에 따라 buyer가 바뀐다.

## 평가 기준

- 기존 도구 지출: Avo, Amplitude, Segment, RudderStack, tag audit, QA automation 예산.
- pain ownership: dashboard incident를 누가 triage하고 누가 사과하는가.
- procurement path: 팀 카드 결제 가능한지, enterprise security review가 필요한지.
- urgency signal: 최근 release에서 tracking issue로 roadmap, revenue, experiment, compliance가 영향을 받았는가.

## 모순

vendor customer logo는 adoption 증거지만 구매자 역할 증거가 아니다. 내부 보고서의 persona는 합리적이지만 primary interview가 필요하다.

## 미결 질문

- `OQ-001`: 최초 champion과 buyer를 인터뷰로 구분해야 한다.
- `OQ-003`: 지불 의사와 구매 trigger를 확인해야 한다.

## 제품 시사점

인터뷰 스크립트는 “누가 불편한가”보다 “누가 지금 해결책을 찾고 있고 어떤 예산으로 살 수 있는가”를 먼저 묻도록 설계해야 한다.

## 관련 문서

- [[behavioral-data-practitioners|행동데이터 운영 실무자]] - 역할별 pain map
- [[research-confidence-map|연구 신뢰도 지도]] - primary evidence 부족 항목
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-practitioner-pain-points|자료 요약: 행동데이터 운영 실무자 페인포인트]] - `SRC-20260721-practitioner-pain-points`
- <a id="source-2"></a>[[source-avo-official-data-design|자료 요약: Avo 공식 문서와 가격]] - `SRC-20260721-avo-official-data-design`
- <a id="source-3"></a>[[source-amplitude-official-data-governance|자료 요약: Amplitude 공식 Data Governance]] - `SRC-20260721-amplitude-official-data-governance`
