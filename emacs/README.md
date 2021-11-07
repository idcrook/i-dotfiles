Emacs .emacs.d
==============

Introduced separate [`.emacs.d`](https://github.com/idcrook/.emacs.d) repository as git submodule.

Supports `emacs27` and later.

See locally here: [.emacs.d](.emacs.d/#readme)

Using
-----

1.	Make edits in `git submodule` checkout, e.g. `~/.dotfiles/emacs/.emacs.d`
2.	Push any changes back to its remote repo
3.	When ready, can add/commit `.emacs.d` directoty/reference into `i-dotfiles`

Install emacs
=============

On macOS, there is a shell wrapper `Emacs.sh` (`~/bin/macos/`) for launching `emacs`

macOS Option 1: Build emacs via emacs-plus formula
--------------------------------------------------

Works best on Apple Silicon Macs (until cask supports native Apple Silicon)

```shell
brew reinstall emacs-plus --with-xwidgets --with-elrumo2-icon
```

macOS Option 2: emacs via homebrew cask
---------------------------------------

```bash
brew install --cask emacs
#  /Applications/Emacs.app
```

As of 2021-Apr-21 `emacs27.2-2` build from https://emacsformacosx.com/

Ubuntu
------

### Ubuntu - Install emacs from snap

```shellsession
$ sudo snap install emacs --classic
$ sudo snap install emacs-28 --beta --classic

# should already be in PATH but ...
$ /snap/bin/emacs

```

Maintained by the `snapd` system

### Install emacs27 on ubuntu

Using PPA [Emacs stable releases : Kevin Kelley](https://launchpad.net/~kelleyk/+archive/ubuntu/emacs)

```
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt update
sudo apt install emacs27
```

secrets
-------

`~/.emacs.d/private/authinfo.secrets` shall contain app API passwords

Refer to

-	https://github.com/seagle0128/grip-mode#customize
-	https://github.com/joeyespo/grip#access

Updating .emacs.d submodule locally from its parent repo
--------------------------------------------------------

```
cd ~/.dotfiles/emacs/.emacs.d
git status # should be clean
git remote update
git pull origin main
# will merge in any updates

# assuming all is well, update i-dotfiles version to this version
cd ~/.dotfiles/
git add emacs/.emacs.d
git commit -m "updated .emacs.d submodule"
git push origin main
```
