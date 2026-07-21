---
id: SRC-20260721-web-agent-eval-benchmarks
title: "Primary web agent evaluation benchmarks: Mind2Web, WebArena, VisualWebArena, WorkArena"
status: accepted
source_type: dataset
original_url: "https://osu-nlp-group.github.io/Mind2Web/"
submitted_by: "Research Agent"
submitted_at: 2026-07-21
retrieved_at: 2026-07-21
issue_url: ""
language: en
publisher: "OSU NLP Group; WebArena authors; ServiceNow Research"
authors: []
published_at: ""
reliability: primary
content_file: ""
content_sha256: ""
supersedes: []
---

# Primary web agent evaluation benchmarks: Mind2Web, WebArena, VisualWebArena, WorkArena

## Submitter Note

Open questions require representative UI-change and autonomous traversal evaluation material. This Source record captures original benchmark/dataset pages that can seed a prototype evaluation plan.

## Research Questions

- `OQ-005` 요소 지문과 자율 순회가 실제 제품 개편에서 달성해야 할 정확도와 안전 기준은 무엇인가?
- `OQ-008` 자율 순회와 요소 지문 가설을 검증할 대표 UI 변경 dataset과 평가 기준은 무엇인가?

## Provenance

- 원문 확보 방법: original benchmark pages, official GitHub repositories, and dataset links를 웹에서 직접 조회.
- 주요 URL:
  - https://osu-nlp-group.github.io/Mind2Web/
  - https://github.com/OSU-NLP-Group/Mind2Web
  - https://github.com/web-arena-x/webarena
  - https://github.com/web-arena-x/visualwebarena
  - https://github.com/ServiceNow/workarena
  - https://servicenow.github.io/WorkArena/
- 원문 보존 위치: URL과 retrieval date를 기록한다. dataset 자체는 크기와 license/access 조건 때문에 로컬 복제하지 않는다.
- 원문과 record의 차이: record는 조사 질문에 필요한 benchmark suitability 요약만 포함한다.

## Triage

- 판정: accepted
- 판정자: LLM auto-triage policy-v1
- 판정일: 2026-07-21
- 사유: 원 논문/공식 repository/dataset 페이지이며 provenance를 URL과 retrieval date로 재현할 수 있고, autonomous web traversal 및 UI interaction 평가 범위와 직접 관련된다. 기존 secondary report와 exact duplicate가 아니다.

## Extracted Content

- Mind2Web는 web generalist agent 평가 dataset이며 2,350 tasks, 137 websites, 31 domains를 포함한다. Training Data, encrypted Test Data, Raw Dump 링크가 제공된다.
- WebArena는 autonomous agents를 위한 standalone, self-hostable web environment다. Repository는 canonical implementation과 environment setup, tasks, evaluation scripts를 제공한다.
- VisualWebArena는 multimodal autonomous language agents를 realistic visual web tasks로 평가하는 benchmark다. WebArena의 execution-based evaluation을 기반으로 하며 tasks/scripts/environment setup을 제공한다.
- WorkArena는 ServiceNow platform 기반 browser tasks로 knowledge worker workflow 자동화 능력을 평가한다.
- WorkArena-L1은 33 atomic tasks에서 19,912 unique instances를 포함하고, WorkArena++는 682 compositional tasks를 포함한다고 repository가 설명한다.
- 이 benchmark들은 traversal/action success 평가에는 적합하지만, 행동데이터 계측 누락 탐지와 요소 fingerprint continuity를 직접 측정하지는 않는다. 프로젝트 전용 evaluation dataset은 benchmark에서 UI task/action trace 구조를 차용해 별도 설계해야 한다.

## Revision Notes

- 2026-07-21: Research Agent가 benchmark primary source 보강용으로 최초 생성하고 Intake Agent가 자동 triage 정책으로 accepted 처리.
