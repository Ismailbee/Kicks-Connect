param(
  [string]$ProjectId,
  [switch]$Android,
  [switch]$IOS,
  [switch]$Web
)

Write-Host "=== Kicks-Connect | Connect Firebase ==="

function Ensure-InPath($dir) {
  if (-not (Test-Path $dir)) { return }
  if ($env:Path -notlike "*${dir}*") { $env:Path = "$dir;" + $env:Path }
}

# Ensure flutter and dart exist
$flutter = Get-Command flutter -ErrorAction SilentlyContinue
if (-not $flutter) { Write-Error 'Flutter not available in PATH; run scripts/setup_flutter.ps1 first.'; exit 1 }

# Activate FlutterFire CLI
dart pub global activate flutterfire_cli
$pubBin = "$env:LOCALAPPDATA\Pub\Cache\bin"
Ensure-InPath $pubBin

# Build args
$args = @()
if ($ProjectId) { $args += @('--project', $ProjectId) }
$plat = @()
if ($Web) { $plat += 'web' }
if ($Android) { $plat += 'android' }
if ($IOS) { $plat += 'ios' }
if ($plat.Count -gt 0) { $args += @('--platforms', ($plat -join ',')) }

Push-Location (Resolve-Path (Join-Path $PSScriptRoot '..'))
try {
  if ($args.Count -gt 0) {
    flutterfire configure @args
  } else {
    flutterfire configure
  }

  if (-not (Test-Path 'lib/firebase_options.dart')) {
    Write-Error 'firebase_options.dart not found after configuration. Check CLI output.'
    exit 1
  }

  # Patch main.dart to use DefaultFirebaseOptions
  $mainPath = 'lib/main.dart'
  $content = Get-Content $mainPath -Raw
  if ($content -notmatch 'firebase_options.dart') {
    $content = "import 'firebase_options.dart';`n" + $content
  }
  $content = $content -replace 'Firebase.initializeApp\(\);', "Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);"
  $content | Set-Content $mainPath -Encoding UTF8

  Write-Host 'Firebase wired. Running pub get...'
  flutter pub get
} finally {
  Pop-Location
}

Write-Host "=== Done | Connect Firebase ==="
