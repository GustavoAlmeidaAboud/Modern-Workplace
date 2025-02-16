class Software {
    [string]$Name
    [string]$Id
    [string]$Version
    [string]$AvailableVersion
}

$Winget = Get-ChildItem -Path (Join-Path -Path (Join-Path -Path $env:ProgramFiles -ChildPath "WindowsApps") -ChildPath "Microsoft.DesktopAppInstaller*_x64*\winget.exe")

$upgradeResult = & $Winget upgrade | Out-String

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


$upgradeList | Format-Table

$toSkip = @(
"Microsoft.Teams",
"Tableau.Desktop",
"Python.Python.3.10",
"Python.Python.2",
"Mirantis.Lens",
"Postman.Postman",
"Microsoft.VCRedist.2015+.x64",
"Microsoft.VCRedist.2015+.x86",
"Microsoft.VCRedist.2013.x64",
"Microsoft.VCRedist.2013.x86",
"Oracle.JavaRuntimeEnvironment",
"Oracle.JDK.17",
"Oracle.JDK.18",
"Oracle.JDK.19",
"OpenJS.NodeJS.LTS",
"OpenJS.NodeJS",
"OpenJS.NodeJS.Nightly",
"Microsoft.Office")

foreach ($package in $upgradeList) 
{
    if (-not ($toSkip -contains $package.Id)) 
    {
        Write-Host "Going to upgrade package $($package.id)"
        & $winget upgrade $package.id
    }
    else 
    {    
        Write-Host "Skipped upgrade to package $($package.id)"
    }
}