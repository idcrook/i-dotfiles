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
# should already be done by homebrew
brew install rustup-init

# accept defaults, except for dotfile edits
rustup-init
```

After installing `stable`, start a new shell- `~/.cargo/bin` should be found and added to path


Ubuntu
------
