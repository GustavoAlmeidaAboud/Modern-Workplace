$AppName = "MongoDB"
$method = "Install"
$date = get-date -format "dddd-MM-dd-HH"
$logPath = "$env:localappdata\winget\logs\$method-$AppName-$date.log"
New-Item -Path $logPath -ItemType File -Force
icacls $logPath /grant Everyone:F

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
        
    $Winget = Get-WingetPath
    &$Winget install --id $AppID --silent --force --accept-source-agreements --accept-package-agreements --scope Machine -o $logpath
    # Example usage
    # install-WingetApp -AppID "VideoLAN.VLC"
}

Install-WingetApp -AppID "MongoDB.server"