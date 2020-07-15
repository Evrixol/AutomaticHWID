$min = [Version]"2.8.5.208"
$curr = (Get-PackageProvider -ListAvailable | Where-Object {$_.Name -eq "NuGet"} | Select-String {$_.Version})

if( !! ([Version]$min -lt [Version]$curr) -EQ $True ) {
    Write-Output ([Version]$min -GE [Version]$curr)
    Write-Host "FIRST" -ForegroundColor Green
}
else {
    Write-Output ([Version]$min -GE [Version]$curr)
    Write-Host "LAST" -BackgroundColor Black -ForegroundColor Red
}

(Get-PackageProvider -ListAvailable | Where-Object {$_.Name -eq "NuGet"} | Select-String {$_.Version})
