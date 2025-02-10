function Logs() {
    $date = get-date -format "dddd-MM-dd-HH"
    $app = "Gimp"
    $method = "Uninstall"
    $logPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\$method $app $date.log"
    Start-Transcript -Path $logPath -Append -Force
}

Logs
winget uninstall --id "GIMP.GIMP" --silent --force --purge --disable-interactivity

stop-transcript
Exit 0