Install
-------

Installation on fresh Ubuntu 20.04 LTS in WSL2

## Pre-reqs

Install on Windows 10

- WSL 2 [Install Guide](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
- from Windows Store: [Ubuntu 20.04 LTS](https://www.microsoft.com/store/apps/9n6svws3rx71)
- nice to have: [Visual Studio Code](https://code.visualstudio.com/)

```shell
sudo apt install -y stow git openssh-server

# use to regenerate host keys
sudo dpkg-reconfigure openssh-server

# this requires SSH key on git account
git clone --recurse-submodules \
    https://github.com/idcrook/i-dotfiles.git ~/.dotfiles

cd ~/.dotfiles
stow -t ~ stow # bootstrap stow config at top-level

# edit ~/.stowrc for home dir
cp ~/.stowrc ~/.stowrc.hard
vi  ~/.stowrc.hard
mv -i ~/.stowrc.hard  ~/.stowrc

cd @linux
sudo stow -vv --target=/ @Apt

# for emacs27 repo
sudo add-apt-repository ppa:kelleyk/emacs
## for emacs snapshot
#sudo add-apt-repository ppa:ubuntu-elisp/ppa

sudo apt update # may be implicit

# some files will be replaced /taken over in ~
mkdir -p ~/backup

cd ~/.dotfiles
mv ~/.gitignore_global ~/backup
mv ~/.git/ ~/backup/
stow -vv git

stow -vv shell

# populate secrets from another host, in another terminal
# incoming SSH from external network is problematic at this time; do manually
TARGET=donor.local
scp $TARGET:.config/git/config.secrets               ./git/.config/git/config.secrets
scp $TARGET:.dotfiles/homedir/.ansiweatherrc.secrets ./homedir/.ansiweatherrc.secrets
scp $TARGET:.dotfiles/homedir/.wakatime.cfg.secrets  ./homedir/.wakatime.cfg.secrets
scp $TARGET:.config/espanso/user/personal.secrets.yml \
  ./espanso/.config/espanso/user/personal.secrets.yml

mv ~/{.bash_logout,.bashrc,.profile} ~/backup
( cd ~ && mv .bash_aliases .bash_profile .inputrc .powerline-shell.json .bash_completion.d/ backup/ )
stow -vv bash

stow -vv zsh

mv ~/.pystartup ~/backup/
stow -vv python

( cd ~ && mv .wakatime.cfg .ansiweatherrc .editorconfig .screenrc .tmux.conf bin/ ~/backup/ )
stow -vv homedir

mv ~/.emacs.d ~/backup/
stow -vv emacs

stow -vv golang

stow -vv espanso
# see README for how to install on Windows

cd _dpkg
# ...
cd ../_pip
# ...
cd ../_npm
# ...

# login from a new terminal
cd ~/.dotfiles/golang
cat README.md
# ...

# login from a new terminal
emacs-snapshot -nw
```
<!--
## Installing powerline fonts on Windows

```
mkdir -p ~/projects/powerline
cd  ~/projects/powerline
git clone https://github.com/powerline/fonts.git
cd fonts
explorer.exe .
# right-click on `install.ps1` and select Run in Powershell
```
 -->

## Install Windows Terminal

See Microsoft Windows Terminal [Get Started](https://docs.microsoft.com/en-us/windows/terminal/get-started)

Windows Terminal Installed now includes the Cascadia Code fonts

### Configure

- Change Ubuntu to default

```diff
-  "defaultProfile": "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}",
+  //"defaultProfile": "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}",
+   "defaultProfile": "{07b52e3e-de2c-5db4-bd2d-ba144ed6c273}",
```

- Change Default Font and Color Scheme

```diff
 "defaults":
         {
             // Put settings here that you want to apply to all profiles.
+            "fontFace" : "Cascadia Mono PL",
+            "fontSize" : 14,
+            "colorScheme": "Solarized Dark"
         },
```

- Change WSL starting directory to Linux home (Uses Windows User directory by default)

```json
"startingDirectory" : "//wsl$/Ubuntu-20.04/home/<Your Ubuntu Username>",
```

Many other [settings](https://github.com/microsoft/terminal/blob/master/doc/user-docs/UsingJsonSettings.md?WT.mc_id=-blog-scottha#profiles)!


### Installing Cascadia Code on Windows

The latest releases include Powerline embeds (trailing "PL" in name)

Download from https://github.com/microsoft/cascadia-code/releases

Unzip, right-click on each in `ttf` sub-directory and Install.
