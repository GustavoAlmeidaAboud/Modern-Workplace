# Function to generate log file path with current date and module name
function Start-Logs() {
    param(
        [string]$AppName = "",
        [string]$Method = ""
    )
    $date = get-date -format "dddd-MM-dd-HH"
    $logPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\$method-$AppName-$date.log"
    Start-Transcript -Path $logPath -Append -Force
}
#Generate Log files
start-logs -AppName "New Microsoft Teams" -Method "uninstall"

# Run the uninstallation process for Teams
start-process -FilePath .\teamsbootstrapper.exe -ArgumentList "-x"

# Stop logging
Stop-Transcript
