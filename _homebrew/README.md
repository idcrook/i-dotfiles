**Homebrew https://brew.sh setup on macOS**

On Apple Silicon, it is possible to have Homebrew for both Apple Silicon and Intel installed side-by-side.

Assumes Homebrew has already been installed : https://docs.brew.sh/Installation

```shell
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

My Typical macOS Homebrew Bring-up
----------------------------------

Pre-reqs (`bundle` and `mas` for `Brewfile`\)

```shell
brew tap homebrew/bundle
brew install mas
# might assume # brew install git stow
```

Ordering here applies specifically to my preferences, and allows me to have consistent availability across my Macs.

```shell
cd ~/.dotfiles/_homebrew

# on Apple Silicon (native)
brew bundle --file=Brewfile.arm64

# Auxiliary on Apple Silicon (Rosetta2) - requires independent
# Homebrew install in the Rosetta environment
brew bundle --file=Brewfile.rosetta

# on Intel Mac
brew bundle --file=Brewfile.intel

# inspect directory for other app bundles
brew bundle --file=Brewfile.apple-dev --verbose
brew bundle --file=Brewfile.hardware-dev --verbose
# etc.
```

(Optional) Cleanup
------------------

You can hand-edit a `Brewfile` and have Homebrew clean things up. The cleanup will prune formulae or dependencies not mentioned in `Brewfile`

```shell
# reads in Brewfile
brew bundle --file=Brewfile --force cleanup
```

Capturing configuration, including Homebrew taps, casks, and MAS (Mac App Store)
--------------------------------------------------------------------------------

```shell
brew tap homebrew/bundle
brew bundle dump --file=- > Brewfile
```
