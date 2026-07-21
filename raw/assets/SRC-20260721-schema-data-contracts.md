# 스키마·데이터 계약 계층 조사 (원자료)

이 문서는 "데이터 파손 탐지"와 "규격(스키마) 검증"을 다루는 대표 접근 세 가지 — Snowplow(스키마 우선 파이프라인), 데이터 계약(data contract), 데이터 옵저버빌리티(Monte Carlo 등) — 를 정리한다. 각 접근이 **무엇을 풀고, 어떻게 풀며, 어떤 기술을 쓰고, 어디에 한계가 있는지**를 본다. 특히 "파손을 파이프라인의 어느 지점에서 잡는가"라는 축으로 셋을 비교하고, 행동 이벤트 데이터(앱·웹에서 사람이 심는 계측)에 적용할 때 생기는 공백을 짚는다. (용어 풀이는 맨 끝 표.)

---

## A. Snowplow — 스키마 우선(schema-first) 행동 데이터 파이프라인

### A-1. 푸는 문제

Snowplow의 핵심 생각은 "모든 이벤트는 **수집되기 전에** 미리 정의된 스키마(데이터 구조 명세)를 통과해야 한다"는 것이다. 스키마에 맞지 않는 데이터는 깨끗한 최종 테이블(`atomic` 테이블)에 들어가지 못하게 막아, 웨어하우스에 도착하는 데이터의 품질을 파이프라인 단계에서 보증한다([Self-describing schemas](https://docs.snowplow.io/docs/fundamentals/schemas/)).

### A-2. 해결 기제와 기술

**(1) 자기기술(self-describing) 이벤트 — 데이터가 자기 스키마를 들고 다닌다**
Snowplow는 "자기기술 JSON 스키마"를 쓴다. 이벤트 데이터 안에 "나는 어떤 스키마를 따른다"는 메타데이터가 함께 담긴다. 각 이벤트는 스키마 식별자(예: `iglu:com.snowplowanalytics.snowplow/page_view/jsonschema/1-0-0`)를 URI로 참조한다. 겉껍데기(`unstruct_event`)가 "이건 자기기술 이벤트다"라고 알리고, 안쪽에 실제 이벤트 스키마와 데이터가 중첩된다. 트래커는 이를 JSON(`ue_pr`) 또는 Base64(`ue_px`)로 전송한다([Self-describing schemas](https://docs.snowplow.io/docs/fundamentals/schemas/)).

**(2) Iglu — 스키마 레지스트리(스키마 저장·배포 창구)**
Iglu는 JSON 스키마를 호스팅·관리하는 스키마 저장소(레지스트리)다. 파이프라인 부품들이 검증할 때 Iglu에서 스키마를 받아 대조한다. 두 형태가 있다: 직접 운영하는 **Iglu Server**(스키마 발행·검증·제공을 REST API로 노출)와, S3 같은 정적 웹사이트에서 읽기 전용으로 제공하는 **정적 저장소(static repository)**. 공개 스키마용 **Iglu Central**도 있다([Iglu 소개](https://docs.snowplow.io/docs/api-reference/iglu/), [Iglu 관리](https://docs.snowplow.io/docs/api-reference/iglu/manage-schemas/)).

**(3) SchemaVer — 스키마 전용 버전 표기법**
스키마 버전은 `MODEL-REVISION-ADDITION`(공식 문서는 major-minor-patch로 설명) 형식이며 `1-0-0`에서 시작한다. 일반 소프트웨어 버전(SemVer)과 달리 점(.)이 아니라 하이픈(-)을 쓰고, `0.1.0`이 아닌 `1-0-0`에서 출발한다([SchemaVer](https://docs.snowplow.io/docs/fundamentals/schemas/versioning/)):
- **major(첫 숫자)**: 과거 데이터를 더 이상 검증할 수 없게 만드는 **깨는 변경**에 올린다(예: 필드 타입 변경, 필수 필드 추가).
- **minor(둘째 숫자)**: 일부 과거 데이터를 검증 못 하게 될 **수도** 있는 변경.
- **patch(셋째 숫자)**: 모든 과거 데이터와 호환되는 변경(예: 선택 필드 추가).

깨는지 여부는 웨어하우스마다 다르다. 예를 들어 "필수→선택" 변경은 Redshift에선 깨는 변경이지만 다른 곳에선 아니다. 잘못 배포된 스키마는 패치 대신 **superseded(대체됨)로 표시**할 수 있다 — 새 버전에 `"$supersedes": ["1-0-2"]`를 넣으면 Enrich 단계가 옛 버전 이벤트를 새 버전으로 자동 변환하고 `validation_info` 엔티티로 그 사실을 기록한다. 단, 이전 버전만 대체할 수 있다([SchemaVer](https://docs.snowplow.io/docs/fundamentals/schemas/versioning/)).

**(4) Data Structures / Data Product Studio — 스키마를 다루는 상위 도구와 워크플로**
Data Product Studio는 이벤트·엔티티의 데이터 구조를 정의·버저닝하고 소유권·거버넌스·관측을 붙이는 관리 계층이다. Data Structures API는 "**개발 레지스트리에서 검증·테스트 → 운영 레지스트리에 배포**"라는 워크플로를 강제한다. 초안(draft) 상태는 개발 환경에 배포되지 않아 검증에 쓰이지 않고, 준비되면 배포한다. **Data Structures CI 도구**는 CI/CD에 붙어 애플리케이션 코드가 배포되기 전에 "필요한 스키마가 환경에 다 배포됐는지"를 검사해 'Schema not found' 계열 실패를 예방한다([Data Structures 관리](https://docs.snowplow.io/docs/data-product-studio/data-structures/manage/), [Data Structures CI 도구](https://docs.snowplow.io/docs/data-product-studio/data-quality/data-structures-ci-tool/)).

**(5) failed events — 파손을 격리·보관·복구**
스키마에 맞지 않는 이벤트는 버려지지 않고 **failed events(실패 이벤트)**로 분리 보관된다. 실패는 파이프라인 여러 단계에서 발생한다([failed events 소개](https://docs.snowplow.io/docs/fundamentals/failed-events/)):
- **수집(collection)**: 잘못된 페이로드 형식
- **검증(validation)**: 이벤트·엔티티가 스키마와 불일치 — 보통 계측 코드가 틀렸거나 스키마가 레지스트리에 없을 때. 파이프라인은 내 Iglu 저장소와 Iglu Central을 모두 뒤진 뒤에야 `ResolutionError`로 처리한다.
- **강화(enrichment)**: 외부 API 장애나 커스텀 JavaScript 강화 코드 오류
- **적재(loading)**: 최신 버전에선 극히 드묾

실패 이벤트는 객체 저장소(S3/GCS)에 유형·시간별로 백업되고, 원하면 웨어하우스의 별도 테이블로 계속 적재해 조사·수정할 수 있다. 파이프라인 재실행(replay)으로 복구도 가능하지만 복잡하다([failed events 소개](https://docs.snowplow.io/docs/fundamentals/failed-events/), [failed events 웨어하우스 적재](https://docs.snowplow.io/docs/monitoring/exploring-failed-events/)). Kafka를 쓰면 검증 실패·강화 실패별로 **데드레터 큐(DLQ, 처리 실패 메시지 격리 대기열)** 토픽을 따로 두도록 구성할 수 있다([Kafka DLQ FAQ](https://snowplow.io/snowplow-frequently-asked-questions/how-to-route-snowplow-bad-events-to-a-dead-letter-queue-in-kafka)). Snowplow는 실패 이벤트 양과 성공 적재량을 비교한 **데이터 품질 점수**도 제공한다([failed events 모니터링](https://docs.snowplow.io/docs/data-product-studio/data-quality/failed-events/monitoring-failed-events/)).

### A-3. 파손을 어디서 잡는가

**수집 직후~웨어하우스 도착 전, 파이프라인 안(in-pipeline)**에서 잡는다. 모든 이벤트가 스키마 검증을 통과해야 `atomic` 테이블에 들어가므로, 규격 위반 데이터는 애초에 깨끗한 테이블에 섞이지 않는다. 트레이드오프: 검증이 **강제·자동**이라 나쁜 데이터가 원천 차단되지만, 위반 이벤트는 그 순간 실패 이벤트로 빠져 **그대로 유실될 수 있다**(복구는 별도 작업). 또한 검증은 "스키마에 맞는가"만 보므로, 스키마엔 맞지만 의미가 틀린 값(잘못된 화면에서 발생한 올바른 형식의 이벤트 등)은 통과한다.

### A-4. 한계

- **높은 엔지니어링 부담**: 컬렉터·강화·로더·모니터링 등 여러 부품과 Iglu 스키마를 계속 관리해야 한다. 이벤트가 늘수록 스키마가 늘고 거버넌스·디버깅·운영 복잡도가 함께 커진다([Snowplow 리뷰(Modern DataTools)](https://www.modern-datatools.com/tools/snowplow)).
- **자체 호스팅 난이도**: 구현에 상당한 엔지니어링 자원이 필요하고 파이프라인 유지보수가 계속된다. "엔지니어가 제품 기능 개발 대신 이벤트 파이프라인 유지에 시간의 40%를 쓴다"는 지적처럼, 상당한 운영 부담을 동반한다([Snowplow 경쟁사 비교(Improvado)](https://improvado.io/blog/snowplow-competitors)).
- **가치 실현까지 시간(time-to-value)이 김**: 즉시 쓰는 턴키형 분석 도구보다 초기 설정이 복잡하고 운영 오버헤드가 크다([Snowplow 리뷰(Modern DataTools)](https://www.modern-datatools.com/tools/snowplow)).

---

## B. 데이터 계약(data contract)

### B-1. 푸는 문제

데이터 계약은 **데이터 생산자(producer)와 소비자(consumer) 사이의 공식 합의**다. 스키마, 의미(semantics), SLA(서비스 수준 약속), 품질 규칙, 소유권, 변경 관리 절차를 버전 관리되는 기계 판독 가능한 형태로 못박는다([What Are Data Contracts?(DataHub)](https://datahub.com/blog/the-what-why-and-how-of-data-contracts/)). 핵심 동기는 "생산자-소비자 사이에 명시적 합의가 없다는 것이 수많은 데이터 신뢰성 사고의 근본 원인"이라는 진단이다. 그래서 품질 책임을 하류(소비자가 사후에 청소)에서 **상류(생산자가 원천에서 보증)로 옮기는** 이른바 "**shift-left(왼쪽으로 당기기)**"를 지향한다([Actian: 데이터 계약 가이드](https://www.actian.com/data-contracts/), [Chad Sanderson: 소비자 정의 데이터 계약](https://dataproducts.substack.com/p/the-consumer-defined-data-contract)).

### B-2. 해결 기제와 기술

**(1) 표준 — ODCS와 Data Contract Specification**
업계 표준은 **ODCS(Open Data Contract Standard, 열린 데이터 계약 표준)**로, Bitol이 관리하는 Linux Foundation 프로젝트이며 현재 v3.1.0이다. ODCS는 논리 타입(string, integer 등)과 물리 타입(varchar, INT64 등)을 분리하고, v3부터 JSON·AVRO 같은 복합 구조도 지원한다. v3.1.0은 v3.0.x와 완전한 하위 호환을 유지한다([ODCS v3.1.0(Bitol)](https://bitol-io.github.io/open-data-contract-standard/v3.1.0/), [ODCS(datacontract.com)](https://docs.datacontract.com/open-data-contract-standard)). 별도로 Data Contract Specification이라는 표기 규격도 있다([Data Contract Specification](https://datacontract-specification.com/)).

**(2) 도구 — datacontract-cli**
Data Contract CLI는 계약을 다루는 오픈소스 도구(명령줄 + 파이썬 라이브러리)다. 주요 명령: `init`(템플릿 생성), `lint`(YAML 문법 검증), `test`(스키마·품질 검사 실행), `export`/`import`(형식 변환, SQL DDL·Avro·Protobuf·dbt·JSON Schema 등 25종 이상), `dbt`(dbt 프로젝트 연동), `changelog`(계약 버전 비교), `edit`(웹 에디터). **`test`는 계약에 적힌 서버 자격증명으로 실제 데이터 소스(Postgres·Snowflake·BigQuery·Databricks 등 18종 이상)에 접속해 SQL 쿼리로 실제 데이터가 스키마·품질 조건에 맞는지 대조한다.** 기본 형식은 ODCS이며, 독립 CLI·파이썬 라이브러리·CI/CD·웹 API로 배포된다([Data Contract CLI](https://cli.datacontract.com/)).

**(3) 스키마 진화(evolution) 규칙**
계약은 시간이 지나며 바뀌므로, "옛 데이터를 깨지 않으면서 필드를 더하는" 진화 규칙이 중요하다. datacontract-cli는 `required: false`로 표시한 선택 필드가 검증에서 필수로 잘못 취급되던 버그를 고쳐, 선택 필드를 추가해도 과거 데이터 파일 검증이 깨지지 않는 정상적 스키마 진화를 지원한다([Changelog](https://cli.datacontract.com/CHANGELOG.html)).

### B-3. 파손을 어디서 잡는가

**생산자 쪽 + CI/CD**에서 잡는다("shift-left"). 계약이 생산자의 배포 파이프라인(CI)에 붙어, 스키마·품질 규칙을 어기는 변경이 릴리스되기 전에 막는 것을 지향한다([DataHub 데이터 계약 가이드](https://datahub.com/blog/the-what-why-and-how-of-data-contracts/)). 트레이드오프: 문제를 **가장 이른 지점(원천)**에서 막을 수 있지만, 그러려면 생산자가 계약을 쓰고 지키도록 조직적으로 합의·강제해야 한다 — 기술 문제가 아니라 사람·문화 문제라서 실제 정착이 어렵다(B-4).

### B-4. 한계

- **가장 큰 장벽은 기술이 아니라 조직·문화**: 비공식적 데이터 공유에서 계약 기반 거버넌스로 옮기려면 협업 방식과 역할이 바뀌어야 한다([TheDataGovernor: 데이터 계약 실무 가이드](https://thedatagovernor.com/data-contracts/)).
- **생산자의 동기 부족**: 생산자에게 추가 작업을 요구하면 "나한테 무슨 이득?"이라는 반응이 나온다. 도메인 팀은 엔지니어링 역량은 있어도 거버넌스 경험이 적어, 좋은 계약을 쓰고 유지하도록 교육·유인이 필요하다([TheDataGovernor: 데이터 계약 실무 가이드](https://thedatagovernor.com/data-contracts/)).
- **관료화·우회 위험**: 잘못 설계한 계약은 개발을 돕기는커녕 늦춘다. 계약이 있어도 사람들이 잊거나 우회하는데, 이는 일부 도구 문제이자 대부분 사람 문제이고 초기 정착이 특히 취약하다([TheDataGovernor: 데이터 계약 실무 가이드](https://thedatagovernor.com/data-contracts/)).

---

## C. 데이터 옵저버빌리티(data observability) — Monte Carlo 중심

### C-1. 푸는 문제

데이터 옵저버빌리티는 "데이터와 파이프라인의 건강 상태를 지속 감시"하는 접근이다. 스키마를 미리 강제하기보다, **이미 웨어하우스에 쌓인 데이터가 평소와 다르게 행동하는지**를 자동 감지해 사고를 조기에 알린다. Monte Carlo가 이 범주를 개척했다([Monte Carlo: 데이터 옵저버빌리티란](https://montecarlo.ai/blog-what-is-data-observability), [Monte Carlo 플랫폼(LinkedIn)](https://www.linkedin.com/products/monte-carlo-data-data-observability-platform/)).

### C-2. 해결 기제와 기술

**(1) 다섯 기둥(five pillars)**
건강한 데이터는 파이프라인 각 단계에서 다섯 축을 감시해 얻는다([Monte Carlo: 데이터 옵저버빌리티란](https://montecarlo.ai/blog-what-is-data-observability)):
- **신선도(freshness)**: 데이터가 얼마나 최신인지, 테이블이 얼마나 자주 갱신되는지
- **품질(quality, 문서에 따라 distribution)**: NULL 비율·고유값 비율·허용 범위 안에 값이 있는지
- **볼륨(volume)**: 데이터 테이블의 완전성 — 행 수가 갑자기 늘거나 줄었는지, 누락·중복이 있는지
- **스키마(schema)**: 구조 변화(누가 언제 바꿨는지)
- **계보(lineage)**: 데이터가 깨졌을 때 영향받는 하류 자산과 원인이 된 상류 소스를 추적

**(2) 머신러닝 기반 기준선 학습**
Monte Carlo의 모니터는 규칙을 손으로 설정·임계값 지정하는 부담이 최소인 ML 기반 이상 감지다. 머신러닝 모델이 내 환경과 데이터를 자동으로 학습해 **정상 기준선(baseline)**을 세우고, 데이터가 비정상으로 행동하면 이상 감지 기법으로 알린다([Monte Carlo: 데이터 옵저버빌리티란](https://montecarlo.ai/blog-what-is-data-observability)).

**(3) 연결과 알림**
기존 데이터 스택(Snowflake·BigQuery·Databricks·Redshift·dbt·Airflow 등)에 붙어 지속 감시하고, 사고 감지 시 담당자에게 즉시 알린다. 최근엔 "Data + AI Observability"로 범위를 넓혀 ML 모델 입출력과 AI 어시스턴트 출력까지 LLM 기반 "judge" 모니터로 평가한다([Basedash: 2026 도구 비교](https://www.basedash.com/blog/best-data-observability-tools-compared-2026)).

### C-3. 비교 — Metaplane / Bigeye

- **Metaplane**: 스타트업·중견 팀 대상. 약 15분 배포를 내세운 빠른 도입과 자동 모니터링이 강점이지만, Monte Carlo보다 고급 기능이 제한적이고 계보 기능이 기본적이며 복잡한 요구엔 커스터마이즈가 약하다([Basedash: 2026 도구 비교](https://www.basedash.com/blog/best-data-observability-tools-compared-2026)).
- **Bigeye**: 지표(metric) 단위의 세밀한 품질 관리에 강하고, 사용자 정의 지표와 SLA 중심 모니터링을 지원한다([Basedash: 2026 도구 비교](https://www.basedash.com/blog/best-data-observability-tools-compared-2026), [Monte Carlo vs Bigeye(Bigeye)](https://www.bigeye.com/blog/monte-carlo-vs-bigeye-an-in-depth-feature-comparison)).
- **정리**: Monte Carlo는 가장 넓은 ML 기반 종단 관측이지만 비싸고, Metaplane·Bigeye는 빠른 배포와 낮은 가격의 중견 시장 대안이다([Basedash: 2026 도구 비교](https://www.basedash.com/blog/best-data-observability-tools-compared-2026)).

### C-4. 파손을 어디서 잡는가

**웨어하우스 도착 후, 사후(after-the-fact)**에 잡는다. 데이터가 이미 쌓인 뒤 평소와 다른 패턴을 감지한다. 트레이드오프: 스키마를 미리 정의·강제할 필요 없이 **어떤 데이터에도 붙일 수 있고** 예상 못 한 이상까지 잡지만, 이미 나쁜 데이터가 들어온 **뒤에** 알린다는 점에서 사후 대응이다.

### C-5. 한계

- **알림 피로(alert fatigue)와 오탐(false positive)**: 기본 모니터가 파이프라인 양이 많은 환경에서 시끄럽다는 평. 스스로 해결되거나 대응이 불필요한 잘못된 알림이 엔지니어를 방해해, 임계값 조정과 알림 피로 관리가 초기 필수 과제로 꼽힌다([Sifflet: Monte Carlo 리뷰](https://www.siffletdata.com/blog/monte-carlo-data-review), [Monte Carlo Pros and Cons(G2)](https://www.g2.com/products/monte-carlo/reviews?qs=pros-and-cons)).
- **설정 복잡도·업무 맥락 부족**: 대규모 배포에서 설정이 복잡하고, 전면 감시 방식이 업무적 맥락을 놓칠 때가 있다([Sifflet: Monte Carlo 리뷰](https://www.siffletdata.com/blog/monte-carlo-data-review)).
- **비용·불투명한 가격**: 엔터프라이즈 맞춤 가격이라 투명성이 낮고, 명확한 ROI 기준이 없으면 소규모 조직이 비용을 정당화하기 어렵다([Sifflet: Monte Carlo 리뷰](https://www.siffletdata.com/blog/monte-carlo-data-review)).

---

## D. 교차 비교 — 파손을 파이프라인의 "어느 지점에서" 잡는가

같은 "데이터 파손 방지"라도 세 접근은 개입 지점이 다르고, 그에 따라 트레이드오프가 갈린다. 데이터 흐름을 **SDK(수집 전) → 파이프라인(수집~적재) → 웨어하우스(도착 후)**로 놓고 보면:

| 지점 | 접근 | 방식 | 강점 | 약점(트레이드오프) |
|---|---|---|---|---|
| 수집 전 SDK | (Avo 등 계측 도구) | 코드 생성·런타임 스키마 검증으로 계측 단계에서 차단 | 계측 원인(코드)에 가장 가까움 | 개발자가 SDK를 심고 함수를 직접 호출해야 함 |
| 파이프라인 안 | **Snowplow** | 수집 후·웨어하우스 전 스키마 검증, 위반은 failed events로 격리 | 나쁜 데이터의 원천 차단, 자동·강제 | 위반 이벤트 유실 위험, 운영 부담 큼 |
| 원천+CI/CD | **데이터 계약** | 생산자 배포 전 계약 검사(shift-left) | 가장 이른 지점에서 예방 | 조직·문화적 합의 필요, 정착이 어려움 |
| 웨어하우스 도착 후 | **옵저버빌리티(Monte Carlo)** | 쌓인 데이터의 이상을 ML로 사후 감지 | 스키마 정의 불필요, 예상 못 한 이상도 포착 | 사후 대응, 알림 피로·오탐 |

핵심 대비: Snowplow와 데이터 계약은 **파손을 미리 막는(예방)** 쪽, 옵저버빌리티는 **파손을 사후에 발견하는(탐지)** 쪽이다. 예방형은 규격을 강제하는 대신 운영·조직 부담이 크고, 탐지형은 붙이기 쉽지만 이미 벌어진 뒤에 안다.

---

## E. 행동 이벤트 데이터의 공백 — 웨어하우스 옵저버빌리티가 못 내려가는 곳

행동 이벤트 데이터(앱·웹에서 사람이 코드로 심는 계측)에 웨어하우스 중심 옵저버빌리티를 적용하면 구조적 사각지대가 생긴다. **옵저버빌리티는 "테이블"을 볼 뿐 "앱"을 보지 못한다.**

- **원인까지 못 내려간다**: UI 변경으로 어떤 트래킹 호출이 삭제되면, 옵저버빌리티는 볼륨이 줄었다는 것은 잡을 수 있어도 "어느 화면의 어떤 코드 변경 때문인지"라는 계측 원인은 이름 붙이지 못한다. 계보(lineage)는 웨어하우스 안 자산 사이의 흐름은 추적하지만([DataHub: 데이터 옵저버빌리티 가이드](https://datahub.com/blog/what-is-data-observability/)), 그 계보는 앱 코드·UI까지 이어지지 않는다.
- **애초에 없는 것은 관측할 수 없다**: 어떤 이벤트가 처음부터 계측되지 않았다면, 관측할 데이터 자체가 없다. 옵저버빌리티는 "설계상 등록하기로 한 것"만 감시하므로, 조용히 이탈한 더 큰 집단은 지표에서 구조적으로 빠진다([Luciq: 모바일 옵저버빌리티 사각지대](https://www.luciq.ai/blog/mobile-observability-organization-types)).
- **왜 이 문서가 필요한가**: 이 공백은 개입 지점을 **웨어하우스에서 SDK(수집 전)로 당겨야** 메워진다. 계측 단계에서 코드 생성·런타임 스키마 검증으로 잡는 Avo/Inspector 같은 접근이 바로 그 지점을 겨냥한다(참고: `avo-조사.md`). Snowplow의 파이프라인 검증도 웨어하우스보다는 앞이지만, 여전히 "이벤트가 발생한 뒤"를 보므로 "심어야 할 계측이 코드에 아예 없다"는 누락은 파이프라인·웨어하우스 어느 쪽도 스스로 알기 어렵다(Snowplow는 CI 도구로 스키마 배포 누락은 막지만, 코드에 계측 호출을 넣었는지는 별개다 — [Data Structures CI 도구](https://docs.snowplow.io/docs/data-product-studio/data-quality/data-structures-ci-tool/)).

정리하면, 웨어하우스 중심 옵저버빌리티는 "데이터가 이상하다"까지는 잘 알리지만, 행동 데이터에서 "왜(어떤 코드·UI 변경 때문에)"와 "무엇이 빠졌나(계측 자체의 부재)"에는 도달하지 못한다. 이 두 질문은 수집 전 계측 계층에서만 답할 수 있다.

---

## F. 용어 정리

| 용어 | 한 줄 풀이 | 출처 |
|---|---|---|
| 스키마 레지스트리(schema registry) | 스키마(데이터 구조 명세)를 한곳에 저장하고 파이프라인에 나눠 주는 창구. Snowplow에선 Iglu가 담당 | [Iglu 소개](https://docs.snowplow.io/docs/api-reference/iglu/) |
| 자기기술 이벤트(self-describing event) | 데이터 안에 "나는 어떤 스키마를 따른다"는 정보를 함께 담아, 데이터가 자기 스키마를 들고 다니게 한 이벤트 | [Self-describing schemas](https://docs.snowplow.io/docs/fundamentals/schemas/) |
| SchemaVer | 스키마 전용 버전 표기법(MODEL-REVISION-ADDITION, `1-0-0`에서 시작). 깨는 변경·부분 호환·완전 호환을 세 숫자로 구분 | [SchemaVer](https://docs.snowplow.io/docs/fundamentals/schemas/versioning/) |
| failed events(실패 이벤트) | 스키마 검증·강화 등에서 실패해 깨끗한 테이블에 못 들어가고 별도 격리·보관되는 이벤트 | [failed events 소개](https://docs.snowplow.io/docs/fundamentals/failed-events/) |
| 데드레터 큐(DLQ) | 처리에 실패한 메시지를 버리지 않고 따로 모아 두는 대기열(Kafka 등에서 실패 유형별로 구성) | [Kafka DLQ FAQ](https://snowplow.io/snowplow-frequently-asked-questions/how-to-route-snowplow-bad-events-to-a-dead-letter-queue-in-kafka) |
| 데이터 계약(data contract) | 데이터 생산자와 소비자가 스키마·품질·SLA·소유권을 못박은 버전 관리되는 공식 합의 | [What Are Data Contracts?(DataHub)](https://datahub.com/blog/the-what-why-and-how-of-data-contracts/) |
| ODCS(Open Data Contract Standard) | 데이터 계약의 업계 표준 서식(Bitol·Linux Foundation, v3.1.0) | [ODCS(Bitol)](https://bitol-io.github.io/open-data-contract-standard/v3.1.0/) |
| shift-left(왼쪽으로 당기기) | 품질 책임을 하류(소비자 사후 청소)에서 상류(생산자 원천 보증)로 옮기는 것 | [Actian: 데이터 계약 가이드](https://www.actian.com/data-contracts/) |
| 스키마 진화(schema evolution) | 과거 데이터를 깨지 않으면서 스키마를 바꿔 가는 것(예: 선택 필드 추가) | [Data Contract CLI Changelog](https://cli.datacontract.com/CHANGELOG.html) |
| 데이터 옵저버빌리티(data observability) | 데이터와 파이프라인의 건강 상태를 지속 감시해 사고를 조기에 알리는 접근 | [Monte Carlo: 데이터 옵저버빌리티란](https://montecarlo.ai/blog-what-is-data-observability) |
| 신선도(freshness) | 데이터가 얼마나 최신인지, 테이블이 얼마나 자주 갱신되는지 | [Monte Carlo: 데이터 옵저버빌리티란](https://montecarlo.ai/blog-what-is-data-observability) |
| 볼륨(volume) | 데이터 양(행 수)의 급변·누락·중복을 감시하는 축 | [Monte Carlo: 데이터 옵저버빌리티란](https://montecarlo.ai/blog-what-is-data-observability) |
| 계보(lineage) | 데이터가 어디서 와서 어디로 흘러가는지의 연결. 깨졌을 때 영향받는 하류·원인 상류를 추적 | [Monte Carlo: 데이터 옵저버빌리티란](https://montecarlo.ai/blog-what-is-data-observability) |
| 기준선 학습(ML baseline) | ML 모델이 정상 데이터 패턴을 자동 학습해 정상 범위를 세우고, 벗어나면 알리는 방식(임계값 수동 설정 부담 최소) | [Monte Carlo: 데이터 옵저버빌리티란](https://montecarlo.ai/blog-what-is-data-observability) |

---

*조사일: 2026-07-21. 모든 주장에 출처 URL을 링크로 표기함. 형식은 `avo-조사.md` 구조를 따름.*
