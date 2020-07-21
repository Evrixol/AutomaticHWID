# Get config.json data.
$json = (Get-Content -Raw -Path $PSScriptroot'\config.json' | ConvertFrom-Json)

# Check if NuGet is installed.
Function Confirm-NuGet
{
    # Display what function is doing.
    Write-Host "`nFunction ``Confirm-NuGet`` called. Output:`n" -ForegroundColor Red
    Write-Host "Checking for ``NuGet`` installation... " -ForegroundColor Yellow
    
    # Checking available package providers, checking names for 'nuget'. 
    If ( !! ( Get-PackageProvider -ListAvailable | Where-Object Name -EQ "nuget" ) -EQ $False )
    {
        # If not installed, install. Install minimum version located in config.json.
        Write-Host "``NuGet`` isn't installed. Installing." -ForegroundColor Yellow -BackgroundColor DarkRed


    }
    # If installed, check version. 
    ElseIf ( !! ( Get-PackageProvider -ListAvailable | Where-Object Name -EQ "nuget" ) -EQ $True )
    {
        Write-Host "``NuGet`` is installed. Checking version..." -ForegroundColor Yellow
        
        # Get the current installed version of NuGet and the required version of NuGet listed in config.json.
        $cur = [Version]::Parse((Get-PackageProvider -ListAvailable | Where-Object Name -EQ "nuget" | Select-Object Version | Foreach-Object -Process {Select-String "^\d.*\d$" -List -InputObject $_.Version }))
        $req = [Version]::Parse($json.min_ver.NuGet)


        # Compare the current version of Nuget versus the minimum required version.
        If (($cur -GE $req) -EQ $True) 
        {
            # If NuGet is installed and holds the minimum required version or newer, display such and end function call.
            Write-Host "``NuGet`` is installed and holds required version.`nEnding function call for ``Confirm-NuGet``." -ForegroundColor Green
        }
        ElseIF (($cur -GE $req) -EQ $False)
        {
            # If NuGet is installed but doesn't hold the minimum required version, display so and update to the minimum required version. 
            Write-Host "``NuGet`` version not up to date. Updating..." -ForegroundColor Red

            Install-PackageProvider -Name "nuget" -RequiredVersion $json.min_ver.NuGet
            Write-Host "``NuGet`` is now installed.`nEnding function call for ``Confirm-NuGet``." -ForegroundColor Green
        }        
    }
}

# Check if "Get-WindowsAutoPilotInfo.ps1" is present in the system. 
Function Confirm-Get_WindowsAutopilotInfo
{
    # Declare what function is and what it is doing.
    Write-Host "`nFunction ``Confirm-Get_WindowsAutoPilotInfo`` called. Output:`n" -ForegroundColor Red
    Write-Host "Checking for ``Get-WindowsAutoPilotInfo.ps1``... " -ForegroundColor Yellow

    # Path to required script, test if it is present.
    $Scrpt = "C:\Program Files\WindowsPowerShell\Scripts\Get-WindowsAutoPilotInfo.ps1"
    $req_present = Test-Path $Scrpt

    # Test if script is present. If it isn't, write so and install.
    If ($req_present -EQ $False)
    {
        Write-Host "``Get-WindowsAutoPilotInfo.ps1`` not installed. Installing..." -ForegroundColor Red
        Install-Script -Name "Get-WindowsAutoPilotInfo.ps1" -Repository "PSGallery" -Force
        Write-Host "``Get-WindowsAutoPilotInfo.ps1`` is now installed. `nEnding function call for ``Confirm-Get_WindowsAutoPilotInfo``." -ForegroundColor Green
    }
    ElseIF ($req_present -EQ $True)
    {
        Write-Host "``Get-WindowsAutoPilotInfo.ps1`` is already installed. `nEnding function call for ``Confirm-Get_WindowsAutoPilotInfo``." -ForegroundColor Green
    }

}

# Checks if directory listed in 'config.json' is present.
Function Confirm-Directory
{
    # Declare what function is and what it is doing.
    Write-Host "`nFunction ``Confirm-Directory`` called. Output:`n" -ForegroundColor Red

    # Test whether or not directory is present.
    Write-Host "Testing whether or not ``$($json.directory.location)$($json.directory.name)`` Exists..." -ForegroundColor Yellow
    $dir =  "$($json.directory.location)$($json.directory.name)" # The directory whole.
    $dir_exists = Test-Path $dir # Directory exists bool.


    Write-Host ($json.directory.location)($json.directory.name)

    If ($dir_exists -EQ $True)
    {
        Write-Host "Directory exists. "
    }
}

# Get the Hardware ID of the system that this script is running on. Place i n
Function Get-HardwareID {

}

Confirm-NuGet
Confirm-Get_WindowsAutoPilotInfo
Confirm-Directory