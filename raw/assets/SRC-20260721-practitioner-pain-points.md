# 행동데이터 운영 실무자 페인포인트 조사 (원자료)

**방법 메모**: 실제 본문을 확인한 자료만 근거로 삼음. Reddit·Medium 원문 직접 접근은 차단되어 일부 커뮤니티 자료는 미확보.

## 1. 데이터매니저 / 애널리틱스 엔지니어 / 그로스 분석가 (운영 주체)

### 1-1. 명명 규칙이 사람마다 제각각이고, 이름 바뀐 이력이 어디에도 없다
- **고통**: 담당자마다 이벤트 이름을 다르게 쓰고, snake_case와 camelCase가 뒤섞이며, 언더바(_)가 여러 뜻으로 쓰여 해석이 헷갈린다. "데이터 이름이 바뀐 경우 이력이 적힌 곳이 없어서, 예전 데이터가 있는데도 트래킹을 못 한다."
- **근거**: 브런치 "데이터 이벤트 로그 설계 과정" — https://brunch.co.kr/@jinny/18
  - "각 프로덕트를 담당하고 계신 PD분들 마다 다르게 이벤트 로그를 작성하고 있었습니다"
  - "어떤 부분은 snake_case로, 어떤 부분은 camelCase로 들어가 있어서 이 두 개의 차이가 뭔지 모르겠다"
  - "데이터 이름이 바뀐 경우 히스토리가 작성된 곳이 없어 이 전 데이터가 있음에도 불구하고 트래킹 하지 못한다"
- **심각도**: 사내 사용자들이 "이 데이터 이름이 뭐예요?"를 반복 질문 — 운영자의 상시 지원 부담.

### 1-2. 태그 파손을 "대시보드가 이상해서" 뒤늦게 발견한다
- **근거**:
  - Trackingplan 블로그 — https://www.trackingplan.com/blog/data-quality-monitoring
    - "For days, maybe even a week, the event volume is zero. Nobody notices because overall site traffic looks fine. By the time someone finally pulls up the conversion funnel report, you've lost a week of critical behavioral data."
    - 업계 조사 인용: "15-25% of data can degrade every single month without proper monitoring"
  - RudderStack 창업자 Soumyadeb Mitra LinkedIn — https://www.linkedin.com/posts/soumyadeb-mitra_most-data-teams-discover-broken-tracking-activity-7324071773392486401-bWSo
    - "Most data teams discover broken tracking in the worst way possible... Your CEO opens the DAU dashboard, and it shows zero users yesterday."
    - "a developer renamed 'login_event' to 'user_login' during an app update. Now your login tracking dashboard shows zero logins. But users ARE logging in."
  - House of Martech — https://houseofmartech.com/blog/systematic-event-tracking-why-your-data-keeps-breaking-and-how-to-fix-it
    - "their 'conversion' event was firing twice for every actual conversion. Their reports showed double the reality for eight months. Nobody had checked."
- **심각도**: 여러 출처가 독립적으로 "며칠~8개월 방치" 사례. 가장 반복적으로 언급되는 고통.

### 1-3. "대시보드가 깨졌다"는 불려감의 반복 — 원인 추적·책임 소재 불명
- **근거**: incident.io — https://incident.io/blog/incident-management-for-data-teams
  - "The key metrics dashboard looks broken, can you take a look?" (주로 금요일 오후)
  - "There are three separate, manual steps before the person who can fix it is notified"
  - "The end user's trust in the dashboard is gradually lost the more it happens"
  - 상류 파손 뒤치다꺼리는 "quite demotivating"

### 1-4. 수동 QA·문서 관리의 반복 부담이 조직이 커질수록 폭증
- **근거**: 원티드 블로그 "이벤트 QA 자동화 회고" — https://blog.wantedlab.com/library/insight/qa-automation
  - "스쿼드와 프로젝트의 수가 늘어남에 따라 이 작업에 투자하는 시간 또한 늘어났어요"
  - E2E 테스트는 "이슈가 발생하면 디버깅이 어려워지는 단점", 배포마다 "개발환경에 심어진 것을 확인" 반복
- **심각도**: 자동화 프로젝트를 별도 착수할 만큼 부담.

### 1-5. 도구 이원화로 데이터끼리 모순 → 아무도 못 믿는다
- **근거**: House of Martech (위)
  - "Your marketing team turns on auto-capture in one tool... Your development team adds explicit tracking in another tool... discovers they contradict each other."
  - "making major budget decisions based on spreadsheets someone manually compiled because the automated reports were 'probably wrong.'"
  - "spending $80,000 annually on analytics tools they couldn't trust."

### 1-6. 나쁜 데이터가 분석 시간의 상당 부분을 잡아먹는다 (수치 근거)
- **근거**: Mixpanel 블로그 — https://mixpanel.com/blog/the-business-impacts-of-data-quality-issues/
  - HBR: "only 3% of companies' data is of good quality"
  - Forrester: "making sense of the bad data takes up more than 40% of data analysts' time"
  - "debates over KPI discrepancies consume more time than decision-making"
  - 번아웃: "constantly working with broken data, figuring out workarounds, and chasing people to fix issues"
- **보강**: Avo "Your company can't afford data debt" — https://www.avo.app/blog/your-company-cant-afford-data-debt-clean-analytics-tracking-can-help-settle-it — "a hodgepodge of different event names and data points that takes time (and money) to untangle later"

## 2. 기획자 / PM (데이터 소비자·계측 요청자)

