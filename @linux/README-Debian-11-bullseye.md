Install
-------

Installation on Debian 11 (bullseye) VM (c. Nov-2021)

```shell
# FIXME: Add sudo install/enable instructions

sudo apt install -y stow git

# set agent forwarding for SSH access to work
git clone --recurse-submodules \
    git@github.com:idcrook/i-dotfiles.git ~/.dotfiles

cd ~/.dotfiles
stow -t ~ stow # bootstrap stow config at top-level

# edit ~/.stowrc for hard-coded home dir
cp ~/.stowrc ~/.stowrc.hard
pwd
vi  ~/.stowrc.hard
mv -i ~/.stowrc.hard  ~/.stowrc

cd @linux
# may need:  sudo rm /etc/apt/apt.conf.d/02proxy
sudo stow -vv --target=/ @Apt
sudo apt update

cd ~/.dotfiles
stow -vv git
# manually edit ~/.config/git/config.secrets instead of 'git config --global user.email ... '

stow -vv shell

# populate secrets from another host, in another terminal
ssh DONOR_HOST

export TARGET=username@bullseye.local
ssh-copy-id $TARGET

scp ~/.config/git/config.secrets                $TARGET:.dotfiles/git/.config/git/config.secrets
scp ~/.dotfiles/homedir/.ansiweatherrc.secrets  $TARGET:.dotfiles/homedir/.ansiweatherrc.secrets
scp ~/.dotfiles/homedir/.wakatime.cfg.secrets   $TARGET:.dotfiles/homedir/.wakatime.cfg.secrets
exit

# prepare to have some files replaced/taken over in ~
mkdir -p ~/backup

mv ~/{.bash_logout,.bashrc,.profile} ~/backup
( cd ~ && mv .bash_aliases .bash_profile .inputrc .powerline-shell.json .bash_completion.d/ backup/ )
#mkdir -p ~/.local/{bin,lib,share}

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

#stow -vv espanso
# espanso README: manual install and custom settings

cd ~/.dotfiles/_dpkg
# ... refer to README.md contained therein
less install_packages.debian.bullseye.txt

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