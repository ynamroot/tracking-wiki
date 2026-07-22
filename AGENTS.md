# Agent 운영 규칙

## 시작 절차

1. `PROJECT_CONTEXT.md`를 읽는다.
2. 작업 대상 디렉터리의 가장 가까운 `AGENTS.md`를 읽는다.
3. `wiki/index.md`와 `wiki/log.md`에서 현재 상태를 확인한다.
4. 요청한 작업에 맞는 Agent 역할 하나를 선언하고 그 권한 안에서 작업한다.

## 문서 우선순위

제품 관련 사실과 결론이 충돌하면 다음 순서를 따른다.

1. `product/approved`
2. `product/decisions`
3. `technical/approved`
4. `wiki`
5. `raw`

외부 사실 자체를 검증할 때는 Wiki 요약보다 `raw/sources`의 원문과 provenance를 우선한다.

## 공통 규칙

- 현재 합의된 내용을 임의로 변경하지 않는다.
- 새로운 제안은 기존 결정과 명확히 구분한다.
- 사실, 여러 자료를 종합한 해석, 제품 제안을 구분해서 작성한다.
- 근거 없는 사실을 추가하지 않는다. 모르면 `wiki/open-questions.md`에 남긴다.
- 기존 문서를 삭제하거나 의미를 뒤집기보다 supersede 관계와 변경 이유를 기록한다.
- 날짜는 `YYYY-MM-DD`, Source ID는 `SRC-YYYYMMDD-slug` 형식을 사용한다.
- Wiki 문서는 Obsidian `[[wikilink]]`를 사용한다.
- 자동화는 `product/approved`와 `technical/approved`를 수정하지 않는다.
- `raw/sources`에 승격된 자료는 수정하지 않는다. 정정은 새 Source로 추가한다.
- 이 저장소와 GitHub Issue는 공개 정보로 취급한다. 자격증명, 개인정보, 고객 비밀, 유료·비공개 원문을 기록하거나 첨부하지 않는다.
- 공개 URL의 저작권 원문은 복제하지 않고 URL, retrieval date, claim 단위 요약만 보존한다.
- 비공개 제품 초안, PRD, Feature Spec, Technical Spec의 제목, 내부 용어, 문장을 이 저장소에 옮기지 않는다. 거기서 나온 질문은 시장·기술 조사 질문으로 바꿔 쓴다.

## Agent 역할

| 역할 | 입력 | 출력 | 허용된 쓰기 영역 |
|---|---|---|---|
| Intake Agent | GitHub Issue, URL, 파일 | 정규화 및 자동 판정된 Source record | `raw/inbox`, `raw/sources`, `raw/rejected` |
| Research Agent | inbox 자료, 조사 질문 | 검증 메모, 보강 Source | `raw/inbox` |
| Wiki Compiler | `raw/sources`, 기존 Wiki | 요약, 개념, 비교, 연결 | `wiki` |
| Query Agent | 조사 질문, Wiki, raw Source | 답변, 필요 시 종합 페이지 | `wiki/knowledge/synthesis`, `wiki/index.md`, `wiki/log.md`, `wiki/open-questions.md` |
| Wiki Auditor | 전체 Wiki | audit report, open question | `wiki/audits`, `wiki/open-questions.md` |
| 초안 검토 Agent | 비공개 제품 초안(저장소 밖), Wiki | 판정 보고서(저장소 밖), open question, 조사 공백 Issue | `wiki/open-questions.md`, `wiki/log.md`, 지식 페이지의 `미결 질문` 절(동기화 한정) |
| Product Agent | `research-baseline`, Wiki, 승인 후보 비공개 초안, Product Decision | PRD와 기능 초안(비공개 작업 공간) | `product/decisions`(공개 수위 판단만); PD가 공개를 택한 범위에 한해 `product/drafts` |
| Technical Reviewer | 승인된 PRD와 Feature Spec(비공개일 수 있음) | 기술 초안, ADR, Change Request(비공개일 수 있음) | PD가 공개를 택한 범위에 한해 `technical/drafts`, `technical/adr`, `technical/change-requests` |

초안 검토 Agent의 판정 보고서와 초안 원문, Product Agent와 Technical Reviewer의 PRD·Feature Spec·Technical Spec·ADR 초안은 모두 이 공개 저장소 밖 비공개 작업 공간에 있다. 그 구체 경로는 저장소에 적지 않고 비공개 쪽 운영 문서가 관리한다. 절차는 `OPERATIONS.md`의 "제품 초안 논증", "Productization", "Technical Review" 절을 따른다.

한 작업에서 여러 역할이 필요하면 역할별 단계를 순서대로 수행하고, 각 단계의 권한 경계를 지킨다.

## 자동 Triage 정책

다음 조건을 모두 만족하는 Source는 Intake Agent가 자동으로 `accepted` 처리하고 `raw/sources`로 승격한다.

- 원문 또는 보존된 파일이 존재하고 provenance를 재현할 수 있다.
- 현재 프로젝트 조사 범위와 직접 관련된다.
- 손상되거나 악성인 파일이 아니다.
- exact duplicate가 아니다.

공식 문서, 원 논문, 원 데이터는 `primary`, 내부 조사나 분석 보고서는 `secondary`로 분류한다.
원문 접근 실패, 인용 근거 부족, 권한 불명확은 비공개 내용을 기록하지 않은 Source record만 `needs-verification`으로 격리한다.
범위 밖 자료는 `deferred`, exact duplicate나 무관한 자료는 `rejected`로 보존한다.

다음 예외만 PO에게 escalation한다.

- Source 간 충돌이 제품 방향이나 승인 문서를 바꿀 수 있다.
- 조사 범위 포함 여부가 불명확하다.
- 유료 또는 비공개 자료가 필요해 현재 공개 저장소 밖의 증거 저장소가 필요하다.
- 자동 판정 신뢰도가 낮다.

## 승인 경계

- Source 개별 승격은 정책 기반 자동 처리하며 판정 근거를 Source record에 기록한다.
- `product/drafts`에서 `product/approved`로의 승격은 PO가 수행한다.
- `technical/drafts`에서 `technical/approved`로의 승격은 PO와 기술 책임자의 승인이 필요하다.
- 비공개 초안의 "승인 후보" 판정은 초안 검토 Agent가 하고, 초안 승인과 공개 수위 결정은 PO가 한다.
- 비공개 PRD·Feature Spec·Technical Spec의 공개 수위 결정(`PD-NNN`)도 PO가 하며, 결정 전에는 `product/drafts`·`technical/drafts`에 아무것도 기록하지 않는다.
- 제품 요구사항 변경이 필요하면 `technical/change-requests`에 Change Request를 작성한다.
- baseline tag는 승인자가 명시적으로 동결을 요청한 경우에만 생성한다.

## 완료 조건

작업 완료 전 다음을 확인한다.

- 변경한 문서의 Source ID와 링크가 유효하다.
- Ingest 또는 Query 결과를 Wiki에 반영했다면 `wiki/index.md`와 `wiki/log.md`를 갱신했다.
- 모순과 불확실성을 숨기지 않고 표시했다.
- `scripts/Validate-Wiki.ps1` 검사를 통과했다.
