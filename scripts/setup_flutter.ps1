param(
  [string]$FlutterDir,
  [switch]$Run
)

Write-Host "=== Kicks-Connect | Setup Flutter ==="

function Add-ToPath($dir) {
  if (-not (Test-Path $dir)) { return }
  if ($env:Path -notlike "*${dir}*") { $env:Path = "$dir;" + $env:Path }
  try { setx PATH ("$dir;" + $env:Path) | Out-Null } catch {}
}

# Find flutter
$flutterBat = $null
$cmd = Get-Command flutter -ErrorAction SilentlyContinue
if ($cmd) { $flutterBat = $cmd.Source }
if (-not $flutterBat -and $FlutterDir) {
  $candidate = Join-Path $FlutterDir 'bin/flutter.bat'
  if (Test-Path $candidate) { $flutterBat = $candidate }
}
if (-not $flutterBat) {
  $candidates = @(
    'C:\src\flutter\bin\flutter.bat',
    "$env:USERPROFILE\flutter\bin\flutter.bat",
    "$env:USERPROFILE\Downloads\flutter\bin\flutter.bat",
    "$env:ProgramFiles\flutter\bin\flutter.bat",
    "$env:ProgramFiles(x86)\flutter\bin\flutter.bat"
  )
  foreach ($p in $candidates) { if (Test-Path $p) { $flutterBat = $p; break } }
}

if (-not $flutterBat) {
  Write-Error "Flutter not found. Re-run with -FlutterDir 'C:\path\to\flutter' or install to C:\src\flutter."
  exit 1
}

$binDir = Split-Path $flutterBat
Add-ToPath $binDir
Write-Host "Using Flutter: $flutterBat"

# Verify install
flutter --version
flutter doctor

# Enable web
flutter config --enable-web

# Move to repo root and prepare app
$root = Resolve-Path (Join-Path $PSScriptRoot '..')
Push-Location $root
try {
  flutter create .
  flutter pub get
} finally {
  Pop-Location
}

if ($Run) {
  Push-Location $root
  try { flutter run -d chrome } finally { Pop-Location }
}

Write-Host "=== Done | Setup Flutter ==="
