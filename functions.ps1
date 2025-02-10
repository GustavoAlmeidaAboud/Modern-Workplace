## Generate Logs
function Logs() {
    $date = get-date -format "dddd-MM-dd-HH"
    $app = "New Teams"
    $method = "Uninstall"
    $logPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\$method$app$date.log"
    Start-Transcript -Path $logPath -Append -Force
}

## Test nuget Package
function Dependencies {
    if (!(Get-PackageProvider -Name NuGet -ListAvailable -ErrorAction SilentlyContinue)) {
        Install-PackageProvider -Name NuGet -Force
    } else {
        Write-Host "NuGet package provider is already installed." -ForegroundColor Green
    }
}

## Add registry key value
function New-RegistryKeyValue {
    param (
        [string]$Path = "HKCU:\Software\Microsoft\Office\16.0\Outlook\Resiliency\DoNotDisableAddinList",
        [string]$ValueName = "TeamsAddin.FastConnect",
        [int]$Value = '1',
        [string]$Type = "DWORD"
    )
    
    # Create the new registry key and set the DWORD value
    New-ItemProperty -Path $Path -Name $ValueName -Value $Value -PropertyType $Type -Force
}

# Define a function to get the property value of a specific registry path
function GetKeyValue {
    param(
        # Define a parameter to accept the registry path, with a default value set
        [String]$path = "registry::HKCU:\Software\Microsoft\Office\16.0\Outlook\Resiliency\DoNotDisableAddinList"
    )
    # Retrieve the properties of the specified registry path
    Get-ItemProperty -Path $path    
}

function wingetcmd {
    $winget = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_*__8wekyb3d8bbwe\winget.exe"
    if ($winget.Count -gt 1) {
        $winget = $winget[-1].Path
    } else {
        $winget = $winget.Path
    }
    return $winget
}

$winget = wingetcmd