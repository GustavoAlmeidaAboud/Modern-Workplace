# Generate Logs
function Start-Logs() {
    param(
        [string]$AppName = "",
        [string]$Method = ""
    )
    $date = get-date -format "dddd-MM-dd-HH"
    $logPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\$method-$AppName-$date.log"
    Start-Transcript -Path $logPath -Append -Force
    # Example Usage
    # Start-Logs -AppName "Git" -Method "Uninstall"
}

Start-Logs -AppName "Winget update all" -Method Install-WingetApp

function Update-WingetAppAllUser{
    return winget update --All --silent --accept-package-agreements --accept-source-agreements --force --scope User --include-unknown
}

try {
    Write-Host "Updating all winget apps"
    Update-WingetAppAllUser
}
catch {
    Write-Host "An potential issue occured $_"
}
finally {
    Stop-transcript
}