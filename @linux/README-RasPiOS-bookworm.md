Install
-------

Installation on Raspberry Pi OS - bookworm (circa JAN-2024)

```shell
sudo apt install -y stow git

git clone --recurse-submodules \
    https://github.com/idcrook/i-dotfiles.git ~/.dotfiles
# alternative: SSH from `ssh-keygen -t ed25519 -C "your_email@example.com"`

cd ~/.dotfiles
stow -t ~ stow # bootstrap stow config at top-level

# edit ~/.stowrc for hard-coded home dir
cp ~/.stowrc ~/.stowrc.hard
vi  ~/.stowrc.hard
mv -i ~/.stowrc.hard  ~/.stowrc

cd @linux
# may need:  sudo rm /etc/apt/apt.conf.d/02proxy
sudo stow -vv --target=/ @Apt
sudo apt update

cd ~/.dotfiles
stow -vv git

stow -vv shell

# populate secrets from another host, in another terminal
ssh DONOR_HOST

export TARGET=pi@raspberrypi.local
ssh-copy-id $TARGET

scp ~/.config/git/config.secrets                $TARGET:.dotfiles/git/.config/git/config.secrets
scp ~/.dotfiles/homedir/.ansiweatherrc.secrets  $TARGET:.dotfiles/homedir/.ansiweatherrc.secrets
scp ~/.dotfiles/homedir/.wakatime.cfg.secrets   $TARGET:.dotfiles/homedir/.wakatime.cfg.secrets
exit

# prepare to have some files replaced/taken over in ~
mkdir -p ~/backup

mv ~/{.bash_logout,.bashrc,.profile} ~/backup
( cd ~ && mv .bash_aliases .bash_profile .inputrc .powerline-shell.json .bash_completion.d/ backup/ )
#mkdir -p ~/.local/{bin,lib}

cd ~/.dotfiles

stow -vv bash zsh

mv ~/.pystartup ~/backup/
stow -vv python

( cd ~ && mv .wakatime.cfg .ansiweatherrc .editorconfig .screenrc .tmux.conf ~/backup/ )

stow -vv homedir

mv ~/.emacs.d ~/backup/
stow -vv emacs

stow -vv golang
# See golang/README for more

stow -vv espanso
# espanso README: manual install and custom settings

cd ~/.dotfiles/_dpkg
# ... refer to README.md contained therein
less install_packages.raspios.bullseye.txt

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

`lxterminal` login shell
------------------------

For whatever reason, there is not a Setting in `lxterminal` (the default terminal app in RasPiOS) to launch a shell as a *login* shell. However, the man page for it has a command line argument for it.

So, in Applications menu, right-click on the Terminal menu item `Applications > Accessories > Terminal` and select `Properties` in the popup.

Then, in the application propoerties dialog, in the *Desktop Entry* Tab, for the **Command:**, append `--loginshell`.

Other options for `lxterminal` can be found by `man lxterminal`

Remap <kbd>CapsLock</kbd> to <kbd>Control</kbd>
-----------------------------------------------

Wayland is being used on Raspberry Pi 5 and Raspberry Pi OS (bookworm). It no longer uses xkb options in this case.

You can find the setting within `~/.config/wayfire.ini`

```console
[input]
#xkb_options=
xkb_options=ctrl:nocaps
```

Restart the desktop and the new settings will be in effect.

Hardware Considerations
-----------------------

[Automatic Fan SHIM Control](https://github.com/pimoroni/fanshim-python/blob/master/examples/README.md)

Example

```shell
mkdir ~/projects
cd ~/projects
git clone https://github.com/pimoroni/fanshim-python
cd fanshim-python
sudo apt install git python3-pip
sudo ./install.sh
cd examples/
sudo ./install-service.sh --on-threshold 65 --off-threshold 55 --delay 2

```
