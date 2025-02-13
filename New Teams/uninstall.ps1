# Function to generate log file path with current date and module name
function Start-Logs {
    param(
        [string]$AppName = "",
        [string]$Method = ""
    )
    $date = Get-Date -Format "dddd-MM-dd-HH"
    $logPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\$Method-$AppName-$date.log"
    Start-Transcript -Path $logPath -Append -Force
}

# Generate Log files
Start-Logs -AppName "New Microsoft Teams" -Method "uninstall"

# Run the uninstallation process for Teams
Start-Process -FilePath ".\teamsbootstrapper.exe" -ArgumentList "-x" -Wait
Get-AppxPackage -AllUsers| Where-Object PackageFullName -like '*MSTeams*' | Remove-AppxPackage -Confirm:$false

# Stop logging
Stop-Transcript
