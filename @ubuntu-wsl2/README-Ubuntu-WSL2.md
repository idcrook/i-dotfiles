Install
-------

Installation on fresh Ubuntu 20.04 LTS in WSL2

```shell
sudo apt install -y stow git openssh-server

# use to regenerate host keys
sudo dpkg-reconfigure openssh-server

# this requires SSH key on git account
git clone --recurse-submodules \
    git@github.com:idcrook/i-dotfiles.git ~/.dotfiles

cd ~/.dotfiles
stow -t ~ stow # bootstrap stow config at top-level

# edit ~/.stowrc for home dir
cp ~/.stowrc ~/.stowrc.hard
vi  ~/.stowrc.hard
mv -i ~/.stowrc.hard  ~/.stowrc

cd @ubuntu-wsl2
sudo stow -vv --target=/ @Apt

# for emacs26 repo
#sudo add-apt-repository ppa:kelleyk/emacs
# for emacs snapshot
sudo add-apt-repository ppa:ubuntu-elisp/ppa

sudo apt update # may be implicit

# some files will be replaced /taken over in ~
mkdir -p ~/backup

cd ~/.dotfiles
mv ~/.gitignore_global ~/backup
mv ~/.git/ ~/backup/
stow -vv git

# populate secrets from another host, in another terminal
# incoming SSH from external network is problematic at this time; do manually
TARGET=donor.local
scp $TARGET:.config/git/config.secrets               ./git/.config/git/config.secrets
scp $TARGET:.dotfiles/homedir/.ansiweatherrc.secrets ./homedir/.ansiweatherrc.secrets
scp $TARGET:.dotfiles/homedir/.wakatime.cfg.secrets  ./homedir/.wakatime.cfg.secrets
scp $TARGET:.dotfiles/homedir/.wakatime.cfg.secrets  ./homedir/.wakatime.cfg.secrets
scp $TARGET:.dotfiles/espanso/user/personal.secrets.yml ./espanso/user/personal.secrets.yml
scp $TARGET:.config/espanso/user/personal.secrets.yml \
  ./espanso/.config/espanso/user/personal.secrets.yml

mv ~/{.bash_logout,.bashrc,.profile} ~/backup
( cd ~ && mv .bash_aliases .bash_profile .inputrc .powerline-shell.json .bash_completion.d/ backup/ )
stow -vv bash

stow -vv zsh

mv ~/.pystartup ~/backup/
stow -vv python

( Cd ~ && mv .wakatime.cfg .ansiweatherrc .editorconfig .screenrc .tmux.conf bin/ ~/backup/ )
stow -vv homedir

mv ~/.emacs.d ~/backup/
stow -vv emacs

stow -vv golang

stow -vv espanso

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

## Installing powerline fonts on Windows

```
mkdir -p ~/projects/powerline
cd  ~/projects/powerline
git clone https://github.com/powerline/fonts.git
cd fonts
explorer.exe .
# right-click on `install.ps1` and select Run in Powershell
```

## Installing Cascadia Code on Windows

The latest releases include Powerline embeds (trailing "PL" in name)

Download from https://github.com/microsoft/cascadia-code/releases

Unzip, right-click on each in `ttf` sub-directory and Install.
