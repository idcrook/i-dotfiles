# Windows specific setup

## Windows Package Manager

<https://docs.microsoft.com/en-us/windows/package-manager/>

Install `winget-cli` via [App Installer](https://www.microsoft.com/en-us/p/app-installer/9nblggh4nns1) (should  be installed by default in recent Windows builds)

In a Command Prompt or PowerShell session, the CLI app is named `winget`.

```powershell
C:\windows> winget list
```

### Install packages

Start PowerShell, navigate to this directory, and run the helper scripts.

```powershell
PS Microsoft.PowerShell.Core\FileSystem::\\wsl$\Ubuntu\home\dpc> cd .\.dotfiles\@windows\

PS Microsoft.PowerShell.Core\FileSystem::\\wsl$\Ubuntu\home\dpc\.dotfiles\@windows> .\install_basics.bat
```

## Windows Configuration

### Use power toys for <kbd>CapsLock</kbd> -> <kbd>Ctrl</kbd> remapping

`Keyboard Manager > Keys: Remap a Key`

Enable `Keyboard Manager`. Start `PowerToys` at Windows Startup

### Use `espanso` for text exapnding capabilities

See [espanso](../espanso/README.md#windows)