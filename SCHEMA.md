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
- `See Also`

주장에는 가능한 한 다음 형식으로 근거를 붙인다.

```markdown
- 주장 내용. [SRC-20260721-example-report]
```

여러 Source에서 도출한 해석은 `Synthesis`라고 명시하고, 제품 제안은 `Product Implication`으로 분리한다.

## Wiki Index

`wiki/index.md`는 공개할 모든 지식 페이지와 Source summary의 wikilink 및 한 줄 설명을 포함한다. 새 페이지 생성, 이름 변경, supersede 시 같은 변경에서 갱신한다. 운영 문서는 `wiki/README.md`에서 안내한다.

## Wiki Log

`wiki/log.md`는 append-only다.

```markdown
## [YYYY-MM-DD] action | 설명

수행 내용, 입력 Source ID, 변경한 주요 페이지, 발견한 모순을 기록한다.
```

## 승인 문서

- 초안은 `status: draft`로 시작한다.
- 승인 시 승인자가 파일을 승인 디렉터리로 이동하고 `status: approved`, `approved_by`, `approved_at`을 기록한다.
- 승인 문서를 대체할 때는 기존 문서를 삭제하지 않고 `status: superseded`, `superseded_by`를 기록한다.
- Agent는 승인 상태를 직접 변경하지 않는다.
