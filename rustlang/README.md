Capture Rust dotfiles
=====================

```
cd ~/.dotfiles
stow -v rustlang
```

In my `zprezto`, I have added a `rust` module: [prezto/init.zsh at master · idcrook/prezto](https://github.com/idcrook/prezto/blob/master/modules/rust/init.zsh). It can be enabled in `.zpreztorc`

install rustlang
================

macOS
-----

```
# next line should already be done by homebrew
brew install rustup-init

# Can customize installation; do not modify PATH variables
rustup-init --no-modify-path
```

After installing `stable`, start a new shell- `~/.cargo/bin` should be found and added to path

Ubuntu or Debian
----------------

Via https://rustup.rs/

Better: Set directly flag to not modify path in startup files

```shell
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path
```

From the website:

```shell
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Rust Applications
-----------------

Cargo could also be used, but might as well use system packager where available.

## `ripgrep`


```console
$ cargo install ripgrep
```


### macOS

```shell
brew install ripgrep
```

### Linux

```shell
sudo apt install ripgrep
```
