# Function to generate log file path with current date and module name
function Start-Logs {
    param(
        [string]$AppName,
        [string]$Method
    )
    $date = Get-Date -Format "dddd-MM-dd-HH"
    $logPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\$Method-$AppName-$date.log"
    Start-Transcript -Path $logPath -Append -Force
}

# Generate Log files
Start-Logs -AppName "New Microsoft Teams" -Method "Install"

# Check if Teams Classic exists
$TeamsClassic = Test-Path "C:\Users\*\AppData\Local\Microsoft\Teams\current\Teams.exe"

$loggedOnUser = (Get-WmiObject -Class Win32_ComputerSystem).UserName
$userSID = (Get-WmiObject -Class Win32_UserAccount -Filter "Name='$($loggedOnUser.Split('\')[-1])'").SID
$TeamsNew = get-appxpackage -user "$userSID" | Where-Object PackageFullName -like '*MSTeams*'

# If Teams Classic exists, uninstall it
if ($TeamsClassic) {
    Write-Host "Teams Classic still installed"
    Write-Host "Uninstalling Teams Classic"
    Start-Process -FilePath ".\teamsbootstrapper.exe" -ArgumentList "-u" -Wait
}

# If New Teams is already installed, exit
if ($TeamsNew) {
    Write-Host "New Microsoft Teams is already installed"
    Stop-Transcript
    Exit 0
} else {
    # If New Teams is not installed, install it
    Write-Host "Installing New Microsoft Teams"
    Start-Process -FilePath ".\teamsbootstrapper.exe" -ArgumentList "-p" -Wait
    Start-Process -FilePath ".\teamsbootstrapper.exe" -ArgumentList "-p" -Wait
    Stop-Transcript
    Exit 0
}