Typical Install (on macOS)
--------------------------

1.	First, install **Homebrew \<https://brew.sh\>**
	-	`brew cask info emacs`
	-	`brew cask info homebrew/cask-versions/emacs-pretest`
	-	`brew cask install homebrew/cask-versions/emacs-pretest`
	-	`emacs` .. [Show In Finder] .. open and Run
2.	Assumes [`stow`](stow/README.md#install-gnu-stow) is installed`brew install stow git`

```shell
ssh-keygen -b 4096
# upload SSH key to GitHub
cd
git clone --recurse-submodules https://github.com/idcrook/i-dotfiles.git .dotfiles
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

stow -vv espanso
# see espanso/README.md

scp $TARGET:.config/espanso/user/personal.secrets.yml \
  ./espanso/.config/espanso/user/personal.secrets.yml

stow -vv emacs
stow -vv golang
stow -vv rustlang

# check the READMEs in the following
cd ~/.dotfiles/_homebrew
# ...
cd ~/.dotfiles/_pip
# ...
cd ~/.dotfiles/_npm
# ...
cd ~/.dotfiles/golang
# ...
cd ~/.dotfiles/rustlang
# ...
```


## other fixup

Does zsh complain about un-safe directories?

```shell
compaudit
chmod 755 /usr/local/share/zsh
chmod 755 /usr/local/share/zsh/site-functions/
```
