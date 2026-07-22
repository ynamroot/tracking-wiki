# 문서 스키마

## 식별자

| 문서 | 형식 | 예시 |
|---|---|---|
| Source | `SRC-YYYYMMDD-slug` | `SRC-20260721-example-report` |
| Open Question | `OQ-NNN` | `OQ-004` |
| Product Decision | `PD-NNN` | `PD-001` |
| Feature | `FEAT-NNN` | `FEAT-001` |
| ADR | `ADR-NNN` | `ADR-001` |
| Change Request | `CR-NNN` | `CR-001` |

slug와 파일 이름에는 소문자 영문, 숫자, 하이픈만 사용한다.
Source summary Wiki 파일은 다른 entity와 basename이 충돌하지 않도록 `source-<slug>.md`를 사용한다.

## Source Record

Source record는 `templates/source-record.md`를 사용한다.

필수 frontmatter:

- `id`: Source ID
- `title`: 원문 제목
- `status`: `inbox`, `needs-verification`, `accepted`, `deferred`, `rejected`, `superseded`
- `source_type`: `article`, `paper`, `documentation`, `report`, `interview`, `dataset`, `issue`, `file`, `other`
- `original_url`: URL 자료가 아니면 빈 문자열
- `submitted_by`, `submitted_at`
- `retrieved_at`: 원문을 실제 확보한 날짜
- `issue_url`: GitHub Issue URL
- `language`
- `publisher`, `authors`, `published_at`
- `reliability`: `unreviewed`, `primary`, `secondary`, `low`
- `content_file`: 로컬 원문 또는 첨부 파일 경로
- `content_sha256`: 로컬 원문이 있을 때 SHA-256
- `supersedes`: 대체하는 Source ID 목록

`raw/inbox`에서는 triage 메모를 보강할 수 있다. `raw/sources`로 승격된 이후에는 immutable이다.

Triage에는 `판정`, `판정자`, `판정일`, `사유`를 기록한다. 자동 판정자는 `LLM auto-triage policy-v1`을 사용한다.
개별 사람의 승인이 없어도 자동 정책을 통과한 Source는 승격할 수 있다.

## Wiki Page

`wiki/overview.md`를 제외한 지식 페이지는 `templates/wiki-page.md`를 사용한다.

저장 위치:

| 문서 성격 | frontmatter `type` | 저장 위치 |
|---|---|---|
| Source 추적 요약 | `source-summary` | `wiki/sources` |
| 고객과 문제 | `customer` | `wiki/knowledge/problem` |
| 시장, 경쟁사, 비교 | `market`, `competitor`, `comparison` | `wiki/knowledge/landscape` |
| 기술과 개념 | `technology`, `concept` | `wiki/knowledge/technology` |
| 교차 Source 종합 | `synthesis` | `wiki/knowledge/synthesis` |
| 운영 감사 | audit report | `wiki/audits` |

폴더는 사람의 탐색 경로를 나타내고 의미 분류의 기준은 frontmatter `type`이다. 지식 페이지 basename은 Wiki 전체에서 유일해야 한다.

상위 폴더만으로 주제를 충분히 설명하려고 하지 않는다. 세부성은 파일 경로보다 페이지 제목, H1, `Current Synthesis`, `See Also`, `wiki/index.md`의 한 줄 설명으로 드러낸다. 필요한 경우 같은 상위 폴더 안에 좁은 주제의 페이지를 추가한다.

필수 frontmatter:

- `title`
- `type`: `source-summary`, `market`, `customer`, `competitor`, `technology`, `concept`, `comparison`, `synthesis`
- `status`: `current`, `disputed`, `stale`, `superseded`
- `confidence`: `low`, `medium`, `high`
- `created`, `updated`
- `sources`: 최소 하나의 Source ID

필수 본문:

- `Current Synthesis`
- `Evidence`
- `Contradictions`
- `Open Questions`
- `Product Implications`
- `See Also`

권장 본문:

- `Context`: 독자가 이 페이지를 읽어야 하는 이유와 범위.
- `Mechanics` 또는 `Workflow`: 기능, 기술, 시장 구조가 실제로 어떻게 작동하는지.
- `Evaluation Criteria`: 비교, benchmark, 기술 가설 검증에 사용할 기준.
- `Limits`: Source coverage, 적용 불가능한 상황, 알려진 약점.

문서가 짧아도 필수 절은 유지한다. 단, 내용이 없으면 빈칸으로 두지 않고 "현재 accepted Source로는 확인되지 않았다"처럼 불확실성을 명시한다.

문장 작성 원칙:

- 외래어와 영문 전문용어는 처음 나올 때 쉬운 한국어 설명을 먼저 쓰고, 필요한 경우 괄호 안에 원어를 병기한다. 예: `검증 규칙 묶음(schema, 스키마)`.
- 같은 문서 안에서는 한 용어를 한 표현으로 통일한다. `증거`, `proof`, `evidence`를 섞지 말고 기본 표현을 `증거`로 둔다.
- 영어 약어는 독자가 바로 알 수 없다고 가정한다. `SDK`, `CDP`, `CI`, `PR`처럼 자주 쓰는 약어도 첫 등장 시 풀어 쓴다.
- 문단은 한 가지 주장만 다룬다. 한 문단에 시장 설명, 기술 설명, 제품 제안이 섞이면 절을 나눈다.
- 표는 비교에만 사용하고, 표 아래에 “그래서 무엇을 뜻하는가”를 한 문단으로 설명한다.
- 어려운 용어가 반복되는 문서는 [[key-terms|핵심 용어 해설]]을 `See Also`에 연결한다.

