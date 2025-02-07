$evidence = get-module -name "psappdeploytoolkit" -ListAvailable
$date = get-date -format "dddd-mm-dd-hh"
$app = get-adtapplication -name "Gimp"
$appuninstall = $app.UninstallString
$logPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\uninstallapplication$AppName_$date.txt"

start-process -FilePath $appuninstall -argumentlist /VERYSILENT
Exit 0