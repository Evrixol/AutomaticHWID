# Check if 'NuGet' is installed on the system.
# TODO: Figure out why it's not putting out output. 
function Check_Nuget 
{
    Write-Output "Checking for NuGet".
    if(Get-PackageProvider -ListAvailable | Where-Object Name -eq "NuGet" | Out-Null)
    {
        Write-output "NuGet installed. Ignoring."
    }
    elseif(Get-PackageProvider -ListAvailable | Where-Object Name -ne "NuGet" | Out-Null)
    {
        Write-Output "'NuGet' package provider not installed. Installing. "
        Install-PackageProvider -Name NuGet -Force | Out-Null
    }
}

# Check if 'Get-WindowsAutoPilotInfo.ps1' is installed on the system. Install if not already installed. Set path to script in $getHWID_path.
function Check_GetWindowsAutoPilotInfo 
{
    $req_a0 = Test-Path "C:\Program Files\WindowsPowerShell\Scripts\Get-WindowsAutoPilotInfo.ps1" # When not placing the script into the path, this is where it's located.
    if($req_a0 -eq $True)
    {
        Write-Output "'Get-WindowsAutoPilotInfo.ps1' script installed. Ignoring."
    }
    elseif($req_a0 -eq $False)
    {
        Write-Output "'Get-WindowsAutoPilotInfo.ps1' script not installed. Installing..."
        Install-Script -Name "Get-WindowsAutoPilotInfo" -Repository 'PSGallery' -Force
    }
}

# Check if directory 'HWID' exists. Create new directory titled 'HWID' if is nonexistant.  
# Set location to <HWID>
function Check_Directory 
{
    $HWID_dir = $PSScriptRoot + "\..\HWID"
    $HWID_dir_exists = Test-Path $HWID_dir
    if($HWID_dir_exists -eq $False) 
    {
        Write-Output "'HWID\' directory nonexistant. Creating new directory. "
        mkdir -Path $HWID_dir | Out-Null
	}
    else
    {
        write-output "'HWID\' directory exists. Ignoring. "
    }

    Set-Location -Path $PSScriptRoot'\..\HWID' | Out-Null
}

# Get the hardware identification using Get-WindowsAutoPilotInfo and output into file 'AutoPilotHWID.csv'. 
# Using 'Regex' search for a twelve digit integer and rename 'AutoPilotHWID.csv' to that twelve digit integer number. (eg: 000111222333.csv)
function Get-HardwareIdentification
{
    C:\'Program Files'\WindowsPowerShell\Scripts\Get-WindowsAutoPilotInfo.ps1 -OutputFile 'AutoPilotHWID.csv' # Get hardware id and send output to 'AutoPilotHWID.csv.' 

    $file = '.\AutoPilotHWID.csv'
    $regex = '\d{12}'
    $output = Select-String -Path $file -Pattern $regex -AllMatches | ForEach-Object {$_.Matches} | ForEach-Object {$_.Value} # Get a twelve digit number using regex in input file and rename file to that twelve digit number.
    Write-Output $output

    Rename-Item -Path '.\AutoPilotHWID.csv' -NewName $output'.csv'
}


Check_Nuget
Check_GetWindowsAutoPilotInfo
Check_Directory
Get-HardwareIdentification