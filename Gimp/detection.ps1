$date = Get-Date -Format "dddd-MM-dd-HH"
$logPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\listadtapplication_$date.txt"
$app = "Gimp"
$AppEvidence = Get-ADTApplication -name $app

if($AppEvidence){
    Write-Host "Application will be uninstalled"
    Exit 1
}
Else{
    Write-Host "Application not found"
    Exit 0
}