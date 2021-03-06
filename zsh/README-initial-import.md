Initial prezto zsh config bootstrap
===================================

https://github.com/sorin-ionescu/prezto

inspired by : https://github.com/ndhoule/dotfiles

Add a module for zsh configs, with `zprezto` as submodule

```shell
mkdir zsh
git submodule add https://github.com/idcrook/prezto.git zsh/.zprezto
git submodule update --init --recursive --  zsh/.zprezto
```

copy startup files

```shell
cd ~/.dotfiles/zsh
# zsh
# setopt EXTENDED_GLOB
# for rcfile in ./.zprezto/runcoms/^README.md(.N); do
#   # ln -s "$rcfile" ".${rcfile:t}"
#   echo "$rcfile" ".${rcfile:t}"
# done
for rcfile in .zprezto/runcoms/*; do
    if [[ $rcfile =~ "README.md" ]] ; then continue ; fi ;
    ln -s $rcfile .$(basename $rcfile)
done
```

stow

```
cd ~/.dotfiles
stow zsh
```

powerlevel10k (faster powerlevel9k (like powerline on BASH))
------------------------------------------------------------

https://github.com/romkatv/powerlevel10k

prezto includes external version

add to `~/.zpreztorc`:

```
zstyle ':prezto:module:prompt' theme 'powerlevel10k'
```

### configuration

adapted from https://github.com/romkatv/powerlevel10k#configuration

```
cd ~/.dotfiles/zsh
( cd ~/.dotfiles/zsh && curl -fsSLO https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.purepower )
echo 'source ~/.purepower' >>! .zshrc
```
