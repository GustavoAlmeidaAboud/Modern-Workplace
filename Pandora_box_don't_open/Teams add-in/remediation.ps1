function Start-Logs() {
    param(
        [string]$AppName = "",
        [string]$Method = ""
    )
    $date = get-date -format "dddd-MM-dd-HH"
    $logPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\$method-$AppName-$date.log"
    Start-Transcript -Path $logPath -Append -Force
}
# Example usage
Start-Logs -AppName "TeamsAddin" -Method "Change"

function New-RegistryKeyValue {
    param (
        [string]$Path = "HKCU:\Software\Microsoft\Office\16.0\Outlook\Resiliency\DoNotDisableAddinList",
        [string]$ValueName = "TeamsAddin.FastConnect",
        [int]$Value = 1,
        [string]$Type = "DWORD"
    )
    
    # Create the new registry key and set the DWORD value
    New-ItemProperty -Path $Path -Name $ValueName -Value $Value -PropertyType $Type -Force
}

## Calling functions
try {
    New-RegistryKeyValue -Path "" -ValueName "" -Value "" -Type ""
    Exit 0
}
catch {
    Write-Host "Key couldn't be added: $($_.Exception.Message)"
}
finally {
    Stop-Transcript
}