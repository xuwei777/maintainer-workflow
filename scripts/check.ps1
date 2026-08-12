[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$repo = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$skill = Join-Path $repo 'skills/maintainer-workflow'
$failures = [System.Collections.Generic.List[string]]::new()

function Assert-True {
    param([bool]$Condition, [string]$Message)
    if (-not $Condition) { $script:failures.Add($Message) }
}

$required = @(
    'README.md',
    'README.zh-CN.md',
    'LICENSE',
    'AGENTS.md',
    'CONTRIBUTING.md',
    'SECURITY.md',
    'skills/maintainer-workflow/SKILL.md',
    'skills/maintainer-workflow/agents/openai.yaml',
    'skills/maintainer-workflow/assets/AGENTS.template.md',
    'skills/maintainer-workflow/assets/work-package.template.md',
    'skills/maintainer-workflow/references/project-profiles.md',
    'skills/maintainer-workflow/scripts/preflight.ps1'
)
foreach ($relative in $required) {
    Assert-True (Test-Path -LiteralPath (Join-Path $repo $relative)) "Missing required file: $relative"
}

$skillText = Get-Content -Raw -LiteralPath (Join-Path $skill 'SKILL.md')
Assert-True ($skillText -match '(?s)^---\r?\nname:\s*maintainer-workflow\r?\ndescription:\s*\S.+?\r?\n---') 'SKILL.md frontmatter must contain only a valid name and description.'
Assert-True (($skillText -split "`r?`n").Count -le 500) 'SKILL.md must remain at or below 500 lines.'

$parserErrors = $null
[System.Management.Automation.Language.Parser]::ParseFile(
    (Join-Path $skill 'scripts/preflight.ps1'),
    [ref]$null,
    [ref]$parserErrors
) | Out-Null
Assert-True ($parserErrors.Count -eq 0) "preflight.ps1 parser errors: $($parserErrors -join '; ')"

$markdownFiles = Get-ChildItem -LiteralPath $repo -Recurse -File -Filter '*.md'
foreach ($file in $markdownFiles) {
    $text = Get-Content -Raw -LiteralPath $file.FullName
    foreach ($match in [regex]::Matches($text, '!?(?:\[[^\]]*\])\(([^)]+)\)')) {
        $target = $match.Groups[1].Value.Trim()
        if ($target -match '^(https?://|mailto:|#)') { continue }
        $target = $target.Split('#')[0]
        if ([string]::IsNullOrWhiteSpace($target)) { continue }
        $local = Join-Path $file.DirectoryName ([uri]::UnescapeDataString($target))
        Assert-True (Test-Path -LiteralPath $local) "Broken local link in $($file.FullName): $target"
    }
}

$publicText = ($markdownFiles | ForEach-Object { Get-Content -Raw -LiteralPath $_.FullName }) -join "`n"
$forbidden = @(
    '10\.0\.\d{1,3}\.\d{1,3}',
    'BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY',
    '(?i)(api[_-]?key|token|password)\s*[:=]\s*[A-Za-z0-9_\-]{12,}'
)
foreach ($pattern in $forbidden) {
    Assert-True (-not [regex]::IsMatch($publicText, $pattern)) "Public-content privacy pattern matched: $pattern"
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Host "PASS: required files, Skill metadata, PowerShell syntax, local links, and privacy patterns"
