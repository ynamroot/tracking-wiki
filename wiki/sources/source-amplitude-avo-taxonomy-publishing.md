---
title: "자료 요약: Amplitude taxonomy·거버넌스 문서와 Avo Publishing 연동 문서"
type: source-summary
status: current
confidence: high
created: 2026-07-23
updated: 2026-07-23
sources:
  - SRC-20260723-amplitude-avo-taxonomy-publishing
---

# 자료 요약: Amplitude taxonomy·거버넌스 문서와 Avo Publishing 연동 문서

## 현재 종합

이 자료는 두 가지를 새로 확인한다. 첫째, Amplitude는 이미 이벤트 이름과 계측 위치까지 제안하는 AI 에이전트 기반 계측 워크플로(`amplitude:taxonomy`, `instrumentation-agent`)를 자사 문서에 공개했다. 둘째, Avo의 Publishing 기능은 트래킹 플랜을 Segment Protocols·Mixpanel Lexicon 등 7개 하류 도구에 자동으로 밀어 넣으며, 대상마다 덮어쓰기·병합 방식이 다르다. <sup>[🔗](#source-1)</sup>

## 근거

- Amplitude `data-planning-playbook`은 `amplitude:taxonomy` "skill"을 명명 규칙·속성 표준·폐기 절차의 단일 진실 원천으로 설명하고, `.amplitude/instrumentation-agent.yaml`·`instrumentation-agent-context.md` 설정 파일과 `amplitude:add-analytics-instrumentation` 자동 계측 파이프라인이 코드 내 정확한 삽입 위치와 추천 이벤트 이름·속성을 생성한다고 밝힌다. <sup>[🔗](#source-1)</sup>
- Amplitude 공식 자료 안에서 이벤트 명명 규칙이 문서마다 엇갈린다 — `data-planning-playbook`과 `analytics-tracking-practices`는 Title Case(`Song Played`)를, `event-taxonomy`는 소문자 스네이크케이스(`button_clicked`)를 권장한다. <sup>[🔗](#source-1)</sup>
- `event-taxonomy` 문서는 이벤트 요청자→데이터 스튜어드→도메인 오너→기술 구현자로 이어지는 승인 구조와, proposed/active/deprecated/removed 생애주기 라벨을 제시한다. <sup>[🔗](#source-1)</sup>
- `data-governance-framework`는 거버넌스를 교육·계측·유지보수 3축으로 나누고 "Data Governor" 역할을 제안하며, Gartner 재인용으로 데이터 품질 저하의 연간 손실을 1,500만 달러로 언급한다(secondary 재인용 수치). <sup>[🔗](#source-1)</sup>
- Avo `publishing`/`integrations` 문서는 Amazon S3, Segment Protocols, Mixpanel Lexicon, RudderStack, Snowplow Data Structures, mParticle Data Master, Amplitude Data, 범용 Webhook 8곳으로의 발행을 확인하며, Auto Publishing은 브랜치 merge 시점에만 발행된다. <sup>[🔗](#source-1)</sup>
- Avo → Segment Protocols는 발행 포함 이벤트를 **덮어쓰기**하고, Avo → Mixpanel Lexicon은 기존 정의와 **병합**한다. 두 경우 모두 대상 도구에만 있는 이벤트는 건드리지 않는다는 원칙은 같다. <sup>[🔗](#source-1)</sup>

## 작동 방식

Avo의 Publishing은 트래킹 플랜을 단일 원본으로 두고 여러 하류 스키마 레지스트리에 같은 모양의 JSON Schema를 밀어 넣는 팬아웃(fan-out) 구조다. Source·Destination·Tag로 발행 범위를 좁힐 수 있고, 이벤트별 이름 매핑과 태그도 함께 전달된다. 다만 대상 도구가 이미 가진 자체 정의와의 충돌 처리 방식(덮어쓰기 vs 병합)은 도구마다 다르므로, 하류 도구를 신뢰할 원본으로 삼을지 Avo를 원본으로 삼을지는 팀마다 결정해야 한다.

## 한계

RudderStack·Snowplow Data Structures·mParticle Data Master·Amazon S3로의 발행은 문서에서 이름만 확인됐고 세부 필드 매핑·덮어쓰기 방식은 이번 자료에 없다. Amplitude의 `amplitude:taxonomy` skill이 실제로 어떤 정확도로 이벤트 이름과 삽입 위치를 제안하는지는 확인되지 않았다 — 문서는 기능 설명일 뿐 성능 데이터가 아니다.

## 모순

Amplitude 자체 문서 안에서 이벤트 명명 규칙이 Title Case와 snake_case로 갈린다. 어느 쪽이 최신 공식 권장인지 이 자료만으로는 판단할 수 없다.

## 미결 질문

- `OQ-012`: Amplitude의 AI 기반 계측 에이전트(`amplitude:taxonomy`)는 실제 운영 환경에서 어느 정도 정확도로 이벤트 이름·삽입 위치를 제안하는가? 자율 순회 기반 계측 제안과 경쟁하거나 보완하는 지점은 무엇인가?

## 제품 시사점

Amplitude가 이미 AI 기반 계측 제안 기능을 문서화했다는 사실은 "자동 계측 제안"을 신규 제품의 단독 차별화로 내세우기 어렵게 만든다. 반대로 Avo의 Publishing이 보여 주는 "설계 원본 → 여러 하류 도구로 팬아웃" 구조는, 신규 제품이 계측 증거를 만들 때 어느 도구를 원본으로 삼고 어디로 결과를 보낼지 설계할 때 참고할 수 있는 선례다.

## 관련 문서

- [[avo|Avo]] - Publishing 반영 대상 지식 페이지
- [[amplitude-data|Amplitude Data]] - taxonomy·거버넌스 반영 대상 지식 페이지
- [[automation-opportunity|행동데이터 자동화 기회]] - AI 계측 에이전트의 경쟁 시사점
- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.

## 출처

- <a id="source-1"></a>[[source-amplitude-avo-taxonomy-publishing|자료 요약: Amplitude taxonomy·거버넌스 문서와 Avo Publishing 연동 문서]] - `SRC-20260723-amplitude-avo-taxonomy-publishing`
