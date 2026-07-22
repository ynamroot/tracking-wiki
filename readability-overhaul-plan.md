# Tracking Wiki 가독성 개편 계획

> 작성일: 2026-07-22. 위키 콘텐츠가 "누구나 읽기 쉬움 + 전문 지식 누적" 두 목표를 만족하는지 진단하고, 개선 실행 계획을 정리한 문서다. 실행 전 검토용이며 위키 본문이 아니다.

## Context — 왜 하는가

두 목표("누구나 읽기 쉬움" + "전문 지식 누적") 대비 진단 결과:

- **전문 지식 누적은 강함** — 사실/종합/제품시사 분리, claim 단위 🔗 앵커, 실질적 모순·OQ 관리 모두 작동. 잔여 약점: `status` 전부 `current`(무정보), 핵심 명제("화면 행동→기대 이벤트→실제 전송 내용 증거 공백")가 ~6개 페이지 중복 서술, 미등록 ad-hoc open question 3곳.
- **쉬운 글은 체계적 실패** — ① 한영 혼용이 기본 문체("release와 analytics 사이의 책임 공백"), ② 약어(SDK/QA/MVP/UAT/ICP) 페이지별 미풀이, ③ key-terms 링크 규칙을 45개 중 7개 파일만 준수, ④ 영어 H2 헤더(Current Synthesis 등)가 공개 사이트 목차까지 영어로 렌더링. 최악: `collection-and-validation-patterns`, `source-web-agent-eval-benchmarks`, problem 3종(비전문가 대상인데 가장 심함).
- **근본 원인(프로세스)** — 규칙(SCHEMA.md:89-98)은 있으나: 모든 지침이 독자를 "전문가"로만 규정, Wiki Auditor 체크리스트에 가독성 없음, validator는 구조만 검사(가독성 0건 집행 + `Product Implications` 필수인데 미검사), ingest 11단계에 가독성 게이트 없음, Query Agent가 synthesis를 쓰는데 역할표·플레이북에 부재.

**사용자 결정:** 한국어 헤더 전환 / 44페이지 전체 일괄 개선 / 기계 검증 추가(가능한 것).

## 검증된 사실 (탐색 결과)

- validator 대상 41페이지 전부 동일한 9개 H2 세트 사용(+ Context 1곳). `[[page#heading]]` 링크는 저장소 전체에 0건 → 헤더 변경으로 깨지는 링크 없음.
- `Validate-Wiki.ps1`은 순수 ASCII·BOM 없음. CI는 `pwsh`(UTF-8), 로컬 문서는 `powershell` 5.1(ANSI) → 한글 리터럴 mojibake 위험. 그래서 현재 `출처`가 char-code로 구성돼 있음(L6).
- `Source Summary:` 문자열 41개 파일 151회. footer regex는 표시 텍스트 임의 허용 → 개명 안전.
- `wiki/audits/`는 validator·사이트 빌드 모두 제외 → 구 audit 보고서는 손대지 않음.

## 1. 한국어 헤더 매핑

| 현재 | 신규 | | 현재 | 신규 |
|---|---|---|---|---|
| Current Synthesis | **현재 종합** | | Evaluation Criteria | **평가 기준** |
| Evidence | **근거** | | Limits | **한계** |
| Context | **배경** | | Contradictions | **모순** |
| Mechanics | **작동 방식** | | Open Questions | **미결 질문** |
| Workflow | **업무 흐름** | | Product Implications | **제품 시사점** |
| See Also | **관련 문서** | | 출처 | (유지) |

- "근거"(Evidence)로 도메인 용어 "증거"(runtime proof)와 구분. "미결 질문"은 중앙 페이지 제목과 일치 — Quartz slug는 파일 경로 기반이라 충돌 없음, 오히려 의도된 연결.
- **`Source Summary:` → `자료 요약:`** 전역 치환(151곳: 19개 frontmatter title + H1, 인용 페이지 표시 텍스트, index의 `## Source Summaries` → `## 자료 요약`).
- frontmatter `type`/`status`/`confidence` 값은 영어 유지(validator regex 의존, 기계용).

## 2. Validator 수정 — `scripts/Validate-Wiki.ps1`

- **인코딩**: UTF-8 **BOM** 으로 재저장 + 한글 리터럴 사용. 파일 상단에 런타임 가드 추가:
  `if ([int][char]"출처"[0] -ne 0xCD9C) { throw "UTF-8 BOM으로 저장 필요" }`
  L6의 char-code 구성 → `$sourceHeading = "출처"` 리터럴로. `$sourceEmoji`는 유지.
