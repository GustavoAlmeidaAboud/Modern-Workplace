$date = get-date -format "dddd-mm-dd-hh"
$logPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\installpsappdeploytoolkit_$date.txt"
Start-Transcript -Path $logPath
try {
    Write-Host "Attempting to install the 'psappdeploytoolkit' module..." -ForegroundColor Green
    Install-Module -Name "psappdeploytoolkit" -Force -AllowClobber -Scope AllUsers
    Write-Host "'psappdeploytoolkit' module installed successfully!" -ForegroundColor Green
} catch {
    Write-Host "An error occurred while trying to install the module." -ForegroundColor Red
    Write-Host "Error Details:" -ForegroundColor Yellow
    Write-Host $_.Exception.Message
}

Stop-Transcript