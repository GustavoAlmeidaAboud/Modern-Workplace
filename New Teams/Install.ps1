# Function to generate log file path with current date and module name
function Logs() {
    $date = get-date -format "dddd-MM-dd-HH"
    $app = "New Teams"
    $method = "Install"
    $logPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\$method $app $date.log"
    Start-Transcript -Path $logPath -Append -Force
}

# Check if Teams Classic exists
$TeamsClassic = Test-Path C:\Users\*\AppData\Local\Microsoft\Teams\current\Teams.exe

# Check if New Teams package is installed for any user
$TeamsNew = Get-AppxPackage -AllUsers | Where-Object PackageFullName -like '*MSTeams*'

# Generate log file path
Logs

# If Teams Classic exists, uninstall it
if ($TeamsClassic) {
    Write-Host "Teams Classic still installed"
    Write-Host "Uninstalling Teams Classic"
    Start-Process -FilePath .\teamsbootstrapper.exe -ArgumentList "-u" -Wait
}

# If New Teams is already installed, exit
if ($TeamsNew) {
    Write-Host "Teams New is already installed"
    Exit 0
} else {
    # If New Teams is not installed, install it
    Write-Host "Installing Teams New"
    start-process -FilePath .\teamsbootstrapper.exe -ArgumentList "-p" -Wait
    start-process -FilePath .\teamsbootstrapper.exe -ArgumentList "-p" -Wait
    Exit 0
}

# Stop logging
Stop-Transcript
