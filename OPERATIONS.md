# 운영 Runbook

## 1. Source Intake

팀원은 GitHub에서 `Source 제출` Issue를 만든다. 저장소와 Issue는 공개되므로 공개 URL 또는 재배포 가능한 파일만 제출하고, 개인정보·고객 비밀·유료·비공개 원문은 첨부하지 않는다. Intake Agent에게 다음과 같이 요청한다.

```text
Intake Agent 역할로 source:new Issue를 처리하라.
중복을 확인하고 Source record를 raw/inbox에 생성하라.
Wiki나 승인 문서는 수정하지 마라.
```

Intake 결과는 `raw/inbox/SRC-YYYYMMDD-slug.md`다. URL 자료는 retrieval date와 publisher 및 claim 단위 요약을 기록하되 저작권 원문 전체를 복제하지 않는다. 재배포 가능한 파일 자료만 `raw/assets`에 보존하고 경로와 SHA-256을 기록한다.

## 2. Automatic Triage

Intake Agent는 Source를 다음 중 하나로 자동 판정한다.

| 판정 | GitHub label | 저장 위치 | 다음 단계 |
|---|---|---|---|
| 추가 검증 | `source:needs-verification` | `raw/inbox` | Research Agent 또는 예외 검토 |
| 채택 | `source:accepted`, `ingest:pending` | `raw/sources` | 자동 Wiki Compiler |
| 보류 | `source:deferred` | `raw/inbox` | 범위 변경 시 재검토 |
| 제외 | `source:rejected` | `raw/rejected` | 종료 |

Agent는 provenance 재현성, 프로젝트 관련성, 원문 접근성, exact duplicate, 파일 안전성을 검사한다.
정책을 통과하면 `accepted`로 자동 승격하고 Source record의 Triage에 판정 정책, 날짜, 사유를 기록한다.
승격한 뒤에는 수정하지 않는다.

PO escalation은 범위가 불명확하거나 공개 저장소에서 다룰 수 없는 자료가 필요하거나 제품 방향을 바꿀 충돌이 있을 때만 발생한다. 비공개 자료는 escalation 여부와 무관하게 이 저장소에 기록하지 않는다.

## 3. Ingest Workflow

가능하면 Source를 한 번에 하나씩 처리한다.

```text
Wiki Compiler 역할로 SRC-YYYYMMDD-slug를 ingest하라.
index를 먼저 읽고 관련 기존 페이지를 모두 확인하라.
사실, 종합, 제품 시사점을 구분하고 모순을 숨기지 마라.
index와 log까지 갱신하라.
```

실행 순서:

1. Source record와 보존된 원문 전체를 읽는다.
2. `wiki/index.md`에서 관련 페이지를 찾고 내용을 읽는다.
3. Source의 핵심 주장, 방법, 한계, 제품/기술 관련성을 claim 단위로 분해한다.
4. `wiki/sources`에 Source summary를 생성한다.
5. 관련 지식 페이지를 `wiki/knowledge/problem`, `landscape`, `technology`, `synthesis` 중 해당 경로에 생성하거나 갱신한다.
6. 주제가 비대해지면 새 지식 페이지로 분할하고, 상위 페이지는 지도와 핵심 종합을 유지한다.
7. 상충하는 주장을 `Contradictions`와 `open-questions.md`에 기록한다.
8. 변경된 모든 페이지의 `updated`, `sources`, `confidence`를 갱신한다.
9. `wiki/index.md`에 새 페이지와 한 줄 설명을 추가한다.
10. `wiki/log.md`에 `ingest` 기록을 append한다.
11. 검증 스크립트를 실행하고 Issue를 `ingest:complete`로 전환한다.

### Ingest Quality Bar

Wiki는 단순 요약 저장소가 아니라 전문가가 빠르게 맥락과 판단 근거를 얻는 지식 문서다. 새 ingest는 다음 기준을 만족해야 한다.

