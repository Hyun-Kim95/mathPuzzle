# Product Requirements Document (PRD)
## mathPuzzle — 100 Logic Riddles

| 항목 | 내용 |
|------|------|
| 문서 버전 | 1.2 |
| 작성일 | 2026-05-17 |
| 최종 수정 | 2026-05-17 (엣지케이스·문서 세트 정합) |
| 기본 언어 | English (en) |
| 플랫폼 | Mobile-first (Android / iOS) — 웹은 Out of Scope (v1) |
| 로그인 | 없음 (게스트 전용) |

---

## 1. 제품 개요

### 1.1 한 줄 정의
**숫자·도형·연산 관계에서 숨겨진 규칙을 찾아 빈 칸을 채우는 100문제 논리 퍼즐 앱**이다. Math Riddles류 앱과 같이 짧은 세션으로 뇌 훈련·IQ 퍼즐 경험을 제공한다.

### 1.2 문제 정의
- 오프라인·짧은 시간에 즐길 수 있는 논리 수학 퍼즐 수요는 있으나, 과도한 계정·구독 장벽은 이탈을 유발한다.
- 힌트·정답은 수익화 포인트이나, **광고 시청 후에만** 제공해야 사용자 신뢰와 수익의 균형을 맞출 수 있다.

### 1.3 제품 목표
| 목표 | 설명 |
|------|------|
| G1 | 100개의 고유 패턴 퍼즐을 **순차 해금** 후, 해금된 레벨을 **자유 선택·재플레이**하며 완주할 수 있다 |
| G2 | 로그인 없이 설치 즉시 플레이 가능 |
| G3 | 힌트/정답은 **리워드 광고 1회 시청 = 1회 공개** 정책 |
| G4 | 후원(IAP)으로 개발 지원 유도 (v1 문의 채널 없음 — O3) |
| G5 | BGM·효과음으로 몰입감·피드백 제공 (설정에서 끄기 가능) |

### 1.4 비목표 (v1 Out of Scope)
- 계정·클라우드 동기화·리더보드·소셜 로그인
- 멀티플레이·UGC(사용자 제작 문제)
- 일일 퀘스트·스트릭·푸시 알림 (v1.1 후보)
- 다국어 UI (v1은 영어만; 문자열 구조는 i18n 대비)
- 웹 버전·태블릿 전용 레이아웃 최적화

---

## 2. 사용자 및 시나리오

### 2.1 타깃 사용자
| 페르소나 | 설명 | 니즈 |
|----------|------|------|
| Casual Solver | 통근·대기 시간에 1~3문제 | 빠른 재개, 광고 최소 체감 |
| Puzzle Enthusiast | 100문제 완주 목표 | 난이도 곡선, 진행 저장 |
| Parent / Educator | 아이와 함께 논리 연습 | 단순 UI, 힌트로 학습 지원 |

### 2.2 핵심 시나리오
1. **첫 실행**: 스플래시 → (선택) 짧은 튜토리얼 1문제 → 레벨 목록
2. **문제 풀이**: 문제 화면 → 숫자/선택지 입력 → 제출 → 정답/오답 피드백
3. **막힘**: 힌트 버튼 → “Watch ad to reveal hint” → 광고 완료 → 힌트 표시
4. **포기/확인**: 정답 버튼 → 동일 광고 게이트 → 정답·해설 표시
5. **설정**: BGM/SFX·테마, 후원하기(IAP), 개인정보·이용약관, About, 진행 초기화
6. **재방문**: 로컬 진행(해금 레벨, 각 문제별 힌트/정답 열람 여부) 자동 복원

---

## 3. 기능 요구사항

### 3.1 퍼즐 콘텐츠 (100 Levels)

#### 3.1.1 문제 유형 (예시 카테고리)
| ID | 유형 | 설명 | 예시 |
|----|------|------|------|
| T1 | Number grid | 격자 내 숫자 관계 | 가로·세로 합/곱 규칙 |
| T2 | Shape + number | 도형별 가중치 | △=2, □=3 합산 |
| T3 | Operator pattern | 연산자가 바뀌는 수열 | +, −, × 순환 |
| T4 | Missing term | ? 위치의 값 | 3, 6, 12, ? |
| T5 | Visual equation | 비표준 방정식 | 시계·도형 조합 |

#### 3.1.2 난이도 분포 (권장)
| 구간 | 레벨 | 난이도 | 비고 |
|------|------|--------|------|
| 1 | 1–20 | Easy | 튜토리얼 성격 포함 |
| 2 | 21–50 | Medium | 복합 규칙 2단계 |
| 3 | 51–80 | Hard | 함정·다중 변수 |
| 4 | 81–100 | Expert | 최소 힌트로 풀 수 있게 설계 |

