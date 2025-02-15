function Install-WingetApp {
    $Winget = Get-WingetPath
    param(
        [string]$AppID
    )
    &$Winget install --id $AppID -All --silent --force --accept-source-agreements --accept-package-agreements
    # Example usage
    # install-WingetApp -AppID "VideoLAN.VLC"
}

Install-WingetApp -AppID "Git.Git"