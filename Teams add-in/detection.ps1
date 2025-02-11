# Define a function to get the property value of a specific registry path
function Get-KeyValue {
    param(
        [String]$path = ""
    )
    # Retrieve the properties of the specified registry path
    Get-ItemProperty -Path $path
}
# Example Usage
Get-KeyValue -path "registry::HKCU:\Software\Microsoft\Office\16.0\Outlook\Resiliency\DoNotDisableAddinList"

$addinValue = Get-KeyValue

# Access the specific property value of the registry key
$addinValue = $keyValue.'TeamsAddin.FastConnect'

# Check if the 'TeamsAddin.FastConnect' property value is equal to 1
if ($addinValue -eq 1) {
    Write-Host "Teams addin behaviour is correctly set"
    Exit 0
} else {
    Write-Host "Teams addin behaviour is not correctly set"
    Exit 1
}
