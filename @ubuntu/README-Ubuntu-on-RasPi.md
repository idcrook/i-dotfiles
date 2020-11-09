Install
-------

Installation on Ubuntu 20.10 (arm64) Rasperry Pi Model 4B

```shell
sudo apt install -y stow git ssh

# allows incoming SSH connections
sudo systemctl enable --now ssh

ssh-keygen -b 4096
# Upload this SSH key to GitHub account
#     cat ~/.ssh/id_rsa.pub
# and test
#     ssh -T git@github.com

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
# until groovy is avail., change to focal
sudo vi /etc/apt/sources.list.d/kelleyk-ubuntu-emacs-groovy.list

sudo apt update

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

# snap is available on arm64
stow -vv espanso
# espanso README: manual install and custom settings

cd ~/.dotfiles/_dpkg
# ...  install_packages.ubuntu20.10.raspi.txt
cd ~/.dotfiles/_pip
# ...  packages3.ubuntu20.10.raspi.txt
cd ~/.dotfiles/_npm
# ...

# login from a new terminal
emacs27 -nw

cd  ~/.dotfiles/golang
cat README.md
# ...

cd ~/.dotfiles/rustlang
cat README.md
# ...
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

Fix for Visual Studio Code remote editting on large Git repos
-------------------------------------------------------------

-	["Visual Studio Code is unable to watch for file changes in this large workspace" (error ENOSPC)](https://code.visualstudio.com/docs/setup/linux#_visual-studio-code-is-unable-to-watch-for-file-changes-in-this-large-workspace-error-enospc)

```console
$ cat /proc/sys/fs/inotify/max_user_watches
65536
$ sudo vi /etc/sysctl.conf
# add line to end of file
fs.inotify.max_user_watches=524288
$ sudo sysctl -p
```