#### 3.1.3 문제 데이터 스키마 (콘텐츠 계약)
각 레벨은 JSON(또는 동등)으로 관리한다.

```json
{
  "id": 1,
  "title": "Level 1",
  "type": "number_grid",
  "prompt": "Find the missing number.",
  "assets": { "image": null, "layout": "grid_3x3" },
  "input": { "mode": "numeric", "min": 0, "max": 999 },
  "answer": 6,
  "hint": "Look at the sum of each row.",
  "explanation": "Each row sums to 15, so ? = 6.",
  "difficulty": "easy",
  "tags": ["addition"]
}
```

**필수 필드**: `id`, `title`, `type`, `prompt`, `input`, `answer`, `hint`, `explanation`, `difficulty`  
**선택**: `assets` (`image`, `layout`), `tags[]`  
**타입 enum·T1–T5 매핑**: [requirements/content-type-mapping.md](requirements/content-type-mapping.md)  
**JSON Schema**: [content/levels/level.schema.json](../content/levels/level.schema.json)

#### 3.1.4 정답 판정·입력 검증
- 숫자: 정수 비교 (앞뒤 공백 제거, 선행 0 제거, `+`/`,` 등 비숫자 문자는 **제출 전** 차단 또는 정규화 실패 시 오류)
- 범위: `input.min`~`input.max` 밖이면 Submit 비활성 또는 “Enter a number between {min} and {max}”
- 빈 입력: Submit 비활성 (버튼 disabled)
- 객관식: 미선택 시 Submit 비활성; `choiceId` 일치 시 정답
- 중복 Submit: 처리 중 **Submit 비활성** (double-tap 방지)
- 오답 시: SFX + “Try again”; **정답·해설 자동 노출 없음** (Show Answer 광고와 별개)
- 정답 시: SFX + “Next level” CTA; Level 100은 All Complete 화면
- 상세 엣지케이스: **§16.1**

#### 3.1.5 진행 규칙
| 규칙 | 정책 |
|------|------|
| 초기 해금 | **Level 1만** 설치 직후 플레이 가능 |
| 레벨 해금 | Level *n* 정답 제출 성공 시 Level *n+1* 해금 |
| 스킵 | v1 없음 (미해금 레벨 직접 진입 불가) |
| 레벨 선택 | **해금·완료된 레벨만** 목록에서 탭해 진입·재플레이 가능 |
| 재시도 | 무제한 (동일 레벨 내 오답·재제출) |
| 완료 표시 | 레벨 카드에 ✓; **별(Perfect)** 은 §3.1.6 기준 충족 시 |
| 클리어 판정 | **정답을 직접 제출해 통과**해야 완료·다음 해금 (광고로 정답만 열람한 것은 클리어 아님) |

진행 상태는 **기기 로컬 저장소**에만 저장 (AsyncStorage / SharedPreferences 등).  
**앱 삭제·기기 변경·Reset Progress** 시 진행은 복구되지 않음 (v1 클라우드 백업 없음).

#### 3.1.6 정답 공개·별(Perfect) 정책
| 항목 | 정책 |
|------|------|
| Show Answer (광고) | `answer`·`explanation` **열람만**; 자동 제출·자동 해금 **없음** |
| 클리어 후 동작 | 사용자가 값을 입력(또는 선택) 후 **Submit** 성공 시에만 완료 처리 |
| 힌트/정답 순서 | 힌트 없이 **정답 광고만** 시청 가능 (힌트 선행 필수 아님) |
| Perfect(별) | 해당 레벨에서 **힌트 광고·정답 광고 모두 미시청** 상태로 Submit 성공 |
| 별 박탈 | 한 번이라도 힌트/정답 광고 보상을 받은 뒤 클리어하면 ✓만 부여 (별 없음) |
| 재플레이 | 완료 레벨 재입장 시 별·완료 상태는 유지; 이미 열람한 힌트/정답은 §3.3.1대로 재표시 |

---

### 3.2 인증·식별·개인정보 (로그인 없음)
- **로그인·회원가입·프로필 없음**
- v1 **문의 기능 없음** (O3) — 이메일·메시지 수집 없음
- `deviceId`: v1 **미사용** (향후 지원/분석 도입 시 로컬 UUID 생성; 광고 ID와 분리)
- 광고·분석 SDK 수집 데이터는 SDK·동의(§6) 범위와 별도; `deviceId`를 광고 ID로 재사용하지 않음

