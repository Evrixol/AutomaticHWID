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
        Write-Host "``NuGet`` isn't installed. Installing..." -ForegroundColor Yellow -BackgroundColor DarkRed

        Install-PackageProvider -Name "nuget" -RequiredVersion $json.min_ver.NuGet -Force | Out-Null
        Write-Host "``NuGet`` is now installed. Ending function call..." -ForegroundColor Green

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

            Install-PackageProvider -Name "nuget" -RequiredVersion $json.min_ver.NuGet -Force | Out-Null
            Write-Host "``NuGet`` is now installed.`nEnding function call for ``Confirm-NuGet``." -ForegroundColor Green
        }        
    }
}

# Check if "Get-WindowsAutoPilotInfo.ps1" is present in the system. 
Function Confirm-Get_WindowsAutoPilotInfo
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
        Install-Script -Name "Get-WindowsAutoPilotInfo" -Repository "PSGallery" -Force -MinimumVersion $json.min_ver.Get_WindowsAutoPilotInfo
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
    $dir = $PSScriptRoot+"$($json.directory.location)$($json.directory.name)" # The directory whole.
    $dir_exists = Test-Path $dir # Directory exists bool.

    If ($dir_exists -EQ $True)
    {
        # If directory exists, say such thing and set location to directory.
        Write-Host "Directory exists." -ForegroundColor Green
        Write-Host "`nSetting location to proper directory..." -ForegroundColor Yellow
        Set-Location $dir
        Write-Host "`nLocation Set!`nEnding function call." -ForegroundColor Green
    }
    ElseIf ($dir_exists -eq $False)
    {
        # If directory doesn't exist, say such and create location. Then set location to that directory.
        Write-Host "`nDirectory does not exist!" -ForegroundColor Red
        
        Write-Host "`nCreating new directory..." -ForegroundColor Yellow
        
        mkdir $dir | Out-Null
        
        Write-Host "Directory created!" -ForegroundColor Green
        Write-Host "`nSetting location to directory..." -ForegroundColor Yellow
        
        Set-Location $dir
        Write-Host "Location set!`nEnding function call.`n" -ForegroundColor Green
    }

    
}

# Get the Hardware ID of the system that this script is running on. Place i n
Function Get-HardwareID 
{
    # God awful output file path spaghetti nightmare. GAOFPSN for short. The acronym matches its meaning.
    $output = $PSScriptRoot+$($json.directory.location)+$($json.directory.name)+$($json.temp_file.name)

    # Write what function is doing.
    Write-Host "`nFunction ``Get-HardwareID`` called. Output:`n" -ForegroundColor Red

    # Get hardware ID and output to file listed in config.
    Write-Host "Getting hardware identification...`nOutputting to file "$output -ForegroundColor yellow
    C:\'Program Files'\WindowsPowerShell\Scripts\Get-WindowsAutoPilotInfo.ps1 -OutputFile $output

    # Renaming file to twelve digit serial number inside of file.
    Write-Host "Renaming file to twelve digit serial number inside file..." -ForegroundColor Yellow
    $regex = '\d{12}'
    $foo = Select-String -Path $output -Pattern $regex -AllMatches | ForEach-Object {$_.Matches} | ForEach-Object {$_.Value} # Get a twelve digit number using regex in input file and rename file to that twelve digit number.
    Rename-Item -Path $output -NewName $($foo+$json.temp_file.extension)

    Write-Host "Done! Ending function call!" -ForegroundColor green
}

# Calling the various functions and ending script.  
Confirm-NuGet
Confirm-Get_WindowsAutopilotInfo
Confirm-Directory
Get-HardwareID
