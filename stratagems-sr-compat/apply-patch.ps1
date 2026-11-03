# Usage: powershell -ExecutionPolicy Bypass -File apply-patch.ps1 "C:\path\to\game\stratagems"
param([Parameter(Mandatory=$true)][string]$StratagemsDir)

$tp2 = Join-Path $StratagemsDir "setup-stratagems.tp2"
if (-not (Test-Path $tp2)) { Write-Error "setup-stratagems.tp2 not found in $StratagemsDir"; exit 1 }

Copy-Item $tp2 "$tp2.bak" -Force
$lines = Get-Content $tp2 -Encoding Default
$out = New-Object System.Collections.Generic.List[string]
$inComp = $false; $removed = 0
foreach ($l in $lines) {
    if ($l -match '^BEGIN\s+@\d+') { $inComp = ($l -match '^BEGIN\s+@3401\s+DESIGNATED\s+4130') }
    if ($inComp -and $l -match '^FORBID_COMPONENT\s+"spell_rev/setup-spell_rev\.tp2"') { $removed++; continue }
    $out.Add($l)
}
Set-Content $tp2 $out -Encoding Default
Write-Host "Removed $removed FORBID_COMPONENT line(s) from component 4130 (backup: setup-stratagems.tp2.bak)."

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Copy-Item (Join-Path $here "gameplay\resurrection.tpa") (Join-Path $StratagemsDir "gameplay\resurrection.tpa") -Force
if (Test-Path (Join-Path $here "resurrection_base")) {
    Copy-Item (Join-Path $here "resurrection_base") $StratagemsDir -Recurse -Force
}
Write-Host "Copied gameplay\resurrection.tpa and resurrection_base."
