# Stitch Option B — 실행 패키지 (CLI)

> **MCP 사용 안 함** (오류 시). **SSOT:** [stitch-cli-sop.md](../stitch-cli-sop.md)

## 1분 요약

```powershell
npm install -g stitch-design-cli
$env:STITCH_API_KEY = "..."
stitch doctor --json

stitch project create --title "mathPuzzle" --json
# → projectId를 docs/design/mock-b-stitch/project.json 에 저장

.\scripts\stitch\Invoke-StitchBScreens.ps1
```

## 산출물

| 경로 | 내용 |
|------|------|
| [prompts/](prompts/) | 화면별 프롬프트 + `_design-system.txt` |
| [output/](output/) | CLI JSON 응답 (`02-*.json` …) |
| [output/screens/](output/screens/) | 수동 저장 스크린샷/HTML (get 후) |
| [project.json](project.json) | projectId + screenId 레지스트리 (gitignore 권장 아님) |

## MCP 문서 (참고만)

- [stitch-sop.md](../stitch-sop.md) — MCP 복구 시
- [stitch-screen-prompts.md](stitch-screen-prompts.md) — MCP용 동일 프롬프트 텍스트

## 상태 (2026-05-17)

- [x] CLI 6화면 + `output/screens/`  
- [x] HUMAN: **Option B 선택** — [design-ab-comparison.md](../design-ab-comparison.md)  
- [ ] 선택: `stitch screen edit` (Mathemagix → **mathPuzzle**)  
- [x] 다크모드: v1 Flutter에서 구현 (토큰 dark 열; Stitch dark pass는 선택)  
