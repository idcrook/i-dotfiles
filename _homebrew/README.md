**Homebrew https://brew.sh setup on macOS**

On Apple Silicon, it is possible to have entire Homebrew for both Apple Silicon and Intel installed side-by-side.

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
# might also assume # brew install git stow
```

Ordering here applies specifically to my preferences, and allows me to have consistent availability across my Macs.

```shell
cd ~/.dotfiles/_homebrew

# on Apple Silicon (native)
brew bundle --file=Brewfile.applesilicon

# Auxiliary on Apple Silicon (Rosetta2) - requires independent
# Homebrew install in the Rosetta environment
brew bundle --file=Brewfile.rosetta

# on Intel Mac
brew bundle --file=Brewfile.intelsilicon
```

Now install interesting groupings of applications.

```
# inspect directory for other app bundles
brew bundle --verbose --file=Brewfile.safariextensions
brew bundle --verbose --file=Brewfile.xcode-dev
brew bundle --verbose --file=Brewfile.cpp-dev
brew bundle --verbose --file=Brewfile.hardware-dev
brew bundle --verbose --file=Brewfile.media-dev
brew bundle --verbose --file=Brewfile.web-dev
# etc.
```

(Optional) Cleanup
------------------

You can hand-edit a `Brewfile` and have Homebrew clean things up. The cleanup will prune formulae or dependencies not mentioned in `Brewfile`

**Note**: The `Brewfile` used below should be a concatenation of all formula and casks for Homebrew installation.

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

Dependency Exploration
----------------------

-	[Untangling Your Homebrew Dependencies | Jonathan Palardy's Blog](https://blog.jpalardy.com/posts/untangling-your-homebrew-dependencies/)

`brew-graph`

```
brew  tap martido/homebrew-graph
brew install graphviz
brew graph --installed | dot -T png -o graph.png
open graph.png
```

`graphviz` itself installs many dependencies...


other tools

```
brew deps --installed
brew leaves
```
