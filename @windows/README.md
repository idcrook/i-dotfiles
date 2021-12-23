# Windows specific setup

## Windows Package Manager

<https://docs.microsoft.com/en-us/windows/package-manager/>

Install `winget-cli` via [App Installer](https://www.microsoft.com/en-us/p/app-installer/9nblggh4nns1) (should  be installed by default in recent Windows builds)

In a Command Prompt or PowerShell session, the CLI app is named `winget`.

```powershell
C:\windows> winget list
```

### Install packages

Start PowerShell, navigate to this directory, and run helper scripts or install manually.

```powershell
PS Microsoft.PowerShell.Core\FileSystem::\\wsl$\Ubuntu\home\dpc> cd .\.dotfiles\@windows\

PS Microsoft.PowerShell.Core\FileSystem::\\wsl$\Ubuntu\home\dpc\.dotfiles\@windows> .\install_basics.bat
...
PS Microsoft.PowerShell.Core\FileSystem::\\wsl$\Ubuntu\home\dpc\.dotfiles\@windows> winget search openscad
Name     Id                Version Source
------------------------------------------
OpenSCAD OpenSCAD.OpenSCAD 2021.01 winget

PS Microsoft.PowerShell.Core\FileSystem::\\wsl$\Ubuntu\home\dpc\.dotfiles\@windows> winget install OpenSCAD.OpenSCAD
Found OpenSCAD [OpenSCAD.OpenSCAD] Version 2021.01
This application is licensed to you by its owner.
Microsoft is not responsible for, nor does it grant any licenses to, third-party packages.
Downloading https://files.openscad.org/OpenSCAD-2021.01-x86-64-Installer.exe
  ██████████████████████████████  20.8 MB / 20.8 MB
Successfully verified installer hash
Starting package install...
Successfully installed
```

### Use PowerShell scripts

We will choose to digitally sign the `.ps1` files... Start PowerShell, navigate to this directory, and **copy and paste interactively** in a PowerShell session:

```powershell
$params = @{
    Subject = 'CN=PowerShell Code Signing Cert'
    Type = 'CodeSigning'
    CertStoreLocation = 'Cert:\CurrentUser\My'
    HashAlgorithm = 'sha256'
}
$cert = New-SelfSignedCertificate @params
```

This creates a self-signed certificate that can be used for signing PS1 files to run them as scripts.  

Next, we will sign a helper script (`add-signature.ps1`) that will help to sign additional scripts as needed. (also run interactively)

```powershell
$cert = @(Get-ChildItem cert:\CurrentUser\My -codesigning)[0]
Set-AuthenticodeSignature Add-Signature.ps1 $cert
```


## Windows Configuration

### Use power toys for <kbd>CapsLock</kbd> -> <kbd>Ctrl</kbd> remapping

`Keyboard Manager > Keys: Remap a Key`

Enable `Keyboard Manager`. Start `PowerToys` at Windows Startup

### Use `espanso` for text exapnding capabilities

See [espanso](../espanso/README.md#windows)