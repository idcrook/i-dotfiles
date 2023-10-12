# Python

**List of packages to install via `pip`, the python packaging tool.**

---

To generate a packages list do something like:

```
pip3 list --format=columns | sed '/Package/,/---------/d' | \
    cut -d " " -f 1 > packages3.txt
```

To install :

```
which pip3
# (masOS) ensure it is pointing to Homebrew version
pip3 install -r packages3.txt
```

(upgrade and/or) re-install packages

```shell
pip3 install --upgrade --force-reinstall  --user -r packages3.txt
pip3 install --ignore-installed           --user -r packages3.txt
```

## macOS / Ubuntu / Debian / Ras Pi OS / WSL

Since we are using `--user` should not need to preface with `sudo`

In a newly sourced shell (to get the proper environment)

```shell
cd ~/.dotfiles/_pip/
# use matching one
pip3 install --user --requirement packages3.ubuntu22.04.txt
pip3 install --user --requirement packages3.ubuntu20.04.txt
pip3 install --user --requirement packages3.ubuntu20.10.txt
pip3 install --user --requirement packages3.debian.bullseye.txt
pip3 install --user --requirement packages3.raspios.buster.txt
pip3 install --user --requirement packages3.ubuntu20.10.raspi.txt
pip3 install --user --requirement packages3.raspios.bullseye.txt
pip3 install --user -r packages3.bigsur.txt
pip3 install --user -r packages3.ventura.txt
pip3 install --user -r packages3.sonoma.txt
```
may get an error if not using an updated shell session about `~/.local/bin` not being in PATH. that should be a transient error and go away in a newly-sourced shell.

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