# Generate one screen; loads API key from ~/.cursor/mcp.json
param(
  [Parameter(Mandatory)] [string] $PromptFile,
  [string] $OutJson,
  [string] $ProjectId = ""
)

$Root = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$mcpPath = Join-Path $env:USERPROFILE ".cursor\mcp.json"
if (Test-Path $mcpPath) {
  $mc = Get-Content $mcpPath -Raw | ConvertFrom-Json
  $env:STITCH_API_KEY = $mc.mcpServers.stitch.env.STITCH_API_KEY
}

if (-not $ProjectId) {
  $projPath = Join-Path $Root "docs\design\mock-b-stitch\project.json"
  $ProjectId = (Get-Content $projPath -Raw | ConvertFrom-Json).projectId
}

$ds = Get-Content (Join-Path $Root "docs\design\mock-b-stitch\prompts\_design-system.txt") -Raw
$body = Get-Content (Join-Path $Root "docs\design\mock-b-stitch\prompts\$PromptFile") -Raw
$prompt = ($body.Trim() + "`n" + $ds).Trim()

if (-not $OutJson) {
  $OutJson = Join-Path $Root "docs\design\mock-b-stitch\output\$PromptFile.json"
}

Write-Host "Generating $PromptFile -> $OutJson"
npx -y stitch-design-cli screen generate `
  --project-id $ProjectId `
  --device-type MOBILE `
  --prompt $prompt `
  --include-image `
  --json 2>&1 | Out-File -FilePath $OutJson -Encoding utf8

Get-Content $OutJson -Raw | ConvertFrom-Json | Select-Object -ExpandProperty items | Select-Object screenId, title
