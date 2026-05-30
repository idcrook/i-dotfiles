Install
-------

Installation on Ubuntu/Kubuntu 25.04 LTS (amd64)

Optional pre-requisites:

1.	CapsLock remap to <kbd>Ctrl</kbd>
2.	*Visual Studio Code*
3.	Change shell (`chsh`) to `zsh`

```shell
sudo apt install -y stow git ssh zsh

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

#  emacs30 in K/Ubuntu 25.04

# some files will be replaced /taken over in ~
mkdir -p ~/backup

cd ~/.dotfiles
mv ~/.gitignore_global ~/backup
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
# espanso README: Use AppImage manual install and custom settings

cd ~/.dotfiles/_dpkg
# ...  install_packages.ubuntu26.04.txt
cd ~/.dotfiles/_pip
# ...  packages3.ubuntu26.04.txt
cd ~/.dotfiles/_npm
# ...

# login from a new terminal
zsh --login -i
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

Use `System Settings / Keyboard` in Kubuntu.
