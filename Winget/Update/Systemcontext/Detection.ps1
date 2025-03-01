class Software {
    [string]$Name
    [string]$Id
    [string]$Version
    [string]$AvailableVersion
}

$Winget = Get-ChildItem -Path (Join-Path -Path (Join-Path -Path $env:ProgramFiles -ChildPath "WindowsApps") -ChildPath "Microsoft.DesktopAppInstaller*_x64*\winget.exe")

$upgradeResult = & $Winget upgrade | Out-String

if ($upgradeResult -like "*No installed package found matching input criteria.*") {
    Write-Host "No updates needed"
    Exit 0
}
else {
    Write-Host "Update needed starting remediation script"
    Exit 1
    $lines = $upgradeResult.Split([Environment]::NewLine)


# Find the line that starts with Name, it contains the header

$fl = 0

    while (-not $lines[$fl].StartsWith("Name"))
{
    $fl++
}


# Line $i has the header, we can find char where we find ID and Version
$idStart = $lines[$fl].IndexOf("Id")
$versionStart = $lines[$fl].IndexOf("Version")
$availableStart = $lines[$fl].IndexOf("Available")
$sourceStart = $lines[$fl].IndexOf("Source")

# Now cycle in real package and split accordingly
$upgradeList = @()
For ($i = $fl + 1; $i -le $lines.Length; $i++) 
{
    $line = $lines[$i]
    if ($line.Length -gt ($availableStart + 1) -and -not $line.StartsWith('-'))
    {
        $name = $line.Substring(0, $idStart).TrimEnd()
        $id = $line.Substring($idStart, $versionStart - $idStart).TrimEnd()
        $version = $line.Substring($versionStart, $availableStart - $versionStart).TrimEnd()
        $available = $line.Substring($availableStart, $sourceStart - $availableStart).TrimEnd()
        $software = [Software]::new()
        $software.Name = $name;
        $software.Id = $id;
        $software.Version = $version
        $software.AvailableVersion = $available;

        $upgradeList += $software
    }
}

$AppsExclusion = @(
    "Microsoft.Teams",
    "Google.Chrome",
    "Microsoft.Outlook",
    "Zoom.Zoom",
    "Microsoft.Office",
    "Microsoft.VisualStudioCode",
    "Microsoft.UI.Xaml.2.7",
    "Microsoft.OneDrive",
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

if(($upgradeList.id -eq $null) -or ($upgradeList.id -in $AppsExclusion)){
    Write-host "No update needed"
    Exit 0
}
else {
    Write-Host "Update needed"
    Exit 1
}
}
