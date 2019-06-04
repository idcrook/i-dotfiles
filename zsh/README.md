ZSH config
==========

macOS 10.15 Catalina makes `zsh` the default shell; figured I'd embrace it early.

Initial prezto zsh config
=========================

https://github.com/sorin-ionescu/prezto

inspired by : https://github.com/ndhoule/dotfiles

Add a module for zsh configs, with `zprezto` as submodule

```shell
mkdir zsh
git submodule add git@github.com:idcrook/prezto.git zsh/.zprezto
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
