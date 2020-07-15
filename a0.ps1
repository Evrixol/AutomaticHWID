


# Check if NuGet is installed.
function CheckInstall-NuGet()
{
    # Display what function is doing.
    Write-Host "Checking if NuGet is installed... " -ForegroundColor Yellow
    
    # Checking available package providers, checking names for 'nuget'. 
    if ( !! ( Get-PackageProvider -ListAvailable | Where-Object Name -CEQ "nuget" ) -EQ $False )
    {
        # If not installed, install. Install minimum version located in config.json.
        Write-Host "NuGet isn't installed. Installing." -ForegroundColor Green


    }
    elseif ( !! ( Get-PackageProvider -ListAvailable | Where-Object Name -CEQ "nuget" ) -EQ $True )
    {
        Write-Host "NuGet is installed. Checking version..."
        $currentVersion = Get-PackageProvider -ListAvailable | Where-Object Name -CEQ "nuget" | Select-Object Version | Foreach-Object -Process {Select-String -Pattern '2.8.5.208' -List -InputObject $_.Version } # This took two hours to figure out. "It worked on my machine." Quote me on that.

    }
}

CheckInstall-NuGet
