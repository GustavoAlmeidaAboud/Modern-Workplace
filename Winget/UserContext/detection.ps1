function Get-WingetUpdateAppAllUser {
    # Capture the output of the winget command
    $evidence = & {
        winget update --All --silent --accept-package-agreements --accept-source-agreements --force --scope User --include-unknown -o
    }
    
    # Check the output for the specific string indicating no updates are needed
    if ($evidence -contains "No installed package found matching input criteria.") {
        Write-Host "No apps need to be updated"
        Exit 0
    } else {
        Write-Host "Application requires update"
        Exit 1
    }
}

# Execute the function
Get-WingetUpdateAppAllUser
