# create working directory on TEMP
$workingDir = New-Item -ItemType Directory -Path $env:TEMP\poshOnTmux -Force

# move to working directory
Push-Location -Path $workingDir

# download script from git repo
$shUrl = "https://raw.githubusercontent.com/ymat19/PoshOnTmux/main/setup.sh"
$psUrl = "https://raw.githubusercontent.com/ymat19/PoshOnTmux/main/setup.ps1"
Invoke-WebRequest -Uri $shUrl
Invoke-WebRequest -Uri $psUrl

.\setup.ps1

# cleanup
Pop-Location
Remove-Item -Path $workingDir -Recurse -Force
