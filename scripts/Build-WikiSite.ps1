param(
    [string]$OutputPath = ".site-output",
    [switch]$Serve,
    [int]$Port = 8080
)

$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$versionPath = Join-Path $root "site/quartz-version.txt"
$configPath = Join-Path $root "site/quartz.config.yaml"
$quartzTsPath = Join-Path $root "site/quartz.ts"
$wikiPath = Join-Path $root "wiki"
$version = (Get-Content -LiteralPath $versionPath -Raw -Encoding UTF8).Trim()
$engineRoot = Join-Path $root ".cache/quartz/$version"
$engineConfigPath = Join-Path $engineRoot "quartz.config.yaml"
$engineQuartzTsPath = Join-Path $engineRoot "quartz.ts"
$pluginMarkerPath = Join-Path $engineRoot ".tracking-wiki-plugin-config"

function Invoke-ExternalCommand {
    param(
        [string]$Command,
        [string[]]$Arguments
    )

    & $Command @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "$Command failed with exit code $LASTEXITCODE"
    }
}

if (-not (Test-Path -LiteralPath (Join-Path $engineRoot ".git"))) {
    New-Item -ItemType Directory -Force -Path $engineRoot | Out-Null
    Invoke-ExternalCommand -Command "git" -Arguments @("-C", $engineRoot, "init")
    Invoke-ExternalCommand -Command "git" -Arguments @("-C", $engineRoot, "remote", "add", "origin", "https://github.com/jackyzha0/quartz.git")
    Invoke-ExternalCommand -Command "git" -Arguments @("-C", $engineRoot, "fetch", "--depth", "1", "origin", $version)
    Invoke-ExternalCommand -Command "git" -Arguments @("-C", $engineRoot, "checkout", "--detach", "FETCH_HEAD")
}

$actualVersion = (& git -C $engineRoot rev-parse HEAD).Trim()
if ($LASTEXITCODE -ne 0 -or $actualVersion -ne $version) {
    throw "Quartz cache version mismatch. Expected $version, found $actualVersion"
}

Copy-Item -LiteralPath $configPath -Destination $engineConfigPath -Force
if (Test-Path -LiteralPath $quartzTsPath) {
    Copy-Item -LiteralPath $quartzTsPath -Destination $engineQuartzTsPath -Force
}

if (-not (Test-Path -LiteralPath (Join-Path $engineRoot "node_modules"))) {
    Invoke-ExternalCommand -Command "npm" -Arguments @("ci", "--prefix", $engineRoot)
}

$configHash = (Get-FileHash -LiteralPath $configPath -Algorithm SHA256).Hash
$marker = "$version`n$configHash"
$installedMarker = if (Test-Path -LiteralPath $pluginMarkerPath) {
    (Get-Content -LiteralPath $pluginMarkerPath -Raw -Encoding UTF8).Trim()
} else {
    ""
}

if ($installedMarker -ne $marker.Trim()) {
    Push-Location $engineRoot
    try {
        Invoke-ExternalCommand -Command "npx" -Arguments @("quartz", "plugin", "install", "--from-config")
    } finally {
        Pop-Location
    }
    Set-Content -LiteralPath $pluginMarkerPath -Value $marker -Encoding UTF8
}

$resolvedOutputPath = if ([System.IO.Path]::IsPathRooted($OutputPath)) {
    $OutputPath
} else {
    Join-Path $root $OutputPath
}

$arguments = @(
    "quartz", "build",
    "--directory", $wikiPath,
    "--output", $resolvedOutputPath
)
if ($Serve) {
    $arguments += @("--serve", "--port", $Port.ToString())
}

Push-Location $engineRoot
try {
    Invoke-ExternalCommand -Command "npx" -Arguments $arguments
} finally {
    Pop-Location
}

if (-not $Serve) {
    if (-not (Test-Path -LiteralPath (Join-Path $resolvedOutputPath "index.html"))) {
        throw "Quartz did not produce index.html"
    }

    $excludedOutputs = @(
        "AGENTS.html",
        "README.html",
        "audits"
    )
    foreach ($excludedOutput in $excludedOutputs) {
        if (Test-Path -LiteralPath (Join-Path $resolvedOutputPath $excludedOutput)) {
            throw "Private operational page was published: $excludedOutput"
        }
    }

    Write-Host "Wiki site build passed: $resolvedOutputPath" -ForegroundColor Green
}
