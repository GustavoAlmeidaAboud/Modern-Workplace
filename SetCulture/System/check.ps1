$evidence = get-winuserlanguagelist
if($evidence.LanguageTag -eq "fr-lu"){
    Write-Host "Found it"
    Exit 0
}
else {
    Write-host "Not found"
}