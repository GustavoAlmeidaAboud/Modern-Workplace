function Get-WingetPath {
    $winget = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_*__8wekyb3d8bbwe\winget.exe"
    if ($winget.Count -gt 1) {
        $winget = $winget[-1].Path
    } else {
        $winget = $winget.Path
    }
    return $winget
}

function Get-UpdateWingetAppAll {
    # Get the path to the winget executable
    $winget = Get-WingetPath
    
    # Use winget to update all apps silently and forcefully
    $evidence = &{
        &$winget update --All --silent --accept-package-agreements --accept-source-agreements --force --include-unknown --scope machine
    }
    if($evidence -contains "No installed package found matching input criteria."){
        Write-Host "No updates required"
        Exit 0
    }
    else{
        Write-host "Updates required"
        Exit 1
    }
}

Get-UpdateWingetAppAll
