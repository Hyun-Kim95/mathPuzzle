#Requires -Version 5.1
<#
.SYNOPSIS
  Generate Option B Stitch screens via stitch-design-cli (no MCP).

.PREREQUISITE
  npm install -g stitch-design-cli
  stitch doctor --json
  docs/design/mock-b-stitch/project.json with valid projectId
    (create: stitch project create --title "Math Pattern Puzzle" --json)

.EXAMPLE
  $env:STITCH_API_KEY = "..."
  .\scripts\stitch\Invoke-StitchBScreens.ps1
  .\scripts\stitch\Invoke-StitchBScreens.ps1 -Screen 01-level-select
#>
param(
  [string] $ProjectJson = "",
  [string] $Screen = "",
  [int] $DelaySeconds = 45
)

$ErrorActionPreference = "Stop"
$Root = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

# Load STITCH_API_KEY from Cursor mcp.json if not set
if (-not $env:STITCH_API_KEY) {
  $mcpPath = Join-Path $env:USERPROFILE ".cursor\mcp.json"
  if (Test-Path $mcpPath) {
    $mc = Get-Content $mcpPath -Raw | ConvertFrom-Json
    $env:STITCH_API_KEY = $mc.mcpServers.stitch.env.STITCH_API_KEY
    Write-Host "Loaded STITCH_API_KEY from $mcpPath" -ForegroundColor DarkGray
  }
}
if (-not $ProjectJson) {
  $ProjectJson = Join-Path $Root "docs\design\mock-b-stitch\project.json"
}

$PromptsDir = Join-Path $Root "docs\design\mock-b-stitch\prompts"
$OutDir = Join-Path $Root "docs\design\mock-b-stitch\output"
$DsBlock = Get-Content (Join-Path $PromptsDir "_design-system.txt") -Raw

if (-not (Test-Path $ProjectJson)) {
  Write-Error "Missing $ProjectJson — copy project.json.example and set projectId after 'stitch project create'."
}

$proj = Get-Content $ProjectJson -Raw | ConvertFrom-Json
$projectId = $proj.projectId
if (-not $projectId -or $projectId -match "REPLACE") {
  Write-Error "Set projectId in $ProjectJson"
}

$stitchCmd = "stitch"
if (-not (Get-Command stitch -ErrorAction SilentlyContinue)) {
  $stitchCmd = "npx"
  $stitchArgs = @("-y", "stitch-design-cli")
} else {
  $stitchArgs = @()
}

function Invoke-StitchCli {
  param([string[]]$CliArgs)
  $all = if ($stitchCmd -eq "npx") { $stitchArgs + $CliArgs } else { $CliArgs }
  & $stitchCmd @all 2>&1
}

New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

$screens = @(
  @{ Key = "levelSelect"; File = "01-level-select.txt"; Out = "02-level-select.json" },
  @{ Key = "puzzlePlay"; File = "02-puzzle-play.txt"; Out = "03-puzzle-play.json" },
  @{ Key = "levelComplete"; File = "03-level-complete.txt"; Out = "04-level-complete.json" },
  @{ Key = "settings"; File = "04-settings.txt"; Out = "05-settings.json" },
  @{ Key = "adModal"; File = "05-ad-modal.txt"; Out = "06-ad-modal.json" },
  @{ Key = "splash"; File = "06-splash.txt"; Out = "07-splash.json" }
)

if ($Screen) {
  $screens = $screens | Where-Object { $_.File -like "*$Screen*" -or $_.Key -like "*$Screen*" }
  if (-not $screens) { Write-Error "Unknown screen filter: $Screen" }
}

Write-Host "Project: $projectId" -ForegroundColor Cyan
Write-Host "Output:  $OutDir" -ForegroundColor Cyan

foreach ($s in $screens) {
  $body = (Get-Content (Join-Path $PromptsDir $s.File) -Raw).Trim()
  $prompt = ($body + "`n" + $DsBlock).Trim()
  $outFile = Join-Path $OutDir $s.Out

  Write-Host "`n=== $($s.File) ===" -ForegroundColor Yellow
  $json = Invoke-StitchCli -CliArgs @(
    "screen", "generate",
    "--project-id", $projectId,
    "--device-type", "MOBILE",
    "--prompt", $prompt,
    "--include-image",
    "--json"
  )

  $json | Out-File -FilePath $outFile -Encoding utf8
  Write-Host "Saved $outFile"

  try {
    $parsed = $json | ConvertFrom-Json
    if ($parsed.ok -and $parsed.data.items[0].screenId) {
      $sid = $parsed.data.items[0].screenId
      $proj.screens.$($s.Key) = $sid
      Write-Host "screenId: $sid" -ForegroundColor Green
    } elseif (-not $parsed.ok) {
      Write-Warning "$($parsed.error.code): $($parsed.error.message)"
    }
  } catch {
    Write-Warning "Could not parse JSON; check $outFile"
  }

  if ($s -ne $screens[-1]) {
    Write-Host "Waiting ${DelaySeconds}s..." -ForegroundColor DarkGray
    Start-Sleep -Seconds $DelaySeconds
  }
}

$proj | ConvertTo-Json -Depth 5 | Set-Content $ProjectJson -Encoding utf8
Write-Host "`nUpdated $ProjectJson with screen IDs." -ForegroundColor Green
Write-Host "Download assets: stitch screen get --project-id $projectId --screen-id <id> --include-html --include-image --json"
