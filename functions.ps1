# Generate Logs
function Start-Logs() {
    param(
        [string]$AppName = "",
        [string]$Method = ""
    )
    $date = get-date -format "dddd-MM-dd-HH"
    $logPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\$method-$AppName-$date.log"
    Start-Transcript -Path $logPath -Append -Force
    # Example Usage
    # Start-Logs -AppName "Git" -Method "Uninstall"
}

#### Registry

# Add registry key value
function New-RegistryKeyValue {
    param (
        [string]$Path = "HKCU:\Software\Microsoft\Office\16.0\Outlook\Resiliency\DoNotDisableAddinList",
        [string]$ValueName = "TeamsAddin.FastConnect",
        [int]$Value = '1',
        [string]$Type = "DWORD"
    )

    New-ItemProperty -Path $Path -Name $ValueName -Value $Value -PropertyType $Type -Force
    # Example Usage
    # New-RegistryKeyValue -Path "" -ValueName "" -Value "" -Type ""
}

# Define a function to get the property value of a specific registry path
function Get-KeyValue {
    param(
        [String]$path
    )
    # Retrieve the properties of the specified registry path
    Get-ItemProperty -Path $path    
    # Example Usage
    # Get-KeyValue -path "registry::HKCU:\Software\Microsoft\Office\16.0\Outlook\Resiliency\DoNotDisableAddinList"

}

### Winget SystemContext

function Get-WingetPath {
    $winget = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_*__8wekyb3d8bbwe\winget.exe"
    if ($winget.Count -gt 1) {
        $winget = $winget[-1].Path
    } else {
        $winget = $winget.Path
    }
    return $winget
}

function Detect-WingetApp {
    $Winget = Get-WingetPath
    param(
        [string]$AppName
    )
    # Execute the winget command and store the result
    $Evidence = &$Winget list $AppName
    
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
    &$Winget uninstall --id $AppID -All --silent --force --accept-source-agreements --scope Machine
    # Example Usage
    # Uninstall-WingetApp -AppID "Mozilla.Firefox"
}

function Install-WingetApp {
    $Winget = Get-WingetPath
    param(
        [string]$AppID
    )
    &$Winget install --id $AppID -All --silent --force --accept-source-agreements --accept-package-agreements --scope Machine
    # Example usage
    # install-WingetApp -AppID "VideoLAN.VLC"
}

function Pin-WingetApp {
    param (
        [String]$AppID
    )
    $winget = Get-WingetPath
    &$winget pin add --id $AppID
    # Example usage
    # Pin-WingetApp -AppID "Valve.Steam"
}

function UnPin-WingetApp {
    param (
        [String]$AppID
    )
    $winget = Get-WingetPath
    &$winget pin remove --id $AppID
    # Example usage
    # Pin-WingetApp -AppID "Valve.Steam"
}

function Update-WingetAppAll {
 $winget = Get-WingetPath
 return &$winget update --All --silent --accept-package-agreements --accept-source-agreements --force --scope machine
 # Example Usage
 # Update-WingetAppAll
}

function Update-WingetApp {
    param(
        [string]$AppID
    )
    $winget = Get-WingetPath
    &$winget update --id $AppID --silent --accept-package-agreements --accept-source-agreements --force --scope machine
    # Example Usage
    # Update-WingetApp -AppID ""
}

### Winget User Context

function Get-WingetUpdateAppAllUser{
    $evidence = return winget update --All --silent --accept-package-agreements --accept-source-agreements --force --scope User --include-unknown
    if($evidence -contains "No installed package found matching input criteria."){
        Write-Host "No apps need to be update"
        #Exit 0
    }
    else {
        Write-Host "Application requires update"
        #Exit 1
    }
}

function Update-WingetAppAllUser{
    return winget update --All --silent --accept-package-agreements --accept-source-agreements --force --scope User --include-unknown
}