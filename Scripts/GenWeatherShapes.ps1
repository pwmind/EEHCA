<#

.SYNOPSIS

.DESCRIPTION

.PARAMETER

.INPUTS

.OUTPUTS


#>

[CmdletBinding()]
param (
    [Parameter()][string]$Date,
    [Parameter()][ValidateRange(1,365)][int]$DayNumber,
    [Parameter(Mandatory=$true)][int]$PeriodsPerDay,
    [Parameter(Mandatory=$true)][string]$Path,
    [Parameter()][string]$OutPath,
    [Parameter()][string[]]$Fields
)

. "$PSScriptRoot\functions.ps1"

$content = Get-Content -Path $Path

$records = Get-RecordsForDayNumber -Content $content -DayNumber $DayNumber -PeriodsPerDay $PeriodsPerDay -StartingLine 1 -IncludeHeader | ConvertFrom-Csv

($records | Select-Object -Property $Fields | ConvertTo-Csv -UseQuotes AsNeeded | Select-Object -Skip 1) -join "`n" | Set-Content -Path $OutPath -NoNewline -Encoding ascii
