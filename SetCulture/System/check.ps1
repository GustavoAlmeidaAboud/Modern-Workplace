$evidence = get-winuserlanguagelist
if($evidence.LanguageTag -eq "fr-lu"){
    Write-Host "Found it"
}
else {
    Write-host "Not found"
}