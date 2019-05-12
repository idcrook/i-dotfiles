## Typical Install (on macOS)

1. First, install **Homebrew <<https://brew.sh>>**
1. Assumes [`stow`](stow/README.md#install-gnu-stow) is installed

```shell
cd
git clone --recurse-submodules git@github.com:idcrook/i-dotfiles.git .dotfiles
cd .dotfiles
stow -t ~ stow
stow @macos
stow git
stow bash
stow python
stow homedir
stow emacs
stow golang
cd _homebrew
# ...
cd ../_pip
# ...
cd ../_npm
# ...
```
