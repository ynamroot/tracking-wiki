# 태그 감사·자동 순회 QA 도구 4종 경쟁 분석 (원자료)

> 이 카테고리는 내부 기획 문서(가치제안)의 **"순회 에이전트"**(서비스 화면을 자동으로 돌아다니며 요소를 지문화하고 이벤트 발화를 검증·증빙하는 구조)와 가장 가까운 상용 선례다. 따라서 직접 비교가 가능하도록 상세히 조사했다.
>
> **핵심 결론 한 줄:** 기존 도구들은 "태그가 발화했는가"는 잘 검증하지만, "화면의 어떤 요소가 무슨 이벤트를 내야 하는지 스스로 발견하고, UI 개편을 넘어 그 이력을 잇는" 일은 거의 사람에게 맡긴다.
>
> **용어 풀이(처음 쓸 때 한 줄):**
> - **크롤링(crawling)**: 봇이 웹페이지 링크를 따라가며 페이지를 자동으로 훑는 방식.
> - **시나리오 시뮬레이션**: 사람이 미리 짠(또는 녹화한) 클릭·입력 순서를 봇이 그대로 재생하는 방식.
> - **수동 관찰/트래픽 청취(passive monitoring)**: 크롤링·재생 없이 실제 이용자가 발생시키는 네트워크 요청을 옆에서 엿듣는 방식(봇이 화면을 돌아다니지 않음).
> - **데이터레이어(data layer)**: 웹페이지가 태그로 보낼 값을 담아두는 자바스크립트 저장소.
> - **태그 거버넌스(governance)**: 어떤 태그가 어디서 무슨 데이터를 수집해도 되는지 규칙으로 관리·감시하는 일.
> - **자가치유(self-healing)**: 셀렉터가 깨졌을 때 대체 위치 지정자를 자동으로 찾아 잇는 기술.
> - **요소 지문(element fingerprint)**: 여러 속성 묶음으로 요소를 식별해 화면이 바뀌어도 같은 요소로 인식하는 방식.
>
> **출처 편향 주의:** ObservePoint·DataTrue·Tag Inspector에 대한 비판적 서술 일부는 경쟁사인 Trackingplan의 자사 비교 글에서 나왔다. 그런 대목은 "Trackingplan은 자사 글에서 ~라고 주장한다"로 화자를 명시했고, 가능한 곳은 독립 출처(G2 등)로 교차 확인했다. 가격의 연간 총액 추정치·이탈 후기 등은 공식이 아니라 제3자 집계·검색 요약 근거임을 표기했다. 독립 사용자 리뷰(G2·TrustRadius·Reddit)는 접근 차단이 많아 정성 후기 인용은 얇다.

---

# 1. ObservePoint — 크롤러 기반 태그 거버넌스·감사

## 1.1 푸는 문제

