$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$errors = New-Object System.Collections.Generic.List[string]
$warnings = New-Object System.Collections.Generic.List[string]
$sourceHeading = ([string][char]0xCD9C) + ([string][char]0xCC98)
$sourceEmoji = [char]::ConvertFromUtf32(0x1F517)

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
    "site/quartz.config.yaml",
    "site/quartz-version.txt",
    "scripts/Build-WikiSite.ps1",
    "raw/inbox",
    "raw/sources",
    "raw/rejected",
    "raw/assets",
    "wiki/index.md",
    "wiki/README.md",
    "wiki/log.md",
    "wiki/overview.md",
    "wiki/open-questions.md",
    "wiki/sources",
    "wiki/knowledge/problem",
    "wiki/knowledge/landscape",
    "wiki/knowledge/technology",
    "wiki/knowledge/synthesis",
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

$legacyWikiPaths = @(
    "wiki/market",
    "wiki/customers",
    "wiki/competitors",
    "wiki/technologies",
    "wiki/synthesis"
)

foreach ($relativePath in $legacyWikiPaths) {
    if (Test-Path -LiteralPath (Join-Path $root $relativePath)) {
        Add-ValidationError "Legacy Wiki path still exists: $relativePath"
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
$excludedWikiFiles = @("AGENTS.md", "README.md", "index.md", "log.md", "open-questions.md")
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

    $typeMatch = [regex]::Match($content, '(?m)^type:\s*([a-z-]+)\s*$')
    if ($typeMatch.Success) {
        $pageType = $typeMatch.Groups[1].Value
        $normalizedPath = $relativePath.Replace("\", "/")
        $allowedTypes = switch -Wildcard ($normalizedPath) {
            "wiki/sources/*" { @("source-summary"); break }
            "wiki/knowledge/problem/*" { @("customer"); break }
            "wiki/knowledge/landscape/*" { @("market", "competitor", "comparison"); break }
            "wiki/knowledge/technology/*" { @("technology", "concept"); break }
            "wiki/knowledge/synthesis/*" { @("synthesis"); break }
            "wiki/overview.md" { @("overview"); break }
            default { @() }
        }

        if ($allowedTypes.Count -eq 0 -or $allowedTypes -notcontains $pageType) {
            Add-ValidationError "$relativePath has type '$pageType' that is invalid for its Wiki path"
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

    $frontmatterContent = [regex]::Match($content, '(?s)\A---\s*(?<frontmatter>.*?)\s*---').Groups['frontmatter'].Value
    $declaredSourceIds = @([regex]::Matches($frontmatterContent, '(?m)^\s*-\s*(SRC-\d{8}-[a-z0-9]+(?:-[a-z0-9]+)*)\s*$') |
        ForEach-Object { $_.Groups[1].Value } |
        Sort-Object -Unique)
    $bodyContent = [regex]::Replace($content, '(?s)\A---\s*.*?\s*---\s*', '')
    $sourcesHeadingPattern = '(?m)^## {0}\r?$' -f [regex]::Escape($sourceHeading)
    $sourcesHeadingMatch = [regex]::Match($bodyContent, $sourcesHeadingPattern)
    $bodyBeforeSources = if ($sourcesHeadingMatch.Success) {
        $bodyContent.Substring(0, $sourcesHeadingMatch.Index)
    } else {
        $bodyContent
    }
    if ($bodyBeforeSources -match 'SRC-\d{8}-[a-z0-9]+(?:-[a-z0-9]+)*') {
        Add-ValidationError "$relativePath contains a visible Source ID in its body; use an emoji source anchor"
    }

    $footerEntries = [regex]::Matches($bodyContent, '(?m)^- <a id="(?<anchor>source-\d+)"></a>\[\[(?<summary>[^\]|]+)\|[^\]]+\]\] - `(?<id>SRC-\d{8}-[a-z0-9]+(?:-[a-z0-9]+)*)`\s*$')
    $sourceAnchors = @($footerEntries |
        ForEach-Object { $_.Groups['anchor'].Value } |
        Sort-Object -Unique)
    $footerSourceIds = @($footerEntries |
        ForEach-Object { $_.Groups['id'].Value } |
        Sort-Object -Unique)
    $citationPattern = '<sup>\[{0}\]\(#(?<anchor>source-\d+)\)</sup>' -f [regex]::Escape($sourceEmoji)
    $citationAnchors = @([regex]::Matches($bodyContent, $citationPattern) |
        ForEach-Object { $_.Groups['anchor'].Value } |
        Sort-Object -Unique)

    $allSourceAnchors = [regex]::Matches($bodyContent, '<a id="source-\d+"></a>')
    if ($allSourceAnchors.Count -ne $footerEntries.Count) {
        Add-ValidationError "$relativePath contains a malformed Source footer entry"
    }

    $allCitationPattern = '<sup>\[{0}\]\([^)]*\)</sup>' -f [regex]::Escape($sourceEmoji)
    $validCitationPattern = '<sup>\[{0}\]\(#source-\d+\)</sup>' -f [regex]::Escape($sourceEmoji)
    $allCitationLinks = [regex]::Matches($bodyContent, $allCitationPattern)
    $validCitationLinks = [regex]::Matches($bodyContent, $validCitationPattern)
    if ($allCitationLinks.Count -ne $validCitationLinks.Count) {
        Add-ValidationError "$relativePath contains a malformed emoji Source citation"
    }

    foreach ($citationAnchor in $citationAnchors) {
        if ($sourceAnchors -notcontains $citationAnchor) {
            Add-ValidationError "$relativePath contains a Source citation without a matching footer anchor: $citationAnchor"
        }
    }

    foreach ($sourceAnchor in $sourceAnchors) {
        if ($citationAnchors -notcontains $sourceAnchor) {
            Add-ValidationError "$relativePath contains an unused Source footer anchor: $sourceAnchor"
        }
    }

    foreach ($declaredSourceId in $declaredSourceIds) {
        if ($footerSourceIds -notcontains $declaredSourceId) {
            Add-ValidationError "$relativePath declares a Source without a footer entry: $declaredSourceId"
        }
    }

    foreach ($footerSourceId in $footerSourceIds) {
        if ($declaredSourceIds -notcontains $footerSourceId) {
            Add-ValidationError "$relativePath contains an undeclared Source footer entry: $footerSourceId"
        }
    }

    if (@($citationAnchors).Count -gt 0 -and -not $sourcesHeadingMatch.Success) {
        Add-ValidationError "$relativePath contains Source citations but is missing its Source footer section"
    }
}

$wikiMarkdownFiles = @(Get-ChildItem -LiteralPath (Join-Path $root "wiki") -Filter "*.md" -File -Recurse)
$wikiTargets = New-Object System.Collections.Generic.HashSet[string] ([System.StringComparer]::OrdinalIgnoreCase)
$wikiBasenames = @{}
foreach ($wikiFile in $wikiMarkdownFiles) {
    [void]$wikiTargets.Add($wikiFile.BaseName)
    $basenameKey = $wikiFile.BaseName.ToLowerInvariant()
    if (-not $wikiBasenames.ContainsKey($basenameKey)) {
        $wikiBasenames[$basenameKey] = @()
    }
    $wikiBasenames[$basenameKey] += Get-RelativePath $wikiFile.FullName
}

foreach ($basenameKey in $wikiBasenames.Keys) {
    if ($wikiBasenames[$basenameKey].Count -gt 1) {
        Add-ValidationError "Duplicate Wiki basename '$basenameKey': $($wikiBasenames[$basenameKey] -join ', ')"
    }
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

    $markdownLinks = [regex]::Matches($content, '(?<!!)\[[^\]]+\]\(([^)]+)\)')
    foreach ($markdownLink in $markdownLinks) {
        $target = $markdownLink.Groups[1].Value.Trim()
        if ($target -match '^(https?://|mailto:|#)') {
            continue
        }

        $pathOnly = $target.Split('#')[0].Split('?')[0]
        $decodedPath = [System.Uri]::UnescapeDataString($pathOnly).Replace("/", [System.IO.Path]::DirectorySeparatorChar)
        $resolvedPath = Join-Path $wikiFile.Directory.FullName $decodedPath
        if (-not (Test-Path -LiteralPath $resolvedPath)) {
            Add-ValidationError "$relativePath contains a broken Markdown link: $($markdownLink.Value)"
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
