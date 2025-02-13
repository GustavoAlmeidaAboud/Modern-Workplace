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
Start-Logs -AppName "psappdeploytoolkit" -Method "install"

try {
    Write-Host "Attempting to install the '$Module'"
    Install-Module -Name $Module -Force -AllowClobber -Scope AllUsers
    Write-Host "'$Module' has been installed successfully!"
    Exit 0
} catch {
    Write-Host "An error occurred while trying to install the module."
    Write-Host "Error Details: $($_.Exception.Message)"
} finally {
    Stop-Transcript
}
