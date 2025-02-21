function Get-WingetPath {
    $winget = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_*__8wekyb3d8bbwe\winget.exe"
    if ($winget.Count -gt 1) {
        $winget = $winget[-1].Path
    } else {
        $winget = $winget.Path
    }
    return $winget
}

function Get-WingetApp {
    param(
        [string]$AppName
    )
    # Get the winget executable path
    $Winget = Get-WingetPath
    # Execute the winget command and store the result
    $Evidence = & $Winget list $AppName
    
    # Check if the app is found
    if ($Evidence -contains "No installed package found matching input criteria.") {
        Write-Host "Not found"
    }
    else {
        Write-Host "Found it"
    }
}

Get-WingetApp -AppName "MongoDB.server"