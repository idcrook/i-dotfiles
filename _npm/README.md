Using `nvm`
===========

https://github.com/nvm-sh/nvm

On macOS
--------

```
mkdir -p ~/.nvm
brew install nvm
# update shell startup files to source nvm and load completions in respective shells
```

On Linux
--------

```
# moves to $XDG_CONFIG_HOME with nvm v0.37 # mkdir -p ~/.nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
```

Source a new shell and install a node version
---------------------------------------------

In a **freshly sourced shell**, after `nvm` is "installed"

```
nvm install node
nvm which node
which npm
npm install -g npm
npm list --global --parseable --depth=0
```

### older system modules

```
=> If you wish to uninstall them at a later point (or re-install them under your
=> `nvm` Nodes), you can remove them from the system Node as follows:

     $ nvm use system
     $ npm uninstall -g a_module
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

To (re)install :

```shell
cd ~/.dotfiles/_npm
[sudo] npm install --global $(cat npm_global_packages.list)
```

-	`sudo` is required when using the system / apt `npm` package
	-	this means `ubuntu` and `raspbian`, and WSL Ubuntu
	-	if using `nvm`, do not use sudo!

Update / upgrade
----------------

```shell
npm update -g
```
