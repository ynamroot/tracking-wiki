---
title: 핵심 용어 해설
type: concept
status: current
confidence: medium
created: 2026-07-22
updated: 2026-07-22
sources:
  - SRC-20260721-practitioner-pain-points
  - SRC-20260721-autocapture-tag-managers
  - SRC-20260721-tracking-governance-four-tools
  - SRC-20260721-schema-data-contracts
  - SRC-20260721-web-agent-eval-benchmarks
  - SRC-20260722-commercial-tools-survey
  - SRC-20260722-commercial-tools-official-docs
  - SRC-20260722-tracking-glossary
---

# 핵심 용어 해설

## 현재 종합

이 Wiki는 행동데이터 수집, 검증, 경쟁 제품, 웹 자동화 평가를 함께 다루기 때문에 외래어와 약어가 많다. 아래 용어는 문서 전체에서 반복해서 쓰이는 기본 단어다. 이 페이지는 제품 결론을 새로 제안하지 않고, 기존 Source를 읽기 위한 용어 안내 역할을 한다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup> <sup>[🔗](#source-3)</sup> <sup>[🔗](#source-4)</sup> <sup>[🔗](#source-5)</sup> <sup>[🔗](#source-6)</sup> <sup>[🔗](#source-7)</sup> 더 상세하고 벤더 고유 용어(SchemaVer, Iglu, 격리, 전파, 데드레터 큐 등)까지 다루는 목록은 [[tracking-terminology|트래킹 상세·벤더 용어 사전]]에 있다. <sup>[🔗](#source-8)</sup>

## 근거

- 내부 조사 Source들은 tracking plan, tag manager, schema, validation, benchmark 같은 용어를 반복해서 사용한다. <sup>[🔗](#source-1)</sup> <sup>[🔗](#source-2)</sup> <sup>[🔗](#source-3)</sup> <sup>[🔗](#source-4)</sup> <sup>[🔗](#source-5)</sup>
- 상용 도구 조사와 공식 문서 보강은 selector, DOM, dataLayer, synthetic scan, passive monitoring, funnel 같은 웹 분석 운영 용어를 추가로 사용한다. <sup>[🔗](#source-6)</sup> <sup>[🔗](#source-7)</sup>

## 작동 방식

| 용어 | 쉬운 설명 |
|---|---|
| 행동데이터 | 사용자가 제품 안에서 한 행동을 기록한 데이터. 예: 버튼 클릭, 가입 완료, 장바구니 추가. |
| 이벤트(event) | 기록할 사용자 행동 하나. 예: `purchase_completed`는 구매 완료 이벤트다. |
| 속성(property) | 이벤트에 붙는 상세 정보. 예: 구매 금액, 상품 ID, 화면 이름. |
| 트래킹 플랜(tracking plan) | 어떤 이벤트와 속성을 언제 수집할지 정한 약속 문서. |
| 계측(instrumentation) | 제품 코드나 설정에 이벤트 수집 코드를 심는 일. |
| 스키마(schema) | 이벤트와 속성이 어떤 이름과 타입을 가져야 하는지 정한 규칙. |
| 검증(validation) | 실제 들어온 데이터가 정해 둔 규칙과 맞는지 확인하는 일. |
| 페이로드(payload) | 이벤트가 서버나 분석 도구로 보낼 때 담고 가는 실제 내용물. |
| 코드 생성(codegen) | 트래킹 플랜을 바탕으로 개발자가 쓸 함수를 자동으로 만드는 일. |
| SDK | 개발자가 앱에 붙여 쓰는 도구 모음. 여기서는 이벤트를 보내는 수집 도구를 뜻하는 경우가 많다. |
| CDP | 고객데이터플랫폼. 여러 곳에서 들어온 고객·이벤트 데이터를 모아 다른 도구로 보내는 시스템. |
| 태그매니저(tag manager) | 웹사이트 코드를 매번 배포하지 않고도 마케팅·분석 태그를 설정하는 도구. |
| 오토캡처(autocapture) | 클릭이나 페이지 이동 같은 행동을 사람이 일일이 지정하지 않아도 자동으로 모으는 방식. |
| 선택자(selector) | 화면 안의 특정 요소를 찾기 위한 주소. CSS selector나 XPath가 대표적이며, 화면 구조가 바뀌면 깨질 수 있다. |
| DOM | 브라우저가 HTML 화면을 나무 구조로 표현한 것. 오토캡처와 태그매니저는 이 구조에서 버튼, 입력창, 링크를 찾는 경우가 많다. |
| dataLayer | 태그매니저에 분석용 값을 전달하기 위해 웹페이지가 미리 쌓아 두는 데이터 공간. DOM에서 값을 긁는 것보다 안정적인 방식으로 여겨진다. |
| 합성 스캔(synthetic scan) | 실제 사용자를 기다리지 않고, 브라우저나 봇이 정해진 페이지와 경로를 직접 실행해 검사하는 방식. |
| 수동 관찰(passive monitoring) | 도구가 실제 사용자 트래픽을 듣고 평소와 다른 이벤트·속성·목적지를 감지하는 방식. 여기서 수동은 사람이 한다는 뜻이 아니라 “트래픽을 먼저 만들지 않는다”는 뜻이다. |
| 퍼널(funnel) | 가입, 결제, 문의처럼 사용자가 순서대로 거치는 단계 묶음. 어느 단계에서 이탈하는지 분석할 때 쓴다. |
| 수집 지점(ingestion) | 이벤트가 분석 시스템이나 데이터 파이프라인으로 처음 들어오는 지점. |
| 데이터 웨어하우스(warehouse) | 분석에 쓰기 위해 데이터를 모아 두는 저장소. |
| 증거(proof/evidence) | “이 화면에서 이 행동을 했고, 이 이벤트가 실제로 발생했다”는 것을 재현 가능하게 보여주는 기록. |
| 요소 지문(element fingerprint) | 버튼이나 입력창 같은 화면 요소를 다시 찾기 위해 쓰는 단서 묶음. 텍스트, 위치, 역할, DOM 경로 등이 포함될 수 있다. |
| 자율 순회 | 사람이 클릭 순서를 직접 지정하지 않아도 에이전트가 화면을 돌아다니며 작업을 수행하는 방식. |
| 벤치마크(benchmark) | 기술 성능을 비교하기 위해 만든 표준 과제나 데이터셋. |
| 회귀 검증(regression test) | 예전에는 되던 기능이 새 배포 뒤에도 계속 되는지 확인하는 테스트. |
| 구매자(buyer) | 실제 예산을 승인하는 사람이나 조직. |
| 챔피언(champion) | 문제를 강하게 느끼고 내부에서 도입을 밀어줄 사람. |

## 평가 기준

새 문서를 작성할 때는 이 표의 쉬운 설명을 기본 표현으로 사용한다. 원어는 독자가 검색하거나 공식 문서를 대조해야 할 때만 괄호로 병기한다.

## 모순

같은 용어가 제품마다 조금 다르게 쓰일 수 있다. 예를 들어 “검증”은 코드 작성 전 확인, 이벤트 수집 시점 확인, 데이터 창고 적재 후 확인을 모두 가리킬 수 있다. 그래서 문서에서는 검증 위치를 함께 적어야 한다.

## 미결 질문

- 문서가 늘어나면서 새 약어나 벤더 고유 용어가 생기면 이 페이지에 추가해야 한다.

## 제품 시사점

제품 문서와 PRD를 작성할 때도 “정확한 용어”보다 “팀 사이에 오해가 없는 용어”를 우선해야 한다. 특히 구매자·챔피언 인터뷰에서는 영어 약어보다 실제 업무 표현을 사용해야 한다.

## 관련 문서

- [[tracking-terminology|트래킹 상세·벤더 용어 사전]] - 스키마·옵저버빌리티·거버넌스·파이프라인의 상세·벤더 용어.
- [[validation-layer-model|검증 계층 모델]] - “검증”이 어디에서 일어나는지 구분한다.
- [[element-event-evidence|요소-이벤트 증거 모델]] - 증거와 요소 지문을 더 자세히 설명한다.

## 출처

- <a id="source-1"></a>[[source-practitioner-pain-points|자료 요약: 행동데이터 운영 실무자 페인포인트]] - `SRC-20260721-practitioner-pain-points`
- <a id="source-2"></a>[[source-autocapture-tag-managers|자료 요약: 오토캡처와 태그매니저]] - `SRC-20260721-autocapture-tag-managers`
- <a id="source-3"></a>[[source-tracking-governance-four-tools|자료 요약: 트래킹 거버넌스 도구 4종]] - `SRC-20260721-tracking-governance-four-tools`
- <a id="source-4"></a>[[source-schema-data-contracts|자료 요약: 스키마 및 데이터 계약 계층]] - `SRC-20260721-schema-data-contracts`
- <a id="source-5"></a>[[source-web-agent-eval-benchmarks|자료 요약: Web Agent Evaluation Benchmarks]] - `SRC-20260721-web-agent-eval-benchmarks`
- <a id="source-6"></a>[[source-commercial-tools-survey|자료 요약: 상용 도구 조사]] - `SRC-20260722-commercial-tools-survey`
- <a id="source-7"></a>[[source-commercial-tools-official-docs|자료 요약: 상용 도구 공식 문서 보강]] - `SRC-20260722-commercial-tools-official-docs`
- <a id="source-8"></a>[[source-tracking-glossary|자료 요약: 트래킹 플랜 자동화 용어집]] - `SRC-20260722-tracking-glossary`
