. .\functions.ps1
function install-WingetApp {
    param(
        [string]$AppID = ""
    )
    # Get the winget executable path
    $Winget = Get-WingetPath
    # Execute the winget command and store the result
    &$Winget install --id $AppID -h --force --accept-source-agreements --accept-package-agreements
}

# Example usage
install-WingetApp -AppID "VideoLAN.VLC"