- Source summary는 원문 provenance, 이 자료가 답하는 질문, 핵심 claim, 적용 범위, 한계, 기존 Wiki와 달라진 점을 포함한다.
- 지식 페이지는 최소한 배경 맥락, 작동 방식 또는 workflow, 주요 행위자와 사용 장면, 확인된 사실, 한계와 반례, 제품/기술 시사점을 구분한다.
- 경쟁사나 기술 문서는 기능 나열에 그치지 않고 검증 위치, 운영 책임, 실패 처리, 통합 경계, 가격/패키징 또는 배포 조건을 함께 정리한다.
- dataset이나 benchmark 문서는 task 구성, 평가 지표, coverage, 프로젝트 가설에 바로 쓸 수 있는 부분과 쓸 수 없는 부분을 분리한다.
- 정량 주장, 가격, 기능 지원 여부, 고객 사례, benchmark 수치는 반드시 claim-level Source 앵커를 붙인다.
- Source가 빈약하면 Wiki 본문도 확정적으로 부풀리지 않고 `confidence: low`, `Open Questions`, `needs-verification`을 명시한다.

### Page Splitting And Knowledge Taxonomy

`knowledge` 하위의 현재 4개 축은 탐색을 위한 상위 분류다. 세부 지식은 폴더보다 페이지 단위로 분할하고, index와 See Also로 방향을 잃지 않게 연결한다.

| 상위 축 | 넣을 내용 | 분할 후보 |
|---|---|---|
| `problem` | 고객, 역할, workflow, pain point, 구매 맥락 | buyer/champion, QA workflow, incident cost, adoption friction |
| `landscape` | 시장 지도, 경쟁사, 대체재, pricing, positioning | vendor별 deep dive, category comparison, pricing and packaging |
| `technology` | 수집, 검증, schema, agent, benchmark, 운영 아키텍처 | validation layer, element fingerprinting, autonomous traversal, evaluation dataset |
| `synthesis` | 여러 Source를 종합한 기회, 전략, 위험, 의사결정 근거 | MVP outcome, wedge hypothesis, risk register, research baseline summary |

다음 중 하나에 해당하면 새 페이지로 분할한다.

- 한 문서가 서로 다른 질문 두 개 이상을 답해 독자가 특정 주제만 찾기 어렵다.
- 독립적으로 갱신될 가능성이 높은 주제다.
- 서로 다른 Source 묶음이나 confidence 수준을 가진다.
- 본문이 길어져 상위 종합, 세부 근거, 제품 시사점이 한 화면에서 섞인다.

반대로 독립 질문, 독립 Source, 독립 갱신 가능성이 없으면 같은 페이지의 절로 유지한다.

Wiki 본문의 근거 표기는 `SCHEMA.md`의 Source 앵커 형식을 따른다. 본문에는 `SRC-...`를 직접 표시하지 않고 `🔗` 앵커로 문서 하단 `출처` 절에 연결한다.

### Open Question Sync

Open question은 자동 동기화되지 않는다. Agent가 같은 변경에서 수동으로 동기화한다.

질문을 추가할 때:

1. `wiki/open-questions.md`에 `OQ-NNN`으로 등록한다.
2. 관련 지식 페이지의 `Open Questions` 절에 같은 `OQ-NNN`을 적는다.
3. 질문이 특정 Source에서 나온 경우 Source summary에도 같은 `OQ-NNN`을 적는다.

질문이 부분 해소 또는 완전 해소될 때:

1. `wiki/open-questions.md`의 상태를 `[~]` 또는 `[x]`로 바꾼다.
2. 관련 지식 페이지의 본문, `Open Questions`, `Contradictions`, `confidence`를 갱신한다.
3. 근거 Source와 반영된 문서를 항목 설명에 남긴다.
4. `wiki/log.md`에 `update` 또는 `decision` 기록을 append한다.

질문을 삭제하지 않는다. 해소된 질문은 추적 가능하도록 남긴다.

## 4. Query Workflow

```text
Query Agent로 다음 질문에 답하라: <질문>
wiki/index.md에서 시작하고 필요한 Wiki와 raw Source를 읽어라.
확인된 사실, 종합한 해석, 제품 제안, 미결 질문을 구분하라.
가치 있는 분석은 wiki/knowledge/synthesis에 저장하고 index와 log를 갱신하라.
```

