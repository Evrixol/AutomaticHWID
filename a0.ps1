# Get config.json data.
$json = (Get-Content -Raw -Path $PSScriptroot'\config.json' | ConvertFrom-Json)

# Check if NuGet is installed.
function CheckInstall-NuGet()
{
    # Display what function is doing.
    Write-Host "Checking for NuGet installation... " -ForegroundColor Yellow
    
    # Checking available package providers, checking names for 'nuget'. 
    if ( !! ( Get-PackageProvider -ListAvailable | Where-Object Name -CEQ "nuget" ) -EQ $False )
    {
        # If not installed, install. Install minimum version located in config.json.
        Write-Host "NuGet isn't installed. Installing." -ForegroundColor Yellow -BackgroundColor DarkRed


    }
    elseif ( !! ( Get-PackageProvider -ListAvailable | Where-Object Name -CEQ "nuget" ) -EQ $True )
    {
        Write-Host "NuGet is installed. Checking version..." -ForegroundColor Yellow
        $Nuget_Has_Required_Version = ( !! ( Get-PackageProvider -ListAvailable | Where-Object Name -CEQ "nuget" | Select-Object Version | Foreach-Object -Process {Select-String "^\d.*\d$" -List -InputObject $_.Version }) -GE $json.min_versions.NuGet)

        If ($Nuget_Has_Required_Version -EQ $False)
        {
            Write-Host "NuGet required version met. Ending function call." -ForegroundColor Green
            Break
        }
        elseif ($Nuget_Has_Required_Version -EQ $True)
        {
            Write-Host "Nuget required version not met. Updating to required version." -ForegroundColor Red -BackgroundColor Black -
        }
    }
}

CheckInstall-NuGet
