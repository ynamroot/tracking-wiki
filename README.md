# Tracking Wiki

행동데이터 수집 도구의 시장, 고객, 경쟁사, 기술을 조사하고 제품 및 기술 스펙으로 전환하는 프로젝트성 LLM Wiki다.

## 운영 원칙

- 사람은 Source를 큐레이션하고 질문, 판단, 승인을 담당한다.
- Agent는 Source 정규화, Wiki 통합, 교차참조, 문서 초안을 담당한다.
- `raw/sources`는 외부 사실의 근거이고 `wiki`는 Agent가 관리하는 현재 종합이다.
- 승인된 요구사항은 `product/approved`, 승인된 구현 방식은 `technical/approved`가 우선한다.

## 시작하기

1. 팀원이 GitHub의 `Source 제출` Issue를 작성한다.
2. Intake Agent가 `templates/source-record.md`를 사용해 `raw/inbox`에 기록한다.
3. Intake Agent가 provenance, 관련성, 접근성, 중복을 검사해 자동 triage한다.
4. 정책을 통과한 자료를 `raw/sources`로 자동 승격하고 Wiki Compiler가 ingest한다.
5. 예외만 PO에게 escalation하고 `OPERATIONS.md`의 Query, Audit, 제품화 절차를 반복한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/Validate-Wiki.ps1
```

GitHub 원격 연결 후 Issue label을 생성한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/Setup-GitHubLabels.ps1
```

push와 pull request에서는 `.github/workflows/validate-wiki.yml`이 동일 검사를 자동 실행한다.

## 주요 문서

- `PROJECT_CONTEXT.md`: 합의된 프로젝트 목적과 원칙
- `AGENTS.md`: Agent 권한과 승인 경계
- `SCHEMA.md`: Source와 Wiki 문서 스키마
- `OPERATIONS.md`: 전체 운영 runbook
- `wiki/index.md`: Wiki 탐색 시작점
- `wiki/log.md`: append-only 작업 이력
- `wiki/open-questions.md`: 미결 질문과 모순
