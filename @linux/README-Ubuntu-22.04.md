Install
-------

Installation on Ubuntu 22.04 LTS (amd64)

Optional pre-requisites:

1.	`sudo apt install gnome-tweaks`
	-	CapsLock remap to <kbd>Ctrl</kbd>
2.	*Visual Studio Code* can be install using the Ubuntu Software app (which installs the snap version).
3.	Change shell (`chsh`) to `zsh`

```shell
sudo apt install -y stow git ssh

# allows incoming SSH connections
sudo systemctl enable --now ssh

ssh-keygen -t ed25519 -C "your_email@example.com"
# Upload this SSH key to GitHub account
#     cat ~/.ssh/id_ed25519.pub
# and test
#     ssh -T git@github.com

# git clone --recurse-submodules https://github.com/idcrook/i-dotfiles.git ~/.dotfiles
# this requires SSH key on git account
git clone --recurse-submodules   git@github.com:idcrook/i-dotfiles.git ~/.dotfiles

cd ~/.dotfiles
stow -t ~ stow # bootstrap stow config at top-level

# edit ~/.stowrc for home dir
cp ~/.stowrc ~/.stowrc.hard
vi  ~/.stowrc.hard
mv -i ~/.stowrc.hard  ~/.stowrc

cd @linux
sudo stow -vv --target=/ @Apt

# for emacs27 - emacs27.1 in Ubuntu 22.04

# some files will be replaced /taken over in ~
mkdir -p ~/backup

cd ~/.dotfiles
mv ~/.gitignore_global ~/backup
mv ~/.git/ ~/backup/
stow -vv git

stow -vv shell

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
# espanso README: manual install and custom settings

cd ~/.dotfiles/_dpkg
# ...  install_packages.ubuntu22.04.txt
cd ~/.dotfiles/_pip
# ...  packages3.ubuntu22.04.txt
cd ~/.dotfiles/_npm
# ...

# login from a new terminal
emacs -nw

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

Hide mounted drives in Ubuntu Dock
----------------------------------

**Note**: This is configurable under Dock Settings via the main *Settings* app in Ubuntu 22.04 beta. 03-MAR-2022

```
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
```

there is also `dconf-editor`

```shell
apt install dconf-editor
```

Launch dconf editor and navigate to "org/gnome/shell/extensions/dash-to-dock", scroll down and turn off the value of "show-mounts".
