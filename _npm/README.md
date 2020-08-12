
Using `nvm`
===========

## On macOS

```
mkdir ~/.nvm
brew install nvm
mkdir -p ~/.nvm
# update shell startup files to source nvm and load completions in respective shells
# ... and source a new shell
nvm install node
```

```
nvm which node
which npm
npm install -g npm
npm list --global --parseable --depth=0
```


## On macOS

```
mkdir ~/.nvm
brew install nvm
mkdir -p ~/.nvm
# update shell startup files to source nvm and load completions in respective shells
# ... and source a new shell
nvm install node
```

```
nvm which node
```


# Using

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
[sudo] npm install --global $(cat npm_global_packages.list)
```

-	`sudo` is required when using the apt `npm` package
	-	this means `ubuntu` and `raspbian`, and WSL Ubuntu

Update / upgrade
----------------

```shell
npm update -g
```
