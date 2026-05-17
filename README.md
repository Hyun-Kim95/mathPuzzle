# mathPuzzle

**mathPuzzle**는 숫자·논리 퍼즐을 단계별로 풀어 가는 모바일 퍼즐 게임입니다. Math Riddles류의 경험을 목표로 하며, 계정 없이 플레이하고 진행은 기기에 저장됩니다.

## 주요 기능

- 100개 레벨 (5챕터 × 20)
- 순차 해금, 정답 제출로 클리어
- 힌트·정답: 리워드 광고로 해제 (AdMob, 테스트 단위 포함)
- 후원형 인앱 결제 (팁, 게임플레이 변경 없음)
- 온보딩·레벨 1 가이드 튜토리얼
- 라이트 / 다크 테마

UI 언어는 **영어**입니다.

## 기술 스택

- **Flutter** (`app/`)
- 퍼즐 데이터: `content/levels/` (JSON)

## 로컬 실행

```powershell
cd app
flutter pub get
flutter run
```

## 문서

상세 요구사항·설계·QA는 [docs/](docs/) 폴더를 참고하세요. 문서 목록: [docs/mathPuzzle-docs-hub.md](docs/mathPuzzle-docs-hub.md)
