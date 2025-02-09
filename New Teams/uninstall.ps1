# Function to generate log file path with current date and module name
function Logs() {
    $date = get-date -format "dddd-MM-dd-HH"
    $app = "New Teams"
    $method = "Uninstall"
    $logPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\$method $app $date.log"
    Start-Transcript -Path $logPath -Append -Force
}

# Generate log file path
Logs

# Run the uninstallation process for Teams
start-process -FilePath .\teamsbootstrapper.exe -ArgumentList "-x"

# Stop logging
Stop-Transcript
