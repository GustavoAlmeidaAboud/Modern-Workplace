$command = Get-AppxPackage -AllUsers| Where-Object PackageFullName -like '*MSTeams*'

if ($command) {
    Write-Host "Found it!"
     exit 0
} else {
    Write-Host "Not found!"
     exit 1
}