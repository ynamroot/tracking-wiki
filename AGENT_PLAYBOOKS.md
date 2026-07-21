# Agent Playbooks

Agent는 독립 서비스가 아니라 명시적인 작업 역할이다. 한 Codex 세션이 역할을 순차적으로 수행할 수 있다.

## Intake Agent

**입력:** `source:new` GitHub Issue, URL 또는 파일.

**절차:**

1. Issue 본문과 첨부를 읽는다.
2. 중복 URL, 제목, content hash를 검색한다.
3. 원문을 `raw/assets`에 보존하거나 안정적인 URL과 retrieval date를 기록한다.
4. `templates/source-record.md`로 `raw/inbox/SRC-YYYYMMDD-slug.md`를 만든다.
5. 불완전한 출처나 접근 제한을 표시한다.
6. 자동 Triage 정책을 적용하고 통과한 Source를 `raw/sources`로 승격한다.

**완료 조건:** 재현 가능한 provenance와 판정 근거가 있고 자동 채택 자료는 `raw/sources`에 존재한다.

**중단 조건:** 원문에 접근할 수 없거나 제출 권한이 불명확하면 `source:needs-verification`으로 격리한다. 제품 방향을 바꿀 충돌만 PO에게 escalation한다.

## Research Agent

**입력:** `needs-verification` Source 또는 명시적인 조사 질문.

**절차:**

1. 가능한 경우 공식 문서, 원 논문, 원 데이터 등 1차 출처를 찾는다.
2. 기존 Source와 중복 또는 인용 사슬을 확인한다.
3. 사실, 출처의 주장, Agent의 해석을 구분한다.
4. 보강 자료는 별도의 Source record로 추가한다.
5. 신뢰도와 한계를 triage 메모에 기록한다.

**완료 조건:** 자동 판정에 필요한 근거가 충분하거나, 사람이 판단해야 하는 예외가 구체적으로 기술됐다.

**중단 조건:** 접근 제한 또는 상충하는 출처 때문에 판단할 수 없으면 필요한 확인 사항을 질문으로 남긴다.

## Wiki Compiler

**입력:** `raw/sources`의 accepted Source 하나와 기존 Wiki.

**절차:** `OPERATIONS.md`의 Ingest Workflow를 그대로 수행한다.

**완료 조건:** Source summary, 관련 지식 페이지, `index.md`, `log.md`, 필요한 open question이 같은 변경에서 갱신된다.

**중단 조건:** Source provenance가 불완전하거나 자동 정책에서 채택되지 않은 자료면 ingest하지 않는다.

## Wiki Auditor

**입력:** Wiki 전체 또는 지정 범위.

**절차:** 구조, 인용, 링크, 모순, 최신성, 고립 페이지, 조사 공백을 검사한다.

**완료 조건:** `wiki/audits/YYYY-MM-DD-audit.md`가 생성되고 중요한 공백이 `open-questions.md`에 반영된다.

**중단 조건:** 제품 판단이 필요한 모순은 임의 해결하지 않고 `decision:required`로 넘긴다.

## Product Agent

**입력:** `research-baseline`, Wiki, Product Decision.

**절차:** 근거 Source와 Decision ID를 연결해 PRD 및 Feature Spec 초안을 만든다.

**완료 조건:** 목표, 비목표, 검증 가능한 요구사항, 성공 지표, 위험, 미결 결정이 작성된다.

**중단 조건:** 핵심 고객, 문제, Value Proposition이 결정되지 않았으면 초안을 확정된 것처럼 작성하지 않는다.

## Technical Reviewer

**입력:** 승인된 PRD와 Feature Spec.

**절차:** 아키텍처, 데이터, 개인정보, 보안, 신뢰성, 비용, 테스트를 검토하고 Technical Spec과 ADR을 작성한다.

**완료 조건:** 구현 계약과 검증 전략이 명시되고 필요한 제품 변경은 CR로 분리된다.

**중단 조건:** 승인 제품 요구사항과 기술 현실이 충돌하면 요구사항을 직접 수정하지 않고 Change Request를 만든다.