- **필수 절 목록**(L129): `@("현재 종합","근거","모순","미결 질문","제품 시사점","관련 문서")` — 기존에 누락됐던 Product Implications 검사를 함께 해결.
- **신규 ERROR — key-terms 링크**: `key-terms.md` 자신 제외, 모든 대상 페이지에 `\[\[key-terms(\]\]|\|)` 매치 요구.
- **신규 WARNING — 미풀이 약어**: 화이트리스트(SDK,CDP,QA,PM,MVP,UAT,ICP,MTU,PRD,CI,PR,API,DOM,KPI 등) 사용 페이지에 괄호 gloss 인접 패턴 없으면 경고.
- **신규 WARNING — 영어 비율**: 본문(코드/URL/HTML/표/링크타깃 제거 후) `[A-Za-z]` / (`[A-Za-z]`+`[가-힣]`) 비율이 지식 페이지 30%, source 40% 초과 시 경고(200자 미만 제외). 벤더명 밀집 페이지가 CI를 깨지 않도록 경고 전용.
- Warning은 기존 `Write-Warning` 경로라 exit code에 영향 없음 → CI green 유지.

## 3. 규칙 문서 정비 (agent 수정)

**원칙: SCHEMA.md 문장 작성 원칙이 유일한 canonical 스타일 소스, wiki/AGENTS.md는 참조만.**

- **SCHEMA.md**: 필수/권장 절 이름 한국어로(L71-85, 관련 언급 L60/96/119/132). 신규 규칙 5건 —
  ① 독자 정의: "비전문가도 본문만 읽고 이해 + 전문가는 판단 근거 획득. 쉬운 한국어가 기본 문체, 원어·약어는 보조."
  ② key-terms 링크 의무화(L96 강화: 모든 지식 페이지·자료 요약의 `관련 문서`에 연결).
  ③ 앵커 위치: 문단 끝에 몰지 말고 각 claim 문장 옆에(현재 종합 포함).
  ④ status 운영 규칙: 핵심 결론 흔드는 미해결 충돌=`disputed`, 낡음=`stale`, 대체=`superseded` + log 기록.
  ⑤ 중복 방지: 핵심 논지는 canonical 페이지 1곳이 전체 서술 소유, 타 페이지는 한 문장+wikilink(overview만 한 문단 허용).
- **wiki/AGENTS.md**: 스타일 규칙 중복(L6-9) 삭제 → SCHEMA 참조로 대체. 절 이름 언급 갱신.
- **AGENTS.md(루트)**: 역할표에 Query Agent 행 추가(쓰기 영역: `wiki/knowledge/synthesis`, index, log, open-questions).
- **AGENT_PLAYBOOKS.md**: Query Agent 플레이북 신설. Wiki Compiler 절차에 "작성 후 가독성 자기 점검" 추가. **Wiki Auditor 검사 대상에 가독성(영어 비율, 미해설 약어, 절 이름, 앵커 위치, key-terms 링크) 추가.**
- **OPERATIONS.md**: Ingest Workflow에 8.5단계(가독성 자기 점검) 추가, Ingest Quality Bar에 비전문가 독해 기준 2개 항목 추가, §5 audit 프롬프트에 가독성 위반 추가, 절 이름 언급 갱신.
- **templates/wiki-page.md**: H2 한국어 전환 + 이중 독자 지침 문장 + `관련 문서`에 key-terms 링크 기본 포함 + footer 예시 `자료 요약:`.
- **templates/audit-report.md**: `## 가독성` 검사 카테고리 추가.

## 4. 콘텐츠 개선 실행 전략

### Commit 1 — 기계적 lockstep 커밋 (validator가 혼합 상태를 보지 않도록 한 커밋)
1. Validate-Wiki.ps1 전체 수정(§2, UTF-8 BOM 저장)
2. 41페이지 헤더 치환 — **줄 단위 anchored** (`^## Current Synthesis$` 등; 본문 내 절 이름 언급은 batch에서 처리)
3. `Source Summary: ` → `자료 요약: ` 전역 + index 헤딩
4. 누락 34페이지의 `관련 문서`에 `- [[key-terms|핵심 용어 해설]] - 반복되는 용어 풀이.` 추가
5. 규칙 문서 5종 + 템플릿 2종(§3)
6. log/index에 `update` 항목. **`updated`는 bump하지 않음**(구조 변경만, 의미 불변 — log에 명시)

### Commits 2–7 — 문장 개선 batch (batch당 subagent 1개)

