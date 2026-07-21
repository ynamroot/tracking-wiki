# Amplitude Data / Ampli SDK 경쟁 분석 리서치 (원자료)

## 1. 푸는 문제

Amplitude Data가 겨냥하는 병목은 생애주기(설계→구현→검증→운영) 중 **"구현 단계의 사람 실수"와 "설계와 실제 데이터의 불일치(drift)"**.

- Iteratively(전신)는 이벤트가 생성되는 지점(upstream, 계측 시점)에서 데이터 품질을 다룬다. Amplitude로 흘러 들어오기 전에 정의·계측·검증([Amplitude 블로그](https://amplitude.com/blog/amplitude-acquires-iteratively))
- 인수: 2021년 5월 12일. 명분은 "데이터 품질 위기" — 잘못된 데이터가 미국 기업에 연간 3조 달러 이상 손실. Iteratively는 수작업·임기응변식(ad hoc) 계측 과정을 셀프서비스 앱으로 대체해 구현 시점의 인적 오류 제거가 목표([보도자료](https://amplitude.com/press/amplitude-acquires-iteratively))
- Iteratively는 계측 이전의 "데이터 플래닝", 기존 Amplitude Govern은 계측 이후 유입 데이터 관리 → 엔드투엔드 거버넌스. 인수 당시 Iteratively 고객의 70% 이상이 이미 Amplitude 사용
- 대표적 병목 증상: 일관성 없는 이벤트 이름, 웹/모바일 간 user ID 연결(stitching) 파손, 중복 프로필, 잘못 발화된 속성으로 퍼널이 읽을 수 없게 되는 문제([userpilot](https://userpilot.com/blog/amplitude-tracking/))

## 2. 해결 기제와 기술 — ①설계 UI → ②코드 생성(Ampli) → ③CI 검증 → ④런타임/사후 관측(Observe)의 4겹

**① 트래킹 플랜(설계 UI)** — Data > Events/Properties 화면에서 이벤트·속성 정의. 속성은 세 종류(event/user/group property). Source(iOS, Android, Web, Backend) 지정. @mention 협업, 명명 규칙 제안, 필수 속성 지정. 이벤트 정의는 **버전(version)** 을 가지며 Observe가 이 버전과 대조([create-tracking-plan](https://amplitude.com/docs/data/create-tracking-plan), [validate-events](https://amplitude.com/docs/data/validate-events))

**② Ampli SDK — 타입 세이프 코드 생성**
- Ampli Wrapper는 Amplitude SDK 위의 얇은 파사드. 플랜의 모든 이벤트에 대해 편의 메서드(`ampli.songPlayed({title:"..."})`)·클래스 생성([Ampli 개요](https://amplitude.com/docs/sdks/ampli))
- `ampli pull`이 플랜 정의를 읽어 언어·플랫폼별 강타입 라이브러리 생성([Ampli CLI](https://amplitude.com/docs/sdks/ampli/ampli-cli))
- 강제 방식은 주로 컴파일 타임 정적 타입 검사. 예: `Error: Event 'Song Played' is missing required property 'title'`
- 일부 SDK는 런타임 입력 검증도 지원. Iteratively 시절부터 "빌드 타임 QA + 런타임 검증, 100% 클라이언트 사이드" 표방

**③ `ampli status` — CI 검증**
- 소스 코드를 스캔해 Ampli 호출을 찾아 플랜과 대조 → 미계측 이벤트 검출
- 종료 코드로 CI 게이트: 전부 계측 시 exit 0, 아니면 미계측 수 반환하며 실패. `-u` 플래그는 구현 상태를 Amplitude Data에 역방향 업데이트

**④ Observe — 런타임/사후 관측·블로킹**
- 코드 변경 없이 유입 이벤트 스트림을 플랜과 실시간 대조. 4상태 분류: **Unexpected**(플랜에 없음) / **Valid·Current**(최신 버전 일치) / **Invalid**(불일치) / **Out of Date**(과거 버전 일치). 이름과 스키마 둘 다 검사([validate-events](https://amplitude.com/docs/data/validate-events))
- 모니터링 창 5분~14일. 필수 속성 누락 비율 임계치 초과 시 경고, 이메일 구독
- 블로킹/변환: 이벤트·속성 변환, 잘못된 데이터 드롭, 수집 중단 데이터 블로킹·삭제

## 3. 사람이 여전히 해야 하는 일

- **플랜 작성은 사람 몫**: 무엇을, 왜, 어떤 이름·속성으로 수집할지 UI에서 직접 정의
- **개발자가 Ampli 호출을 코드에 직접 배선**: 자동생성되는 것은 타입 세이프 API일 뿐. "개발자가 계측을 손으로 작성한다"는 전제 유지
- **QA/검증 주기 운영**: ampli status를 CI에 걸고, Observe 경고를 사람이 구독·판독·트리아지, 플랜 버전 갱신

## 4. 미해결 영역·한계

- **Observe는 업스트림에서 차단·필터·변환된 데이터를 볼 수 없음** — "If you're blocking, filtering, or transforming your data upstream of Amplitude, Observe can't access this data."
- 정적 타입 검사 핵심 한계: "코드가 컴파일된다 ≠ 사용자가 실제로 그 버튼을 눌렀을 때 이벤트가 올바르게 발화된다"
- **개발자 의존성**이 가장 일관된 통점: PM·마케터가 엔지니어링 티켓 없이 계측 시작 불가([userpilot](https://userpilot.com/blog/amplitude-tracking/))
- 크로스디바이스 user ID, 정밀 퍼널 스텝, A/B 계측 등 비자명한 질문은 여전히 엔지니어링 티켓 필요
- G2: 셋업 시간·기술적 선행요건 반복 지적([G2](https://www.g2.com/products/amplitude-analytics/reviews))
- **가격**: 스케일에서 비쌈이 1위 불만(동등 사용량 기준 Mixpanel의 2~5배라는 요약)([costbench](https://costbench.com/software/developer-tools/amplitude/))
- drift를 막으려 Segment/RudderStack CDP를 스키마 검증기로 앞단에 두는 추가 인프라 사례 — Ampli만으로 drift가 완전 해결되지 않음을 시사

## 5. 가격 모델

- MTU(월간 추적 사용자) 기반 4단계: Starter($0, 1만 MTU/월 200만 이벤트) · Plus($49/월, 30만 MTU) · Growth(맞춤) · Enterprise(맞춤)([가격](https://amplitude.com/pricing))
- 거버넌스는 상위 티어 번들: advanced data governance는 Growth 이상, RBAC·컴플라이언스는 Enterprise
- 실계약 중앙값 연 $64,724(범위 $24K~$379K)([usercall](https://www.usercall.co/post/amplitude-pricing), [vendr](https://www.vendr.com/marketplace/amplitude))

## 6. 핵심 용어

- **Tracking plan**: 수집할 모든 이벤트·속성과 이유·출처를 계측 전에 정의한 스키마 문서
- **Ampli / Ampli Wrapper**: 플랜 기반 자동생성되는 강타입 파사드 라이브러리
- **Ampli CLI**: pull(코드 생성)·status(계측 여부 검증) 명령줄 도구
- **Event schema**: 이벤트의 이름·속성(타입·필수여부) 규격. 버전을 가짐
- **Taxonomy**: 회사 전역 표준 명명 규칙·이벤트 분류 체계
- **Blocking**: 원치 않는/잘못된 이벤트를 수집·쿼리에서 차단·삭제
- **Observe**: 코드 변경 없이 유입 이벤트를 플랜과 실시간 대조·분류·경고
- **Visual Labeling / Autocapture**: 코드 없이 UI 요소를 지목해 이벤트로 정의

## 지정 질문 답변

**Q1. 수동 계측 전제 유지?** — 유지. Ampli는 타입 세이프 API 자동생성뿐, 호출을 올바른 위치에 심는 것은 수작업. 미해결: ① 비개발 직군의 엔지니어링 티켓 의존 ② 컴파일 통과해도 "실제 UI 상호작용 시점에 올바른 이벤트 발화" 의미론적 정확성 보장 불가 ③ 심는 걸 깜빡하면 애초에 데이터가 없음.

**Q2. 괴리 탐지 시점** — 3층: ① 컴파일 타임(정적 타입 검사) ② CI(ampli status — 플랜에 있는데 코드에 미계측) ③ 런타임/사후(Observe — Unexpected/Invalid/Out-of-date 분류·경고. 데이터가 이미 들어온 뒤의 사후 탐지, 업스트림 차단 데이터는 못 봄).

**Q3. 요소↔이벤트 매핑·시각 증빙** — Ampli 자체는 없음. 별도 트랙인 Autocapture + Visual Labeling이 다룸: 클릭·변경 요소와 HTML 부모 구조를 자동 수집, 화면에서 포인트앤클릭으로 이벤트 이름 부여. 라벨은 과거 Autocapture 데이터에 소급 적용, 비즈니스 이름을 DOM 요소와 분리해 drift 완화([Visual Labeling](https://amplitude.com/docs/data/visual-labeling)). 단 코드 기반 수동 계측(Ampli) 트랙에는 요소↔이벤트 시각 매핑 없음.
