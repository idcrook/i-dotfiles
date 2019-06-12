## Typical Install (on macOS)

1. First, install **Homebrew <<https://brew.sh>>**
1. Assumes [`stow`](stow/README.md#install-gnu-stow) is installed
   `brew install stow git`

```shell
cd
git clone --recurse-submodules git@github.com:idcrook/i-dotfiles.git .dotfiles
cd .dotfiles
stow -t ~ stow
stow -vv @macos

stow -vv git
cp -v git/.config/git/config.secrets.example ~/.config/git/config.secrets
$EDITOR  ~/.config/git/config.secrets

stow -vv bash
cp -v bash/.config/shell/local.aliases.secrets.sh.example \
      bash/.config/shell/local.aliases.secrets.sh
$EDITOR bash/.config/shell/local.aliases.secrets.sh

stow -vv zsh

stow -vv python

stow -vv homedir
cp -v homedir/{.ansiweatherrc.secrets.example,.ansiweatherrc.secrets}
cp -v homedir/{.wakatime.cfg.secrets.example,.wakatime.cfg.secrets}
cp -v ./homedir/bin/macos/homebrew/HOMEBREW_GITHUB_API_TOKEN.secrets.example \
      ./homedir/bin/macos/homebrew/HOMEBREW_GITHUB_API_TOKEN.secrets
# edit them

stow -vv emacs
stow -vv golang
cd _homebrew
# ...
cd ../_pip
# ...
cd ../_npm
# ...
```
