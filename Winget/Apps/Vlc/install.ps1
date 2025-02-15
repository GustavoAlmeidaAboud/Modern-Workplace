. C:\Users\almei\Modern-Workplace\functions.ps1

function Install-WingetApp {
    param(
        [string]$AppID = ""
    )
    # Get the winget executable path
    $Winget = Get-WingetPath
    # Execute the winget command and store the result
    &$Winget install --id $AppID -h --force --accept-source-agreements
}

try {
    Write-Host "Installing required app"
    Uninstall-WingetApp -AppID "VideoLAN.VLC"
    
}
catch {
    Write-Host "Unable to uninstall app"
}