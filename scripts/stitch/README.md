# Stitch CLI scripts

MCP 없이 **Option B** 화면을 생성할 때 사용.

## Quick start

```powershell
npm install -g stitch-design-cli   # optional; npx works

cd d:\cursor\game\mathPuzzle

# API key from Cursor mcp.json (stitch server env)
$mc = Get-Content "$env:USERPROFILE\.cursor\mcp.json" -Raw | ConvertFrom-Json
$env:STITCH_API_KEY = $mc.mcpServers.stitch.env.STITCH_API_KEY
npx -y stitch-design-cli doctor --json

# Already done for this repo — see docs/design/mock-b-stitch/project.json
# Re-generate one screen:
.\scripts\stitch\Invoke-StitchGenerateOne.ps1 -PromptFile "02-puzzle-play.txt"

# Download PNGs after screen get:
.\scripts\stitch\Download-StitchScreens.ps1
```

Full SOP: [docs/design/stitch-cli-sop.md](../../docs/design/stitch-cli-sop.md)
