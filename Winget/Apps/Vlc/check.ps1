. C:\Users\almei\Modern-Workplace\functions.ps1

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
        Exit 1
    }
    else {
        Write-Host "Found it"
        Exit 0
    }
}

Get-WingetApp -AppName Vlc