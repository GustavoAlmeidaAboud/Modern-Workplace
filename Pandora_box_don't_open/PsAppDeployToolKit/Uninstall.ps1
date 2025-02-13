# Define the module variable at the beginning
$Module = "PsAppDeployToolKit"
function Start-Logs() {
    param(
        [string]$AppName = "",
        [string]$Method = ""
    )
    $date = get-date -format "dddd-MM-dd-HH"
    $logPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\$method-$AppName-$date.log"
    Start-Transcript -Path $logPath -Append -Force
}
# Example usage
Start-Logs -AppName "psappdeploytoolkit" -Method "uninstall"

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