기업 규모의 웹사이트에서 "태그가 제대로 붙어 있고, 올바른 데이터를 수집하며, 개인정보·동의 규칙을 어기지 않는가"를 사람이 일일이 확인할 수 없다는 문제를 푼다. 배포·개편 때마다 깨지는 태그, 누락된 컨테이너, 잘못 수집되는 개인정보를 자동 감사로 잡아내는 것이 목표다([ObservePoint 홈](https://www.observepoint.com/), [태그 감사란](https://resources.observepoint.com/blog/tag-auditing-analysts)).

## 1.2 해결 방식과 기술

두 엔진으로 움직인다.

**(1) Audits — 크롤링 기반 전수 스캔.** 시작 URL에서 sitemap·robots.txt와 include/exclude 필터로 페이지를 자동 발견해 크롤한다(기본 100페이지, 최대 약 1만). 클라우드가 실제 브라우저 안에서 각 페이지를 렌더링하고, 수집 서버로 나가는 네트워크 요청을 감시해 "어떤 태그가 어디에 있고 무슨 데이터를 수집하는지" 기록한다. 다만 기본은 **페이지 로드 관찰 중심**이며, 클릭 등 상호작용은 On-Page Actions로 명시 설정해야만 수행한다([감사 만들기](https://help.observepoint.com/en/articles/9099982-creating-audits), [태그 감사란](https://resources.observepoint.com/blog/tag-auditing-analysts)).

**(2) Journeys — 시나리오 재생(사람이 손으로 스크립트, 녹화 아님).** 사람이 정의한 클릭·입력 순서를 봇이 재생한다. 지원 동작: "Navigate To", "Click", "Input", "Masked Input"(암호 등 보안 입력, AES 암호화 저장), 드롭다운·체크박스, "Execute"(자바스크립트 실행), "Watch"(태그 발화 대기) 등 12종. 요소 지정 우선순위는 ID → Name → XPath → CSS → HTML이다. 예약된 저니는 활동을 완료 못 하거나 기대 태그를 못 잡으면 알림을 준다([저니 만들기](https://help.observepoint.com/en/articles/9101987-creating-journeys), [저니·규칙 가이드](https://www.testedpath.com/observepoint-custom-rules-journeys.html)).

**(3) ClickAll+ — 요소 단위 클릭 검증(별도 애드온).** 페이지의 요소들을 프로그램적으로 클릭하고 다른 상호작용도 수행한다. 사람이 `INTERACTION_TYPES` 배열에 **CSS 셀렉터와 라벨을 직접 설정**해야 하며(개발자도구로 셀렉터를 골라 넣는 방식), 자동 요소 발견은 아니다. 상호작용한 요소를 화면에서 **하이라이트(시각 증거)** 하려 시도하고, 하이라이트가 어려운 숨은 요소는 `interactionObject` 데이터레이어의 Element Selector 변수로 어떤 요소가 클릭됐는지 남긴다. "클릭했는데 애널리틱스가 안 나오면 플래그"하는 식의 미계측 탐지도 사람이 지정한 범위 안에서 가능하나, 미계측 자동 탐지를 명시 기능으로 내세우지는 않는다([ClickAll+ 구현 가이드](https://help.observepoint.com/en/articles/9414370-clickall-solution-implementation-guide)).

**검증 규칙 정의 주체 — 사람.** Tag & Variable Rule은 `WHEN(조건) + EXPECT(기대값)` 구조로, Equals/Contains/Is set/Regex 등을 AND로 조합한다. 규칙과 기대값을 사람이 Rules Library에서 정의한다([태그·변수 규칙 만들기](https://help.observepoint.com/en/articles/9090206-create-tag-variable-rules)).

**감지 주기 — 스케줄(예약).** 예약 실행으로 상시 감시가 된다. 권장 빈도는 "결제·리드폼은 매일 저니, 주요 템플릿은 주간 감사, 배포 직후 수동 실행, 월 1회 전체 크롤 심층 감사" 식이다([감사 방법](https://resources.observepoint.com/blog/how-to-conduct-a-tag-management-audit/)).

**증빙.** Page Details 리포트가 페이지별로 수집 데이터·Web Vitals·태그·쿠키·네트워크 요청·콘솔 로그를 남긴다([감사 리포트 안내](https://www.observepoint.com/resources/guides/getting-to-know-the-observepoint-audit-report/)). ClickAll+는 요소 하이라이트 스크린샷을 시도한다(위). 요청 기록 증빙은 남기나, 전면적인 요소별 스크린샷 증빙은 보장되지 않는다(숨은 요소는 하이라이트 실패).

## 1.3 한계

- **커버리지가 사람이 짠 것에 종속.** 모든 저니·URL·기기를 수동으로 정의해야 하고, 정의된 것만 감시되므로, 짜놓지 않은 경로로 사용자가 가면 태깅 공백이 그냥 지나간다([Trackingplan 경쟁사 비교글](https://www.trackingplan.com/blog/observepoint-competitors) — 경쟁사 자사 글임에 유의).
- **자가치유 없음 → 유지보수가 사람 서비스로 상품화.** 셀렉터 자가치유가 없어, 공식 Best Practice가 "안정 셀렉터(`#buy-it-now`, `[data-test-id]`)를 사람이 고르라", "긴 퍼널 대신 짧은 저니를 만들라"고 권고한다. UI가 바뀌면 저니가 깨지고, 수정은 유료 "Journey Support" 팀이 48시간 내 처리하되 계정별 수정 가능 저니 수에 제한이 있다([저니 Best Practice](https://help.observepoint.com/en/articles/10090916-journey-best-practices), [저니 서포트](https://help.observepoint.com/en/articles/9102002-journey-support)).
- **스캔 시차.** 예약 스캔 사이의 빈틈, 그리고 "동의 상태·캠페인 파라미터·브라우저·배포 타이밍이 뒤섞인 실제 상황"에서만 나는 문제는 놓친다(Trackingplan 자사 글 주장).
- **관측·경보까지만.** 문제를 찾아 알려주지만 태그를 대신 고쳐주지는 않는다(수리·계측 실행 없음).
- **이탈 사유 — 방치로 인한 소진(burn-out).** 제3자 집계에 인용된 G2 후기 요약에 따르면 "기업들이 들뜬 채 도입했다가 아무도 관리하지 않아 금방 소진되는" 패턴이 지배적이며, 6주 온보딩으로 대시보드는 만들어지지만 이후 감사 이력이 조용해진다고 한다. UI가 복잡·비직관적이라 초기 설정·학습이 어렵다는 불만도 있다([G2 후기·장단점 요약](https://www.g2.com/products/observepoint/reviews?qs=pros-and-cons)).

## 1.4 가격 모델

페이지 스캔 규모 기반 티어로, 엔터프라이즈 고가로 알려져 있다. 제3자 집계 기준: Free(월 300 스캔), Essentials 월 $599(4,000 스캔), Professional 월 $2,400(20,000 스캔), Enterprise 맞춤(초과). 엔터프라이즈 평균 연 약 $72k로 추정된다([G2 가격 페이지](https://www.g2.com/products/observepoint/pricing)). TrustRadius에는 $598부터로 표기된다. "프리미엄 가격이라 소규모 예산엔 부담"이라는 후기가 있다.

## 1.5 공통 미해결 질문 답변

- **Q1(커버리지 결정 요인):** 사람이 짠 저니·규칙·URL·기기 목록의 양이 결정한다. 정의하지 않은 경로는 감시되지 않는다.
- **Q2(UI 요소 수준 검증?):** 부분적으로 그렇다. 저니와 ClickAll+ 애드온은 "이 요소를 누른다"는 UI 동작을 재생하고 태그 발화를 검증하나, **사람이 CSS 셀렉터로 지정한 요소에 한한다.** 기본 Audit(크롤링)은 페이지 로드 시 네트워크 요청 관측에 가깝다.
- **Q3(개편 후 규칙은?):** 사람이 고쳐야 한다. 자가치유가 없어 UI가 바뀌면 저니가 깨지고, 유료 Journey Support 큐를 통해 사람이 재작성한다.
- **Q4(증빙 남기는가?):** 남긴다. 페이지별 네트워크 요청·태그·쿠키·콘솔 로그. ClickAll+는 요소 하이라이트 스크린샷을 시도하나 숨은 요소는 실패.

---

# 2. Trackingplan.com — 실트래픽 청취 + 기준선 자동 학습 + 이탈 감지

## 2.1 푸는 문제

"마케터·경영진이 QA보다 먼저 트래킹 파손을 알아채는" 상황, 즉 사후 보고서로 파손을 뒤늦게 발견하는 문제를 푼다. 실제 운영 트래픽을 상시 감시해 파손·이상을 즉시 잡는 것이 목표다([Trackingplan 홈](https://www.trackingplan.com/), [경쟁사 비교글](https://www.trackingplan.com/blog/observepoint-competitors)).

## 2.2 해결 방식과 기술

**ObservePoint와 정반대 축 — 능동 크롤이 아니라 수동(passive) 실트래픽 관찰.** 태그매니저에 가벼운 스니펫을 넣거나 SDK를 심으면, 스니펫이 표준 자바스크립트 통신 메서드를 감싸(wrap) **이미 나가고 있는** 애널리틱스 요청만 엿본다: XHR(`XMLHttpRequest.open/send`), 픽셀(`HTMLImageElement.prototype.setAttribute`), Beacon(`navigator.sendBeacon`). 원 요청은 그대로 먼저 보내지고, 알려진 애널리틱스 도메인과 일치할 때만 사본이 **비차단(non-blocking)** 으로 Trackingplan 서버에 전달된다. 능동 크롤·합성 테스트는 전혀 하지 않는다([작동 원리 문서](https://www.trackingplan.com/docs/how-it-works), [작동 원리 페이지](https://www.trackingplan.com/how-it-works)). 웹·iOS·안드로이드·서버사이드를 지원한다.

**기준선 자동 학습(사람이 규칙을 짜지 않음).** 실제 데이터만으로 "살아있는 트래킹 플랜"을 만들고, 새 이벤트는 등장하는 대로 자동 추가한다. AI가 우리 스택의 "정상"이 무엇인지(이벤트별 발생 빈도·요일/시간대 변동성) 학습해 들어오는 데이터를 그 패턴과 계속 대조한다. 수동 스키마 설정이 필요 없고, 계절성·캠페인 기준선을 지속 갱신해 일시적 변화로 인한 오경보를 줄인다(동적 임계 "Grey band")([작동 원리](https://www.trackingplan.com/how-it-works), [이상 감지란](https://www.trackingplan.com/blog/what-is-traffic-anomaly-detection-for-marketers-en)).

**감지 주기 — 상시(24/7) + 매일 Deep Audit.** 예약 스캔이 아니라 상시 감시다. 새 버전 배포·태그 변경·꺼진 픽셀을 "일어나는 순간" 포착해 실시간 경보를 준다. 매일 아침 Deep Audit이 세션 단위(깨진 퍼널 시퀀스·중복 hit·프로바이더 간 일관성)를 배치 검증하고, 이메일·Slack·daily digest로 알린다([웹 트래킹 모니터링](https://www.trackingplan.com/solutions/web-tracking-monitoring), [Deep Audits 문서](https://www.trackingplan.com/docs/deep-audits)).

**증빙·진단.** 데이터레이어와 이벤트의 완전한 일일 스냅샷을 남기고, 실사용자 데이터 재생으로 세션을 탐색할 수 있다. AI Debugger가 경고에 대한 요약·근본원인 가설·권장 조치를 생성한다(진단 보조이며 자동 수정은 아님)([작동 원리](https://www.trackingplan.com/how-it-works)). 즉 요청·데이터 기록 증빙은 남기나, 이는 실트래픽 관측 기록이지 요소별 시각 증빙이 아니다.

## 2.3 한계

- **네트워크 관측만 — UI 요소 단위 검증 없음, 요소↔화면 매핑 없음.** 관찰 단위가 요청·이벤트·페이지라 "이 버튼을 누르면 이 이벤트"라는 요소 단위 검증이나 화면 스크린샷 대조가 없다([작동 원리](https://www.trackingplan.com/how-it-works)).
- **미계측 요소는 원리상 발견 불가.** 실제 발화된 트래픽만 보므로, 태그가 아예 없는 버튼(미계측 요소)은 신호가 없어 발견할 수 없다. 릴리스 전/스테이징 QA도 불가하고, 저볼륨 이벤트는 통계 노이즈가 된다([5가지 접근 비교](https://www.trackingplan.com/blog/5-approaches-to-tracking-audits-and-monitoring-compared)).
- **저트래픽 경로 사각지대.** 로그인·다단계 커버리지는 "실사용자가 밟기만 하면 자연히 커버"되는 역설적 강점이나, 실사용자가 안 밟는 경로(미출시 기능, 저트래픽 엣지)는 관측 표본이 없어 사각지대다.
- **관측·경보까지만.** 수리·계측 실행은 없다(안내만).
- **이탈·불만 후기.** 독립 후기는 아직 얇다. G2 15건 4.9/5, Product Hunt 16건 5/5로 만족도는 높으나, 구체적 불만·이탈 사유의 공개 자료는 부족하다([G2 대안 비교](https://www.g2.com/products/trackingplan/competitors/alternatives), [Product Hunt 후기](https://www.producthunt.com/products/trackingplan/reviews)). — **공개된 독립 후기 부족.**

## 2.4 가격 모델

MAU(월간 활성 이용자) 기반. Free($0, 월 방문자 1만) / Pay as You Grow($249/월~) / Enterprise($1,750/월~). 일부 집계 자료는 Enterprise를 월 $1,500부터로 표기해 자료 간 차이가 있다([Trackingplan 가격](https://www.trackingplan.com/pricing), [TrustRadius 가격](https://www.trustradius.com/products/trackingplan/pricing)).

## 2.5 공통 미해결 질문 답변

- **Q1(커버리지 결정 요인):** 실사용자 트래픽의 분포가 결정한다. 사람이 짠 시나리오 양이 아니라 "실제로 사람들이 다닌 만큼" 관측된다.
- **Q2(UI 요소 수준 검증?):** 아니다. 네트워크 요청 관측만. 요소 동작↔이벤트의 인과 검증은 사각지대.
- **Q3(개편 후 규칙은?):** 자동 재학습된다. 고쳐야 할 사람 정의 규칙이 애초에 없어, 실트래픽에서 새 패턴을 다시 학습한다.
- **Q4(증빙 남기는가?):** 남긴다. 데이터레이어·이벤트 일일 스냅샷과 세션 재생. 단 요소별 시각 증빙은 아님.

---

# 3. DataTrue — 시나리오 시뮬레이션 태그 테스트 + CI 연동

## 3.1 푸는 문제

배포 전후에 "핵심 사용자 여정(가입·장바구니·결제)에서 태그가 올바른 값과 함께 정확히 발화하는가"를 자동 테스트로 검증하는 문제를 푼다. 소프트웨어 개발 주기(CI) 안에서 트래킹 문제를 프로덕션 전에 잡는 것이 목표다([DataTrue 홈](https://datatrue.com/en/), [제품 투어](https://datatrue.com/products)).

## 3.2 해결 방식과 기술

**이중 구조 — Coverage Test + Simulation Test.** Coverage Test는 다수 페이지를 자동 크롤해 태그 존재·성능을 페이지 단위로 확인한다. Simulation Test는 특정 여정을 실제 브라우저로 재현하며 능동적으로 태그 발화를 감시한다(network 레벨 캡처, iframe·AJAX·지연 발화 처리, 태그매니저 preview 테스트)([제품 투어](https://datatrue.com/products)).

**저작 = 녹화·재생(record-and-playback) 기본.** 크롬 확장 Test Builder로 사이트와의 상호작용(클릭·이동)을 **녹화**해 테스트를 만든다. 가입·장바구니·결제 같은 여정을 사람이 녹화하면 봇이 재생한다. 방대한 태그 템플릿 라이브러리와 TypeScript API를 제공하고, 여러 브라우저·반응형 모드에서 테스트한다([제품 투어](https://datatrue.com/products)).

**태그 검증 + 데이터레이어 단위 테스트.** "Run Script" 단계로 데이터레이어를 강제 갱신하고, 페이지에서 이벤트가 실제 완료됐는지와 무관하게 올바른 태그가 발화하는지 검증한다. 단계마다 Tag Validation을 붙여 세밀한 단위 테스트를 만든다([데이터레이어 태그 단위 테스트 자동화](https://datatrue.com/en/how-to-automate-unit-testing-of-data-layer-triggered-tags/)).

**검증 규칙 정의 주체 — 사람.** 사람이 크롬 확장으로 시나리오를 녹화하고, 태그 템플릿 라이브러리로 기대값을 구성한다(맞춤 태그 생성 가능)([제품 투어](https://datatrue.com/products)).

**감지 주기 — 예약 + CI 트리거.** 예약 실행으로 자동 QA를 돌리고 여정을 상시 모니터링하는 한편, REST API·클라이언트로 Jenkins·TeamCity·Travis CI·Codeship 같은 CI 도구에서 릴리스 시점에 테스트를 트리거할 수 있다([API·CLI](https://datatrue.com/en/apis-cli-tools/), [Ruby API 클라이언트](https://github.com/datatrue-analytics/datatrue-api-client)).

**SPA·로그인.** 실제 브라우저 테스트라 인증 보호 환경을 지원하고, 여러 국가 실행·IP 대역 화이트리스트도 가능하다([제품 투어](https://datatrue.com/products)).

**증빙.** 로딩 시간·태그 검증 결과·태그 데이터 페이로드·오류를 담은 상세 리포트를 남긴다([제품 투어](https://datatrue.com/products)). 요청·페이로드 기록 증빙은 있으나, 요소별 스크린샷 증빙은 공식 문서에서 명확히 확인되지 않았다.

## 3.3 한계

- **커버리지가 사람이 녹화한 시나리오에 종속.** 녹화한 여정·단위 테스트만 검증되므로, 짜놓지 않은 경로는 빠진다. Simulation은 "이 요소 클릭 → 이 이벤트가 이 payload로 발화"를 증거와 함께 검증하나, **테스트에 포함시킨 요소에 한정**된다.
- **자가치유 없음.** record-and-playback 특성상 UI 변경 시 스텝이 깨져 사람이 재녹화·수정해야 한다(공식 자가치유 근거 없음).
- **여전히 스캔·테스트 중심.** Trackingplan은 자사 글에서 DataTrue를 "지속 관측으로 대체하기보다 감사·경보 워크플로를 현대화한 것"이라 평한다([경쟁사 비교글](https://www.trackingplan.com/blog/observepoint-competitors), 경쟁사 주장). "라이브 트래픽에서만 나타나는 문제는 스캔 중심이라 다 잡지 못한다"는 지적도 있다([DataTrue vs ObservePoint 비교](https://www.g2.com/compare/datatrue-vs-observepoint)).
- **관측·경보까지만.** 자동 수리는 없다.
- **불만 후기.** Capterra 리뷰(4건 5.0)는 셋업 간편·빠른 알림을 칭찬하는 한편 **가파른 학습곡선·시간 소모적 초기 구현**을 반복 지적한다.

## 3.4 가격 모델

연간 총액이 높은 편이다(드물게 공개). Starter 연 $16,000(도메인 2·사용자 2·월 1만 페이지), Team 연 $32,000(도메인 6·사용자 5·월 5만 페이지), Enterprise 맞춤(무제한 도메인·사용자, 월 2억 페이지, 민감정보 경보·쿠키 감사·모바일 앱 테스트 포함)([DataTrue 가격](https://datatrue.com/plans-and-pricing)).

## 3.5 공통 미해결 질문 답변

- **Q1(커버리지 결정 요인):** 사람이 녹화한 시나리오·단위 테스트의 양이 결정한다.
- **Q2(UI 요소 수준 검증?):** 그렇다. 녹화된 클릭·입력을 실제 브라우저로 재생하며 각 단계 태그 발화를 검증하므로, 사람이 짠 범위에서 요소 동작↔이벤트를 확인한다. Run Script는 데이터레이어를 직접 갱신해 검증하기도 한다.
- **Q3(개편 후 규칙은?):** 사람이 고쳐야 한다. 녹화 시나리오가 화면 요소에 묶여 있어 개편 시 재녹화·수정이 필요하다(자동 적응 기제 없음).
- **Q4(증빙 남기는가?):** 남긴다. 태그 검증 결과·페이로드·오류 리포트. 단 요소별 시각 증빙은 미확인.

---

# 4. Tag Inspector (InfoTrust) — 크롤·실시간 태그 모니터링

## 4.1 푸는 문제

멀티 브랜드·대규모 사이트에서 "모든 태그·쿠키가 무엇을 수집하고, 서드파티가 몰래 붙는 태그(피기배킹)는 없는지, 동의 규칙을 지키는지"를 프라이버시 중심으로 관리하는 문제를 푼다. 태그 거버넌스와 개인정보 컴플라이언스가 핵심 타깃이다([Tag Inspector 제품](https://infotrust.com/products/tag-inspector/), [거버넌스 모듈](https://infotrust.com/articles/tag-inspector-governance-module-game-changer-for-multi-brand-organizations/)).

## 4.2 해결 방식과 기술

**두 축 — 합성 크롤링 + 실시간 모니터링.**

**(1) 합성 스캔(크롤링).** 지능형 크롤러가 사용자를 흉내 내며 페이지를 돌고, 선택한 지역·동의 조건(동의 수락/거부/GPC 거부/미선택)별로 시뮬레이션한다. 모든 페이지를 로드해 결과 태그·쿠키 동작을 리포트로 남긴다. 태그 라이브러리는 2,900개 이상 분류돼 있다([제품 페이지](https://infotrust.com/products/tag-inspector/), [기술 토크](https://clickz.com/tech-talk-with-infotrusts-tag-inspector-tag-monitoring-for-unparalleled-data-quality/)).

**(2) Realtime(실시간).** 모든 전환·버튼 클릭·페이지 로드에서 태그 동작을 검증한다. 최대 1분 이내로 발생·실패를 추적하고 결제 퍼널·전환 완료 페이지를 검증한다. PII(개인식별정보) 평문 수집을 실시간 모니터링한다([기술 토크](https://clickz.com/tech-talk-with-infotrusts-tag-inspector-tag-monitoring-for-unparalleled-data-quality/)).

**검증 규칙 정의 주체 — 사람.** 조직이 지역별로 "허용되는 데이터 수집"을 문서화한 동의 정책(Consent Policy)을 세우면, 시스템이 그 맞춤 규칙과 대조해 위반을 검증한다([제품 페이지](https://infotrust.com/products/tag-inspector/)).

**감지 주기 — 스케줄 스캔 + 실시간 PII 감시 병행.** 월간 프라이버시 감사(이력 보존)를 예약하는 한편, PII 모니터링은 상시로 보인다([제품 페이지](https://infotrust.com/products/tag-inspector/)).

**SPA·로그인.** 2026년 3월 업데이트로 노코드 인증 녹화 기능이 추가되어, 로그인 뒤 화면을 로그인한 사용자로서 감사할 수 있다([2026년 3월 릴리스 노트](https://infotrust.com/articles/tag-inspector-march-2026-release-notes/)).

**증빙.** 정책 위반 상세(위반의 기술 세부)와 태그·쿠키 인벤토리·감사 이력을 남긴다([제품 페이지](https://infotrust.com/products/tag-inspector/)). 태그·쿠키 네트워크 동작 분석이 중심이며, 요소↔이벤트 매핑이나 요소별 스크린샷 증빙은 확인되지 않았다.

## 4.3 한계

- **UI 요소 검증보다 태그·쿠키 네트워크 동작 분석 중심.** Trackingplan은 자사 글에서 Tag Inspector를 "대규모 크롤링·쿠키 인벤토리·피기배킹 가시성·프라이버시 워크플로에 강한, 실시간 관측형이라기보다 거버넌스 중심 도구"로 규정한다([경쟁사 비교글](https://www.trackingplan.com/blog/observepoint-competitors), 경쟁사 주장).
- **스캔 시차.** 월간 예약 감사가 기본이라 스캔 사이 빈틈이 존재한다(실시간 축은 PII·전환 검증에 집중).
- **관측·경보까지만.** 감사·진단·관리는 하되 자동 수리·계측 실행은 없다.
- **이탈·불만 후기.** G2 8건 4.2/5(5점 62%, 4점 25%)로 표본이 작고, 구체적 불만·이탈 사유의 공개 자료는 부족하다([G2 가격 페이지](https://www.g2.com/products/tag-inspector/pricing), [SaaSworthy](https://www.saasworthy.com/product/tag-inspector)). — **공개된 독립 후기 부족.**

## 4.4 가격 모델

도메인 수가 아니라 **페이지·히트 수 기반** 과금. 무료 체험(신용카드 없이 100페이지 감사)과 소규모용 Essential 티어(감사당 최대 500페이지)가 있고, 상위 티어는 비공개다. Managed Audit Review(전문가 감사 검토) 애드온이 있다([패키지·가격](https://infotrust.com/products/tag-inspector/packages/), [G2 가격](https://www.g2.com/products/tag-inspector/pricing)).

## 4.5 공통 미해결 질문 답변

- **Q1(커버리지 결정 요인):** 크롤 범위 설정 + 사람이 정의한 동의 정책의 양이 결정한다. 실시간 축은 실제 전환·클릭 트래픽에 따른다.
- **Q2(UI 요소 수준 검증?):** 주로 네트워크 요청·쿠키 관측. Realtime이 전환·클릭에서 태그 동작을 검증하나, "이 요소를 누르면 이 이벤트"라는 요소 단위 인과 매핑보다는 태그 발화·PII 수집 관측에 무게가 있다.
- **Q3(개편 후 규칙은?):** 사람이 고쳐야 한다. 동의 정책·크롤 설정이 사람 정의라 개편 시 재검토가 필요하다(자동 적응 기제 없음).
- **Q4(증빙 남기는가?):** 남긴다. 정책 위반 상세·태그/쿠키 인벤토리·감사 이력. 단 요소별 시각 증빙은 미확인.

---

# 5. 네 도구의 방식 한눈에 비교

| 축 | ObservePoint | Trackingplan | DataTrue | Tag Inspector |
|---|---|---|---|---|
| 순회 방식 | 크롤링 + 시나리오 재생 (+ClickAll+) | 실트래픽 청취(순회 안 함) | 크롤(Coverage) + 시나리오 재생(Simulation) | 크롤링 + 실시간 모니터링 |
| 커버리지 결정 | 사람이 짠 저니·규칙 | 실사용자 트래픽 분포 | 사람이 녹화한 시나리오 | 크롤 설정 + 사람 정의 동의 정책 |
| 규칙 정의 | 사람 | 자동 학습 | 사람 | 사람 |
| 감지 주기 | 스케줄 | 상시 24/7 | 스케줄 + CI 트리거 | 스케줄 스캔 + 실시간 PII |
| UI 요소 단위 검증 | 부분(짠 범위, ClickAll+) | 없음(네트워크만) | 있음(짠 범위) | 부분(전환·클릭) |
| 미계측 요소 발견 | 사람 지정 범위 내에서만 | 원리상 불가 | 사람 지정 범위 내에서만 | 아님 |
| 개편 후 규칙 | 사람이 수리(유료 서비스) | 자동 재학습 | 사람이 수리(재녹화) | 사람이 수리 |
| 자가치유 셀렉터 | 없음 | 해당 없음(규칙 없음) | 없음 | 없음 |
| 증빙 | 요청·로그 기록(+요소 하이라이트) | 데이터레이어 스냅샷 | 페이로드·오류 리포트 | 위반 상세·인벤토리 |
| 요소별 시각 증빙 | 부분(숨은 요소 실패) | 아님 | 미확인 | 미확인 |
| 수리 실행 | 없음(경보만) | 없음(안내만) | 없음(경보만) | 없음(경보만) |
| 가격대 | 프리미엄(엔터 연 ~$72k 추정) | MAU 기반(엔터 월 $1.75k~) | 연 $16k~$32k~ | 페이지·히트 기반 |

---

# 6. 가치제안 문서와의 접점 — 이미 성취한 것 vs 남겨둔 공백

내부 기획 문서(`트래킹플랜-자동화-가치제안 (2).md`)의 핵심 차별 축(요소 지문 + 시각 증빙, 미계측 요소 자동 발견, 자가 생성 경로 컨텍스트, 개편 시 자동 이관, 진단·수정안 생성, 태그매니저 흡수)에 4개 도구를 대응시킨다.

| 가치제안의 축 | 대응 공통질문 | 4개 도구가 이미 성취한 것 | 남겨둔 공백(가치제안이 겨냥하는 지점) |
|---|---|---|---|
| **① 화면 순회로 요소·태그·증빙 자동 기록** | Q4 | ObservePoint 저니·ClickAll+, DataTrue 녹화가 화면을 재생하며 태그를 검증하고 요청·로그를 남김. 크롤러가 전 페이지 스캔 | 네 도구 모두 **요소 지문 + 스크린샷·좌표의 전면적 시각 증빙**은 없음(ClickAll+ 하이라이트도 숨은 요소는 실패). 증빙은 네트워크 요청·페이로드 수준 |
| **② UI 요소↔이벤트 인과 검증**("이 버튼→이 이벤트") | Q2 | ObservePoint·DataTrue는 사람이 짠 범위에서 요소 동작↔태그 발화를 확인. Tag Inspector Realtime은 전환·클릭 검증 | Trackingplan은 네트워크 관측만. 나머지도 **사람이 지정한 요소에 한함** — 화면 전체 요소를 자동으로 인과 검증하지는 않음 |
| **③ 커버리지를 사람이 아닌 도구가 확장**(미계측 요소 자동 발견) | Q1 | Trackingplan은 실트래픽에서 이벤트를 자동 발견해 사람 시나리오 부담을 없앰(자동 학습) | ObservePoint·DataTrue·Tag Inspector는 **사람이 짠 시나리오·규칙만큼만** 커버. **"클릭 가능하나 태그 없는 요소"의 능동 자동 탐지는 시장의 명확한 백지** — Trackingplan조차 실트래픽 방식이라 원리상 불가 |
| **④ 자가 생성 경로 컨텍스트**(사람이 경로를 입력하지 않음) | Q1 | Trackingplan은 실트래픽으로 실사용 경로를 자동 반영 | ObservePoint·DataTrue는 **사람이 경로를 손으로 짜야** 함. 봇의 클릭 이력이 곧 진입 경로가 되는 자가 생성 컨텍스트는 없음 |
| **⑤ 개편 시 자동 이관**(요소 지문·유사도 매칭으로 무개입 이관) | Q3 | Trackingplan만 규칙이 없어 자동 재학습 | 규칙 기반 3개 도구는 개편 시 **사람이 저니·시나리오·정책을 다시 손봐야** 함(ObservePoint는 유료 서비스로 흡수). 요소 지문 기반 이벤트 이력 연속성 유지는 태그 감사 진영에 없음(테스트 자동화 진영에만 — 7장 참조) |
| **⑥ 진단을 넘어 수정안 생성**(반영은 승인 뒤) | (기획 고유) | Trackingplan AI Debugger가 근본원인 가설·권장 조치 제시 | 네 도구 모두 **경보·안내까지**. 태그매니저 계층에서 수정안을 생성·재검증해 승인 대기열에 올리는 수리 루프는 없음("관측·경보까지만" 공통) |
| **⑦ 수집·검증의 단일화**(태그매니저 흡수) | (기획 고유) | 없음 — 네 도구 모두 기존 태그매니저 **위에 얹혀 검증만** 함 | 수집(태그매니저)과 검증을 한 몸으로 흡수해 계획–설치–발생 삼각 대조를 내부에서 산출하는 구조는 어느 도구에도 없음 |

**요약.** 실트래픽 청취(Trackingplan)는 가치제안의 ③④⑤(자동 커버리지·자가 경로·개편 자동 적응)를 상당 부분 이미 달성했으나, **네트워크 관측에 머물러 UI 요소 인과 검증·시각 증빙(①②)이 없고, 미계측 요소는 원리상 못 찾는다.** 시나리오·크롤 기반 3개 도구(ObservePoint·DataTrue·Tag Inspector)는 UI 동작 재생·검증을 하지만 **커버리지가 사람이 짠 것에 묶이고, 자가치유가 없어 개편 시 사람이 고쳐야** 한다. 네 도구 공통의 가장 큰 공백은 (a) **요소 지문 + 스크린샷·좌표의 시각 증빙**, (b) **미계측 요소 능동 자동 발견**, (c) **개편 내성 있는 요소 이력 계승**, (d) **진단을 넘어선 수정안 생성**, (e) **태그매니저 흡수를 통한 수집·검증 단일화**다 — 가치제안 문서가 정확히 이 공백들을 겨냥하고 있다.

---

# 7. 인접 영역 참고 (가치제안 기술 청사진에 직결)

태그 감사 4종의 공백을 메우는 방법론은 이웃 진영에 이미 있다.

- **자가치유 셀렉터 / 요소 지문(가장 직결).** 테스트 자동화 진영의 표준 5단계 파이프라인: ① 요소 지문 생성(XPath/CSS + class/name/aria-label/data-* 속성 + DOM 계층·위치 + visual + visible text + 주변 요소 — "12개 속성이 단일 취약 locator보다 낫다") → ② 실패 감지 → ③ 다중 전략 복구(안정성 순위: ARIA label/role > visible text > name/placeholder > CSS class > DOM position > 자동 생성 ID) → ④ ML 신뢰도 점수(임계 초과만 자동 적용, 낮으면 사람 검토) → ⑤ 로깅·갱신([ThinkPalm 기술 딥다이브](https://thinkpalm.com/blogs/how-self-healing-test-automation-works-a-technical-deep-dive/)). 벤더: Testim(Smart Locators), Functionize(요소당 수백 속성 이력 점수), Testsigma(사람 개입), Healenium(오픈소스 Selenium ML 매칭 + 교체 이력·스크린샷). → **가치제안의 "요소 지문으로 이력을 잇는다"와 정확히 맞닿는 검증된 청사진.**
- **AI 에이전트 QA 스타트업 — analytics 검증은 백지.** QA Wolf·Momentic·Meticulous·Reflect·mabl·Applitools·Autify·Octomind 조사 결론: **트래킹/애널리틱스 이벤트 검증을 내세우는 곳은 사실상 없음**(기능·시각 회귀에 집중). 단 UI 자율 조작 기술은 참고 가치 — QA Wolf "Mapping AI"(자율 탐색 → deterministic Playwright 코드 변환, DOM 미도달 지점은 vision), Momentic(vision + step 캐시 + self-heal), Octomind("AI는 test runtime에 있으면 안 된다" — 생성·유지보수만 AI, 실행은 deterministic). → **UI 자율 조작 × analytics 검증의 교차점이 통째로 비어 있음.**
- **사내 Playwright/Cypress 검증.** network interception(page.route/waitForResponse, cy.intercept로 /collect·/track beacon 캡처 후 assert)이나 dataLayer 직접 assert, 전용 도구 Snowplow Micro(로컬 수집 엔드포인트 + schema 검증)로 자체 검증은 가능하나, 테스트가 극도로 취약하고 SPA 타이밍·경우의 수 폭발·silent failure 때문에 대부분 팀이 유지하지 못한다([Snowplow Micro](https://github.com/snowplow-incubator/snowplow-micro)).
- **부분 예외 도구.** Hub'Scan의 **Tag Defender**는 데이터레이어 실시간 감시·자동 교정(patching)을 표방해 일종의 self-healing에 가깝다(공식 사이트 무응답, 서드파티 리스팅 근거). Adobe Assurance는 세션 기반 실시간 SDK 디버깅으로 상시 자동 감사에는 부적합. Elevar는 Shopify 전환 추적 특화.

---

**조사 한계 요약:** (1) 독립 사용자 리뷰(G2·TrustRadius·Reddit)는 접근 차단이 많아 정량 후기 확보가 얇음 — 이탈 사유는 제3자 집계·검색 요약에 의존. (2) Trackingplan의 "요소 단위 매핑 없음"은 문서 미언급에 기반한 추론. (3) ObservePoint·DataTrue·Tag Inspector 비판 일부는 경쟁사 Trackingplan 자사 글 출처로, 화자를 명시함. (4) Hub'Scan 공식 사이트 무응답.
