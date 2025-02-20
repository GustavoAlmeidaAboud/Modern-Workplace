### Get Logged On User SID
$loggedOnUser = (Get-WmiObject -Class Win32_ComputerSystem).UserName
$userSID = (Get-WmiObject -Class Win32_UserAccount -Filter "Name='$($loggedOnUser.Split('\')[-1])'").SID
$TeamsNew = get-appxpackage -user "$userSID" | Where-Object PackageFullName -like '*MSTeams*'

# Define the command to run as the user
    if ($TeamsNew -and (!$TeamsClassic)) {
        Write-Host "Found it!"
        #exit 0
    } else {
        Write-Host "Not found!"
        #exit 1
    }
