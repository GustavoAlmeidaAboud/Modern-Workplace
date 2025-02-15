function Get-WingetPath {
    # Resolves the path to the winget executable
    $winget = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_*__8wekyb3d8bbwe\winget.exe"
    
    # If multiple paths are found, use the latest one
    if ($winget.Count -gt 1) {
        $winget = $winget[-1].Path
    } else {
        # Otherwise, use the single path found
        $winget = $winget.Path
    }
    
    # Return the resolved path
    return $winget
}

function Pin-WingetApp {
    # Get the path to the winget executable
    $winget = Get-WingetPath
    
    param (
        # Parameter for the AppID to pin
        [String]$AppID
    )
    
    # Use winget to pin the specified app
    &$winget pin add --id "$AppID"
}

$AppsExclusion = @(
    "Microsoft.Teams",
    "Google.Chrome",
    "Microsoft.Edge",
    "Microsoft.Outlook",
    "Zoom.Zoom",
    "Microsoft.Office",
    "Microsoft.VisualStudioCode",
    "Microsoft.UI.Xaml.2.7",
    "Microsoft.OneDrive",
    "Microsoft.Teams",
    "Microsoft.Teams.Classic",
    "Tableau.Desktop",
    "Python.Python.3.10",
    "Python.Python.2",
    "Mirantis.Lens",
    "Postman.Postman",
    "Microsoft.VCRedist.2015+.x64",
    "Microsoft.VCRedist.2015+.x86",
    "Adobe.Acrobat.Reader.64-bit",
    "Microsoft.VCRedist.2013.x64",
    "Microsoft.VCRedist.2013.x86",
    "Oracle.JavaRuntimeEnvironment",
    "Oracle.JDK.17",
    "Oracle.JDK.18",
    "Oracle.JDK.19",
    "OpenJS.NodeJS.LTS",
    "OpenJS.NodeJS",
    "OpenJS.NodeJS.Nightly",
    "Microsoft.VCRedist.2015+.x8",
    "Microsoft.VCRedist.2015+.x6",
    "Microsoft.Office",
    "JetBrains.IntelliJIDEA.Community",
    "JetBrains.IntelliJIDEA.Ultimate"
)


# List of applications to exclude from pinning or updating

foreach($App in $AppsExclusion) {
    try {
        # Attempt to pin each application
        Write-Host "Pinning app $App"
        Pin-WingetApp -AppID $App
    }
    catch {
        # If pinning fails, log that the app is not installed
        Write-host "$App is not installed no Pin required"
        # Write-Host "$_"
    }
}


function Update-WingetAppAll {
    # Get the path to the winget executable
    $winget = Get-WingetPath
    
    # Use winget to update all apps silently and forcefully
    &$winget update --All --silent --accept-package-agreements --accept-source-agreements --force --include-unknown
}

try {
    # Attempt to update all winget applications
    Write-Host "Updating Winget Applications"
    Update-WingetAppAll
    Exit 0
}
catch {
    # If updating fails, log the error message
    Write-Host "$_"
}
