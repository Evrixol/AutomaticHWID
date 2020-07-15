if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    
    for($i = 0; $i -lt 3; $i++) {
        [Console]::Beep(1000, 100)
    }

    Write-Host "`nInsufficient permissions to run this script. Run this as an administrator.`n" -ForegroundColor Red -BackgroundColor Black
    
    Pause
    Break
}
else {
    Write-Host "`nScript is running with elevated permissions. Continuing...`n" -ForegroundColor Green
    Pause
}