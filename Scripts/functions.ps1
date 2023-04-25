# functions.ps1
# Intended to be a central file for functions that are used across scripts.

# XXX: need beginning record number for dealing with header lines
function Get-RecordsForDayNumber {
    param(
        $DayNumber,
        $PeriodsPerDay,
        $Content,
        $StartingLine,
        [Parameter()][switch]$IncludeHeader
    )

    if ($null -eq $StartingLine) {
        $StartingLine = 0
    }

    # Multiply periodsperday by daynumber to get the starting record.  (Remember, PS arrays are 0 start while day numbers start with 1)
    $start = $StartingLine + $PeriodsPerDay * ($DayNumber - 1)
    $end = $start + $PeriodsPerDay - 1

    if ($IncludeHeader) {
        $header = $content[0]
        return @($header, $content[$start..$end])
    }
    else {
        return $content[$start..$end]
    }
    
}

