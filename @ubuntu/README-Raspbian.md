Install
-------

Installation on Raspbian Buster (c. 07/2019)

```shell
sudo apt install -y stow git

# requires SSH public key to be installed in github account
git clone --recurse-submodules \
    https://github.com/idcrook/i-dotfiles.git ~/.dotfiles

cd ~/.dotfiles
stow -t ~ stow # bootstrap stow config at top-level

# edit ~/.stowrc for home dir
cp ~/.stowrc ~/.stowrc.hard
vi  ~/.stowrc.hard
mv -i ~/.stowrc.hard  ~/.stowrc

cd @ubuntu
sudo stow -vv --target=/ @Apt

cd ~/.dotfiles
stow git

# populate secrets from another host, in another terminal
ssh DONOR_HOST

export TARGET=pi@raspberrypi.local
scp ~/.config/git/config.secrets  $TARGET:.dotfiles/git/.config/git/config.secrets
scp ~/.dotfiles/homedir/.ansiweatherrc.secrets  $TARGET:.dotfiles/homedir/.ansiweatherrc.secrets
scp ~/.dotfiles/homedir/.wakatime.cfg.secrets $TARGET:.dotfiles/homedir/.wakatime.cfg.secrets
exit

# some files will be replaced /taken over in ~
mkdir -p ~/backup
mv ~/{.bash_logout,.bashrc,.profile} ~/backup
( cd ~ && mv .bash_aliases .bash_profile .inputrc .powerline-shell.json .bash_completion.d/ backup/ )
mkdir -p ~/.local/{bin,lib}
stow -vv bash

mv ~/.pystartup ~/backup/
stow python

mv .wakatime.cfg .ansiweatherrc .editorconfig .screenrc .tmux.conf ~/backup/
stow homedir

stow -vv zsh

mv ~/.emacs.d ~/backup/
stow emacs

stow -vv golang
# See golang/README for more

cd _dpkg
# ... refer to README.md contained therein
cd ../_pip
# ...
cd ../_npm
# ...

# login from a new terminal
emacs
```

Remap <kbd>CapsLock</kbd> to <kbd>Control</kbd>
-----------------------------------------------

Via https://unix.stackexchange.com/questions/452391/execute-command-to-swap-caps-lock-and-ctrl-at-startup

```
root@rpi:/home/pi# cat /etc/default/keyboard
# KEYBOARD CONFIGURATION FILE

# Consult the keyboard(5) manual page.

XKBMODEL="microsoft4000"
XKBLAYOUT="us"
XKBVARIANT=""
#XKBOPTIONS="ctrl:nocaps"
XKBOPTIONS="terminate:ctrl_alt_bksp,ctrl:nocaps"

BACKSPACE="guess"
```

Now run this command as described in man 7 keyboard:

```
udevadm trigger --subsystem-match=input --action=change
```
