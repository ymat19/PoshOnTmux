#!/bin/sh
newUserName="tmux"

# create user and install tmux
adduser --disabled-password --gecos "" tmux
apk add "tmux"

cat <<EOF > /etc/wsl.conf
[user]
default = tmux
EOF

cat <<'EOF' > /home/$newUserName/.profile
# Set path to PowerShell
core_posh_path=$(/mnt/c/Windows/System32/cmd.exe /c "where pwsh" | head -n 1 | tr -d '\r')
legacy_posh_path=$(/mnt/c/Windows/System32/cmd.exe /c "where powershell" | head -n 1 | tr -d '\r')
export POSH_PATH="$(wslpath "${core_posh_path:-$legacy_posh_path}")"


if [[ "$(pwd)" == "$HOME" ]]; then
    cd $($POSH_PATH -c 'Write-Host -NoNewLine \$env:userprofile' | xargs -0 wslpath)
fi

exec tmux new-session -n PowerShell

# not working block: Freezes when trying to attach-session session
# if tmux has-session -t=posh; then
#   exec tmux attach-session -t posh
# else
#   exec tmux new-session -s posh -n PowerShell
# fi
EOF

cat <<'EOF' > /home/$newUserName/.tmux.conf
# essential settings
set -g default-command "exec $POSH_PATH"

# set name of the session
set-window-option -g automatic-rename off
bind c new-window -n "PowerShell"

# Give this tmux a "PowerShell blue" color to differentiate it
set -g status-bg blue

# Use UTF8
set -qg utf8
set-window-option -qg utf8 on

# Use 256 colors
set -g default-terminal "screen-256color"

# mouse scrolling
set -g mouse on
bind-key -T edit-mode-vi WheelUpPane send-keys -X scroll-up
bind-key -T edit-mode-vi WheelDownPane send-keys -X scroll-down
EOF

chown $newUserName /home/$newUserName/.profile
chown $newUserName /home/$newUserName/.tmux.conf
