function Get-WingetPath {
    $winget = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_*__8wekyb3d8bbwe\winget.exe"
    if ($winget.Count -gt 1) {
        $winget = $winget[-1].Path
    } else {
        $winget = $winget.Path
    }
    return $winget
}


function Pin-WingetApp {
    $winget = Get-WingetPath
    param (
        [String]$AppID
    )
    &$winget pin add --id $AppID
    # Example usage
    # Pin-WingetApp -AppID "Valve.Steam"
}


Microsoft Teams: Microsoft.Teams
Google Chrome: Google.Chrome
Microsoft Edge: Microsoft.Edge
Microsoft Outlook: Microsoft.Outlook
Zoom: Zoom.Zoom
Microsoft Office: Microsoft.Office
Visual Studio Code: Microsoft.VisualStudioCode