### 2-1. 배포 다음 날 대시보드를 열었더니 "아무것도 안 찍히고 있다"
- **근거**: Medium "The Analytics Tax: Why Every Product Launch Requires Three Teams and Two Weeks" — https://medium.com/@ori.o/the-analytics-tax-why-every-product-launch-requires-three-teams-and-two-weeks-cfacc5dadefc
  - "Day one: Executives want to know how it's performing. Day two: Your PM opens the analytics dashboard and realizes… nothing is being tracked."
  - "You missed the critical launch window. You made optimization decisions blind."
- **심각도**: 제목 자체가 "모든 출시가 3개 팀과 2주를 잡아먹는다"는 반복 세금(tax) 프레임.

### 2-2. 계측이 개발 우선순위에서 밀려 리드타임이 길다
- **근거**: The Analytics Tax (위) — PM은 계측 검증에 막히고(blocked), 엔지니어는 상시 컨텍스트 스위칭, 분석팀은 계측 완료를 기다리는 병목.

### 2-3. 이벤트 이름만 봐서는 무슨 데이터인지 알 수 없어 계속 물어본다
- **근거**: 브런치 @jinny/18 — 반복 질문 서술 / Mixpanel 블로그 — "teams avoid using analytics tools like Mixpanel due to messy event tracking with labels like Signup Completed, Signed Up, or user_signup" (이름 난립 → 소비자의 도구 회피)

## 3. 프론트엔드 개발자 (계측 구현 주체)

### 3-1. "트래킹 플랜만 잘 짜면 슉슉 될 줄 알았는데" — 실제 구현은 스프레드시트 수작업
- **근거**: "이벤트 로그 설계, Tracking plan만 짜면 되는 것 아니었나요? +Ampli Cli" — https://sowhatmylifeismine.tistory.com/261
  - "tracking plan만 잘 짜면 로그 개발은 쉽게 슉슉 되는 건 줄 알았습니다. 하지만.."
  - 하드코딩 문자열 오타·유지보수 문제, 구글시트 참조 후 수동 복붙(자동완성 부재), 버전 관리 공백, 시트 코멘트/Jira 분산으로 진행 추적 어려움
- **심각도**: 해소하려 Ampli CLI(코드젠) 도입 — "점(.)을 찍으면 이벤트/프로퍼티/Enum값들이 자동 완성됩니다"

### 3-2. 계측이 비즈니스 로직과 무관한 잡무, 배포마다 수동 확인 반복
- **근거**: 원티드 블로그 (위)

### 3-3. 리팩토링/리디자인이 계측을 깨뜨리는데, 개발자는 모른다
- **근거**: House of Martech (위)
  - "Someone redesigns a page, and the button your tracking code references disappears. The event stops firing."
  - "The developer who built your tracking system leaves. The new developer doesn't understand the logic."
  - "These teams rarely talk to each other about tracking until something goes catastrophically wrong."
- **보강**: RudderStack 포스트 (위) — 개발자가 이벤트명을 바꿔 트래킹이 깨졌지만 무인지.

## 4. 역할 간 협업 마찰

- **명명·규칙 통일 실패, 담당자 의존**: PD마다 다른 규칙, case 혼용, "_"의 다의성, 이력 부재 → 소통이 구두·질문 의존 (브런치 @jinny/18)
- **역할 간 언어 차이**: "내가 아는 것 ≠ 개발자가 아는 것. 개발자의 언어로 이해해야 함" — 변성윤(zzsza) "데이터 로그 설계/데이터 QA의 모든 것" — https://zzsza.github.io/data/2021/06/13/data-event-log-definition/
- **네이밍 논쟁과 문서 표류**: "workspace_member_invited vs. member_invited_to_workspace" 같은 임의 규칙 논쟁, 낡은 문서, 담당자 교체 시 해석 어긋남 (The Analytics Tax)
- **책임 소재 불명**: "Unclear ownership – Determining who handles what becomes a manual exercise" (incident.io)
- **핸드오프 세금**: GitHub → IDE → GitHub → CI/CD → 분석 도구 전환마다 마찰·지연 (The Analytics Tax)
- **도구 이원화로 인한 데이터 모순**: 마케팅(오토캡처) vs 개발(명시 계측) 충돌 (House of Martech)

## 5. 전체 요약 — 가장 자주 언급된 고통 톱5

1. **파손을 "대시보드가 이상해서" 뒤늦게 발견** — 며칠~수개월 방치 (4개 이상 출처 독립 언급, 가장 반복적)
2. **명명 규칙 난립 + 문서-실제 괴리** — 이름 변경 이력 부재, 낡은 문서 표류 (브런치, The Analytics Tax, Mixpanel, Avo)
3. **계측 리드타임/병목** — 기능보다 2주 늦고, 배포 후에야 "데이터가 없다" 발견 (The Analytics Tax, sowhatmylifeismine)
4. **수동 QA·스프레드시트 수작업 반복 부담** — 조직이 커질수록 시간 폭증 (원티드, sowhatmylifeismine, House of Martech)
5. **데이터 신뢰 상실 → 데이터 회피** — 리포트 불신, 분석가 40% 시간이 나쁜 데이터 처리에 소모 (Mixpanel/HBR/Forrester/MIT, incident.io)

부차 반복 주제: 개발자의 리팩토링이 계측을 깨뜨리는데 본인 무인지 / 역할 간 책임 소재 불명 / 핸드오프·컨텍스트 스위칭 세금.

**조사 한계**: Reddit(r/analytics, r/dataengineering)·Measure Slack·dbt 커뮤니티 스레드 직접 인용 미확보 (도메인 차단).