---

### 3.3 광고 게이트 — 힌트 & 정답

#### 3.3.1 정책 (핵심)
| 항목 | 정책 |
|------|------|
| 힌트 | 레벨당 **최초 1회** 광고 시청 후 `hint` 텍스트 영구 표시 (해당 기기) |
| 정답 | 레벨당 **최초 1회** 광고 시청 후 `answer` + `explanation` 영구 표시 |
| 재시청 | 이미 열람한 힌트/정답은 광고 없이 다시 표시 |
| 광고 유형 | **Rewarded Video** (전면/배너는 보조만) |
| 실패 | 로드 실패·중도 종료·보상 미지급 → **미공개**; 사용자 메시지·재시도는 **§16.3** |
| 미성년 | 스토어 연령 등급에 따른 광고 SDK 정책 준수 |
| 튜토리얼 | 온보딩/튜토리얼 구간(§4, O8)에서는 **힌트·정답 버튼 비활성 또는 광고 없이 안내** (첫 광고는 본게임 Level 1 이후) |
| 오프라인 | 광고 SDK 미로드 시 시청 불가; §3.3.1 실패 정책 적용 (우회 열람 없음) |
| 중복 보상 | `onRewarded` **1회만** unlock 처리; SDK 중복 콜백은 idempotent 저장 |
| 일일 상한 | v1: 리워드 광고 **무제한** (남용 모니터링만); v1.1에서 일일 cap 검토 가능 |

#### 3.3.2 UX 플로우
```
[Hint button] → Modal: "Watch a short video to unlock hint"
  → [Watch] → Ad SDK → onRewarded → Show hint panel
  → [Cancel] → Dismiss
```
정답 버튼도 동일 패턴. 힌트와 정답은 **별도 광고 1회** (총 최대 2회/레벨).

#### 3.3.3 수익화 보조 (v1 선택)
- 배너: 레벨 목록 하단만 (게임플레이 화면 X)
- 인터스티셜: v1 **비권장** (이탈 위험); 도입 시 레벨 5문제마다 등 상한 명시

---

### 3.4 문의하기 (Contact / Support)

**v1 Out of Scope (O3, ADR-0003)** — 설정에 Contact Us 없음. 스토어 리뷰·향후 v1.1+에서 재검토.

---

### 3.5 후원하기 (Support / Donate)

| 항목 | 요구사항 |
|------|----------|
| 진입 | 설정 “Support the Developer” |
| 방식 A | 인앱 결제 (IAP) — Tip $0.99 / $2.99 / $4.99; v1 기본은 **소모성(Consumable) 팁** (스토어별 가이드 준수) |
| 방식 B | 외부 링크 — **v1 미포함** (O2 = IAP only) |
| UX | 감사 메시지, **게임 진행·힌트/정답 열람에 영향 없음** (Pay-to-win·광고 면제 금지) |
| 실패 | 취소·오류·대기·중복 탭 — **§16.5** |
| 환불 | 스토어 환불 정책 따름; 앱 내 별도 환불 UI 없음 |
| 복원 | 소모성 팁은 Restore 불필요; 비소모 SKU 도입 시에만 Restore Purchases 제공 |

**확정 (O2)**: v1 **IAP only** — Consumable tips; 외부 링크 없음.

---

### 3.6 오디오 (BGM & SFX)

| 종류 | 요구사항 |
|------|----------|
| BGM | 메인·레벨 목록·문제 화면 루프, 저작권 로열티 프리 또는 자작 |
| SFX | 탭, 정답, 오답, 레벨 해금, 힌트/정답 공개, 버튼 |
| 설정 | **Master Mute** + BGM on/off + SFX on/off |
| 음량 우선순위 | Master Mute ON → BGM·SFX 모두 무음; OFF일 때만 BGM/SFX 개별 토글 적용 |
| 저장 | 설정값 로컬 영구 저장 (Master·BGM·SFX 각각) |
| 인터럽션 | 전화·알림·백그라운드·무음 스위치 — **§16.6** |
| 리소스 | 파일 크기 합계 목표 < 5MB; 로드 실패 시 해당 SFX만 스킵, 앱 중단 없음 |

---

### 3.7 설정 및 정보 화면

| 메뉴 | 설명 |
|------|------|
| Appearance | System / Light / Dark (ADR-0002) |
| Sound | BGM / SFX toggles |
| Support Developer | §3.5 IAP tips |
| Privacy Policy | 웹뷰 또는 외부 브라우저 |
| Terms of Use | 동일 |
| About | 앱명, 버전, 크레딧 |
| Reset Progress | 2단계 확인(“This cannot be undone”) 후 §3.7 범위 초기화; 실패 시 **§16.2** |

