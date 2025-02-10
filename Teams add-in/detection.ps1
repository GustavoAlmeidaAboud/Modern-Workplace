# Define a function to get the property value of a specific registry path
function GetKeyValue {
    param(
        # Define a parameter to accept the registry path, with a default value set
        [String]$path = "registry::HKCU:\Software\Microsoft\Office\16.0\Outlook\Resiliency\DoNotDisableAddinList"
    )
    Get-ItemProperty -Path $path    
}

# Call the function to get the registry key value and store it in a variable
$keyValue = GetKeyValue

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
