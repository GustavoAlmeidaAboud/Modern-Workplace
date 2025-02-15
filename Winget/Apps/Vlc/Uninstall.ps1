function Get-WingetPath {
    $winget = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_*__8wekyb3d8bbwe\winget.exe"
    if ($winget.Count -gt 1) {
        $winget = $winget[-1].Path
    } else {
        $winget = $winget.Path
    }
    return $winget
}

function Uninstall-WingetApp {
    param(
        [string]$AppID
    )
    # Get the winget executable path
    $Winget = Get-WingetPath
    # Execute the winget command and store the result
    &$Winget uninstall --id $AppID --All -h --force --accept-source-agreements
}

try {
    Write-Host "Uninstalling required app"
    Uninstall-WingetApp -AppID "VideoLAN.VLC"
    Exit 0
    
}
catch {
    Write-Host "Unable to uninstall app"
    Write-Host "An error occurred: $_"
    Exit 1
}