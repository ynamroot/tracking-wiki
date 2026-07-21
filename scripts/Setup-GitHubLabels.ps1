param(
    [string]$Repository = ""
)

$ErrorActionPreference = "Stop"

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    throw "GitHub CLI (gh) is not installed."
}

& gh auth status 2>$null
if ($LASTEXITCODE -ne 0) {
    throw "GitHub CLI authentication is required. Run 'gh auth login' first."
}

if ([string]::IsNullOrWhiteSpace($Repository)) {
    & git remote get-url origin 2>$null | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "No origin remote found. Pass -Repository OWNER/REPOSITORY."
    }
}

$labels = @(
    @{ Name = "source:new"; Color = "D4C5F9"; Description = "New source waiting for intake" },
    @{ Name = "source:needs-verification"; Color = "FBCA04"; Description = "Original source or supporting evidence required" },
    @{ Name = "source:accepted"; Color = "0E8A16"; Description = "Source accepted by the PO" },
    @{ Name = "source:deferred"; Color = "BFD4F2"; Description = "Source deferred as out of current scope" },
    @{ Name = "source:rejected"; Color = "B60205"; Description = "Source rejected as duplicate, low quality, or irrelevant" },
    @{ Name = "ingest:pending"; Color = "1D76DB"; Description = "Accepted source waiting for wiki ingest" },
    @{ Name = "ingest:complete"; Color = "006B75"; Description = "Source integrated into the wiki" },
    @{ Name = "question:open"; Color = "D93F0B"; Description = "Question requires an answer or further research" },
    @{ Name = "question:answered"; Color = "5319E7"; Description = "Question answered with evidence in the wiki" },
    @{ Name = "decision:required"; Color = "E99695"; Description = "PO decision required" }
)

foreach ($label in $labels) {
    $arguments = @(
        "label", "create", $label.Name,
        "--color", $label.Color,
        "--description", $label.Description,
        "--force"
    )

    if (-not [string]::IsNullOrWhiteSpace($Repository)) {
        $arguments += @("--repo", $Repository)
    }

    & gh @arguments
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to create label: $($label.Name)"
    }
}

Write-Host "Applied $($labels.Count) GitHub labels."
