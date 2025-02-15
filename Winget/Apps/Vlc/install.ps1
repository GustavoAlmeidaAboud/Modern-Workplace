function Get-WingetPath {
    $winget = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_*__8wekyb3d8bbwe\winget.exe"
    if ($winget.Count -gt 1) {
        $winget = $winget[-1].Path
    } else {
        $winget = $winget.Path
    }
    return $winget
}

function Install-WingetApp {
    param(
        [string]$AppID
    )
    # Get the winget executable path
    $Winget = Get-WingetPath
    # Execute the winget command and store the result
    &$Winget install --id $AppID -h --force --accept-source-agreements --accept-package-agreements
}

try {
    Write-Host "Installing required app"
    install-WingetApp -AppID "VideoLAN.VLC" 
    Exit 0
}
catch {
    Write-Host "Unable to uninstall app"
    Write-Host "An error occurred: $_"
    Exit 1
}