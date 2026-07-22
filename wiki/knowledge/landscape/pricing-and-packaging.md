---
title: 가격과 패키징 비교
type: comparison
status: current
confidence: high
created: 2026-07-22
updated: 2026-07-22
sources:
  - SRC-20260721-avo-official-data-design
  - SRC-20260721-amplitude-official-data-governance
  - SRC-20260721-segment-protocols-official
  - SRC-20260721-rudderstack-tracking-plans-official
  - SRC-20260721-mparticle-data-planning-official
---

# 가격과 패키징 비교

## 현재 종합

공식 Source 기준 가격 공개 수준은 크게 다르다. Avo는 Free/Team 가격을 명확히 공개하고 Enterprise를 custom으로 둔다. Amplitude는 Free event volume을 공개하고 Growth/Enterprise를 custom으로 둔다. Segment Protocols와 mParticle은 핵심 governance 가격이 공개 정액이 아니며, RudderStack은 Free/Growth/Enterprise별 tracking plan limit을 비교적 명확히 공개한다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup> <sup>[🔗](#source-3)</sup> <sup>[🔗](#source-4)</sup> <sup>[🔗](#source-5)</sup>

## 근거

- Avo Free는 $0, 2 editors, 100k Inspector observed events이고 Team은 annual $250/month, monthly $300/month다. <sup>[🔗](#source-1)</sup>
- Avo Enterprise는 enforceable approvals, automated required reviews, enforceable standards, 1M Inspector observed events, SSO, premium support를 포함한다. <sup>[🔗](#source-1)</sup>
- Amplitude Free plan은 2 million events/month를 포함하고 Growth/Enterprise는 custom-priced다. <sup>[🔗](#source-2)</sup>
- Segment Protocols는 Customer Data Pipeline Business plan과 CDP plans의 optional add-on이다. <sup>[🔗](#source-3)</sup>
- RudderStack Tracking Plans는 Free 1 plan/5 events, Growth unlimited plans/75 events, Enterprise unlimited/unlimited로 제한된다. <sup>[🔗](#source-4)</sup>
- mParticle 공식 Source는 공개 정액 가격을 확정하지 못하며 Data Plan feature와 API/SDK workflow를 설명한다. <sup>[🔗](#source-5)</sup>

## 작동 방식

가격은 제품 포지션을 말한다. Avo는 editor와 observed events 중심으로 data design workspace를 판다. Amplitude는 analytics event volume과 platform tier가 중심이다. Segment/mParticle은 enterprise data pipeline add-on 성격이 강하다. RudderStack은 governance feature를 낮은 tier에도 보여주지만 limit으로 expansion을 유도한다.

## 평가 기준

- self-serve 가능성: 공개 가격과 무료 tier가 pilot을 가능하게 하는가.
- usage metric: editor, event volume, MTU, plan/event count 중 무엇을 과금 기준으로 삼는가.
- governance gate: approval, standards, violation management가 어느 tier부터 의미 있는가.
- integration cost: 기존 analytics/CDP spend 위에 추가 budget을 요구하는가.

## 모순

secondary Source의 제3자 계약 규모와 공식 가격은 비교 목적이 다르다. 제품 판단에는 공식 가격을 우선하고, 실제 지불 의사는 인터뷰나 구매 사례로 검증해야 한다.

## 미결 질문

- 신규 제품의 가격 metric은 route/run, tracked event, team seat, connected destination 중 무엇이 적절한가?
- buyer가 이미 CDP/analytics 비용을 내는 경우 addon budget을 만들 수 있는가?

## 제품 시사점

초기 packaging은 enterprise governance suite가 아니라 release 검증 run 또는 project당 evidence automation으로 self-serve pilot을 가능하게 해야 한다.

## 관련 문서

- [[avo|Avo]] - Avo pricing details
- [[tracking-governance-platforms|트래킹 거버넌스 플랫폼]] - governance 기능 비교
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-avo-official-data-design|자료 요약: Avo 공식 문서와 가격]] - `SRC-20260721-avo-official-data-design`
- <a id="source-2"></a>[[source-amplitude-official-data-governance|자료 요약: Amplitude 공식 Data Governance]] - `SRC-20260721-amplitude-official-data-governance`
- <a id="source-3"></a>[[source-segment-protocols-official|자료 요약: Twilio Segment Protocols 공식 문서]] - `SRC-20260721-segment-protocols-official`
- <a id="source-4"></a>[[source-rudderstack-tracking-plans-official|자료 요약: RudderStack Tracking Plans 공식 문서]] - `SRC-20260721-rudderstack-tracking-plans-official`
- <a id="source-5"></a>[[source-mparticle-data-planning-official|자료 요약: mParticle Data Planning 공식 문서]] - `SRC-20260721-mparticle-data-planning-official`