---

## 4. 화면 구조 (Information Architecture)

```
App
├── Splash
├── Onboarding (optional, skippable)
│   └── Tutorial Puzzle (Level 0 or Level 1 guided)
├── Home / Level Select
│   └── Grid 1–100 (locked / unlocked / completed)
├── Puzzle Play
│   ├── Prompt + Input
│   ├── Submit
│   ├── Hint (ad-gated)
│   └── Show Answer (ad-gated)
├── Level Complete
├── All Complete (100/100)
└── Settings
    ├── Appearance
    ├── Sound
    ├── Donate (IAP)
    ├── Legal
    ├── About
    └── Reset Progress
```

### 4.1 주요 화면 와이어 요구 (구현 전 산출물)
- Level Select: 10×10 또는 챕터(20레벨 단위) 스크롤
- Puzzle Play: 상단 레벨 번호, 중앙 문제, 하단 입력·제출·힌트·정답
- Ad modal: 단일 CTA, 취소 명확

---

## 5. UX / UI 원칙

- **단순 정보 구조**: 한 화면에 하나의 문제
- **터치 타깃**: 최소 44×44pt
- **상태**: 로딩(광고), 빈 목록 없음, 오류(광고·네트워크), 성공(클리어)
- **접근성**: 색만으로 정오답 구분 X, 라벨·VoiceOver 지원
- **기본 언어**: 모든 UI 문자열 `en` — `strings.en.json` 등으로 분리
- **다크 모드**: v1 권장 (시스템 연동)

---

## 6. 비기능 요구사항

| 영역 | 요구사항 |
|------|----------|
| 성능 | 콜드 스타트 < 3s (중급 기기), 레벨 전환 < 300ms |
| 오프라인 | 100문제·오디오 번들 로컬; 광고·IAP만 네트워크 필요 |
| 저장 | 진행·설정·unlock 플래그 로컬 저장; 손상·마이그레이션 — **§16.2** |
| 보안 | API 키 하드코딩 금지 |
| 분석 | v1 선택 — Firebase Analytics: `level_complete`, `ad_reward_hint`, `ad_reward_answer`, `donate_click` |
| 규정 | GDPR/CCPA: **첫 리워드 광고 또는 분석 활성화 전** 동의(또는 CMP); EU/UK 타깃 필수 |
| COPPA | 연령 등급 Everyone이면 **아동 대상 광고·행동 광고 금지** SDK 설정 및 Privacy Policy 반영 |
| 스토어 | 연령 등급, 데이터 안전성 양식, **광고 포함·인앱 구매** 명시 |
| ATT (iOS) | 추적 필요 SDK 사용 시 ATT 프롬프트; 거부 시에도 **비개인화 광고**로 힌트/정답 게이트 유지 |

---

## 7. 기술 방향 (권장, 확정 전 가정)

| 항목 | 권장안 | 비고 |
|------|--------|------|
| 프레임워크 | **Flutter** (확정, ADR-0002) | Dart 3.x |
| 테마 | **라이트 + 다크** (시스템 기본, 설정에서 System/Light/Dark) | [design-tokens-v0.md](design/design-tokens-v0.md) |
| 광고 | Google AdMob Rewarded | iOS ATT 고려 |
| IAP | 네이티브 IAP (`in_app_purchase` 등) | 후원 팁 |
| 로컬 DB | JSON 번들 + key-value 진행 | SQLite는 v1 과함 |
| CI | Flutter build + Fastlane / Codemagic | 스토어 배포 |

**역할 분담 (구현 단계)**  
- **frontend-agent**: 화면·상태·오디오·광고 UI 연동  
- **backend-agent**: v1 백엔드 없음 (O3 문의 없음)  
- **design-system-agent**: 색·타이포·다크모드 토큰  
- Gate 2 병렬: UI 트랙 vs 콘텐츠 JSON 100문제 제작 트랙 병렬 가능 (파일 충돌 낮음)

---

## 8. 콘텐츠 제작 & QA

| 단계 | 산출물 |
|------|--------|
| 설계 | 100문제 스펙 시트 (정답·힌트·해설 검수) |
| 검증 | 자동: 정답 타입 체크 / 수동: 난이도·오타 |
| QA 시나리오 | **§16.8** 체크리스트 전 항목 (P0 필수) |

---

