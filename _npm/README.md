Using `nvm` to manage `node` and `npm`
======================================

https://github.com/nvm-sh/nvm#readme

On macOS
--------

```shell
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | zsh
```

On Linux
--------

```shells
# $XDG_CONFIG_HOME instead with nvm v0.37+ # mkdir -p ~/.nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
```

Source a new shell and install a node version
---------------------------------------------

In a **freshly sourced shell**, i.e., with `nvm` "installed" and activated"

```shell
nvm install node
nvm which node
which npm
npm install -g npm
npm --version
npm list --global --parseable --depth=0
```

#### Old macOS way

```shell
# mkdir -p ~/.nvm
# brew install nvm
# update shell startup files to source nvm and load completions in respective shells
```

Using node packages
===================

**List of packages to install via `npm`, the *node.js* packaging tool.**

```
 └── npm_global_packages.list
```

---

To create the packages list do :

```shell
#!/bin/bash
# Save to a file npm's global packages
list="$(npm list --global --parseable --depth=0 | sed '1d')"
newlist=""
for i in $list; do
  name="${i##*/}"
  newlist+="$name "
done
echo "$newlist"
echo "$newlist" > npm_global_packages.list
```

Install
-------

-	`sudo` may be required when using system / apt `npm` package for global packages
	-	if using `nvm`, do not use **`sudo`**!

To install or re-install packages:

```shell
cd ~/.dotfiles/_npm
npm install --global $(cat npm_global_packages.list)
```

Update / upgrade
----------------

```shell
npm update -g
```
