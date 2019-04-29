# My dotfiles

## Background

I used to manage my macOS/Linux/msys2/WSL dotfiles in a "homedir.git" repository. This left things to be desired, and syncing multiple platforms sometimes presented conflicts. Now I use GNU Stow and this organization.

Inspired heavily by:

- http://dotfiles.github.io
  - https://github.com/Kraymer/F-dotfiles


## My Typical Install

1. Assumes `stow` is installed
2. On macOS, additionally assumes Homebrew is installed


```shell
cd
git clone --recurse-submodules git@github.com:idcrook/i-dotfiles.git .dotfiles
cd .dotfiles
stow -t ~ stow
stow @macos
stow git
```

### git submodules refresh


```
git submodule update --remote
```