## 9. 릴리즈 기준 (Definition of Done)

- [ ] 100레벨 플레이·해금·로컬 저장 동작
- [ ] 힌트/정답 각각 리워드 광고 1회 정책 준수
- [ ] 광고 정답 열람 후에도 Submit 클리어·Perfect(별) 규칙 (§3.1.6)
- [ ] Reset Progress 범위 (§3.7) 및 튜토리얼 무광고 (§3.3.1)
- [ ] 후원 1종 이상 동작
- [ ] BGM/SFX 및 설정 저장
- [ ] 영어 UI 전체 적용
- [ ] Privacy Policy URL live
- [ ] 스토어 스크린샷·설명(영어) 준비
- [ ] §16 P0 엣지케이스·에러 처리 QA 통과

---

## 10. 로드맵

| 버전 | 범위 |
|------|------|
| **v1.0 (MVP)** | 100문제, 광고 힌트/정답, IAP 후원, 오디오, en, Android |
| v1.1 | 일일 퍼즐, 성취 배지, 가벼운 통계 |
| v1.2 | 추가 언어 (ko, es…) |
| v2 | 클라우드 백업(선택), UGC |

---

## 11. 성공 지표 (KPI)

| 지표 | 목표 (출시 후 30일, 가정) |
|------|---------------------------|
| D1 retention | ≥ 35% |
| 평균 세션 길이 | 5–8분 |
| L10 도달률 | ≥ 50% |
| 힌트 광고 완료율 | ≥ 70% (요청 대비) |
| 후원 전환 | ≥ 0.5% MAU |

---

## 12. 가정 및 미확정 사항

| ID | 항목 | 가정 / 선택 필요 |
|----|------|------------------|
| O1 | 플랫폼 우선순위 | **Decided:** Android 먼저 |
| O2 | 후원 수단 | **Decided:** IAP only (v1) |
| O3 | 문의 | **Decided:** v1 기능 없음 |
| O4 | 광고 SDK | **Decided:** Google AdMob — [ADR-0005](decisions/ADR-0005-admob-everyone-coppa.md) |
| O5 | 레벨 UI | **Decided:** 5 chapters × 20 |
| O6 | 브랜드명·번들 ID | **Decided:** 표시명 **mathPuzzle**, 번들 `com.mathpuzzle.app` (권장) |
| O11 | 모바일 스택 | **Decided:** Flutter |
| O7 | 연령 등급 | **Decided:** Everyone — [ADR-0005](decisions/ADR-0005-admob-everyone-coppa.md) |
| O8 | 튜토리얼 | **Decided:** 스킵 가능 |
| O9 | 튜토리얼 | **Decided:** Level 1 가이드 (별도 Level 0 없음) |
| O10 | COPPA·광고 SDK | **Decided:** child-directed UMP — [ADR-0005](decisions/ADR-0005-admob-everyone-coppa.md) |

**구현 착수 전 Human 확인 권장**: — (O1–O11 확정; 스토어 제출 전 ADR-0005 재확인)

---

## 13. Gate 1 자체 점검

| Gate 1 항목 | 상태 |
|-------------|------|
| 목표·사용자·시나리오 | ✅ |
| 핵심/비핵심 범위 | ✅ |
| 화면 IA | ✅ (와이어는 구현 직전) |
| 정책 (광고·진행·로그인 없음) | ✅ (v1.1 §15) |
| 엣지케이스·에러 처리 | ✅ (v1.2 §16) |
| 미확정 분리 | ✅ §12 |
| 구현 단위 분해 | ✅ 콘텐츠 / 앱 / 수익화 트랙 |

→ **Gate 1 통과 가능**. O1–O3, O6, O11 확정 — `start-feature` / 콘텐츠 병렬 착수 가능.

---

## 14. 부록 — 사용자 스토리 (요약)

| ID | As a… | I want… | So that… |
|----|--------|---------|----------|
| US-01 | player | play without signing up | I start immediately |
| US-02 | player | see 100 levels with clear progress | I know how far I’ve gone |
| US-03 | stuck player | watch an ad for a hint | I get help without paying |
| US-04 | stuck player | watch an ad for the answer | I can learn and move on |
| US-05 | player | turn off music/sounds | I can play quietly |
| US-06 | user | contact support | *(v1.1+ — O3 out of scope)* |
| US-07 | fan | tip the developer | I can show appreciation |
| US-08 | returning player | resume my progress | I don’t lose my work |

---

## 15. 정책 충돌 해소·누락 보완 (변경 이력)

