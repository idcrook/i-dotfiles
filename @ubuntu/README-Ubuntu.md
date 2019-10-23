Install
-------

Installation on fresh ubuntu 18.04 (server)

```shell
sudo apt install -y stow git

git clone --recurse-submodules \
    git@github.com:idcrook/i-dotfiles.git ~/.dotfiles

cd ~/.dotfiles
stow -t ~ stow # bootstrap stow config at top-level

# edit ~/.stowrc for home dir
cp ~/.stowrc ~/.stowrc.hard
vi  ~/.stowrc.hard
mv -i ~/.stowrc.hard  ~/.stowrc

cd @ubuntu
sudo stow -vv --target=/ @Apt

# for emacs26 repo
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt update

<!-- # for eternal terminal - https://eternalterminal.dev/download/git log -p -->
<!-- sudo apt-get install -y software-properties-common -->
<!-- sudo add-apt-repository ppa:jgmath2000/et -->
<!-- sudo apt-get update -->
<!-- sudo apt-get install et -->

cd ~/.dotfiles
stow -vv git

# populate secrets from another host, in another terminal
ssh DONOR_HOST
scp ~/.config/git/config.secrets  TARGET:.dotfiles/git/.config/git/config.secrets
scp ~/.dotfiles/homedir/.ansiweatherrc.secrets  TARGET:.dotfiles/homedir/.ansiweatherrc.secrets
scp ~/.dotfiles/homedir/.wakatime.cfg.secrets TARGET:.dotfiles/homedir/.wakatime.cfg.secrets
exit

# some files will be replaced /taken over in ~
mkdir -p ~/backup
mv ~/{.bash_logout,.bashrc,.profile} ~/backup
( cd ~ && mv .bash_aliases .bash_profile .inputrc .powerline-shell.json .bash_completion.d/ backup/ )
stow -vv bash

stow -vv zsh

mv ~/.pystartup ~/backup/
stow -vv python

( cd ~ && mv .wakatime.cfg .ansiweatherrc .editorconfig .screenrc .tmux.conf ~/backup/ )
stow -vv homedir

mv ~/.emacs.d ~/backup/
stow -vv emacs

stow -vv golang

cd _dpkg
# ...
cd ../_pip
# ...
cd ../_npm
# ...

# login from a new terminal
emacs26 -nw
```

## Remap <kbd>CapsLock</kbd> to <kbd>Control</kbd>

Via  https://unix.stackexchange.com/questions/452391/execute-command-to-swap-caps-lock-and-ctrl-at-startup


```
root@debian:/home/ja# cat /etc/default/keyboard
# KEYBOARD CONFIGURATION FILE

# Consult the keyboard(5) manual page.

XKBMODEL="pc105"
XKBLAYOUT="us"
XKBVARIANT=""
XKBOPTIONS="ctrl:nocaps"

BACKSPACE="guess"
```

Now run this command as described in man 7 keyboard:

```
udevadm trigger --subsystem-match=input --action=change
```
