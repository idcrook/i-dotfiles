[`espanso`](https://espanso.org/)
---------------------------------

```
└── .config
    └── espanso
        ├── default.yml
        └── user
            ├── datetime.yml
            ├── kubernetes.yml
            └── etc.
```

### customize secrets

```shell
cp .config/espanso/user/personal.secrets.yml.example \
   .config/espanso/user/personal.secrets.yml
espanso restart
```

### espanso Install notes

See https://espanso.org/install/ for more

-	macOS config path: `$HOME/.config/espanso` works
	-	default is `$HOME/Library/Preferences/espanso`
-	Linux config path: `$HOME/.config/espanso`

To see where `espanso` configuration folder is:

```
espanso path
```

See below for additional steps for Windows 10/WSL 2

#### Ubuntu / Debian Linux

https://espanso.org/install/linux/

snap now recommended

```shell
sudo snap install espanso --classic
sudo apt install xclip libnotify-bin
```

Important: if you are upgrading espanso, after the previous command, execute `espanso unregister` in the terminal.

##### DEB package

```shell
wget https://github.com/federico-terzi/espanso/releases/latest/download/espanso-debian-amd64.deb
sudo apt install ./espanso-debian-amd64.deb
```

### Now launch

```shell
espanso start
```

### macOS

```shell
# open its tap
brew tap federico-terzi/espanso

# install
brew install espanso

# To make sure that espanso was correctly installed, you can open a terminal and type:
espanso --version
```

On macOS, will also need to enable system accessibility access.

##### Enabling Accessibility

https://espanso.org/install/mac/#enabling-accessibility

```shell
# initiate with
espanso register

# now traverse System Preferences to enable Accessibility for espanso
# > > >

# now after the following command, should see espanso icon appear in the status bar
espanso start
```

#### Windows

This should work for Windows 10 and Windows 11

**Destination**

```bat
# in a windows cmd prompt
explorer %HOMEDRIVE%%HOMEPATH%\AppData\Roaming\espanso
```

**Source**

now, in a WSL 2

```shell
cd ~/.dotfiles/espanso/.config/espanso/
xdg-open .
```

Alternatively, in Windows explorer, a path like:

```
\\wsl.localhost\Ubuntu\home\dpc\.dotfiles\espanso\.config\espanso
```

Now drag the files from the WSL 2 location (`default.yml` and `user/`) in explorer.exe to the Windows location.

You should see the "Espanso Reload" Windows notification appear a few times as it observes the file changes.
