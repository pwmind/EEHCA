<# 
.SYNOPSIS

Download SMART-DS files from OEDI

.DESCRIPTION

Download the SMART-DS files from OEDI.  This script will download from the base prefix specified in
$baseprefix to the target directory specified by $targetbase.  This script downloads only the tree, it does
not download the load shape files specified in the LoadShapes.dss files.

.NOTES

# $index = Invoke-WebRequest -Uri "https://data.openei.org/s3_viewer?bucket=oedi-data-lake&prefix=SMART-DS%2Fv1.0%2F2018%2FSFO%2FP1U%2Fscenarios%2Fbase_timeseries%2Fopendss%2F"

# $folders = $index.Links | where-object -Property data-s3 -eq "folder"  

# $objects = $index.Links | Where-Object -Property data-s3 -eq "object"  

data-s3: folder | object

data-prefix: folders only, key path

for folders, don't forget the trailing slash

href: 
    folders: URL path for key path
    objects: full URL for file

$folders2.'data-prefix' | %{New-Item -Path "." -Name $_.Split("/")[-2] -ItemType Directory}
#>

<#
.SYNOPSIS

Recursive function for downloading files from OEDI

.DESCRIPTION

Recurse through the directories.  This function is depth first and will go down into the lowest directory before downloading 
the files.  Function will get called until it reaches a folder with no children folders.

.PARAMETER  URLPath

Prefix path for this folder

.PARAMETER DestinationPath

File path to place the files.  New folders will be created to match the OEDI file structure.

#>

Param (
    [Parameter(Mandatory=$true)]$DestinationPath
)

function Get-S3File {
    Param(
        $URLPath,
        $DestinationPath)

    $response = Invoke-WebRequest -Uri $URLPath

    $folders = $response.Links | Where-Object -Property 'data-s3' -eq "folder"

    # recursive loop
    foreach($f in $folders) {
        # get the folder name
        $foldername = $f.'data-prefix'.Split('/')[-2]

        Write-Debug "foldername = $foldername"

        if ((Test-Path -Path "$($DestinationPath)/$($foldername)") -eq $false) {
            New-Item -Path $DestinationPath -Name $foldername -ItemType Directory
        }
        else {
            Write-Debug "Path $($DestinationPath)\$($foldername) exists, continuing"
        }

        # add the folder name to DestinationPath
        $newDestPath = $DestinationPath + "\" + $foldername
        Write-Debug "newDestPath = $newDestPath"

        $newURL = $baseurl + $f.href

        Get-S3File -URLPath $newURL -DestinationPath $newDestPath
    }

    $files = $response.Links | Where-Object -Property 'data-s3' -eq "object"

    foreach($file in $files) {
        $filename = $file.href.Split("/")[-1]
        $uri = $file.href
        $dest = "$($DestinationPath)\$($filename)" 
        Invoke-WebRequest -Uri $uri -OutFile $dest 
        Write-Debug "Uri = $uri, OutFile = $dest"
    }
}

# Configuration parameters

$baseurl = "https://data.openei.org"

$service = "s3_viewer"

$bucket = "oedi-data-lake"

$baseprefix = "SMART-DS/v1.0/2018/SFO/P1U/scenarios/base_timeseries/opendss/"


# build the first URL for querying
$firsturl = "$baseurl/$($service)?bucket=$($bucket)&prefix=$($baseprefix)"

Write-Debug "firsturl = $firsturl"

Get-S3File -URLPath $firsturl -DestinationPath $DestinationPath