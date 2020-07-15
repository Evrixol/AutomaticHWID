$json = Get-Content -Raw -Path config.json | ConvertFrom-Json # Gather JSON configuration data and convert from JSON to powershlel readable content.

function Get-NuGet 
{
    Write-Host "Checking if NuGet is installed..."

    if((Get-PackageProvider -ListAvailable | Where-Object {$_.Name -EQ "NuGet"}) -EQ $False ) 
    {
        
        # If NuGet isn't installed, display such and install. 
        Write-Host "NuGet not installed! Installing..." -ForeGroundColor Yellow
        Install-PackageProvider -Name NuGet -Force -MinimumVersion $json. | Out-Null # Figure out a way to change verbosity. 
        Write-Host "NuGet is now installed! " -ForeGroundColor Green 
    }
    else 
    {
        Write-Host "NuGet is installed. Checking if version number is correct... "
        if ( !! (Get-PackageProvider -ListAvailable | Where-Object Name -EQ "NuGet" | Where-Object Version -GE [Version]"2.8.5.209") -EQ $True)
        {
            Write-Host "True"
        }
        elseif ( $_ -EQ $False )
        {
            Write-Host "False"
        }
    }
}

Write-Output $json