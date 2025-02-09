# Function to generate log file path with current date and module name
function Logs() {
    $date = get-date -format "dddd-MM-dd-HH"
    $module = "New_Teams"
    $logPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\uninstall_$module_Powershell_Module_$date.log"
}

# Generate log file path
Logs

# Start logging
Start-Transcript -path $logPath -Append

# Run the uninstallation process for Teams
start-process -FilePath .\teamsbootstrapper.exe -ArgumentList "-x"

# Stop logging
Stop-Transcript
