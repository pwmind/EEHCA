# 
# DownloadProfiles.ps1
# 
# Download the SMART-DS loadshape files lised in the OpenDSS LoadShape.dss file.  Store files in $targetdir.
# Example loadshape URL https://oedi-data-lake.s3.amazonaws.com/SMART-DS/v1.0/2018/SFO/P1U/profiles/com_kvar_1061_pu.csv

Param (
    [Parameter(Mandatory=$true)]$loadshapedir
    [Parameter(Mandatory=$true)]$targetdir
)

function Get-ProfileFile {
    param (
        [Parameter(Mandatory=$true)]$FileName,
        [Parameter(Mandatory=$true)]$TargetDirectory,
        [Parameter(Mandatory=$true)]$URL
    )

    if ((Test-Path -Path "$($TargetDirectory)\$($FileName)" -Type Leaf) -ne $true) {
        $fullurl = $baseurl + $FileName
        $outpath = $targetdir + $FileName

        Write-Debug "url = $fullurl, outpath = $outpath"
        Invoke-WebRequest -Uri $fullurl -OutFile $outpath
    }
}
# get all LoadShapes.dss files
$loadshapefiles = Get-ChildItem -Path $loadshapedir -Recurse -Include LoadShapes.dss

$baseurl = "https://oedi-data-lake.s3.amazonaws.com/SMART-DS/v1.0/2018/SFO/P1U/profiles/"
# for each file:
foreach ($lsf in $loadshapefiles) {
    $content = Get-Content $lsf.PSPath

    foreach ($line in $content) {

        if($line -match '(?<buildtype>\w\w\w)_kw_(?<buildnum>\d+)_pu'){ 
            
            $kwcsv = $Matches.buildtype + "_kw_" + $Matches.buildnum + "_pu.csv"

            Get-ProfileFile -FileName $kwcsv -TargetDirectory $targetdir -URL $baseurl

            $kvarcsv = $Matches.buildtype + "_kvar_" + $Matches.buildnum + "_pu.csv"

            Get-ProfileFile -FileName $kvarcsv -TargetDirectory $targetdir -URL $baseurl
        }
    }
}
