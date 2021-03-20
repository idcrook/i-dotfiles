Capture Rust dotfiles
=====================

```
cd ~/.dotfiles
stow -v rustlang
```

install rustlang
================

macOS
-----

```
# next line should already be done by homebrew
brew install rustup-init

# Customize installation, and do not modify PATH variables
rustup-init
```

After installing `stable`, start a new shell- `~/.cargo/bin` should be found and added to path

Ubuntu or Debian
----------------

Via https://rustup.rs/

```shell
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Better: Set directly flag to not modify path in startup files

```shell
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path
```

Rust Applications
-----------------

Cargo could also be used, but might as well use system packager where available.

### macOS

```shell
brew install ripgrep
```

### Linux

```shell
sudo apt install ripgrep
```
