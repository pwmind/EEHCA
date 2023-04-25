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
    [Parameter()][string]$OutPath
)

. "$PSScriptRoot\functions.ps1"

# If date is provided, determine the day number.  Otherwise use the provided day number.
if ($null -eq $DayNumber) {
    $DayNumber = ([datetime]$Date).DayOfYear
}
elseif ($null -eq $Date) {
    Write-Error "At least on of Date or DayNumber needs to be provided."
}

$content = Get-Content -Path $Path

$records = Get-RecordsForDayNumber -DayNumber $DayNumber -Content $content

$records
