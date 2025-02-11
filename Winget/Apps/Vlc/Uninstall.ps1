. C:\Users\almei\Modern-Workplace\functions.ps1

function Uninstall-WingetApp {
    param(
        [string]$AppID = ""
    )
    # Get the winget executable path
    $Winget = Get-WingetPath
    # Execute the winget command and store the result
    &$Winget uninstall --id $AppID --All -h --force --accept-source-agreements
}

Uninstall-WingetApp -AppID "VideoLAN.VLC"