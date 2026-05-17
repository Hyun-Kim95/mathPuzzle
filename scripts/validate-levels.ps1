# Validates level-*.json against manifest and basic rules
$ErrorActionPreference = "Stop"
$root = Split-Path $PSScriptRoot -Parent
$levelsDir = Join-Path $root "content\levels"
$manifestPath = Join-Path $levelsDir "levels.manifest.json"
if (-not (Test-Path $manifestPath)) { Write-Error "Missing levels.manifest.json"; exit 1 }
$manifest = Get-Content $manifestPath -Raw | ConvertFrom-Json
$expectedIds = @($manifest.ids | ForEach-Object { [int]$_ })
$files = Get-ChildItem $levelsDir -Filter "level-*.json"
if ($files.Count -ne $expectedIds.Count) {
  Write-Error "File count $($files.Count) != manifest $($expectedIds.Count)"
}
$ids = @()
foreach ($id in $expectedIds) {
  $path = Join-Path $levelsDir ("level-{0:D3}.json" -f $id)
  if (-not (Test-Path $path)) { Write-Error "Missing $path" }
  $j = Get-Content $path -Raw | ConvertFrom-Json
  if ($j.id -ne $id) { Write-Error "$path id mismatch $($j.id) vs $id" }
  if ($ids -contains $j.id) { Write-Error "Duplicate id $($j.id)" }
  $ids += $j.id
  if ($j.input.mode -eq "numeric") {
    if ($j.answer -lt $j.input.min -or $j.answer -gt $j.input.max) {
      Write-Error "$path answer out of range"
    }
  }
  foreach ($req in @("id","title","type","prompt","input","answer","hint","explanation","difficulty")) {
    if (-not ($j.PSObject.Properties.Name -contains $req)) { Write-Error "$path missing $req" }
  }
}
Write-Host "OK: $($expectedIds.Count) levels validated"
exit 0
