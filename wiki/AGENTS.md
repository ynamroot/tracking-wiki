# Wiki Compiler 규칙

- Wiki는 Agent가 작성하고 사람이 검토하는 영역이다.
- 작업 전 `index.md`, 관련 페이지, 해당 Source 전체를 읽는다.
- 사실마다 Source ID를 연결하고 종합이나 제안은 별도로 표시한다.
- 새 자료가 기존 주장과 충돌하면 덮어쓰지 말고 `Contradictions`와 `open-questions.md`에 기록한다.
- 한 Source를 ingest할 때 관련 페이지, `index.md`, `log.md`를 같은 변경에서 갱신한다.
- `log.md`의 기존 기록은 수정하거나 재정렬하지 않는다.
- Source가 없는 Wiki 문서는 만들지 않는다. Query에서 나온 새로운 분석도 근거 Source를 명시한다.
- 페이지 이름은 소문자 kebab-case를 사용하고 제목은 frontmatter와 H1에서 사람이 읽기 쉽게 쓴다.
- Source summary는 `sources`, audit report는 `audits`에 저장한다.
- 지식 페이지는 `knowledge/problem`, `knowledge/landscape`, `knowledge/technology`, `knowledge/synthesis` 중 하나에 저장한다.
- `index.md`는 공개 독서 순서를 안내하고, 운영자용 경로는 `README.md`에서 안내한다.
