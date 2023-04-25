
[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)][ValidateRange(1,365)][int]$DayNumber,
    [Parameter(Mandatory=$true)][string]$ProfilesPath,
    [Parameter(Mandatory=$true)][string]$OutPath
)

. "$PSScriptRoot\functions.ps1"

$resloadshapeids = @(5148, 8528, 13967, 8039, 1154, 12787, 438)

$comloadshapeids = @(17383, 2616, 34423)

$periods = 96

foreach ($id in $resloadshapeids) {
    foreach ($ptype in ("kw","kvar")) {
        $outfilename = "res_$($ptype)_$($id)_d$($DayNumber)_pu.csv"
        $infilename = "res_$($ptype)_$($id)_pu.csv"

        $allrecs = Get-Content -Path "$ProfilesPath\$infilename"

        $records = Get-RecordsForDayNumber -DayNumber $DayNumber -Content $allrecs -PeriodsPerDay $periods

        $records | Out-File -FilePath "$OutPath\$outfilename"
    }
}

foreach ($id in $comloadshapeids) {
    foreach ($ptype in ("kw","kvar")) {
        $outfilename = "com_$($ptype)_$($id)_d$($DayNumber)_pu.csv"
        $infilename = "com_$($ptype)_$($id)_pu.csv"

        $allrecs = Get-Content -Path "$ProfilesPath\$infilename"

        $records = Get-RecordsForDayNumber -DayNumber $DayNumber -Content $allrecs -PeriodsPerDay $periods

        $records | Out-File -FilePath "$OutPath\$outfilename"
    }
}