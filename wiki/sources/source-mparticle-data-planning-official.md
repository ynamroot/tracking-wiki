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

mParticle Data Planning은 데이터 플랜(data plan)을 ‘수집할 데이터에 대해 코드로 명문화한 기대치(codified expectation)’로 두고, API·SDK·검증 작업 흐름(validation workflow)과 결합한다. 공식 문서에서 데이터 포인트 한도(data point limit)와 계획에 없는 위반(unplanned violation)을 차단하는 범위가 확인된다. <sup>[🔗](#source-1)</sup>

## 근거

- Data Plan은 수집 데이터의 범위(extent)와 형태(shape)에 대해 코드로 명문화한 기대치로 설명된다. <sup>[🔗](#source-1)</sup>
- 공식 문서 기준 데이터 플랜은 최대 1,000개 데이터 포인트(1,000 data points)를 지원한다. <sup>[🔗](#source-1)</sup>
- 데이터 포인트가 400개를 넘으면 화면(UI)에서 관리하기 어려울 수 있어, Data Plan Builder나 Data Planning API 사용을 권장한다. <sup>[🔗](#source-1)</sup>
- 차단할 수 있는 데이터는 계획에 없는 위반, 즉 데이터 플랜 스키마(schema)와 이름이 다른 이벤트나 속성으로 제한된다. <sup>[🔗](#source-1)</sup>
- 공식 Node.js SDK는 데이터 플랜·버전 가져오기(fetch)와, 데이터가 도착하기 전 이벤트·배치 검증(validation before arrival)을 목적으로 한다. <sup>[🔗](#source-1)</sup>

## 작동 방식

mParticle은 기업용 데이터 파이프라인(enterprise data pipeline) 안에서 플랜·버전을 명시하고 이벤트 배치(event batch)를 검증하는 방식이다. 데이터 플랜이 클수록 화면보다 API·Builder 작업 흐름이 중요해지고, 차단 정책은 데이터 유실과 격리(quarantine)·재적재(backfill) 같은 운영 문제를 함께 불러온다.

## 평가 기준

- 플랜 규모(plan scale): 400개·1,000개 데이터 포인트 경계(threshold)가 운영성에 미치는 영향.
- 도착 전 클라이언트 검증(client-before-arrival validation): SDK 검증이 실제 전송 내용(payload)만 보는지, 누락 이벤트(missing event)까지 볼 수 있는지.
- 차단 범위(block scope): 계획된 스키마 불일치(planned schema mismatch)와 완전 누락(complete omission)의 차이.

## 모순

공식 자료는 공개된 정액 가격을 제공하지 않는다. 가격은 맞춤·비공개(custom)로만 다뤄야 한다.

## 미결 질문

- mParticle의 차단 범위가 계측 누락 문제에는 어느 정도 무력한가?
- Data Plan API와 신규 화면 증거 계약(UI evidence contract)을 연결할 수 있는가?

## 제품 시사점

mParticle 고객에게는 데이터 플랜이 이미 있으므로, 신규 제품은 그 플랜을 읽어 배포 전 화면 순회에서 기대되는 이벤트 목록(pre-release UI traversal expected event set)을 만들어 주는 보완재가 될 수 있다.

## 관련 문서

- [[tracking-governance-platforms|트래킹 거버넌스 플랫폼]] - mParticle 비교
- [[validation-layer-model|검증 계층 모델]] - 도착 전 검증
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-mparticle-data-planning-official|mParticle official docs: Data Plans, Data Planning API, and validation SDK]] - `SRC-20260721-mparticle-data-planning-official`
