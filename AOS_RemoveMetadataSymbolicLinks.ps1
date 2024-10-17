<#
	.SYNOPSIS
	Removes symbolic links for all the D365FO modules registered in Metadata folder from AOSService\PackagesLocalDirectory.
    
	.DESCRIPTION
	*** Script version: AOS_RemoveMetadataSymbolicLinks.ps1 v1.1 ***

    When using source control repositories such as GIT you have only one source location. 
    D365FO requires separate location for Modules (Metadata) and Projects connecting the source files 
    together in a structured and organized way. The script creates symbolic links for all 
    the D365FO modules registered in Metadata folder.
		
	Existing AOS Modules are skipped.

	*** NOTE: Please run the script as administrator
	
	.EXAMPLE
	PS> .\AOS_RemoveMetadataSymbolicLinks.ps1
	
	Removes symbolic links from AOSService\PackagesLocalDirectory, the folder will be auto-found if it's in a root drive location (for example C:\AOSService\PackagesLocalDirectory).
	
	.EXAMPLE
	PS> .\AOS_RemoveMetadataSymbolicLinks.ps1 -PackagesLocalFolder "C:\CustomAOS\PackagesLocalDirectory"
	
	Removes symbolic links from the specified folder.
#>

# Input parameters
param
(
	[Parameter(Mandatory=$false,
		HelpMessage = 'If specified this will be the folder from which symbolic links will be removed.')]
    [String]$PackagesLocalFolder
)

#Requires -RunAsAdministrator

## https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/set-strictmode
Set-StrictMode -Version 3.0

## Searching for AOS folder
$AOSMetadataPath = ""
if ([System.String]::IsNullOrWhiteSpace($PackagesLocalFolder))
{
	Get-Partition | Where-Object { $AOSMetadataPath -eq "" } | ForEach-Object { 
		if(Test-Path ($_.DriveLetter+":\AOSService\PackagesLocalDirectory")) { 
			$AOSMetadataPath = ($_.DriveLetter+":\AOSService\PackagesLocalDirectory")
		} 
	}
} else {
	$AOSMetadataPath = $PackagesLocalFolder
}

## If path is missing exit the script
if(!$AOSMetadataPath)
{
	Write-Host "The AOS PackagesLocalDirectory folder is missing (e.g., C:\AOSService\PackagesLocalDirectory)." -ForegroundColor Red
	Exit
}

## Register all the repository Metadata folders (Modules) as Symbolic links to AOS
$RepoMetadataPath = ".\Metadata"
if(!(Test-Path $RepoMetadataPath)) { 
    Write-Host "The 'Metadata' folder containing all Docentric modules is missing. Please check if script was run from the same folder as the script is located in." -ForegroundColor Red
	Exit
}

Write-Host "AOS PackagesLocal Folder: $AOSMetadataPath"
Write-Host "GIT Metadata Folder: $RepoMetadataPath"

Write-Host "`nStarting to remove AOS metadata symbolic links...`n"

$RepoModelFolders = Get-ChildItem $RepoMetadataPath -Directory
foreach ($ModelFolder in $RepoModelFolders)
{
	$Target = "$RepoMetadataPath\$ModelFolder"
    ## The full destination path
    $AOSModulePath = [System.IO.Path]::Combine($AOSMetadataPath, $ModelFolder)
    if (Test-Path $AOSModulePath) {
        (Get-Item "$AOSModulePath").Delete() | Out-Null

        if($error.count -eq 0) {
            Write-Host "  Removed symbolic link for model '$ModelFolder': $AOSModulePath" -ForegroundColor Green
        } else {
            Write-Host "  Failed to remove symbolic link for model '$ModelFolder': $AOSModulePath" -ForegroundColor Red
            Write-Host "  Error: $($error)" -ForegroundColor Red
            $error.clear()
        }
    } else {
        Write-Host "  Model folder '$ModelFolder' is missing in AOS 'PackagesLocalDirectory' folder. Action is skipped." -ForegroundColor Yellow
    }
}

Write-Host "`nScript completed."

Set-StrictMode -Off