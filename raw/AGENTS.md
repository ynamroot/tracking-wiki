# Raw 영역 규칙

## `inbox`

- Intake Agent와 Research Agent만 작성한다.
- 제출된 원문을 보존하고 provenance와 수집 시점을 기록한다.
- 자동 triage가 끝나기 전에는 내용을 보강할 수 있지만 변경 이유를 Source record에 기록한다.

## `sources`

- 루트 `AGENTS.md`의 자동 Triage 정책을 통과해 `accepted`로 판정된 자료만 들어간다.
- 승격 후 파일 내용과 첨부 원문은 immutable이다.
- 오탈자나 출처 변경도 기존 파일을 수정하지 않고 새 Source를 추가해 supersede한다.

## `rejected`

- 제외된 자료와 제외 이유를 보존한다.
- Wiki의 근거로 인용하지 않는다.
