[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [string]$Path = '.',

    [string]$BaseRef = '',

    [switch]$Json
)

$ErrorActionPreference = 'Stop'

function Invoke-Git {
    param([Parameter(ValueFromRemainingArguments = $true)][string[]]$Arguments)

    $output = & git -C $script:RepoRoot @Arguments 2>$null
    [pscustomobject]@{ Output = @($output); Code = $LASTEXITCODE }
}

function Redact-RemoteUrl {
    param([string]$Url)
    if ([string]::IsNullOrWhiteSpace($Url)) { return $Url }
    return $Url -replace '(?<=https://)[^/@\s]+@', '<redacted>@'
}

$resolved = Resolve-Path -LiteralPath $Path
$rootProbe = & git -C $resolved.Path rev-parse --show-toplevel 2>$null
if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($rootProbe)) {
    throw "Not a Git repository: $($resolved.Path)"
}
$script:RepoRoot = $rootProbe.Trim()

$branchResult = Invoke-Git symbolic-ref --quiet --short HEAD
$branch = if ($branchResult.Code -eq 0) { $branchResult.Output -join '' } else { '(detached)' }
$headResult = Invoke-Git rev-parse --verify HEAD
$head = if ($headResult.Code -eq 0) { $headResult.Output -join '' } else { '(unborn)' }
$status = (Invoke-Git status --short).Output
$upstreamResult = Invoke-Git rev-parse --abbrev-ref '@{upstream}'
$upstream = if ($upstreamResult.Code -eq 0) { $upstreamResult.Output -join '' } else { '' }

$remoteRows = @()
$remoteNames = (Invoke-Git remote).Output
foreach ($name in $remoteNames) {
    $fetch = (Invoke-Git remote get-url $name).Output -join ''
    $pushResult = Invoke-Git remote get-url --push $name
    $push = if ($pushResult.Code -eq 0) { $pushResult.Output -join '' } else { '' }
    $remoteRows += [pscustomobject]@{
        name = $name
        fetch = Redact-RemoteUrl $fetch
        push = Redact-RemoteUrl $push
    }
}

$authorityPaths = @(
    'AGENTS.md',
    'CONTEXT.md',
    'docs/README.md',
    'docs/HANDOFF.md',
    'docs/PRODUCT.md',
    'docs/ARCHITECTURE.md',
    'docs/ROADMAP.md'
)
$authority = [ordered]@{}
foreach ($relative in $authorityPaths) {
    $authority[$relative] = Test-Path -LiteralPath (Join-Path $script:RepoRoot $relative)
}

$base = $null
if (-not [string]::IsNullOrWhiteSpace($BaseRef)) {
    $baseResult = Invoke-Git rev-parse --verify $BaseRef
    if ($baseResult.Code -eq 0) {
        & git -C $script:RepoRoot merge-base --is-ancestor $BaseRef HEAD 2>$null
        $base = [pscustomobject]@{
            reference = $BaseRef
            resolved = $true
            sha = $baseResult.Output -join ''
            isAncestor = ($LASTEXITCODE -eq 0)
        }
    } else {
        $base = [pscustomobject]@{
            reference = $BaseRef
            resolved = $false
            sha = ''
            isAncestor = $false
        }
    }
}

$warnings = @()
if ($status.Count -gt 0) { $warnings += "Working tree is dirty ($($status.Count) entries). Preserve unrelated changes." }
if ([string]::IsNullOrWhiteSpace($upstream)) { $warnings += 'Current branch has no upstream.' }
if ($base -and -not $base.resolved) { $warnings += "Base reference does not resolve: $BaseRef" }
if ($base -and $base.resolved -and -not $base.isAncestor) { $warnings += "Base reference is not an ancestor of HEAD: $BaseRef" }

$report = [pscustomobject]@{
    repositoryRoot = $script:RepoRoot
    branch = $branch
    head = $head
    upstream = $upstream
    dirtyEntries = $status.Count
    status = @($status)
    remotes = @($remoteRows)
    worktrees = @((Invoke-Git worktree list --porcelain).Output)
    authorityFiles = [pscustomobject]$authority
    base = $base
    warnings = @($warnings)
}

if ($Json) {
    $report | ConvertTo-Json -Depth 6
    exit 0
}

Write-Host "Repository : $($report.repositoryRoot)"
Write-Host "Branch     : $($report.branch)"
Write-Host "HEAD       : $($report.head)"
Write-Host "Upstream   : $(if ($report.upstream) { $report.upstream } else { '(none)' })"
Write-Host "Dirty      : $($report.dirtyEntries)"
if ($base) { Write-Host "Base       : $($base.reference) (resolved=$($base.resolved), ancestor=$($base.isAncestor))" }
if ($warnings.Count -gt 0) {
    Write-Host 'Warnings:'
    $warnings | ForEach-Object { Write-Host "- $_" }
}
