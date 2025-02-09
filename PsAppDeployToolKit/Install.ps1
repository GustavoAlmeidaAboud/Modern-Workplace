# Define the module variable at the beginning
$Module = "PsAppDeployToolKit"

function Logs() {
    $date = get-date -format "dddd-MM-dd-HH"
    $app = "psappdeploytoolkit"
    $method = "Install"
    $logPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\$method $app $date.log"
    Start-Transcript -Path $logPath -Append -Force
}

function Dependencies() {
    if (!(Get-PackageProvider -Name NuGet -ListAvailable -ErrorAction SilentlyContinue)) {
        Install-PackageProvider -Name NuGet -Force
    } else {
        Write-Host "NuGet package provider is already installed." -ForegroundColor Green
    }
}

Logs

# Check whether NuGet package is installed or not
try {
    Write-Host "Checking NuGet dependency..."
    Dependencies  # Call function to ensure NuGet provider is installed
    Write-Host "Attempting to install the '$Module'"
    Install-Module -Name $Module -Force -AllowClobber -Scope AllUsers
    Write-Host "'$Module' has been installed successfully!"
    Exit 0
} catch {
    Write-Host "An error occurred while trying to install the module."
    Write-Host "Error Details: $($_.Exception.Message)"
} finally {
    Stop-Transcript
}
