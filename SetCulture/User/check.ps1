$evidence = get-culture
if($evidence.Name -eq "fr-lu"){
    Write-Host "Found it"
    Exit 0
}
else {
    Write-host "Not found"
    Exit 1
}