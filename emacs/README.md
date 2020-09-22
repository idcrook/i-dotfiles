Emacs .emacs.d
==============

Introduced separate [`.emacs.d`](https://github.com/idcrook/.emacs.d) repository as git submodule

Using
-----

1.	Make edits in git submodule checkout, e.g. `~/.dotfiles/emacs/.emacs.d`
2.	Push any changes back to its remote
3.	When ready, can add/commit `.emacs.d` reference into `i-dotfiles`

Install emacs
=============

macOS : emacs via homebrew casks
--------------------------------

there is a shell wrapper `Emacs.sh`

### Install emacs cask

from https://emacsformacosx.com/

As of 2020-Aug-12 `emacs27.1` build

```bash
brew cask install emacs
#  /Applications/Emacs.app
```

Ubuntu
------

<!-- ### Ubuntu - Install emacs from snap (recommended) -->

<!-- - `--beta` will not be needed when emacs27 hits stable -->

<!-- ```shellsession -->

<!-- $ sudo snap install emacs --beta --classic -->

<!-- # should be in path -->

<!-- $ /snap/bin/emacs -->

<!-- ``` -->

<!-- Maintained by the `snapd` system -->

### Install emacs27 on ubuntu

```
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt-get update
sudo apt install emacs27
```

secrets
-------

`~/.emacs.d/private/authinfo.secrets` shall contain app API passwords

Refer to

-	https://github.com/seagle0128/grip-mode#customize
-	https://github.com/joeyespo/grip#access

Updating .emacs.d locally from its host repo
--------------------------------------------

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
git clone https://github.com/idcrook/.emacs.d.git
# this is back to the "exported" dir again
cd ../emacs.d
mv ../.emacs.d/.git .

# now sanitize any secrets, etc. before first commit... then
git commit -m "first commit"
git push -u origin master

# now add to i-dotfiles (you may want https:// github URL instead)
cd ~/.dotfiles/
git submodule add http://github.com/idcrook/.emacs.d.git emacs/.emacs.d
# implicitly does a 'git add .gitmodules emacs/.emacs.d'

# first time, for transition
mv ~/.emacs.d/ ~/backup/
stow -vv emacs
# we are live! copy secrets as necessary
```
