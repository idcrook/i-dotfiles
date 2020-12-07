Install
-------

Installation on fresh ubuntu 20.04

```shell
sudo apt install -y stow git 
(OPTIONAL, may be required: sudo apt install openssh-server)

ssh-keygen -b 4096
# Upload this SSH key to GitHub account # cat ~/.ssh/id_rsa.pub
# and test # ssh -T git@github.com

# Add locales, like, e.g., `en_US.UTF-8`
sudo dpkg-reconfigure locales


git clone --recurse-submodules https://github.com/idcrook/i-dotfiles.git ~/.dotfiles
# this requires SSH key on git account
# git clone --recurse-submodules   git@github.com:idcrook/i-dotfiles.git ~/.dotfiles

cd ~/.dotfiles
stow -t ~ stow # bootstrap stow config at top-level

# edit ~/.stowrc for home dir
cp ~/.stowrc ~/.stowrc.hard
vi  ~/.stowrc.hard
mv -i ~/.stowrc.hard  ~/.stowrc

cd @ubuntu
sudo stow -vv --target=/ @Apt

# for emacs27 - https://launchpad.net/~kelleyk/+archive/ubuntu/emacs
sudo add-apt-repository ppa:kelleyk/emacs

sudo apt update # may be implicit

# some files will be replaced /taken over in ~
mkdir -p ~/backup

cd ~/.dotfiles
mv ~/.gitignore_global ~/backup
mv ~/.git/ ~/backup/
stow -vv git

# populate secrets from another host, in another terminal
ssh DONOR_HOST
TARGET=host.local
scp ~/.config/git/config.secrets  $TARGET:.dotfiles/git/.config/git/config.secrets
scp ~/.dotfiles/homedir/.ansiweatherrc.secrets  $TARGET:.dotfiles/homedir/.ansiweatherrc.secrets
scp ~/.dotfiles/homedir/.wakatime.cfg.secrets $TARGET:.dotfiles/homedir/.wakatime.cfg.secrets
exit

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
# espanso README: manual install and custom settings (can skip for Non-Desktop env)

cd ~/.dotfiles/_dpkg
# ...  install_packages.ubuntu20.04.txt
cd ~/.dotfiles/_pip
# ...  packages3.ubuntu20.04.txt
cd ~/.dotfiles/_npm
# ...

# login from a new terminal
emacs27 -nw

cd ~/.dotfiles/golang
cat README.md
# ...

cd ~/.dotfiles/rustlang
cat README.md
# ...
```

Update GRUB config to save defaults
-----------------------------------

```diff
-GRUB_DEFAULT=0
+#GRUB_DEFAULT=0
+GRUB_DEFAULT=saved
+GRUB_SAVEDEFAULT=true
 GRUB_TIMEOUT_STYLE=hidden
 GRUB_TIMEOUT=10
 GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
-GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
+#GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
+GRUB_CMDLINE_LINUX_DEFAULT="quiet"
 GRUB_CMDLINE_LINUX=""
```

Some older machines BIOS-es do not play well with the graphical splash screen on Ubuntu 20.04. Removing `splash` from the `GRUB_CMDLINE_LINUX_DEFAULT=` is only needed if Ubuntu spinner on the boot screen spins forever.

```shell
sudo update-grub2
```

Tell Ubuntu to play together if dual booting with Windows via BIOS RTC
----------------------------------------------------------------------

```shell
timedatectl set-local-rtc 1 --adjust-system-clock
timedatectl
```

Now should show:

```
“RTC in local TZ: yes”
```

and gives a verbose warning about UTC and local BIOS RTC. To revert to the standard Ubuntu behavior:

```
timedatectl set-local-rtc 0 --adjust-system-clock
```

Remap <kbd>CapsLock</kbd> to <kbd>Control</kbd>
-----------------------------------------------

Use `gnome-tweaks` to do related in Ubuntu 20.04+

Via https://unix.stackexchange.com/questions/452391/execute-command-to-swap-caps-lock-and-ctrl-at-startup

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
sudo udevadm trigger --subsystem-match=input --action=change
```
