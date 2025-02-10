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
    New-RegistryKeyValue
    Exit 0
}
catch {
    Write-Host "Key couldn't be added: $($_.Exception.Message)"
}
finally {
    Stop-Transcript
}