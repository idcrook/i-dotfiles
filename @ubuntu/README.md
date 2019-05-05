
## Install notes

Installation on fresh ubuntu 18.04 (server)

```
sudo apt install stow

cd ~/.dotfiles
stow -t ~ stow # bootstrap stow config at top-level
# edit ~/.stowrc for home dir

cd @ubuntu
sudo stow -vv --target=/ @Apt

# for emacs26 repo
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt update

cd ~/.dotfiles
stow git
# populate secrets from another host
scp ~/.config/git/config.secrets  server:.dotfiles/git/.config/git/config.secrets
scp ~/.dotfiles/homedir/.ansiweatherrc.secrets  server:.dotfiles/homedir/.ansiweatherrc.secrets
scp ~/.dotfiles/homedir/.wakatime.cfg.secrets server:.dotfiles/homedir/.wakatime.cfg.secrets


# some files will be clobbered
mkdir -p ~/backup
mv ~/{.bash_logout,.bashrc,.profile} ~/backup
stow bash

stow python
stow homedir
stow emacs

cd _dpkg
# ...
cd ../_pip
# ...
cd ../_npm
# ...

# login from a new terminal
emacs26 -nw
```
