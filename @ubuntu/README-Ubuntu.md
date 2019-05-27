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
stow git
# populate secrets from another host
scp ~/.config/git/config.secrets  server:.dotfiles/git/.config/git/config.secrets
scp ~/.dotfiles/homedir/.ansiweatherrc.secrets  server:.dotfiles/homedir/.ansiweatherrc.secrets
scp ~/.dotfiles/homedir/.wakatime.cfg.secrets server:.dotfiles/homedir/.wakatime.cfg.secrets

# some files will be replaced /taken over in ~
mkdir -p ~/backup
mv ~/{.bash_logout,.bashrc,.profile} ~/backup
( cd ~ && mv .bash_aliases .bash_profile .inputrc .powerline-shell.json .bash_completion.d/ backup/ )
stow -vv bash

mv ~/.pystartup ~/backup/
stow python

mv .wakatime.cfg .ansiweatherrc .editorconfig .screenrc .tmux.conf backup/
stow homedir

mv ~/.emacs.d ~/backup/
stow emacs

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
