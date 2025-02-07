function TranscriptVariables{
    $date = get-date -format "dddd-MM-dd-HH"
    $module = "psappdeploytoolkit"
    $logPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\uninstall_$module_Powershell_Module_$date.log"
}

TranscriptVariables

Start-Transcript -Path $logPath -Append

try {
    Write-Host "Attempting to uninstall the Module '$module'"
    uninstall-Module -Name $module -Force -AllowClobber -Scope -AllVersions
    Write-Host "'$module' has been installed successfully!"
} catch {
    Write-Host "An error occurred while trying to uninstall the module."
    Write-Host "Error Details: $($_.Exception.Message)"
} finally {
    Stop-Transcript
}