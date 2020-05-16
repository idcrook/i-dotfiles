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

<!-- #### macOS -->

<!-- ```shell -->

<!-- cd ~/Library/Preferences -->

<!-- rm espanso -->

<!-- ln -s ~/.config/espanso . -->

<!-- ``` -->

#### Ubuntu / Debian Linux

```shell
wget https://github.com/federico-terzi/espanso/releases/latest/download/espanso-debian-amd64.deb
sudo apt install ./espanso-debian-amd64.deb
espanso start
```

#### macOS

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
