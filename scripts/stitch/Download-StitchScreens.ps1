# Download PNG/HTML from stitch screen get JSON
param(
  [string] $GetJson = ""
)

$Root = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
if (-not $GetJson) {
  $GetJson = Join-Path $Root "docs\design\mock-b-stitch\output\all-screens-get.json"
}
$outDir = Join-Path $Root "docs\design\mock-b-stitch\output\screens"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

$raw = Get-Content $GetJson -Raw | ConvertFrom-Json
$items = if ($raw.data.items) { $raw.data.items } elseif ($raw.items) { $raw.items } else { @($raw.data) }

foreach ($item in $items) {
  $sid = $item.screenId
  if (-not $sid) { $sid = $item.id }
  $title = ($item.title -replace '[^\w\-]', '-').ToLower()
  $url = $item.imageUrl
  if (-not $url -and $item.data.screenshot.downloadUrl) {
    $url = $item.data.screenshot.downloadUrl
  }
  if ($url) {
    $png = Join-Path $outDir "$sid-$title.png"
    Write-Host "Download $png"
    Invoke-WebRequest -Uri $url -OutFile $png -UseBasicParsing
  }
  if ($item.htmlUrl) {
    $html = Join-Path $outDir "$sid-$title.html"
    Invoke-WebRequest -Uri $item.htmlUrl -OutFile $html -UseBasicParsing
  }
}
Write-Host "Done -> $outDir"
