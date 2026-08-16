param(
    [string]$Root = ""
)

$ErrorActionPreference = "Stop"
if ([string]::IsNullOrWhiteSpace($Root)) {
    $Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
} else {
    $Root = (Resolve-Path $Root).Path
}

$BoardPath = Join-Path $Root "project-memory\BOARD.md"
if (-not (Test-Path -LiteralPath $BoardPath -PathType Leaf)) {
    Write-Error "Missing required file: project-memory/BOARD.md"
    exit 1
}

$Warnings = New-Object System.Collections.Generic.List[string]
function Report-Warning {
    param([string]$Message)
    $Warnings.Add($Message)
    Write-Host "WARN  $Message" -ForegroundColor Yellow
}

function Parse-ActiveTasks {
    param([string]$Path)
    $Records = @()
    $Current = $null

    function Flush-Current {
        if ($null -ne $script:CurrentCoordinationRecord -and $script:CurrentCoordinationRecord.Status -eq 'active') {
            $script:CoordinationRecords += $script:CurrentCoordinationRecord
        }
    }

    $script:CoordinationRecords = @()
    $script:CurrentCoordinationRecord = $null

    foreach ($Line in Get-Content -LiteralPath $Path -Encoding UTF8) {
        if ($Line -match '^## (TASK-[0-9]{4})(?:[ ]+[—-])?[ ]*(.*)$') {
            Flush-Current
            $script:CurrentCoordinationRecord = [PSCustomObject]@{
                Id = $Matches[1]
                Status = ""
                Owner = ""
                Branch = ""
                Scope = ""
            }
            continue
        }
        if ($null -eq $script:CurrentCoordinationRecord) { continue }
        if ($Line -match '^- Status:[ ]*(.*)$') { $script:CurrentCoordinationRecord.Status = $Matches[1].Trim().ToLowerInvariant(); continue }
        if ($Line -match '^- Owner:[ ]*(.*)$') { $script:CurrentCoordinationRecord.Owner = $Matches[1].Trim(); continue }
        if ($Line -match '^- Branch:[ ]*(.*)$') { $script:CurrentCoordinationRecord.Branch = $Matches[1].Trim(); continue }
        if ($Line -match '^- Scope:[ ]*(.*)$') { $script:CurrentCoordinationRecord.Scope = $Matches[1].Trim(); continue }
    }
    Flush-Current
    return @($script:CoordinationRecords)
}

function Normalize-Scope {
    param([string]$Value)
    if ([string]::IsNullOrWhiteSpace($Value)) { return "" }
    $Value = $Value.Trim()
    if ($Value.StartsWith('./')) { $Value = $Value.Substring(2) }
    return $Value.TrimEnd('/')
}

function Test-ScopeOverlap {
    param([string]$Left, [string]$Right)
    if ($Left -eq $Right) { return $true }
    if ($Left.StartsWith($Right + '/', [System.StringComparison]::Ordinal)) { return $true }
    if ($Right.StartsWith($Left + '/', [System.StringComparison]::Ordinal)) { return $true }
    return $false
}

$Active = @(Parse-ActiveTasks $BoardPath)

foreach ($Task in $Active) {
    if ($Task.Owner -eq 'unassigned') {
        Report-Warning "$($Task.Id) is active but Owner is unassigned"
    }
    if (-not [string]::IsNullOrWhiteSpace($Task.Branch) -and [string]::IsNullOrWhiteSpace($Task.Scope)) {
        Report-Warning "$($Task.Id) declares Branch '$($Task.Branch)' but no Scope; parallel-work overlap cannot be assessed"
    }
}

for ($i = 0; $i -lt $Active.Count; $i++) {
    if ([string]::IsNullOrWhiteSpace($Active[$i].Scope)) { continue }
    for ($j = $i + 1; $j -lt $Active.Count; $j++) {
        if ([string]::IsNullOrWhiteSpace($Active[$j].Scope)) { continue }
        $Found = $false
        foreach ($LeftRaw in $Active[$i].Scope.Split(',')) {
            $Left = Normalize-Scope $LeftRaw
            if (-not $Left) { continue }
            foreach ($RightRaw in $Active[$j].Scope.Split(',')) {
                $Right = Normalize-Scope $RightRaw
                if (-not $Right) { continue }
                if (Test-ScopeOverlap $Left $Right) {
                    $Message = "$($Active[$i].Id) scope '$Left' overlaps active $($Active[$j].Id) scope '$Right'"
                    if ($Active[$i].Owner -or $Active[$j].Owner) {
                        $Message += " ($($Active[$i].Owner) / $($Active[$j].Owner))"
                    }
                    if ($Active[$i].Branch -or $Active[$j].Branch) {
                        $Message += " [$($Active[$i].Branch) / $($Active[$j].Branch)]"
                    }
                    Report-Warning $Message
                    $Found = $true
                    break
                }
            }
            if ($Found) { break }
        }
    }
}

$CurrentBranch = $env:GITHUB_HEAD_REF
if ([string]::IsNullOrWhiteSpace($CurrentBranch)) { $CurrentBranch = $env:GITHUB_REF_NAME }
if ([string]::IsNullOrWhiteSpace($CurrentBranch) -and (Get-Command git -ErrorAction SilentlyContinue)) {
    try { $CurrentBranch = (& git -C $Root branch --show-current 2>$null).Trim() } catch { $CurrentBranch = "" }
}
$Actor = $env:GITHUB_ACTOR

if (-not [string]::IsNullOrWhiteSpace($CurrentBranch) -and -not [string]::IsNullOrWhiteSpace($Actor)) {
    foreach ($Task in $Active) {
        if ($Task.Branch -ne $CurrentBranch) { continue }
        if ($Task.Owner -notmatch '^@([A-Za-z0-9][A-Za-z0-9-]*)$') { continue }
        $Expected = $Matches[1]
        if (-not $Expected.Equals($Actor, [System.StringComparison]::OrdinalIgnoreCase)) {
            Report-Warning "$($Task.Id) branch '$($Task.Branch)' is owned by $($Task.Owner) but GitHub actor is @$Actor"
        }
    }
}

Write-Host ""
Write-Host "Coordination summary: $($Warnings.Count) advisory finding(s)"
Write-Host "PASS  Shared-work coordination check completed"
exit 0
