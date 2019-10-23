ZSH config
==========

macOS 10.15 Catalina makes `zsh` the default shell; figured I'd embrace it early.

Using Prezto and powerlevel10k

-	https://github.com/sorin-ionescu/prezto - ZSH package set
-	powerlevel10k (faster powerlevel9k (like powerline on BASH))

	-	https://github.com/romkatv/powerlevel10k
	-	purepower, as adapted from https://github.com/romkatv/powerlevel10k#configuration

See [README-initial-import.md](README-initial-import.md)

## Manually change login shell

This should work in both macOS and Linux

```shell
chsh -s /bin/zsh
```

### Display current user's login shell

```shell
# macOS
dscl . -read /Users/$USER UserShell

# Ubuntu Linux
egrep ^$USER /etc/passwd | cut -d: -f7
```
