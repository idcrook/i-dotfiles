Install
-------

Installation on Raspberry Pi OS - Buster (c. Mar-2021)

```shell
sudo apt install -y stow git

git clone --recurse-submodules \
    https://github.com/idcrook/i-dotfiles.git ~/.dotfiles

cd ~/.dotfiles
stow -t ~ stow # bootstrap stow config at top-level

# edit ~/.stowrc for hard-coded home dir
cp ~/.stowrc ~/.stowrc.hard
vi  ~/.stowrc.hard
mv -i ~/.stowrc.hard  ~/.stowrc

cd @linux
# may need:  sudo rm /etc/apt/apt.conf.d/02proxy
sudo stow -vv --target=/ @Apt

cd ~/.dotfiles
stow git

stow -vv shell

# populate secrets from another host, in another terminal
ssh DONOR_HOST

export TARGET=pi@raspberrypi.local
scp ~/.config/git/config.secrets                $TARGET:.dotfiles/git/.config/git/config.secrets
scp ~/.dotfiles/homedir/.ansiweatherrc.secrets  $TARGET:.dotfiles/homedir/.ansiweatherrc.secrets
scp ~/.dotfiles/homedir/.wakatime.cfg.secrets   $TARGET:.dotfiles/homedir/.wakatime.cfg.secrets
exit

# prepare to have some files replaced/taken over in ~
mkdir -p ~/backup

mv ~/{.bash_logout,.bashrc,.profile} ~/backup
( cd ~ && mv .bash_aliases .bash_profile .inputrc .powerline-shell.json .bash_completion.d/ backup/ )
mkdir -p ~/.local/{bin,lib}

stow -vv bash zsh

mv ~/.pystartup ~/backup/
stow python

mv .wakatime.cfg .ansiweatherrc .editorconfig .screenrc .tmux.conf ~/backup/
stow homedir

mv ~/.emacs.d ~/backup/
stow -vv emacs

stow -vv golang
# See golang/README for more

#stow -vv espanso
# espanso README: manual install and custom settings

cd ~/.dotfiles/_dpkg
# ... refer to README.md contained therein
cd ~/.dotfiles/_pip
# ...
cd ~/.dotfiles/_npm
# ...
cd ~/.dotfiles/golang
# ...
cd ~/.dotfiles/rustlang
# ...

# login from a new terminal (in GUI, may want to logout/back in first)
emacs
```

Remap <kbd>CapsLock</kbd> to <kbd>Control</kbd>
-----------------------------------------------

Via https://unix.stackexchange.com/questions/452391/execute-command-to-swap-caps-lock-and-ctrl-at-startup

the `XKBOPTIONS` is the important setting

```console
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
sudo udevadm trigger --subsystem-match=input --action=change
```

## Hardware Considerations

[Automatic Fan SHIM Control](https://github.com/pimoroni/fanshim-python/blob/master/examples/README.md)

Example
```console
mkdir ~/projects
cd ~/projects
git clone https://github.com/pimoroni/fanshim-python
cd fanshim-python
sudo apt install git python3-pip
sudo ./install.sh
cd examples/
sudo ./install-service.sh --on-threshold 65 --off-threshold 55 --delay 2

```
