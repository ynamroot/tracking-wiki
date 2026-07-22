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

공식 자료는 Avo가 트래킹 플랜(tracking plan), Journeys, Codegen, Inspector, 승인(approval), 스키마 레지스트리 동기화(schema registry sync)를 하나의 작업 공간(workspace)으로 묶는다는 점을 확인한다. 가격과 기능 구분선(feature gate)도 공식적으로 확인되어, 기존 2차 자료의 주장(secondary claim)을 보정한다. <sup>[🔗](#source-1)</sup>

## 근거

- Avo Tracking Plan은 애플리케이션의 데이터 정의(application data definition)이며, 코드 생성(codegen)과 검증에 쓰이는 중심 명세다. <sup>[🔗](#source-1)</sup>
- 작업 공간을 이루는 요소에는 Journeys, Tracking Plan Events, Properties, Metrics, Publishing, Connection Setup, Codegen, Inspector가 포함된다. <sup>[🔗](#source-1)</sup>
- Free는 $0, 편집자(editor) 2명, Inspector 관측 이벤트 100k, 편집자용 Codegen, 하류 스키마 레지스트리 동기화 1개를 포함한다. <sup>[🔗](#source-1)</sup>
- Team은 연간 결제 기준 $250/month, 월간 결제 기준 $300/month이며 편집자 5명을 포함한다. <sup>[🔗](#source-1)</sup>
- Enterprise는 강제 가능한 승인(enforceable approvals), 필수 리뷰 자동화(automated required reviews), 강제 가능한 표준(enforceable standards), Inspector 관측 이벤트 1M, 통합 로그인(SSO), 프리미엄 지원(premium support)을 포함한다. <sup>[🔗](#source-1)</sup>

## 작동 방식

공식 문서는 Avo를 단순한 플랜 작성 도구가 아니라 데이터 설계 작업 공간(data design workspace)으로 자리매김한다. Journeys는 제품 스크린샷을 바탕으로 시각 설계를 돕고, Codegen은 구현 결과물(implementation artifact)을 만들며, Inspector는 배포된 이벤트 스키마(deployed event schema)를 관찰한다. 이 세 축은 사람이 설계한 플랜을 더 강하게 운용하게 해 주지만, 실행 시점의 화면 행동 증거(runtime UI action proof) 자체를 자동으로 만들어 낸다는 증거는 없다.

## 평가 기준

- 가격 구분선(price gate): Free/Team/Enterprise별 거버넌스 기능 차이.
- 시각 설계 깊이(visual design depth): 스크린샷이나 Journey가 실행 시점 증거와 연결되는지.
- 통합(integration): 하류 레지스트리 동기화와 기존 고객데이터플랫폼(CDP)과의 공존.
- 구매자 신호(buyer signal): 고객 목록(customer index)이 실제 구매자 역할을 말해 주는지.

## 모순

고객 사례 목록은 구매자·챔피언 후보(buyer/champion lead)를 알려 줄 뿐, 구매자 역할을 확정하는 인터뷰 원문은 아니다.

## 미결 질문

- Avo 고객 사례에서 실제 후원자(sponsor)와 챔피언(champion)을 뽑아낼 수 있는가?
- Avo를 대체할지 보완할지 결정해야 한다.

## 제품 시사점

Avo 공식 가격과 기능을 기준으로, 초기 제품은 Avo Team/Enterprise 고객의 보완재이거나, Avo를 아직 쓰지 않는 팀을 위한 가벼운 증거 계층(lightweight evidence layer)으로 자리 잡을 수 있다.

## 관련 문서

- [[avo|Avo]] - 경쟁사 심층 분석
- [[pricing-and-packaging|가격과 패키징 비교]] - 공식 가격 기준 비교
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-avo-official-data-design|Avo official docs: tracking plan, pricing, and customer story index]] - `SRC-20260721-avo-official-data-design`
