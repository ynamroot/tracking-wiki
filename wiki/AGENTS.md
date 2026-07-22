# Wiki Compiler 규칙

- Wiki는 Agent가 작성하고 사람이 검토하는 영역이다.
- 작업 전 `index.md`, 관련 페이지, 해당 Source 전체를 읽는다.
- 사실마다 `<sup>[🔗](#source-N)</sup>` 형식의 Source 앵커를 연결하고, 전체 Source ID와 Source summary 링크는 문서 최하단 `출처` 절에 한 번만 기록한다.
- Source summary와 지식 페이지는 전문가 독자를 기준으로 작성한다. 단순 bullet 요약만 남기지 말고 배경, 작동 방식, workflow, 한계, 반례, 제품/기술 시사점을 분리한다.
- 전문가 독자라도 처음 읽는 사람이라고 가정한다. 외래어와 영문 전문용어는 첫 등장 시 쉬운 한국어 설명을 먼저 쓰고 원어는 괄호로 보조한다.
- 같은 문서 안에서 `증거/proof/evidence`, `검증/validation`, `흐름/workflow`처럼 같은 뜻의 표현을 섞지 않는다.
- 가격, 수치, 기능 지원 여부, 고객 사례, benchmark 구성, 날짜가 붙은 주장은 claim-level 앵커를 반드시 붙인다.
- 새 자료가 기존 주장과 충돌하면 덮어쓰지 말고 `Contradictions`와 `open-questions.md`에 기록한다.
- Open question은 자동 동기화되지 않는다. `OQ-NNN`을 추가·부분 해소·해소할 때는 `wiki/open-questions.md`, 관련 지식 페이지의 `Open Questions` 절, `wiki/log.md`를 같은 변경에서 갱신한다.
- 한 Source를 ingest할 때 관련 페이지, `index.md`, `log.md`를 같은 변경에서 갱신한다.
- `log.md`의 기존 기록은 수정하거나 재정렬하지 않는다.
- Source가 없는 Wiki 문서는 만들지 않는다. Query에서 나온 새로운 분석도 근거 Source를 명시한다.
- 페이지 이름은 소문자 kebab-case를 사용하고 제목은 frontmatter와 H1에서 사람이 읽기 쉽게 쓴다.
- Source summary는 `sources`, audit report는 `audits`에 저장한다.
- 지식 페이지는 `knowledge/problem`, `knowledge/landscape`, `knowledge/technology`, `knowledge/synthesis` 중 하나에 저장한다.
- 상위 폴더는 탐색 축이고, 세부성은 독립 페이지로 확보한다. 주제가 독립 질문, 독립 Source 묶음, 독립 갱신 가능성을 가지면 새 페이지로 분할하고 상위 페이지에는 지도와 핵심 종합만 유지한다.
- `index.md`는 공개 독서 순서를 안내하고, 운영자용 경로는 `README.md`에서 안내한다.
