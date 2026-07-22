---
title: "자료 요약: mParticle Data Planning 공식 문서"
type: source-summary
status: current
confidence: high
created: 2026-07-22
updated: 2026-07-22
sources:
  - SRC-20260721-mparticle-data-planning-official
---

# 자료 요약: mParticle Data Planning 공식 문서

## 현재 종합

mParticle Data Planning은 data plan을 수집 데이터의 codified expectation으로 두고, API/SDK/validation workflow와 결합한다. 공식 문서상 data point limit과 unplanned violation 차단 범위가 확인된다. <sup>[🔗](#source-1)</sup>

## 근거

- Data Plan은 수집 데이터의 extent와 shape에 대한 codified expectations로 설명된다. <sup>[🔗](#source-1)</sup>
- 공식 문서 기준 data plan은 최대 1,000 data points를 지원한다. <sup>[🔗](#source-1)</sup>
- 400개 초과 data point는 UI 관리가 어려울 수 있어 Data Plan Builder 또는 Data Planning API 사용을 권장한다. <sup>[🔗](#source-1)</sup>
- block 가능한 data는 unplanned violations, 즉 data plan schema와 이름이 다른 events 또는 attributes로 제한된다. <sup>[🔗](#source-1)</sup>
- official Node SDK는 Data Plan/Version fetch와 event/batch validation before arrival을 목적으로 한다. <sup>[🔗](#source-1)</sup>

## 작동 방식

mParticle은 enterprise data pipeline 안에서 plan/version을 명시하고 event batch를 검증하는 모델이다. data plan이 클수록 UI보다 API/Builder workflow가 중요해지고, 차단 정책은 데이터 유실과 quarantine/backfill 운영 문제를 동반한다.

## 평가 기준

- plan scale: 400/1,000 data point threshold가 운영성에 미치는 영향.
- client-before-arrival validation: SDK validation이 실제 payload만 보는지, missing event도 볼 수 있는지.
- block scope: planned schema mismatch와 complete omission의 차이.

## 모순

공식 Source는 공개 정액 가격을 제공하지 않는다. 가격은 custom/비공개로만 다뤄야 한다.

## 미결 질문

- mParticle의 차단 범위가 계측 누락 문제에는 어느 정도 무력한가?
- Data Plan API와 신규 UI evidence contract를 연결할 수 있는가?

## 제품 시사점

mParticle 고객에게는 data plan이 이미 존재하므로 신규 제품은 그 plan을 읽어 pre-release UI traversal expected event set을 생성하는 보완재가 될 수 있다.

## 관련 문서

- [[tracking-governance-platforms|트래킹 거버넌스 플랫폼]] - mParticle 비교
- [[validation-layer-model|검증 계층 모델]] - before-arrival validation
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-mparticle-data-planning-official|mParticle official docs: Data Plans, Data Planning API, and validation SDK]] - `SRC-20260721-mparticle-data-planning-official`
