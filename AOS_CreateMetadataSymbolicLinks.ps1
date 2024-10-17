<#
	.SYNOPSIS
	Creates symbolic links for all the D365FO modules registered in Metadata folder to AOSService\PackagesLocalDirectory.
    
	.DESCRIPTION
	*** Script version: AOS_CreateMetadataSymbolicLinks.ps1 v1.1 ***

    When using source control repositories such as GIT you have only one source location. 
    D365FO requires separate location for Modules (Metadata) and Projects connecting the source files 
    together in a structured and organized way. The script creates symbolic links for all 
    the D365FO modules registered in Metadata folder to AOSService\PackagesLocalDirectory.
		
	Existing AOS Modules are skipped.

	*** NOTE: Please run the script as administrator
	
	.PARAMETER PackagesLocalFolder
	Specify a custom AOS PackagesLocalDirectory path.
	
	.EXAMPLE
	PS> .\AOS_CreateMetadataSymbolicLinks.ps1
	
	Creates symbolic links for all models.

	.EXAMPLE
	PS> .\AOS_CreateMetadataSymbolicLinks.ps1 -PackagesLocalFolder "C:\CustomAOS\PackagesLocalDirectory"
	
	Creates symbolic links for all models.
#>

# Input parameters
param
(
	[Parameter(Mandatory=$false,
		HelpMessage = 'If specified this will be the folder in which symbolic links are to be created.')]
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
    Write-Host "The 'Metadata' folder containing all D365FO modules is missing. Please check if script was run from the same folder as the script is located in." -ForegroundColor Red
	Exit
}

Write-Host "AOS PackagesLocal Folder: $AOSMetadataPath"
Write-Host "GIT Metadata Folder: $RepoMetadataPath"

Write-Host "`nStarting to register AOS metadata symbolic links...`n"

$RepoModelFolders = Get-ChildItem $RepoMetadataPath -Directory
foreach ($ModelFolder in $RepoModelFolders)
{
	$Target = "$RepoMetadataPath\$ModelFolder"
	## The full destination path
	$AOSModulePath = [System.IO.Path]::Combine($AOSMetadataPath, $ModelFolder)
	if (!(Test-Path $AOSModulePath))
	{
		New-Item -ItemType SymbolicLink -Path "$AOSMetadataPath" -Name "$ModelFolder" -Value "$Target" -ErrorAction Stop | Out-Null
		Write-Host "  Created symbolic link for model '$ModelFolder': $AOSModulePath" -ForegroundColor Green
	} else {
		Write-Host "  Model folder '$ModelFolder' already exists in AOS 'PackagesLocalDirectory' folder. Action is skipped." -ForegroundColor Yellow
	}
}

Write-Host "`nScript completed."

Set-StrictMode -Off