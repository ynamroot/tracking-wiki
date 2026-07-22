# Wiki Compiler 규칙

- Wiki는 Agent가 작성하고 사람이 검토하는 영역이다.
- 작업 전 `index.md`, 관련 페이지, 해당 Source 전체를 읽는다.
- 사실마다 `<sup>[🔗](#source-N)</sup>` 형식의 Source 앵커를 연결하고, 전체 Source ID와 Source summary 링크는 문서 최하단 `출처` 절에 한 번만 기록한다.
- 문장 작성은 `SCHEMA.md`의 문장 작성 원칙을 canonical 기준으로 따른다. 독자 기준(비전문가 이해 + 전문가 판단 근거), 쉬운 한국어 우선, 한영 혼용 금지, 용어 통일, 약어 첫 등장 풀이, `관련 문서`의 [[key-terms|핵심 용어 해설]] 링크, claim-level 앵커 규칙이 모두 그곳에 있다. 이 파일은 그 규칙을 다시 적지 않고 참조만 한다.
- Source summary와 지식 페이지는 단순 bullet 요약만 남기지 말고 배경, 작동 방식, 업무 흐름, 한계, 반례, 제품/기술 시사점을 분리한다. 비전문가도 본문만으로 이해할 수 있어야 한다.
- 새 자료가 기존 주장과 충돌하면 덮어쓰지 말고 `모순` 절과 `open-questions.md`에 기록한다.
- Open question은 자동 동기화되지 않는다. `OQ-NNN`을 추가·부분 해소·해소할 때는 `wiki/open-questions.md`, 관련 지식 페이지의 `미결 질문` 절, `wiki/log.md`를 같은 변경에서 갱신한다.
- 한 Source를 ingest할 때 관련 페이지, `index.md`, `log.md`를 같은 변경에서 갱신한다.
- 새 공개 문서를 추가하거나 기존 공개 문서의 핵심 결론을 바꾸면 독자가 발견할 수 있도록 `index.md`와 `log.md`를 같은 변경에서 갱신한다.
- `log.md`의 기존 기록은 수정하거나 재정렬하지 않는다.
- Source가 없는 Wiki 문서는 만들지 않는다. Query에서 나온 새로운 분석도 근거 Source를 명시한다.
- 페이지 이름은 소문자 kebab-case를 사용하고 제목은 frontmatter와 H1에서 사람이 읽기 쉽게 쓴다.
- Source summary는 `sources`, audit report는 `audits`에 저장한다.
- 지식 페이지는 `knowledge/problem`, `knowledge/landscape`, `knowledge/technology`, `knowledge/synthesis` 중 하나에 저장한다.
- 상위 폴더는 탐색 축이고, 세부성은 독립 페이지로 확보한다. 주제가 독립 질문, 독립 Source 묶음, 독립 갱신 가능성을 가지면 새 페이지로 분할하고 상위 페이지에는 지도와 핵심 종합만 유지한다.
- `index.md`는 공개 독서 순서를 안내한다. 사이드바 탐색 트리도 index의 독서 순서를 기준으로 정렬되므로, index 순서가 독자에게 보여줄 기본 정보 구조다.
- 운영자용 경로는 `README.md`에서 안내한다.
