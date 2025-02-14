function Get-WingetPath {
    $winget = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_*__8wekyb3d8bbwe\winget.exe"
    if ($winget.Count -gt 1) {
        $winget = $winget[-1].Path
    } else {
        $winget = $winget.Path
    }
    return $winget
}
function Pin-WingetApp {
    $winget = Get-WingetPath
    param (
        [String]$AppID
    )
    &$winget pin add --id "$AppID"
}
function Update-WingetAppAll {
    $winget = Get-WingetPath
    &$winget update --All --silent --accept-package-agreements --accept-source-agreements --force
}

$AppsExclusion = @(
    "Microsoft.Teams",
    "Google.Chrome",
    "Microsoft.Edge",
    "Microsoft.Outlook",
    "Zoom.Zoom",
    "Microsoft.Office",
    "Microsoft.VisualStudioCode",
    "Microsoft.UI.Xaml.2.7",
    "Microsoft.OneDrive"
    "Microsoft.Teams",
    "Microsoft.Teams.Classic",
    "Tableau.Desktop",
    "Python.Python.3.10",
    "Python.Python.2",
    "Mirantis.Lens",
    "Postman.Postman",
    "Microsoft.VCRedist.2015+.x64",
    "Microsoft.VCRedist.2015+.x86",
    "Adobe.Acrobat.Reader.64-bit",
    "Microsoft.VCRedist.2013.x64",
    "Microsoft.VCRedist.2013.x86",
    "Oracle.JavaRuntimeEnvironment",
    "Oracle.JDK.17",
    "Oracle.JDK.18",
    "Oracle.JDK.19",
    "OpenJS.NodeJS.LTS",
    "OpenJS.NodeJS",
    "OpenJS.NodeJS.Nightly",
    "Microsoft.VCRedist.2015+.x8",
    "Microsoft.VCRedist.2015+.x6",
    "Microsoft.Office",
    "JetBrains.IntelliJIDEA.Community",
    "JetBrains.IntelliJIDEA.Ultimate"
)

foreach($App in $AppsExclusion){
    try {
        Write-Host "Pinning app $App"
        Pin-WingetApp -AppID $App
    }
    catch {
        Write-host "$App is not installed no Pin required"
    }
}