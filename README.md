# Tool for Integrating PowerShell and tmux on Windows

This setup script enables you to use **tmux keybindings for pane operations** in a Windows environment. By running tmux from WSL (Windows Subsystem for Linux), you can control PowerShell using tmux, providing a consistent terminal experience across Windows and macOS.

## Features

- **Installs Alpine Linux on WSL** and runs tmux within it
- **Launches the host PowerShell inside tmux**, allowing for pane splitting and keybinding operations
- **Shares tmux configuration files between macOS and Windows** for a unified setup

## Limitations

- **No session persistence**
  - Sessions reset when the terminal is closed or the system is restarted
  - Attaching to an existing PowerShell session may cause it to become unresponsive

## Installation

Run the following command to install:

```powershell
powershell -ExecutionPolicy Bypass -c "iwr https://raw.githubusercontent.com/ymat19/PoshOnTmux/main/install.ps1 -UseBasicParsing | iex"
```

## Usage

After installation, start tmux and PowerShell with:

```powershell
wsl -d PoshOnTmux
```

## Configuration Files

Configuration files are located at:

```
\\wsl$\PoshOnTmux\home\tmux\.tmux.conf
```

## Uninstallation

To uninstall, run:

```powershell
wsl --unregister -d PoshOnTmux
```

## Reference

- [SuperUser Reference Article](https://superuser.com/a/1643117)

## License

MIT License
