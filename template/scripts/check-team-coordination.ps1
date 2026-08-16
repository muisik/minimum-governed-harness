param(
    [string]$Root = "",
    [switch]$Strict
)

$ErrorActionPreference = "Stop"
if ([string]::IsNullOrWhiteSpace($Root)) {
    $Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
} else {
    $Root = (Resolve-Path $Root).Path
}

$BoardPath = Join-Path $Root "project-memory\BOARD.md"
if (-not (Test-Path -LiteralPath $BoardPath -PathType Leaf)) {
    Write-Host "ERROR Missing required file: project-memory/BOARD.md" -ForegroundColor Red
    exit 1
}

$script:ErrorCount = 0
$script:WarningCount = 0

function Report-Error {
    param([string]$Message)
    $script:ErrorCount++
    Write-Host "ERROR $Message" -ForegroundColor Red
}

function Report-Warning {
    param([string]$Message)
    $script:WarningCount++
    Write-Host "WARN  $Message" -ForegroundColor Yellow
}

function Normalize-ScopePath {
    param([string]$Value)
    $Path = $Value.Trim().Replace('\','/')
    while ($Path.StartsWith('./')) { $Path = $Path.Substring(2) }
    $Path = $Path.TrimEnd('/')
    if ([string]::IsNullOrWhiteSpace($Path)) { return '.' }
    return $Path
}

function Test-ScopePath {
    param([string]$Value)
    if ($Value -eq '.') { return $true }
    if ($Value.StartsWith('/')) { return $false }
    if ($Value -match '(^|/)\.\.($|/)') { return $false }
    if ($Value -match '[*?\[]') { return $false }
    return $true
}

function Test-GitHubOwner {
    param([string]$Value)
    if (-not $Value.StartsWith('@')) { return $true }
    $Login = $Value.Substring(1)
    if ($Login.Length -lt 1 -or $Login.Length -gt 39) { return $false }
    if ($Login -notmatch '^[A-Za-z0-9][A-Za-z0-9-]*$') { return $false }
    if ($Login.Contains('--') -or $Login.EndsWith('-')) { return $false }
    return $true
}

$Tasks = @()
$Current = $null
foreach ($Line in Get-Content -LiteralPath $BoardPath -Encoding UTF8) {
    if ($Line -match '^## (TASK-[0-9]{4})(?:[ ]+[—-])?[ ]*(.*)$') {
        if ($null -ne $Current) { $Tasks += $Current }
        $Current = [PSCustomObject]@{
            Id = $Matches[1]
            Status = ''
            Owner = ''
            Branch = ''
            Scope = ''
        }
        continue
    }
    if ($null -eq $Current) { continue }
    if ($Line -match '^- Status:[ ]*(.*)$') { $Current.Status = $Matches[1].Trim(); continue }
    if ($Line -match '^- Owner:[ ]*(.*)$') { $Current.Owner = $Matches[1].Trim(); continue }
    if ($Line -match '^- Branch:[ ]*(.*)$') { $Current.Branch = $Matches[1].Trim(); continue }
    if ($Line -match '^- Scope:[ ]*(.*)$') { $Current.Scope = $Matches[1].Trim(); continue }
}
if ($null -ne $Current) { $Tasks += $Current }

$ScopeRows = @()
$BranchRows = @()
foreach ($Task in $Tasks) {
    if ($Task.Owner.StartsWith('@') -and -not (Test-GitHubOwner $Task.Owner)) {
        Report-Error "$($Task.Id) has invalid GitHub-style Owner: $($Task.Owner)"
    }
    if (-not [string]::IsNullOrWhiteSpace($Task.Branch) -and $Task.Branch -match '\s') {
        Report-Error "$($Task.Id) Branch must not contain whitespace: $($Task.Branch)"
    }

    if (-not [string]::IsNullOrWhiteSpace($Task.Scope)) {
        foreach ($RawScope in $Task.Scope.Split(',')) {
            $Item = $RawScope.Trim()
            if ([string]::IsNullOrWhiteSpace($Item)) {
                Report-Error "$($Task.Id) Scope contains an empty path entry"
                continue
            }
            $Normalized = Normalize-ScopePath $Item
            if (-not (Test-ScopePath $Normalized)) {
                Report-Error "$($Task.Id) has invalid Scope path: $Item"
                continue
            }
            if ($Task.Status -eq 'active') {
                $ScopeRows += [PSCustomObject]@{
                    Task = $Task.Id
                    Owner = $Task.Owner
                    Branch = $Task.Branch
                    Scope = $Normalized
                }
            }
        }
    }

    if ($Task.Status -eq 'active' -and -not [string]::IsNullOrWhiteSpace($Task.Branch)) {
        $BranchRows += [PSCustomObject]@{
            Task = $Task.Id
            Owner = $Task.Owner
            Branch = $Task.Branch
        }
    }
}

function Test-ScopeOverlap {
    param([string]$A, [string]$B)
    if ($A -eq '.' -or $B -eq '.') { return $true }
    if ($A -eq $B) { return $true }
    if ($A.StartsWith($B + '/')) { return $true }
    if ($B.StartsWith($A + '/')) { return $true }
    return $false
}

$SeenPairs = @{}
for ($i = 0; $i -lt $ScopeRows.Count; $i++) {
    for ($j = $i + 1; $j -lt $ScopeRows.Count; $j++) {
        $Left = $ScopeRows[$i]
        $Right = $ScopeRows[$j]
        if ($Left.Task -eq $Right.Task) { continue }
        if (-not (Test-ScopeOverlap $Left.Scope $Right.Scope)) { continue }
        $Pair = @($Left.Task, $Right.Task) | Sort-Object
        $Key = $Pair -join '|'
        if ($SeenPairs.ContainsKey($Key)) { continue }
        $SeenPairs[$Key] = $true
        Report-Warning "$($Left.Task) scope '$($Left.Scope)' overlaps active $($Right.Task) scope '$($Right.Scope)'"
    }
}

$SeenBranches = @{}
foreach ($Row in $BranchRows) {
    if ($SeenBranches.ContainsKey($Row.Branch)) {
        $Previous = $SeenBranches[$Row.Branch]
        if ($Previous -ne $Row.Task) {
            Report-Warning "$Previous and $($Row.Task) declare the same active Branch: $($Row.Branch)"
        }
    } else {
        $SeenBranches[$Row.Branch] = $Row.Task
    }
}

$CurrentBranch = ''
if (-not [string]::IsNullOrWhiteSpace($env:GITHUB_HEAD_REF)) {
    $CurrentBranch = $env:GITHUB_HEAD_REF
} elseif (-not [string]::IsNullOrWhiteSpace($env:GITHUB_REF_NAME)) {
    $CurrentBranch = $env:GITHUB_REF_NAME
}
$Actor = $env:GITHUB_ACTOR
if (-not [string]::IsNullOrWhiteSpace($CurrentBranch) -and -not [string]::IsNullOrWhiteSpace($Actor)) {
    foreach ($Row in $BranchRows) {
        if ($Row.Branch -ne $CurrentBranch) { continue }
        if (-not $Row.Owner.StartsWith('@')) { continue }
        $OwnerLogin = $Row.Owner.Substring(1)
        if ($OwnerLogin -ine $Actor) {
            Report-Warning "$($Row.Task) declares Owner $($Row.Owner) on branch $CurrentBranch but GitHub actor is @$Actor"
        }
    }
}

Write-Host ""
Write-Host "Coordination summary: $($script:ErrorCount) error(s), $($script:WarningCount) warning(s)"
if ($script:ErrorCount -gt 0) { exit 1 }
if ($Strict -and $script:WarningCount -gt 0) { exit 2 }
Write-Host "PASS  Team coordination metadata is consistent" -ForegroundColor Green
exit 0