### 15.1 해소한 충돌
| # | 충돌 | 해소 |
|---|------|------|
| C1 | G1 “선택 플레이” vs 순차 해금·스킵 없음 | “선택” = **해금된 레벨만** 재선택·재플레이 (§1.3 G1, §3.1.5) |
| C2 | 광고로 정답 열람 vs “정답 제출로 해금” | 열람 ≠ 클리어; **Submit 성공** 시에만 완료·해금 (§3.1.5–3.1.6) |
| C3 | Perfect(별) vs 힌트/정답 광고 수익화 | 별 = **두 광고 모두 미사용** 클리어; 광고 사용 시 ✓만 (§3.1.6) |
| C4 | Master Mute vs BGM/SFX 개별 | Master ON이면 전부 무음 (§3.6) |
| C5 | Reset Progress 범위 불명 | 진행·unlock·별 초기화 / 사운드·IAP 유지 (§3.7) |
| C6 | 후원(IAP) vs Pay-to-win 금지 | 팁은 **진행·광고 면제와 무관** 명시 (§3.5) |
| C7 | IAP 소모/비소모 미정 | v1 기본 **Consumable**; Restore는 비소모 도입 시만 (§3.5) |

### 15.2 보완한 누락 정책
| # | 누락 | 보완 위치 |
|---|------|-----------|
| M1 | Level 1 초기 해금 | §3.1.5 |
| M2 | 힌트 없이 정답 광고만 보기 | §3.1.6 |
| M3 | 튜토리얼 구간 광고 정책 | §3.3.1 |
| M4 | 광고 SDK 중복 보상·오프라인 | §3.3.1 |
| M5 | deviceId·문의 개인정보 범위 | §3.2 |
| M6 | 앱 삭제 시 진행 소실 | §3.1.5 |
| M7 | 동의(UMP/CMP)·COPPA·ATT | §6 |
| M8 | Reset 시 unlock 포함 여부 | §3.7 |
| M9 | JSON 예시 answer/explanation 불일치 | §3.1.3 예시는 `answer: 6`으로 정합 (구현 시 검증) |

### 15.3 v1.2 엣지케이스 보완 요약
| # | 영역 | 보완 |
|---|------|------|
| X1 | 입력·Submit | min/max, 빈값, 중복 탭, 정규화 (§16.1) |
| X2 | 저장 | 손상·쓰기 실패·kill 시 클리어 (§16.2) |
| X3 | 광고 | no-fill, 동의, 백그라운드, kill (§16.3) |
| X4 | 문의·IAP·오디오·시스템 | §16.4–16.7 |
| X5 | QA DoD | §16.8 P0 체크리스트 |

---

## 16. 엣지케이스·에러 처리 기준

> UI 문구는 **영어(en)**. 심각도: **P0** = 출시 차단, **P1** = 출시 전 수정 권장, **P2** = v1.1.

### 16.0 공통 원칙

| 원칙 | 내용 |
|------|------|
| 실패 기본값 | 수익화·진행에 영향 시 **보수적**: unlock·클리어·결제 **지급하지 않음** |
| 사용자 피드백 | 모든 차단/실패에 **짧은 인라인 또는 토스트** + 가능하면 **재시도** |
| 로깅 | P0·P1 이벤트는 비PII 로컬/크래시 로그(선택: Sentry); `deviceId`는 로그에 해시 가능 |
| 중복 방지 | Submit·IAP·광고 Watch 버튼은 **in-flight lock** |
| 백그라운드 | 광고·결제·저장 중 앱 일시정지 시 **§16.3·16.5** |

---

### 16.1 퍼즐·입력·제출 (Puzzle / Submit)