| Batch | 대상 | 비고 |
|---|---|---|
| B1 | technology 8개 | canonical 논지 페이지 `element-event-evidence` + 최악 `collection-and-validation-patterns`. OQ-011 등록 |
| B2 | problem 3개 + overview | overview는 논지 한 문단 요약+링크 유지 |
| B3 | landscape 7개 | OQ-009(Avo 잔여 수동 작업), OQ-010(거버넌스 통합 시 전달 형태) 등록 |
| B4 | synthesis 3개 + open-questions 정리 | automation-opportunity 논지 압축 |
| B5/B6 | sources 19개 (2분할) | source-avo의 ad-hoc 질문 → OQ 참조로 전환 |

- **논지 중복 해소**: canonical = `wiki/knowledge/technology/element-event-evidence.md`. 나머지 5곳은 한 문장+wikilink로 압축.
- **ad-hoc OQ**: 기존 OQ에 포섭되면 그 OQ 인용으로 재작성, 아니면 신규 OQ-NNN 발급(실행 시 번호 확정). SCHEMA:130 규칙대로 open-questions.md + 해당 페이지 + 같은 커밋.

### Subagent용 페이지별 체크리스트 (brief에 그대로 포함)
1. **불변 조건**: frontmatter(`updated`·규칙상 필요한 `status` 제외), 모든 `<sup>[🔗](#source-N)</sup>` 앵커와 번호, footer 항목, SRC ID, wikilink 타깃, OQ ID, 표의 데이터 값, H1/title(자료 요약 접두 제외) — 변경 금지
2. 한영 혼용 제거: 쉬운 한국어 먼저, 원어는 첫 등장 괄호만(key-terms 기본 표현 사용)
3. 화이트리스트 약어 페이지별 첫 등장 풀이
4. 문서 내 한 용어 한 표현
5. 앵커 재배치: 문단 끝 몰림 → 각 claim 문장 옆(중복 허용, 삭제 금지)
6. 논지 중복/ad-hoc OQ 처리(위 규칙)
7. 본문 내 영어 절 이름 언급 수정, `updated` bump
8. 자기 검증: 앵커 수 ≥ 이전, footer 동일, validator 통과 + 이 페이지 신규 경고 0

- 스타일 모범: `key-terms.md`, `validation-layer-model.md`, `source-pain-point-analysis.md`

## 5. 순서와 검증

1. **브랜치 작업** (`readability-overhaul`) — CI(validate+build)는 push마다 실행, deploy는 master만. 완료 후 1회 merge.
2. Commit 1 후: `pwsh scripts/Validate-Wiki.ps1` **및** `powershell -File ...` 5.1로도 1회(BOM 검증), `Build-WikiSite.ps1` 실행 → `.site-output`에서 한국어 목차, `#현재-종합` 앵커, `자료 요약:` 제목, audits 제외 확인.
3. 각 batch 후 validator, B1·B6 후 전체 빌드. 부모가 batch마다 `git diff --stat` + 파일별 🔗 개수 before/after 대조.
4. 최종: log에 `update | 전체 지식 페이지 가독성 개편 완료`(신규 OQ, canonical화, status 변경 요약) + index 최근 변경, 경고 ~0 확인, push → CI green → master merge → Pages 배포 확인.

## 리스크

- **PS1 인코딩(최대)**: BOM 없는 한글 리터럴은 5.1에서 조용히 깨짐 → BOM + 런타임 assertion으로 이중 방어.
- **의미 훼손**: 불변 조건 + 앵커 수 검사 + validator의 인용-footer 정합 검사로 방어.
- **전역 치환 오폭**: 헤더 치환은 반드시 줄 anchored, 문장 내 언급은 batch에서 수동.
- **영어 비율 오탐**: 경고 전용 + source 페이지 완화 임계(40%) + 200자 하한.
- Quartz 한글 앵커: github-slugger가 한글 보존, `locale: ko-KR` 기설정 — 위험 낮음, Commit 1 빌드로 확인.

## 수정 파일 요약

- `scripts/Validate-Wiki.ps1` (인코딩+검사 5건)
- `SCHEMA.md`, `OPERATIONS.md`, `AGENTS.md`, `AGENT_PLAYBOOKS.md`, `wiki/AGENTS.md` (규칙·역할)
- `templates/wiki-page.md`, `templates/audit-report.md`
- `wiki/**/*.md` 41페이지 + `wiki/index.md`, `wiki/log.md`, `wiki/open-questions.md`
- canonical 논지: `wiki/knowledge/technology/element-event-evidence.md`
