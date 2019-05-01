


# Emacs .emacs.d

Introduced separate [`.emacs.d`](https://github.com/idcrook/.emacs.d) repository as git submodule

## Using

1. Make edits in git submodule checkout, e.g. `~/.dotfiles/emacs/.emacs.d`
1. Push any changes back to its remote
1. When ready, can add/commit `.emacs.d` reference into `i-dotfiles`

## Updating .emacs.d locally from its host repo

```
cd ~/.dotfiles/emacs/.emacs.d
git status # should be clean
git remote update
git pull origin master
# will merge in any updates

# assuming all is well, update i-dotfiles version to this version
cd ~/.dotfiles/
git add emacs/.emacs.d
git commit -a -m "updated .emacs.d submodule"
git push origin master
```



#### Importing .emacs.d subtree from original homedir.git

for reference

```shell
# https://stackoverflow.com/questions/1662753/export-subtree-in-git-with-history#comment1535432_1662787
# "Just make sure to run this on a clone of the original repository, as it wipes the rest of the repo"

# in fresh, "throw-away" homedir.git clone somewhere else, extract .emacs.d
cd homedir
git filter-branch --subdirectory-filter .emacs.d -- --all
# this dir has now become the root of homedir.git/.emacs.d

# export files/dirs to a new directory
mkdir ../emacs.d
git archive master | tar -x -C ../emacs.d

# Clone the new repository so we can add things to it
cd ..
git clone git@github.com:idcrook/.emacs.d.git
# this is back to the "exported" dir again
cd ../emacs.d
mv ../.emacs.d/.git .

# now sanitize any secrets, etc. before first commit... then
git commit -m "first commit"
git push -u origin master

# now add to i-dotfiles (you may want https:// github URL instead)
cd ~/.dotfiles/
git submodule add git@github.com:idcrook/.emacs.d.git emacs/.emacs.d
# implicitly does a 'git add .gitmodules emacs/.emacs.d'

# first time, for transition
mv ~/.emacs.d/ ~/backup/
stow -vv emacs
# we are live! copy secrets as necessary
```
