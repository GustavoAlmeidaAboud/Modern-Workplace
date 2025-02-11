## Generate Logs
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
#:Start-Logs -AppName "Git" -Method "Uninstall"

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
# Example Usage
#:New-RegistryKeyValue -Path "" -ValueName "" -Value "" -Type ""


# Define a function to get the property value of a specific registry path
function Get-KeyValue {
    param(
        [String]$path = ""
    )
    # Retrieve the properties of the specified registry path
    Get-ItemProperty -Path $path    
}
# Example Usage
#:Get-KeyValue -path "registry::HKCU:\Software\Microsoft\Office\16.0\Outlook\Resiliency\DoNotDisableAddinList"

function Get-WingetPath {
    $winget = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_*__8wekyb3d8bbwe\winget.exe"
    if ($winget.Count -gt 1) {
        $winget = $winget[-1].Path
    } else {
        $winget = $winget.Path
    }
    return $winget
}

function Get-WingetApp {
    param(
        [string]$AppName = "firefox"
    )
    # Get the winget executable path
    $Winget = Get-WingetPath
    # Execute the winget command and store the result
    $Evidence = & $Winget list $AppName
    
    # Check if the app is found
    if ($Evidence -contains "No installed package found matching input criteria.") {
        Write-Host "Not found"
        Exit 1
    }
    else {
        Write-Host "Found it"
        Exit 0
    }
}

function Uninstall-WingetApp {
    param(
        [string]$AppID = ""
    )
    # Get the winget executable path
    $Winget = Get-WingetPath
    # Execute the winget command and store the result
    &$Winget uninstall --id $AppID -All -h- --force --accept-source-agreements
}

# Example usage
## Uninstall-WingetApp -AppID "Vlc"


function install-WingetApp {
    param(
        [string]$AppID = ""
    )
    # Get the winget executable path
    $Winget = Get-WingetPath
    # Execute the winget command and store the result
    &$Winget install --id $AppID -All -h- --force --accept-source-agreements --accept-package-agreements
}

# Example usage
## install-WingetApp -AppID "VideoLAN.VLC"
