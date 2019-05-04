
## Install notes

Installation on fresh ubuntu 18.04 (server)

```
sudo apt install stow

cd ~/.dotfiles
stow -t ~ stow # bootstrap stow config at top-level
# edit ~/.stowrc for home dir

cd @ubuntu
sudo stow --target=/ @Apt

# for emacs26 repo
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt-get update

```
