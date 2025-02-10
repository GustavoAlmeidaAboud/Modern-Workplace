# Define the registry path
$registryPath = "HKCU:\Software\Microsoft\Office\16.0\Outlook\Resiliency\DoNotDisableAddinList"

# Define the name and value of the DWORD
$dwordName = "TeamsAddin.FastConnect"
$dwordValue = 1

# Create the registry key if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force
}

# Set the DWORD value
New-ItemProperty -Path $registryPath -Name $dwordName -Value $dwordValue -PropertyType DWORD -Force

Write-Output "Registry key and value created successfully."

exit 0