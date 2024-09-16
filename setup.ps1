$tarFileUrl = "https://dl-cdn.alpinelinux.org/alpine/v3.20/releases/x86_64/alpine-minirootfs-3.20.3-x86_64.tar.gz"
$tarFilePath = "alpineFs.tar.gz"
$instanceName = "PoshOnTmux"
$installDir = "$env:USERPROFILE\tmuxOnPosh"
$tmuxConfigPath="\\wsl$\poshOnTmux\home\tmux\.tmux.conf"

Invoke-WebRequest -Uri $tarFileUrl -OutFile $tarFilePath

wsl --import $instanceName $installDir $tarFilePath --version 1
wsl -d $instanceName $(wsl wslpath "'$(Get-Location)\setup.sh'")
wsl --shutdown -d $instanceName

Write-Host "Installation complete. Run 'wsl -d $instanceName' to start Alpine Linux."
Write-Host "tmux config: $tmuxConfigPath"
