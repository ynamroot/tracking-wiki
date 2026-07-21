# 프로젝트 컨텍스트

## 목적

행동데이터 수집 도구의 VP, 시장, 경쟁사, 기술 스택을 조사하고,
그 결과를 PRD, 기능 정의, 기술 스펙으로 변환한다.

## 운영 모델

Karpathy식 프로젝트성 LLM Wiki를 사용한다.

생명주기:

1. 자료조사와 Wiki 구축
2. PRD, 기능 정의 초안
3. 기술 정의와 변경 요청
4. PRD, 기능, 기술 스펙 확정
5. Wiki 동결 및 프로젝트 아카이브화

## 역할

- PO: 조사 범위, 제품 판단, PRD와 기능 정의 최종 승인
- 팀원: 자료, 질문, 기술적 반론 제출
- LLM: 자료 정규화, Wiki 통합, 문서 초안 생성
- 개발자: 기술 설계, ADR, 변경 요청 작성

## 자료 입력

팀원에게 정형 문서를 요구하지 않는다.

팀원 입력:

- URL 또는 파일
- 선택적인 한 줄 의견

GitHub Issue를 자료 제출 인터페이스로 사용한다.

LLM 처리:

GitHub Issue
-> `raw/inbox` Source 문서 생성
-> LLM 정책 기반 자동 triage
-> `raw/sources` 승격
-> Wiki ingest

자동 triage는 provenance, 조사 범위 관련성, 원문 접근성, 중복 여부를 검사한다.
정책을 통과한 Source는 자동 채택하고, 범위가 불명확하거나 인용 권한 문제가 있거나
제품 방향을 바꿀 정도의 충돌이 있을 때만 PO에게 판단을 요청한다.

## 문서 우선순위

1. `product/approved`
2. `product/decisions`
3. `technical/approved`
4. `wiki`
5. `raw`

Wiki는 외부 사실의 SSOT가 아니라 LLM이 종합한 지식 마트다.

- 외부 사실의 SSOT: raw source
- 시장, 기술에 대한 현재 종합: wiki
- 제품 요구사항의 SSOT: approved PRD와 기능 스펙
- 구현 방식의 SSOT: Technical Spec, ADR, 코드와 테스트

## 핵심 원칙

- Ingest는 Wiki만 수정한다.
- Approved 문서는 자동으로 수정하지 않는다.
- 기술팀이 제품 변경 필요성을 발견하면 Change Request를 생성한다.
- 기술 검토 결과를 반영한 뒤 최종 스펙을 확정한다.
- 조사 종료 시 `research-baseline` Git tag를 생성한다.
- 최종 확정 시 `spec-baseline` Git tag를 생성한다.

## 공개와 배포

- GitHub 저장소와 Issue는 인터넷에 공개하며 모든 tracked 문서를 공개 정보로 취급한다.
- Git 저장소의 Markdown이 SSOT이고 Quartz 사이트는 읽기 전용 파생 결과다.
- 공개 사이트는 `wiki/index.md`, `overview.md`, `open-questions.md`, `knowledge`, `sources`를 게시한다.
- Agent 규칙, Wiki log, audit report는 저장소에서는 공개되지만 읽기용 사이트에서는 제외한다.
- 개인정보, 고객 비밀, 자격증명, 유료·비공개 원문은 Issue와 저장소에 기록하지 않는다.