| ID | 트리거 | 기대 동작 | 사용자 메시지 (en) | 심각도 |
|----|--------|-----------|-------------------|--------|
| E1-01 | 빈 입력 Submit | 버튼 disabled | — | P0 |
| E1-02 | min/max 밖 숫자 | Submit 차단 | Enter a number between {min} and {max}. | P0 |
| E1-03 | 소수·문자·공백만 | 제출 차단 또는 strip 후 빈값이면 E1-01 | Invalid input. | P0 |
| E1-04 | `001` vs `1` | 정규화 후 동일 정답 처리 | — | P0 |
| E1-05 | 음수 허용 문제 | 스키마 `min`이 음수일 때만 허용 | (E1-02) | P0 |
| E1-06 | 정답 열람(광고) 후 동일 값 Submit | 정상 클리어; Perfect는 §3.1.6 (별 없음) | — | P0 |
| E1-07 | 정답 열람만 하고 Submit 안 함 | 미완료·미해금 | — | P0 |
| E1-08 | 완료 레벨 재입장 후 재Submit | ✓ 유지; Perfect 이미 잃었으면 복구 안 함 | — | P1 |
| E1-09 | 레벨 JSON 필드 누락·타입 오류 | 해당 레벨 **스킵 불가**; 에러 화면 + 목록 복귀 | This puzzle couldn't load. | P0 |
| E1-10 | `choices` 없는데 choice 모드 | E1-09 동일 | This puzzle couldn't load. | P0 |
| E1-11 | 미해금 레벨 딥링크/직접 라우트 | 진입 차단 → Level Select | Complete the previous level first. | P0 |
| E1-12 | 존재하지 않는 levelId | Level Select로 fallback | Level not found. | P0 |
| E1-13 | 제출 직후 앱 kill | **저장 성공 후에만** 클리어 반영; 미저장 시 이전 상태 | (재실행 시 이전 진행) | P0 |
| E1-14 | Level 100 정답 | All Complete; Next 비활성 또는 “Back to levels” | You completed all levels! | P0 |

---

### 16.2 진행·로컬 저장 (Progress / Persistence)

| ID | 트리거 | 기대 동작 | 사용자 메시지 (en) | 심각도 |
|----|--------|-----------|-------------------|--------|
| E2-01 | 첫 실행 | Level 1 해금; 빈 진행 | — | P0 |
| E2-02 | 저장소 읽기 실패·JSON 손상 | **안전 기본값**으로 시작(Level 1); 손상 파일 백업 후 재생성 | Your progress couldn't be loaded. Starting fresh. | P0 |
| E2-03 | 저장 쓰기 실패(디스크 full 등) | 클리어 UI는 표시하되 **재시도 큐** 1회; 실패 시 토스트 | Couldn't save progress. Try again. | P0 |
| E2-04 | 앱 업데이트(스키마 v1→v2) | 마이그레이션 함수; 실패 시 E2-02 | (E2-02) | P1 |
| E2-05 | Reset Progress 중 취소 | 변경 없음 | — | P0 |
| E2-06 | Reset 완료 | §3.7; 즉시 Level Select | Progress reset. | P0 |
| E2-07 | OS 백업 복원(기기 교체) | v1 **미보장**; 문서·FAQ에 명시 | — | P2 |
| E2-08 | unlock 플래그만 있고 completed 없음 | 불일치 시 **completed 없으면 미완료**; hint/answer unlock은 유지 | — | P1 |
| E2-09 | 동시에 두 레벨 탭(레이스) | 마지막 유효 화면만 유지 | — | P1 |

---

### 16.3 광고 (Rewarded Ads)

| ID | 트리거 | 기대 동작 | 사용자 메시지 (en) | 심각도 |
|----|--------|-----------|-------------------|--------|
| E3-01 | 오프라인·로드 타임아웃(권장 10s) | unlock 없음; [Retry] [Cancel] | Ad isn't available. Check your connection. | P0 |
| E3-02 | 사용자 조기 닫기 | unlock 없음 | Ad closed before finish. | P0 |
| E3-03 | `onRewarded` 전 앱 kill | unlock 없음 (재시청 가능) | — | P0 |
| E3-04 | `onRewarded` 후 kill | **unlock 저장 후** 재실행 시 힌트/정답 표시 | — | P0 |
| E3-05 | SDK 중복 `onRewarded` | idempotent; 1회만 저장 | — | P0 |
| E3-06 | 이미 unlock된 힌트/정답 | 광고 없이 표시 | — | P0 |
| E3-07 | 광고 재생 중 전화·홈 | SDK 콜백 기준; 미보상 시 E3-02 | (E3-02) | P0 |
| E3-08 | CMP/동의 미완료 | 광고 요청 전 동의 UI; 거부 시 E3-01 동급 | Ads are disabled until you update privacy choices. | P0 |
| E3-09 | No fill (재고 없음) | E3-01 + Retry | No ads right now. Try again later. | P0 |
| E3-10 | 힌트·정답 연속 요청 | 각각 별도 세션; 첫 요청 처리 중 두 번째 버튼 disabled | — | P1 |
| E3-11 | 튜토리얼에서 Hint/Answer | 버튼 hidden/disabled | — | P0 |
| E3-12 | 배너 로드 실패 | 빈 영역 또는 placeholder; 게임 차단 없음 | — | P2 |

---

### 16.4 문의하기 (Contact)

