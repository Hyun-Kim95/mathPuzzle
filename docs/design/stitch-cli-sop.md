---
type: doc
project: mathPuzzle
doc_lane: design
updated_at: 2026-05-17T14:00:00
tags: [docs, design, stitch, cli]
---

# Stitch CLI 운영 SOP (mathPuzzle)

**상황:** Cursor Stitch MCP 오류 → **CLI만 사용** (`stitch-design-cli`, 공식 `@google/stitch-sdk` 래퍼).

**MCP SOP (참고):** [stitch-sop.md](stitch-sop.md) — MCP 복구 시 병행 가능.

---

## 0. 설치·인증

```powershell
npm install -g stitch-design-cli   # 또는 npx -y stitch-design-cli

# API 키: Cursor MCP 설정에서 로드 (권장)
$mc = Get-Content "$env:USERPROFILE\.cursor\mcp.json" -Raw | ConvertFrom-Json
$env:STITCH_API_KEY = $mc.mcpServers.stitch.env.STITCH_API_KEY

npx -y stitch-design-cli doctor --json
# auth.present + api.projects.list OK 이면 충분 (tools.list 실패는 무시 가능)
```

스크립트 `Invoke-StitchBScreens.ps1` / `Invoke-StitchGenerateOne.ps1`은 **mcp.json 키를 자동 로드**한다.

OAuth 사용 시: `stitch auth set --access-token ... --project-id $env:GOOGLE_CLOUD_PROJECT`

**비밀:** `.env` / `STITCH_API_KEY`는 **git에 커밋하지 않음** — [.env.example](../../.env.example) 참고.

---

## 1. 프로젝트 생성

```powershell
cd d:\cursor\game\mathPuzzle

stitch project create --title "mathPuzzle" --json `
  | Tee-Object -FilePath docs\design\mock-b-stitch\output\01-project-create.json

# projectId를 아래 파일에 저장 (스크립트가 읽음)
# docs\design\mock-b-stitch\project.json
```

`project.json` 예:

```json
{
  "projectId": "PASTE_FROM_CREATE_OUTPUT",
  "title": "mathPuzzle"
}
```

---

## 2. 디자인 시스템

`stitch-design-cli` v1은 **design-system 전용 CLI 없음**. 대신:

- 모든 `screen generate` 프롬프트에 **동일 DESIGN SYSTEM 블록** 포함 → [mock-b-stitch/prompts/_design-system.txt](mock-b-stitch/prompts/_design-system.txt)
- 토큰 참고: [stitch-design-system.json](mock-b-stitch/stitch-design-system.json)

---

## 3. 화면 생성 (일괄)

```powershell
.\scripts\stitch\Invoke-StitchBScreens.ps1
```

또는 화면별 수동:

```powershell
$pid = (Get-Content docs\design\mock-b-stitch\project.json | ConvertFrom-Json).projectId
$prompt = Get-Content docs\design\mock-b-stitch\prompts\01-level-select.txt -Raw

stitch screen generate --project-id $pid --device-type MOBILE `
  --prompt $prompt --include-image --json `
  | Tee-Object docs\design\mock-b-stitch\output\02-level-select.json
```

**주의:** 생성은 수 분 걸릴 수 있음. 실패 시 JSON의 `error.code` 확인 (`RATE_LIMITED`, `AUTH_FAILED` 등).

---

## 4. 산출물 다운로드

응답 JSON의 `followUp.getCommand` 또는:

```powershell
stitch screen get --project-id $pid --screen-id SCREEN_ID `
  --include-html --include-image --json `
  | Tee-Object docs\design\mock-b-stitch\output\get-SCREEN_ID.json
```

`imageUrl` / `htmlUrl`을 브라우저로 열어 `docs/design/mock-b-stitch/output/screens/`에 저장.

---

## 5. 문서 반영

| 항목 | 파일 |
|------|------|
| projectId, screen IDs | [design-option-b-stitch.md](design-option-b-stitch.md) 표 |
| 스크린샷 경로 | `mock-b-stitch/output/screens/` |
| A/B 선택 | [design-ab-comparison.md](design-ab-comparison.md) |

---

## 6. 화면 목록 (Option B)

| # | 파일 | PRD |
|---|------|-----|
| 01 | `prompts/01-level-select.txt` | S04 |
| 02 | `prompts/02-puzzle-play.txt` | S05 |
| 03 | `prompts/03-level-complete.txt` | S06 |
| 04 | `prompts/04-settings.txt` | S08 |
| 05 | `prompts/05-ad-modal.txt` | overlay |
| 06 | `prompts/06-splash.txt` | S01 |

---

## 트러블슈팅

| 증상 | 조치 |
|------|------|
| `AUTH_MISSING` | `stitch auth set` 또는 `STITCH_API_KEY` |
| `AUTH_FAILED` | 키 재발급 또는 OAuth 전환 |
| `RATE_LIMITED` | 대기 후 재시도; 화면 간 30–60s |
| MCP만 실패, CLI OK | 본 SOP 유지 (정상) |

## Vault

- [[mathPuzzle/docs/mathPuzzle-docs-hub|Hub]]
