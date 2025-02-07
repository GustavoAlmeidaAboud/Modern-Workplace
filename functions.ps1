# Check whether Nuget package is installed or not
function Dependencies {
    if (!(Get-PackageProvider -Name NuGet -ListAvailable -ErrorAction SilentlyContinue)) {
        Write-Host "NuGet package provider is not installed. Installing..." -ForegroundColor Yellow
        Write-Host "NuGet package provider installed successfully." -ForegroundColor Green
    } else {
        Write-Host "NuGet package provider is already installed." -ForegroundColor Green
    }
}

function TranscriptVariables{
    $date = get-date -format "dddd-MM-dd-HH"
    $module = "psappdeploytoolkit"
    $logPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\uninstall_$module_Powershell_Module_$date.log"
}