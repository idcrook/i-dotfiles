**Config files for `stow`<<https://www.gnu.org/software/stow/>>, the symlink farm manager.**

    ├── .stow-global-ignore     Ignore files based on i-dotfiles naming scheme
    └── .stowrc                 Set $HOME as default target dir

### Install notes

**Important:** This should be the first package you install as it is responsible for filtering *README*, *TODO* and subpackages files trees when you stow a package.

Edit your `$HOME` full path in [.stowrc](.stowrc)


#### Install GNU Stow

```shell
# Debian / Ubuntu
sudo apt install stow

# macOS - assumes Homebrew << https://brew.sh/ >> is installed
brew install stow

# Windows MSYS2 << https://www.msys2.org >>
pacman -S stow  # not tested

```
