function Logs() {
    $date = get-date -format "dddd-MM-dd-HH"
    $module = "psappdeploytoolkit"
    $logPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\install_$module_Powershell_Module_$date.log"
    }
    
function Dependencies {
    if (!(Get-PackageProvider -Name NuGet -ListAvailable -ErrorAction SilentlyContinue)) {
        Write-Host "NuGet package provider is not installed. Installing..." -ForegroundColor Yellow
        Install-PackageProvider -Name NuGet -Force
        Write-Host "NuGet package provider installed successfully." -ForegroundColor Green
    } else {
        Write-Host "NuGet package provider is already installed." -ForegroundColor Green
    }
}
