$evidence = get-module -name "psappdeploytoolkit" -ListAvailable

if($evidence){
    Write-host "Found it"
    Exit 0
}
else {
    Exit 1
}