**v1 N/A** — Contact 화면 없음 (O3). 아래 E4-01–E4-08은 v1.1+ 재도입 시 적용.

| ID | 트리거 | 기대 동작 | 사용자 메시지 (en) | 심각도 |
|----|--------|-----------|-------------------|--------|
| E4-09 | Privacy/Terms URL 실패 (설정 링크) | 외부 브라우저 fallback | Couldn't open link. | P1 |

---

### 16.5 후원·IAP (Donate)

| ID | 트리거 | 기대 동작 | 사용자 메시지 (en) | 심각도 |
|----|--------|-----------|-------------------|--------|
| E5-01 | 사용자 취소 | 조용히 닫기 또는 “Purchase cancelled.” | Purchase cancelled. | P0 |
| E5-02 | 결제 실패·스토어 오류 | 게임 상태 변경 없음 | Purchase failed. Try again. | P0 |
| E5-03 | 결제 pending | “Processing…”; 완료 시 감사 토스트 | Payment is processing. | P1 |
| E5-04 | 완료 후 게임 혜택 | **없음** (§3.5) | Thanks for your support! | P0 |
| E5-05 | 결제 중 앱 kill | 스토어 영수증 기준; 앱은 **중복 지급 없음** | — | P1 |
| E5-06 | 스토어 미연결(아동 기기 등) | Donate 비활성 | Purchases aren't available on this device. | P1 |
| E5-07 | 외부 링크 열기 실패 | URL 복사 | Couldn't open browser. Link copied. | P1 |

---

### 16.6 오디오 (BGM / SFX)

| ID | 트리거 | 기대 동작 | 사용자 메시지 (en) | 심각도 |
|----|--------|-----------|-------------------|--------|
| E6-01 | BGM 파일 로드 실패 | BGM 없이 진행; 설정 토글은 유지 | — | P1 |
| E6-02 | iOS 무음 스위치 | **SFX는 respect**; BGM은 플랫폼 기본(무음 시 BGM off 권장) | — | P1 |
| E6-03 | 백그라운드 | BGM 일시정지; 포그라운드 복귀 시 재개(설정 ON일 때) | — | P0 |
| E6-04 | 블루투스·이어폰 분리 | 재생 중단 없이 라우팅 복구 시도 | — | P2 |
| E6-05 | Master Mute ON 중 정답 SFX | 무음 (진동도 v1 없음) | — | P0 |

---

### 16.7 앱 생명주기·네비게이션·시스템

| ID | 트리거 | 기대 동작 | 사용자 메시지 (en) | 심각도 |
|----|--------|-----------|-------------------|--------|
| E7-01 | 콜드 스타트 로딩 >3s | 스플래시 + 로딩 인디케이터 | — | P1 |
| E7-02 | 메모리 경고(low memory) | 비필수 캐시 해제; 진행 저장 flush | — | P1 |
| E7-03 | 뒤로가기(Android) 문제 화면 | “Leave level?” 확인 또는 진행 저장 후 목록 | — | P1 |
| E7-04 | 뒤로가기 설정 | 상위(목록)로 | — | P0 |
| E7-05 | 회전·폴드 | 세로 고정 또는 레이아웃 유지; **입력값·스크롤 위치 유지** | — | P1 |
| E7-06 | 시스템 글자 크기 200% | 레이아웃 깨짐 없이 스크롤 가능 | — | P1 |
| E7-07 | VoiceOver | 버튼·입력 라벨; 정오답 **텍스트** 안내 | — | P1 |
| E7-08 | Reduce Motion | 과도한 전환·흔들림 애니 생략 | — | P2 |

---

### 16.8 QA 체크리스트 (P0 요약)

구현·QA 시 아래 **전부** 통과:

- [ ] E1-01~07, 11~14  
- [ ] E2-01~03, 05~06  
- [ ] E3-01~06, 08~09, 11  
- [ ] E4-01, 04~08  
- [ ] E5-01~02, 04  
- [ ] E6-03, 05  
- [ ] E7-04  

---

### 16.9 §15·기존 섹션과의 관계

| 기존 | §16 보완 |
|------|----------|
| §3.3.1 실패 1줄 | E3-01~09 상세 분기 |
| §3.1.4 판정 | E1 입력·중복 Submit |
| §3.4 문의 | v1 N/A (O3) |
| §6 저장 1줄 | E2 손상·쓰기 실패 |
| §8 QA 1줄 | §16.8 체크리스트 |

---

*다음 단계: §12 미확정 확정 → §16 P0 QA → 와이어프레임 → 100문제 콘텐츠 → 구현 (`start-feature`).*
