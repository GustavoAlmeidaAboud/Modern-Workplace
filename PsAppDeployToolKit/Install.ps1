function TranscriptVariables() {
    $date = get-date -format "dddd-MM-dd-HH"
    $module = "psappdeploytoolkit"
    $logPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\install_$module_Powershell_Module_$date.log"
    }
    
function Dependencies {
    if (!(Get-PackageProvider -Name NuGet -ListAvailable -ErrorAction SilentlyContinue)) {
        Write-Host "NuGet package provider is not installed. Installing..." -ForegroundColor Yellow
        Install-PackageProvider -Name NuGet -Force
        Write-Host "NuGet package provider installed successfully." -ForegroundColor Green
    } else {
        Write-Host "NuGet package provider is already installed." -ForegroundColor Green
    }

TranscriptVariables

Start-Transcript -Path $logPath -Append

# Check whether Nuget package is installed or not

try {
    Write-Host "Checking NuGet dependency..."
    Dependencies  # Call function to ensure NuGet provider is installed
    Write-Host "Attempting to install the '$module'"
    Install-Module -Name $module -Force -AllowClobber -Scope AllUsers
    Write-Host "'$module' has been installed successfully!"
} catch {
    Write-Host "An error occurred while trying to install the module."
    Write-Host "Error Details: $($_.Exception.Message)"
} finally {
    Stop-Transcript
}
