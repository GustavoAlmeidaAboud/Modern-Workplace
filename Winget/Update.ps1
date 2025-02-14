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


$appsToAvoid = @(
    "Microsoft.Teams",
    "Google.Chrome",
    "Microsoft.Edge",
    "Microsoft.Outlook",
    "Zoom.Zoom",
    "Microsoft.Office",
    "Microsoft.VisualStudioCode",
    "Microsoft.UI.Xaml.2.7",
    "Microsoft.OneDrive"
)

foreach($apptoavoid in $appsToAvoid){
    Pin-WingetApp -AppID $apptoavoid
}


function Update-WingetAppAll {
    $winget = Get-WingetPath
    return &$winget update --All --silent --accept-package-agreements --accept-source-agreements --force
    # Example Usage
    # Update-WingetAppAll
   }