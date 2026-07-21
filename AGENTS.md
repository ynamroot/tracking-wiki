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

## Agent 역할

| 역할 | 입력 | 출력 | 허용된 쓰기 영역 |
|---|---|---|---|
| Intake Agent | GitHub Issue, URL, 파일 | 정규화 및 자동 판정된 Source record | `raw/inbox`, `raw/sources`, `raw/rejected` |
| Research Agent | inbox 자료, 조사 질문 | 검증 메모, 보강 Source | `raw/inbox` |
| Wiki Compiler | `raw/sources`, 기존 Wiki | 요약, 개념, 비교, 연결 | `wiki` |
| Wiki Auditor | 전체 Wiki | audit report, open question | `wiki/audits`, `wiki/open-questions.md` |
| Product Agent | Wiki, 승인된 결정 | PRD와 기능 초안 | `product/drafts` |
| Technical Reviewer | 승인 제품 문서 | 기술 초안, ADR, Change Request | `technical/drafts`, `technical/adr`, `technical/change-requests` |

한 작업에서 여러 역할이 필요하면 역할별 단계를 순서대로 수행하고, 각 단계의 권한 경계를 지킨다.

## 자동 Triage 정책

다음 조건을 모두 만족하는 Source는 Intake Agent가 자동으로 `accepted` 처리하고 `raw/sources`로 승격한다.

- 원문 또는 보존된 파일이 존재하고 provenance를 재현할 수 있다.
- 현재 프로젝트 조사 범위와 직접 관련된다.
- 손상되거나 악성인 파일이 아니다.
- exact duplicate가 아니다.

공식 문서, 원 논문, 원 데이터는 `primary`, 내부 조사나 분석 보고서는 `secondary`로 분류한다.
원문 접근 실패, 인용 근거 부족, 권한 불명확은 `needs-verification`으로 격리한다.
범위 밖 자료는 `deferred`, exact duplicate나 무관한 자료는 `rejected`로 보존한다.

다음 예외만 PO에게 escalation한다.

- Source 간 충돌이 제품 방향이나 승인 문서를 바꿀 수 있다.
- 조사 범위 포함 여부가 불명확하다.
- 유료 또는 비공개 자료의 보존과 인용 권한이 불명확하다.
- 자동 판정 신뢰도가 낮다.

## 승인 경계

- Source 개별 승격은 정책 기반 자동 처리하며 판정 근거를 Source record에 기록한다.
- `product/drafts`에서 `product/approved`로의 승격은 PO가 수행한다.
- `technical/drafts`에서 `technical/approved`로의 승격은 PO와 기술 책임자의 승인이 필요하다.
- 제품 요구사항 변경이 필요하면 `technical/change-requests`에 Change Request를 작성한다.
- baseline tag는 승인자가 명시적으로 동결을 요청한 경우에만 생성한다.

## 완료 조건

작업 완료 전 다음을 확인한다.

- 변경한 문서의 Source ID와 링크가 유효하다.
- Ingest 또는 Query 결과를 Wiki에 반영했다면 `wiki/index.md`와 `wiki/log.md`를 갱신했다.
- 모순과 불확실성을 숨기지 않고 표시했다.
- `scripts/Validate-Wiki.ps1` 검사를 통과했다.
