# starting message
Write-Host "Installing PoshOnTmux..."

# create working directory on TEMP
$workingDir = New-Item -ItemType Directory -Path $env:TEMP\PoshOnTmux -Force

# move to working directory
Push-Location -Path $workingDir

# download script from git repo
$shUrl = "https://raw.githubusercontent.com/ymat19/PoshOnTmux/main/setup.sh"
$psUrl = "https://raw.githubusercontent.com/ymat19/PoshOnTmux/main/setup.ps1"
Invoke-WebRequest -Uri $shUrl -OutFile "setup.sh"
Invoke-WebRequest -Uri $psUrl -OutFile "setup.ps1"

. .\setup.ps1

# cleanup
Pop-Location
Remove-Item -Path $workingDir -Recurse -Force
