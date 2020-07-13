# Check if 'NuGet' is installed on the system. 
function Check_Nuget 
{
    if(Get-PackageProvider -ListAvailable | Where-Object {$_.Name -eq "NuGet"} | Out-Null)
    {
        Write-Output "'NuGet' package provider installed. Ignoring. "
    }
    elseif(Get-PackageProvider -ListAvailable | Where-Object {$_.Name -ne "NuGet"} | Out-Null)
    {
        Write-Output "'NuGet' package provider not installed. Installing. "
        Install-PackageProvider -Name NuGet -Force | Out-Null
    }
}

# Check if 'Get-WindowsAutoPilotInfo.ps1' is installed on the system. Install if not already installed. Set path to script in $getHWID_path.
function Check_GetWindowsAutoPilotInfo 
{
    if(Get-InstalledScript | Where-Object {$_.Name -eq "Get-WindowsAutoPilotInfo"} | Out-Null)
    {
        Write-Oputput "'Get-WindowsAutoPilotInfo.ps1' script installed. Ignoring."
    }
    elseif(Get-InstalledScript | Where-Object {$_.Name -ne "Get-WindowsAutoPilotInfo"} | Out-Null)
    {
        Write-Output "'Get-WindowsAutoPilotInfo.ps1' script not installed. Installing..."
        Install-Script -Name "Get-WindowsAutoPilotInfo" -Repository 'PSGallery' -Force
    }
}

# TODO: Move 'HWID' directory to one directory above.
# Check if directory 'HWID' exists. Create new directory titled 'HWID' if is nonexistant.  
# Set location to <HWID>
function Check_Directory 
{
    $HWID_dir_exists = Test-Path $PSScriptRoot+'\..\HWID'
    if($HWID_dir_exists -eq $False) 
    {
        Write-Output "'HWID\' directory nonexistant. Creating new directory. "
        mkdir -Path $PSScriptRoot+'\..\HWID' | Out-Null
	}
    else
    {
        write-output "'HWID\' directory exists. Ignoring. "
    }

    Set-Location -Path $PSScriptRoot+'\..\HWID' | Out-Null
}

function Get-HWID
{
    C:\'Program Files'\WindowsPowerShell\Scripts\Get-WindowsAutoPilotInfo.ps1 -OutputFile AutoPilotHWID.csv # Get hardware id and send output to 'AutoPilotHWID.csv.' 

    $regex = (\d{12}) # Define a regex value of twelve numeric digits.
    $output = Select-String -Path 'AutoPilotHWID.csv' -Pattern $regex -AllMatches | foreach-Object {$_.Matches } | foreach-object {$_.Value} # Get hardware id.
    Rename-Item -Path '.\AutoPilotHWID.csv' -NewName $output'.csv' # Rename file to hardware id.
}

Check_Directory
Check_Nuget
Check_GetWindowsAutoPilotInfo
Get-HWID