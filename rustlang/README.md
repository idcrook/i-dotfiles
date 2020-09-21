Capture Rust dotfiles
=====================


```
cd ~/.dotfiles
stow -v rustlang
```

install rustlang
=====================

macOS
-----

```
# next line should already be done by homebrew
brew install rustup-init

# Customize installation, and do not modify PATH variables
rustup-init
```

After installing `stable`, start a new shell- `~/.cargo/bin` should be found and added to path


Ubuntu
------

Via https://rustup.rs/

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
