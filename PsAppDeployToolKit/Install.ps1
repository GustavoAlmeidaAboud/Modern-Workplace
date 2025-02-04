$date = get-date -format "dddd-MM-dd-HH"
$logPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\Install_PSAppDeployToolKit_Powershell_Module_$date.log"
$module = "psappdeploytoolkit"
$dependency = Get-PackageProvider -Name NuGet -ListAvailable


Start-Transcript -Path $logPath
try {
    Write-Host "Attempting to install the 'psappdeploytoolkit' module..." -ForegroundColor Green
    Install-Module -Name "$module" -Force -AllowClobber -Scope AllUsers
    Write-Host "'psappdeploytoolkit' has been installed!" -ForegroundColor Green
    Exit 0
} catch {
    Write-Host "An error occurred while trying to install the module." -ForegroundColor Red
    Write-Host "Error Details:" -ForegroundColor Yellow
    Write-Host $_.Exception.Message
    Exit 1
} finally {
    Stop-Transcript
}