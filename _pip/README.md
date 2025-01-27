# Python

**List of packages to install for user via `pip`, the python packaging tool.**

`python2` is deprecated mostly everywhere now (Linux, macOS, etc.) so focus on `python3`

## macOS / Linux

We are using `--user` for shell-wide availability

In a newly sourced shell (to get the proper environment)

```shell
cd ~/.dotfiles/_pip/
# use a corresponding one
pip3 install --break-system-packages --user --requirement  packages3.ubuntu24.04.txt
pip3 install --user --requirement packages3.ubuntu22.04.txt
pip3 install --break-system-packages --user --requirement  packages3.raspios.bookworm.txt

# for ESP, micropython, arduino, etc.
pip3 install --break-system-packages --user --requirement  packages.hwdev.macos.txt
```
If get an error about `~/.local/bin` not being in PATH, that should be transient and go away in a newly-sourced shell (it should be in PATH from `shell` stow module.

## uv

<https://github.com/astral-sh/uv>

<https://docs.astral.sh/uv/getting-started/installation/>

```
# Linux/macOS user install
pip3 install --break-system-packages --user uv

# macOS
brew install uv
```

## pipx

<https://pypa.github.io/pipx/> - Install and Run Python Applications in Isolated Environments

### Install pipx

debian / ubuntu

```shell
python3 -m pip install --user pipx
python3 -m pipx ensurepath
```

macOS

```shell
brew install pipx
pipx ensurepath
```

### Use pipx

```console
> pipx install glances
⣻ upgrading shared libraries ...
  These apps are now globally available
    - glances
done! ✨ 🌟 ✨
> pipx inject glances "glances[web]"
> pipx list
> glances
```

### useful pipx apps

- `glances` - a cross-platform system monitoring tool written in Python. - https://nicolargo.github.io/glances/
- `ptpython` - A better Python REPL - https://github.com/prompt-toolkit/ptpython
- `asciinema` - Terminal session recorder - https://github.com/asciinema/asciinema
  - `pipx run asciinema`

# Generate list or upgrade packages

To generate a packages list do something like:

```
pip3 list --format=columns | sed '/Package/,/---------/d' | \
    cut -d " " -f 1 > packages3.txt
```

To install :

```
which pip3
# (masOS) ensure it is pointing to Homebrew version
pip3 install --break-system-packages --user -r packages3.txt
```

(upgrade and/or) re-install packages

```shell
pip3 install --upgrade --force-reinstall  --user --break-system-packages -r packages3.txt
pip3 install --ignore-installed           --user --break-system-packages -r packages3.txt
```
