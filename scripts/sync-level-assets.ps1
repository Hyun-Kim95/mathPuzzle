# Sync content/levels/*.json to app/assets/levels/
$ErrorActionPreference = "Stop"
$root = Split-Path $PSScriptRoot -Parent
$src = Join-Path $root "content\levels"
$dst = Join-Path $root "app\assets\levels"
New-Item -ItemType Directory -Force -Path $dst | Out-Null
Copy-Item (Join-Path $src "level-*.json") $dst -Force
Copy-Item (Join-Path $src "levels.manifest.json") $dst -Force
$count = (Get-ChildItem $dst -Filter "level-*.json").Count
Write-Host "Synced $count level files + manifest to app/assets/levels/"
