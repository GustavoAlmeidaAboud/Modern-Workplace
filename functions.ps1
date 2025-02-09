function Logs() {
    $date = get-date -format "dddd-MM-dd-HH"
    $app = "New Teams"
    $method = "Uninstall"
    $logPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\$method $app $date.log"
    Start-Transcript -Path $logPath -Append -Force
}
    
function Dependencies {
    if (!(Get-PackageProvider -Name NuGet -ListAvailable -ErrorAction SilentlyContinue)) {
        Install-PackageProvider -Name NuGet -Force
    } else {
        Write-Host "NuGet package provider is already installed." -ForegroundColor Green
    }
}