주장에는 가능한 한 본문을 방해하지 않는 Source 앵커를 붙인다. 본문에는 Source ID를 직접 노출하지 않고, 링크의 title과 문서 하단 `출처` 절에서 전체 ID를 확인할 수 있게 한다.

```markdown
- 주장 내용. <sup>[🔗](#source-1)</sup>

## 출처

- <a id="source-1"></a>[[source-example-report|Example Report]] - `SRC-20260721-example-report`
```

- 한 문서에서 같은 Source를 여러 번 인용해도 같은 `#source-N`을 사용하고 하단 출처 항목은 한 번만 작성한다.
- 여러 Source가 한 주장을 뒷받침하면 Source별 `🔗` 링크를 나란히 둔다.
- `sources` frontmatter에는 기존처럼 전체 Source ID를 기록한다.
- `wiki/log.md` 같은 운영 문서는 이 표시 규칙의 적용 대상이 아니다.
- 출처 앵커는 문단 전체가 아니라 구체 claim에 가깝게 붙인다. 가격, 수치, 기능 지원 여부, 고객 사례, benchmark 구성, 날짜가 있는 주장은 반드시 앵커를 붙인다.
- Source summary에만 근거가 있다는 이유로 지식 페이지의 출처 표기를 생략하지 않는다. 지식 페이지 본문도 독립적으로 claim을 추적할 수 있어야 한다.

여러 Source에서 도출한 해석은 `Synthesis`라고 명시하고, 제품 제안은 `Product Implication`으로 분리한다.

## Open Question

`wiki/open-questions.md`가 미결 질문의 단일 목록이다. 각 지식 페이지의 `Open Questions` 절은 이 단일 목록을 참조하는 지역 인덱스다.

상태 표기:

- `[ ]`: 열림. 아직 답이 없거나 검증이 부족하다.
- `[~]`: 부분 해소. 일부 Source로 좁혀졌지만 결정이나 검증이 남아 있다.
- `[x]`: 해소. 답, 근거 Source, 반영 문서, 해소일이 기록됐다.

작성 규칙:

- 모든 미결 질문은 `OQ-NNN` ID를 가져야 한다.
- 지식 페이지에 새 질문을 쓰면 같은 변경에서 `wiki/open-questions.md`에도 같은 ID로 추가한다.
- 질문을 해소하거나 부분 해소하면 `wiki/open-questions.md`, 해당 질문이 걸린 지식 페이지들, `wiki/log.md`를 같은 변경에서 갱신한다.
- 지식 페이지의 `Open Questions` 절에는 질문 본문만 반복하지 말고, `[[open-questions|OQ-NNN]]` 또는 `OQ-NNN`을 명시해 중앙 목록과 연결한다.
- 해소된 질문은 삭제하지 않는다. `Resolved Questions` 또는 해당 항목의 설명에 근거 Source와 반영 문서를 남긴다.

## Wiki Index

`wiki/index.md`는 공개할 모든 지식 페이지와 Source summary의 wikilink 및 한 줄 설명을 포함한다. 새 페이지 생성, 이름 변경, supersede 시 같은 변경에서 갱신한다. 운영 문서는 `wiki/README.md`에서 안내한다.

Index는 독자의 읽기 순서를 기준으로 정렬한다. 권장 순서는 참여 경로, 먼저 읽기, 최근 변경, 문제 이해, 시장과 경쟁 구도, 기술 접근, 제품 종합, Source summary다. 새 문서를 추가하거나 기존 문서의 의미 있는 결론을 바꾸면 독자가 발견할 수 있도록 `wiki/index.md`와 `wiki/log.md`를 같은 변경에서 갱신한다.

## Wiki Log

`wiki/log.md`는 append-only이며 공개 Wiki의 변경 발견용 페이지다. 새 문서, 의미 있는 결론 변경, open question 상태 변경, 배포 구조 변경은 log에 남긴다.

허용 action은 `ingest`, `query`, `audit`, `update`, `decision`, `freeze`, `review`다. `review`는 비공개 제품 초안 검토 회차와 그 결과로 등록한 open question, 조사 공백 Issue를 기록한다.

```markdown
## [YYYY-MM-DD] action | 설명

수행 내용, 입력 Source ID, 변경한 주요 페이지, 발견한 모순을 기록한다.
```

## 승인 문서

- 초안은 `status: draft`로 시작한다.
- 승인 시 승인자가 파일을 승인 디렉터리로 이동하고 `status: approved`, `approved_by`, `approved_at`을 기록한다.
- 승인 문서를 대체할 때는 기존 문서를 삭제하지 않고 `status: superseded`, `superseded_by`를 기록한다.
- Agent는 승인 상태를 직접 변경하지 않는다.
