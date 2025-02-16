# Run the winget command and capture the output
$wingetOutput = winget list --scope user

# Parse the output and convert it into objects
$wingetUpdateUserContext = $wingetOutput | ForEach-Object {
    # Split the line by two or more spaces
    $line = $_.Trim() -split '\s{2,}'
    
    # Only process lines with at least 5 elements
    if ($line.Count -ge 5) {
        [PSCustomObject]@{
            Name      = $line[0]
            Id        = $line[1]
            Version   = $line[2]
            Available = $line[3]
            Source    = $line[4]
        }
    }
}

# Display the output as objects
$wingetUpdateUserContext

function Update-WingetAppAllUser{
    $AppName = "WingetApps"
    $method = "Update"
    $date = get-date -format "dddd-MM-dd-HH"
    $logPath = "$env:localappdata\winget\logs\$method-$AppName-$date.log"
    New-Item -Path $logPath -ItemType File -Force
    icacls $logPath /grant Everyone:F
    foreach($app in $wingetUpdateUserContext){
        winget update --id $app.Id --silent --accept-package-agreements --accept-source-agreements --force --include-unknown  --disable-interactivity --uninstall-previous --log $logPath --scope user
    }
}

try {
    Write-Host "Updating all winget apps"
    Update-WingetAppAllUser
}
catch {
    Write-Host "An potential issue occured $_"
}