Query 답변은 Source ID를 추적하되, Wiki에 저장하는 본문은 Source 앵커 형식을 사용한다. Wiki만으로 답할 수 없으면 추측하지 않고 `open-questions.md`와 GitHub `question:open` Issue에 조사 공백을 남긴다.

## 5. Wiki Audit

Source 10개 ingest 또는 주 1회 중 먼저 도래한 시점에 실행한다.

```text
Wiki Auditor 역할로 전체 Wiki를 검사하라.
모순, stale claim, 인용 누락, 깨진 링크, 고립 페이지,
없는 핵심 개념, 조사 공백을 찾고 audit report를 작성하라.
제품 판단이 필요한 항목은 직접 해결하지 마라.
```

Audit 결과는 `wiki/audits/YYYY-MM-DD-audit.md`에 저장한다. 기계적으로 고칠 수 있는 index와 링크는 함께 수정할 수 있지만, 의미가 바뀌는 수정은 PO 판정을 기다린다.

## 6. Research Baseline

다음 조건을 모두 만족할 때 PO가 조사 종료를 선언한다.

- 핵심 고객, 문제, 대체재, 경쟁사, 시장, 기술 위험에 대한 Wiki 페이지가 있다.
- 주요 주장에 accepted Source가 연결되어 있다.
- P0 open question이 없다.
- 최신 Wiki Audit의 high-severity 항목이 해소됐다.
- PO가 현재 종합을 제품 초안의 근거로 승인했다.

승인 후 annotated tag를 만든다.

```powershell
git tag -a research-baseline -m "Freeze approved research baseline"
```

이미 tag가 있으면 덮어쓰지 않고 `research-baseline-v2`처럼 새 버전을 사용한다.

## 7. Productization

Product Agent는 `research-baseline`을 기준으로 `product/drafts`에 PRD와 Feature Spec을 작성한다. 제안된 제품 판단은 `product/decisions`에 `status: proposed`로 남긴다.

PO는 다음을 검토한다.

- 고객과 문제 정의가 Source에 의해 뒷받침되는가?
- Value Proposition과 비목표가 명확한가?
- 요구사항이 검증 가능한가?
- 성공 지표가 제품 목표와 연결되는가?
- 해석이나 제안이 외부 사실로 표현되지 않았는가?

승인 시에만 PO가 문서를 `product/approved`로 이동하고 승인 metadata를 기록한다.

## 8. Technical Review

Technical Reviewer는 승인 제품 문서만을 입력으로 사용한다. `technical/drafts`에 Technical Spec, `technical/adr`에 ADR을 작성한다.

반드시 다음을 검토한다.

- 데이터 수집 경계와 이벤트 스키마
- 개인정보, 동의, 마스킹, 보존 및 삭제
- 보안과 접근 통제
- 처리량, 지연, 저장 비용
- 장애, 재시도, 중복, 순서 보장
- 관측 가능성과 운영 절차
- 테스트와 점진적 rollout

제품 요구사항 변경이 필요하면 `technical/change-requests`에 CR을 작성한다. PO가 CR을 승인 또는 거절한 뒤 관련 제품 및 기술 초안을 갱신한다.

## 9. Spec Baseline And Archive

승인된 PRD, Feature Spec, Technical Spec, 핵심 ADR 사이에 미해결 충돌이 없고 P0 CR이 모두 결정되면 tag를 만든다.

```powershell
git tag -a spec-baseline -m "Freeze approved product and technical specifications"
```

이후 Wiki는 기준 시점의 조사 기록으로 동결한다. 새 조사나 제품 변경은 새 milestone 또는 새 baseline 버전에서 수행한다.

## 10. Public Wiki

Git 저장소의 `wiki`가 유일한 원본이다. Quartz는 공개 독서 화면만 생성하며 빌드 결과는 commit하지 않는다.

로컬 빌드:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/Build-WikiSite.ps1
```

로컬 preview:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/Build-WikiSite.ps1 -Serve -Port 8080
```

`master` push에서는 구조 검증과 Quartz build가 모두 통과한 뒤 GitHub Pages를 배포한다. `wiki/AGENTS.md`, `wiki/README.md`, `wiki/log.md`, `wiki/audits`는 사이트 빌드에서 제외한다.
