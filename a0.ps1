# Get config.json data.
$json = (Get-Content -Raw -Path $PSScriptroot'\config.json' | ConvertFrom-Json)

# Check if NuGet is installed.
Function Confirm-NuGet()
{
    # Display what function is doing.
    Write-Host "Checking for NuGet installation... " -ForegroundColor Yellow
    
    # Checking available package providers, checking names for 'nuget'. 
    If ( !! ( Get-PackageProvider -ListAvailable | Where-Object Name -CEQ "nuget" ) -EQ $False )
    {
        # If not installed, install. Install minimum version located in config.json.
        Write-Host "NuGet isn't installed. Installing." -ForegroundColor Yellow -BackgroundColor DarkRed


    }
    # If installed, check version. 
    ElseIf ( !! ( Get-PackageProvider -ListAvailable | Where-Object Name -CEQ "nuget" ) -EQ $True )
    {
        # Display what function is doing.
        Write-Host "NuGet is installed. Checking version..." -ForegroundColor Yellow
        
        # Get the current installed version of NuGet and the required version of NuGet listed in config.json.
        $cur = [Version]::Parse((Get-PackageProvider -ListAvailable | Where-Object Name -CEQ "nuget" | Select-Object Version | Foreach-Object -Process {Select-String "^\d.*\d$" -List -InputObject $_.Version }))
        $req = [Version]::Parse($json.min_ver.NuGet)

        # Compare the current version of Nuget versus the minimum required version.
        If (($cur -GE $req) -EQ $True) 
        {
            # If NuGet is installed and holds the minimum required version or newer, display such and end function call.
            Write-Host "NuGet is installed and holds required version." -ForegroundColor Green
            Break
        }
        ElseIF (($cur -GE $req) -EQ $False)
        {
            # If NuGet is installed but doesn't hold the minimum required version, display so and update to the minimum required version. 
            Write-Host "NuGet version not up to date. Updating..." -ForegroundColor Red

            Update-Module nuget -Force
        }


        
    }
}

Confirm-Nuget
