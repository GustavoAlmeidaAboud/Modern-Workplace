# Define the registry paths
$registryPaths = Get-ItemProperty "HKCU:\Software\Microsoft\Office\16.0\Outlook\Resiliency\DoNotDisableAddinList"
$addinValue = $registryPaths.'TeamsAddin.FastConnect'

if ($addinValue -eq 1) {
    Write-Host "Teams addin behaviour is correctly set"
    Exit 0
} else {
    Write-Host "Teams addin behaviour is not correctly set"
    Exit 1
}