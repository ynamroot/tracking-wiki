---
title: 구매자와 챔피언 가설
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

# 구매자와 챔피언 가설

## 현재 종합

현재 자료만으로 예산을 쥔 구매자를 확정할 수 없다. 가장 방어적인 가설은, 챔피언은 분석 엔지니어(analytics engineer), 데이터·분석 책임자, 기획자(PM), 품질 검증(QA) 담당자 중 배포 관련 고통을 직접 겪는 사람이고, 구매자는 분석·데이터 리더 또는 제품·엔지니어링 리더라는 것이다. Avo 고객 사례 목록(index)과 Amplitude 협업 문서는 실마리(lead)를 제공하지만, 실제 구매 증거는 아니다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup> <sup>[🔗](#source-3)</sup>

## 근거

- 내부 고통 자료는 기획자, 개발자, 데이터 담당자 사이의 넘겨주기(handoff)와 반복되는 품질 검증 비용을 핵심 문제로 다룬다. <sup>[🔗](#source-1)</sup>
- Avo 공식 고객 목록은 Delivery Hero, Wolt, OneFootball, Fender 등 고객 후보를 나열하지만 구매자 역할은 확정하지 않는다. <sup>[🔗](#source-2)</sup>
- Amplitude 공식 문서는 분석가, 기획자, 개발자 협업 흐름을 제시하지만 구매 승인자 정보는 제공하지 않는다. <sup>[🔗](#source-3)</sup>

## 작동 방식

구매자와 챔피언은 분리해서 조사해야 한다. 챔피언은 현재 업무 흐름의 불편(friction)을 느끼고 시범 도입(pilot)을 밀 수 있는 사람이다. 구매자는 예산을 승인하고 공급사 위험(vendor risk)을 감수할 수 있는 사람이다. 행동데이터 품질 제품은 분석 예산, 고객데이터플랫폼(CDP) 예산, 품질 검증 자동화 예산, 개발 생산성 예산 중 어디에 걸리는지에 따라 구매자가 바뀐다.

## 평가 기준

- 기존 도구 지출: Avo, Amplitude, Segment, RudderStack, 태그 감사, 품질 검증 자동화 예산.
- 고통 주체: 대시보드 장애(incident)를 누가 분류(triage)하고 누가 사과하는가.
- 구매 경로: 팀 카드로 결제할 수 있는지, 기업 보안 검토(enterprise security review)가 필요한지.
- 긴급 신호: 최근 배포에서 트래킹 문제로 로드맵, 매출, 실험, 규정 준수가 영향을 받았는가.

## 모순

공급사의 고객 로고는 도입(adoption) 증거지만 구매자 역할 증거가 아니다. 내부 보고서의 페르소나(persona)는 합리적이지만 직접 인터뷰(primary interview)가 필요하다.

## 미결 질문

- `OQ-001`: 최초 챔피언과 구매자를 인터뷰로 구분해야 한다.
- `OQ-003`: 지불 의사와 구매 계기(trigger)를 확인해야 한다.

## 제품 시사점

인터뷰 스크립트는 “누가 불편한가”보다 “누가 지금 해결책을 찾고 있고 어떤 예산으로 살 수 있는가”를 먼저 묻도록 설계해야 한다.

## 관련 문서

- [[behavioral-data-practitioners|행동데이터 운영 실무자]] - 역할별 고통 지도
- [[research-confidence-map|연구 신뢰도 지도]] - 직접 증거가 부족한 항목
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-practitioner-pain-points|자료 요약: 행동데이터 운영 실무자 페인포인트]] - `SRC-20260721-practitioner-pain-points`
- <a id="source-2"></a>[[source-avo-official-data-design|자료 요약: Avo 공식 문서와 가격]] - `SRC-20260721-avo-official-data-design`
- <a id="source-3"></a>[[source-amplitude-official-data-governance|자료 요약: Amplitude 공식 Data Governance]] - `SRC-20260721-amplitude-official-data-governance`
