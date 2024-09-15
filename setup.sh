#!/bin/sh
newUserName="tmux"

adduser --disabled-password --gecos "" tmux
apk add "tmux"
cat <<EOF > /etc/wsl.conf
[user]
default = tmux
EOF

cat <<'EOF' > /home/$newUserName/.profile
core_posh_path=$(/mnt/c/Windows/System32/cmd.exe /c "where pwsh" | tr -d '\r')
legacy_posh_path=$(/mnt/c/Windows/System32/cmd.exe /c "where powershell" | tr -d '\r')
export POSH_PATH="$(wslpath ${core_posh_path:-$legacy_posh_path})"
if tmux has-session -t=posh; then
  exec tmux attach-session -t posh
else
  exec tmux new-session -s posh -n PowerShell
fi
EOF

chown $newUserName /home/$newUserName/.profile

cat <<'EOF' > /home/$newUserName/.tmux.conf
set -g default-command "cd $($POSH_PATH -c 'Write-Host -NoNewLine \$env:userprofile' | xargs -0 wslpath); exec $POSH_PATH"
set-window-option -g automatic-rename off
bind c new-window -n "PowerShell"

# Give this tmux a "PowerShell blue" color to differentiate it
set -g status-bg blue

# Use UTF8
set -qg utf8
set-window-option -qg utf8 on

set -g default-terminal "screen-256color"
EOF

chown $newUserName /home/$newUserName/.tmux.conf
