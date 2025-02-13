$TeamsNew = Get-AppxPackage -AllUsers| Where-Object PackageFullName -like '*MSTeams*'
$TeamsClassic = Test-Path C:\Users\*\AppData\Local\Microsoft\Teams\current\Teams.exe

if ($TeamsNew.'PackageUserInformation'.'InstallState' -contains "Installed" -and (!$TeamsClassic)) {
    Write-Host "Found it!"
     exit 0
} else {
    Write-Host "Not found!"
     exit 1
}