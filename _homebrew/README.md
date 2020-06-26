**Homebrew <<https://brew.sh>> setup on macOS**

https://docs.brew.sh/Installation


Assumes Homebrew has already been installed :

```shell
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```


## Typical macOS System bootstrap

Applies specifically to my preferences. For example, my shell setup wants these first.

```shell
brew install keychain git 
# 'open /Applications/Emacs.app' or run 'Emacs.sh'
brew install mas
brew tap homebrew/bundle
brew bundle --file=Brewfile
```
## (Optional) Cleanup

You can hand-edit `Brewfile` and have Homebrew clean things up.

```shell
# reads in Brewfile
brew bundle --file=Brewfile --force cleanup
```

## Capturing configuration, including Homebrew taps, casks, and MAS (Mac App Store) 

```shell
brew tap homebrew/bundle
brew bundle dump --file=- > Brewfile
```
