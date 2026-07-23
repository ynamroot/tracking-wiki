---
title: MVP outcome 선택지
type: synthesis
status: current
confidence: low
created: 2026-07-22
updated: 2026-07-23
sources:
  - SRC-20260721-practitioner-pain-points
  - SRC-20260721-tag-audit-qa-tools
  - SRC-20260721-web-agent-eval-benchmarks
  - SRC-20260721-tracking-governance-remaining-tools
  - SRC-20260722-prospect-interview-behavior-data-fusion
---

# MVP outcome 선택지

## 현재 종합

최소기능제품(MVP) 후보는 세 가지다: 배포 전 회귀 검증, 운영 파손 경보, 자동 계측 제안. 현재 자료(Source) 기준으로 가장 방어적인 순서는 배포 전 회귀 검증, 운영 파손 경보, 자동 계측 제안이다. 자동 계측 제안은 매력적이지만 정확도·안전성 근거가 가장 부족하다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup> <sup>[🔗](#source-3)</sup> <sup>[🔗](#source-4)</sup>

## 근거

- 실무의 어려움(pain)은 수동 품질 검사(QA)와 늦은 파손 발견을 반복되는 문제로 제시한다. <sup>[🔗](#source-1)</sup>
- 태그 감사(tag audit) 도구는 운영 감시와 스캔(scan)이 이미 경쟁 영역임을 보여준다. <sup>[🔗](#source-2)</sup>
- 웹 에이전트 벤치마크(web-agent benchmark)는 화면 순회 자동화(traversal automation)의 출발점(seed)을 제공하지만, 트래킹 전용 평가(tracking-specific evaluation)는 별도 설계가 필요하다. <sup>[🔗](#source-3)</sup>
- 인접 도구 자료는 배포 전 검증과 요소-이벤트 증거를 공백으로 제시한다. <sup>[🔗](#source-4)</sup>

## 작동 방식

배포 전 회귀 검증은 코드 변경 요청(PR)이나 빌드 단계에서 바뀐 화면 경로(changed route)를 돌며 기대 이벤트가 실제로 발생했다는 증거(expected event proof)를 만든다. 운영 파손 경보는 운영 트래픽의 평소 기준선(production traffic baseline)과 이상치(anomaly)를 감지한다. 자동 계측 제안은 화면 요소와 업무 의도(business intent)를 추론해 새 이벤트나 코드 삽입(code insertion)을 제안한다. 세 단계는 성숙도 사다리(maturity ladder)로 볼 수 있다.

## 평가 기준

| 후보 | 강점 | 위험 |
|---|---|---|
| 배포 전 회귀 검증 | proof-first, release workflow에 명확 | traversal coverage와 expected event set 필요 |
| 운영 파손 경보 | 실제 traffic 기반 | 이미 사고 후이며 기존 tag audit과 겹침 |
| 자동 계측 제안 | value가 큼 | false positive, privacy, 승인 경계 위험 |

## 모순

고객에 따라 운영 경보가 더 급할 수 있다. 자료만으로 MVP를 확정하면 안 되고, 인터뷰로 배포 관련 어려움(release pain)과 운영 사고 관련 어려움(incident pain)을 비교해야 한다.

익명화한 잠재 고객 인터뷰 1건은 자체 구축 전환 조건으로 "현재 도구를 조작해 가며 확인하는 탐색을 별도 조작 없이 바로 볼 수 있는 형태"를 언급했다. <sup>[🔗](#source-5)</sup> 이는 위 세 후보(배포 전 회귀 검증, 운영 파손 경보, 자동 계측 제안) 중 어느 것과도 정확히 일치하지 않는 네 번째 축("즉시 탐색")일 수 있다. 다만 이 인터뷰는 AI 요약본 1건뿐이라 새 MVP 후보로 확정하기보다 후속 확인이 필요한 신호로만 남긴다.

## 미결 질문

- `OQ-002`: 첫 MVP 성과는 무엇인가?
- `OQ-003`: 가치 제안(value proposition) 검증 기준은 무엇인가?

## 제품 시사점

우선순위 제안은 `배포 전 회귀 검증 -> 운영 경보 -> 자동 계측 제안`이다. 자동 계측은 증거(proof)와 승인 흐름(approval loop)이 검증된 뒤 확장해야 한다.

## 관련 문서

- [[automation-opportunity|행동데이터 자동화 기회]] - 전체 기회
- [[tracking-qa-workflow|트래킹 QA 운영 흐름]] - 배포 사용 사례
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-practitioner-pain-points|자료 요약: 행동데이터 운영 실무자 페인포인트]] - `SRC-20260721-practitioner-pain-points`
- <a id="source-2"></a>[[source-tag-audit-qa-tools|자료 요약: 태그 감사 및 자동 순회 QA 도구]] - `SRC-20260721-tag-audit-qa-tools`
- <a id="source-3"></a>[[source-web-agent-eval-benchmarks|자료 요약: Web Agent Evaluation Benchmarks]] - `SRC-20260721-web-agent-eval-benchmarks`
- <a id="source-4"></a>[[source-tracking-governance-remaining-tools|자료 요약: 트래킹 거버넌스 및 인접 도구]] - `SRC-20260721-tracking-governance-remaining-tools`
- <a id="source-5"></a>[[source-prospect-interview-behavior-data-fusion|자료 요약: 잠재 고객 인터뷰 — 행동데이터와 내부 서비스 데이터 결합 요구]] - `SRC-20260722-prospect-interview-behavior-data-fusion`
