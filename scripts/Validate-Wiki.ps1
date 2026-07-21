$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$errors = New-Object System.Collections.Generic.List[string]
$warnings = New-Object System.Collections.Generic.List[string]

function Add-ValidationError {
    param([string]$Message)
    $errors.Add($Message)
}

function Get-RelativePath {
    param([string]$Path)
    return $Path.Substring($root.Length + 1).Replace("\", "/")
}

function Test-FrontmatterField {
    param(
        [string]$Content,
        [string]$Field
    )
    $pattern = '(?m)^{0}:\s*.*$' -f [regex]::Escape($Field)
    return $Content -match $pattern
}

$requiredPaths = @(
    "PROJECT_CONTEXT.md",
    "AGENTS.md",
    "SCHEMA.md",
    "OPERATIONS.md",
    "AGENT_PLAYBOOKS.md",
    "raw/inbox",
    "raw/sources",
    "raw/rejected",
    "raw/assets",
    "wiki/index.md",
    "wiki/log.md",
    "wiki/overview.md",
    "wiki/open-questions.md",
    "wiki/sources",
    "wiki/market",
    "wiki/customers",
    "wiki/competitors",
    "wiki/technologies",
    "wiki/synthesis",
    "wiki/audits",
    "product/drafts",
    "product/approved",
    "product/decisions",
    "technical/drafts",
    "technical/approved",
    "technical/adr",
    "technical/change-requests",
    ".github/ISSUE_TEMPLATE/source-submission.yml"
)

foreach ($relativePath in $requiredPaths) {
    if (-not (Test-Path -LiteralPath (Join-Path $root $relativePath))) {
        Add-ValidationError "Missing required path: $relativePath"
    }
}

$sourceFields = @(
    "id", "title", "status", "source_type", "original_url", "submitted_by",
    "submitted_at", "retrieved_at", "issue_url", "language", "publisher",
    "authors", "published_at", "reliability", "content_file", "content_sha256",
    "supersedes"
)

$acceptedSourceIds = New-Object System.Collections.Generic.HashSet[string]
$sourceSets = @(
    @{ Path = "raw/inbox"; Statuses = @("inbox", "needs-verification", "deferred") },
    @{ Path = "raw/sources"; Statuses = @("accepted", "superseded") },
    @{ Path = "raw/rejected"; Statuses = @("rejected") }
)

$acceptedSources = @()
foreach ($sourceSet in $sourceSets) {
    $sourceDirectory = Join-Path $root $sourceSet.Path
    $sourceFiles = @(Get-ChildItem -LiteralPath $sourceDirectory -Filter "*.md" -File -ErrorAction SilentlyContinue)

    foreach ($source in $sourceFiles) {
    $content = Get-Content -LiteralPath $source.FullName -Raw -Encoding UTF8
    $relativePath = Get-RelativePath $source.FullName

    if ($source.BaseName -notmatch '^SRC-\d{8}-[a-z0-9]+(?:-[a-z0-9]+)*$') {
        Add-ValidationError "Invalid accepted source filename: $relativePath"
    }

    foreach ($field in $sourceFields) {
        if (-not (Test-FrontmatterField -Content $content -Field $field)) {
            Add-ValidationError "$relativePath is missing source frontmatter field: $field"
        }
    }

        $statusMatch = [regex]::Match($content, '(?m)^status:\s*([a-z-]+)\s*$')
        if (-not $statusMatch.Success -or $sourceSet.Statuses -notcontains $statusMatch.Groups[1].Value) {
            Add-ValidationError "$relativePath has a status that is invalid for $($sourceSet.Path)"
        }

        if ($sourceSet.Path -eq "raw/sources") {
            $acceptedSources += $source
            [void]$acceptedSourceIds.Add($source.BaseName)
        }
    }
}

$wikiFields = @("title", "type", "status", "confidence", "created", "updated", "sources")
$wikiSections = @("Current Synthesis", "Evidence", "Contradictions", "Open Questions", "See Also")
$excludedWikiFiles = @("AGENTS.md", "index.md", "log.md", "open-questions.md")
$knowledgePages = Get-ChildItem -LiteralPath (Join-Path $root "wiki") -Filter "*.md" -File -Recurse |
    Where-Object {
        $excludedWikiFiles -notcontains $_.Name -and
        $_.Directory.Name -ne "audits"
    }

$indexContent = ""
$indexPath = Join-Path $root "wiki/index.md"
if (Test-Path -LiteralPath $indexPath) {
    $indexContent = Get-Content -LiteralPath $indexPath -Raw -Encoding UTF8
}

foreach ($page in $knowledgePages) {
    $content = Get-Content -LiteralPath $page.FullName -Raw -Encoding UTF8
    $relativePath = Get-RelativePath $page.FullName

    foreach ($field in $wikiFields) {
        if (-not (Test-FrontmatterField -Content $content -Field $field)) {
            Add-ValidationError "$relativePath is missing wiki frontmatter field: $field"
        }
    }

    foreach ($section in $wikiSections) {
        $sectionPattern = '(?m)^## {0}\s*$' -f [regex]::Escape($section)
        if ($content -notmatch $sectionPattern) {
            Add-ValidationError "$relativePath is missing required section: $section"
        }
    }

    $indexToken = '[[' + $page.BaseName
    if ($indexContent.IndexOf($indexToken, [System.StringComparison]::OrdinalIgnoreCase) -lt 0) {
        Add-ValidationError "$relativePath is not registered in wiki/index.md"
    }

    $sourceReferences = [regex]::Matches($content, 'SRC-\d{8}-[a-z0-9]+(?:-[a-z0-9]+)*') |
        ForEach-Object { $_.Value } |
        Sort-Object -Unique

    foreach ($sourceId in $sourceReferences) {
        if (-not $acceptedSourceIds.Contains($sourceId)) {
            Add-ValidationError "$relativePath references a missing accepted source: $sourceId"
        }
    }

    if ($page.BaseName -ne "overview" -and @($sourceReferences).Count -eq 0) {
        Add-ValidationError "$relativePath does not reference an accepted source"
    }
}

$wikiMarkdownFiles = @(Get-ChildItem -LiteralPath (Join-Path $root "wiki") -Filter "*.md" -File -Recurse)
$wikiTargets = New-Object System.Collections.Generic.HashSet[string] ([System.StringComparer]::OrdinalIgnoreCase)
foreach ($wikiFile in $wikiMarkdownFiles) {
    [void]$wikiTargets.Add($wikiFile.BaseName)
}

foreach ($wikiFile in $wikiMarkdownFiles) {
    $content = Get-Content -LiteralPath $wikiFile.FullName -Raw -Encoding UTF8
    $relativePath = Get-RelativePath $wikiFile.FullName
    $wikiLinks = [regex]::Matches($content, '\[\[([^\]|#]+)(?:#[^\]|]+)?(?:\|[^\]]+)?\]\]')

    foreach ($wikiLink in $wikiLinks) {
        $target = $wikiLink.Groups[1].Value.Trim().Replace("\", "/")
        $targetName = [System.IO.Path]::GetFileNameWithoutExtension($target)
        if (-not $wikiTargets.Contains($targetName)) {
            Add-ValidationError "$relativePath contains a broken wikilink: $($wikiLink.Value)"
        }
    }
}

if (Test-Path -LiteralPath (Join-Path $root "wiki/log.md")) {
    $logContent = Get-Content -LiteralPath (Join-Path $root "wiki/log.md") -Raw -Encoding UTF8
    $invalidLogHeadings = [regex]::Matches($logContent, '(?m)^## (.+)$') |
        ForEach-Object { $_.Groups[1].Value } |
        Where-Object { $_ -notmatch '^\d{4}-\d{2}-\d{2}$' -and $_ -notmatch '^\[\d{4}-\d{2}-\d{2}\] (ingest|query|audit|update|decision|freeze) \| .+$' }

    foreach ($heading in $invalidLogHeadings) {
        Add-ValidationError "Invalid wiki/log.md entry format: ## $heading"
    }
}

if ($acceptedSources.Count -eq 0) {
    $warnings.Add("No accepted sources exist yet. Populate raw/sources after the first triage.")
}

foreach ($warning in $warnings) {
    Write-Warning $warning
}

if ($errors.Count -gt 0) {
    Write-Host "Wiki validation failed: $($errors.Count) error(s)" -ForegroundColor Red
    foreach ($validationError in $errors) {
        Write-Host "- $validationError" -ForegroundColor Red
    }
    exit 1
}

Write-Host "Wiki validation passed: $($knowledgePages.Count) knowledge page(s), $($acceptedSources.Count) accepted source(s)." -ForegroundColor Green
