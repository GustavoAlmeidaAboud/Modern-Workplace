# Define the module variable at the beginning
$Module = "PsAppDeployToolKit"

function Logs() {
    $date = get-date -format "dddd-MM-dd-HH"
    $app = "psappdeploytoolkit"
    $method = "Install"
    $logPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\$method $app $date.log"
    Start-Transcript -Path $logPath -Append -Force
}

function Dependencies() {
    if (!(Get-PackageProvider -Name NuGet -ListAvailable -ErrorAction SilentlyContinue)) {
        Install-PackageProvider -Name NuGet -Force
    } else {
        Write-Host "NuGet package provider is already installed." -ForegroundColor Green
    }
}

Logs

try {
    Write-Host "Attempting to uninstall the Module '$module'"
    uninstall-Module -Name $module -Force -AllVersions
    Write-Host "'$module' has been uninstalled successfully!"
} catch {
    Write-Host "An error occurred while trying to uninstall the module."
    Write-Host "Error Details: $($_.Exception.Message)"
} finally {
    Stop-Transcript
}