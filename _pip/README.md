**List of packages to install via `pip`, the python packaging tool.**

---

To create the packages list do :

```
pip3 list --format=columns | sed '/Package/,/---------/d' | \
    cut -d " " -f 1 > packages3.txt
```

To install :

```
pip3 install -r packages3.txt
```

### macOS


```shell
pip3 install --user -r packages3.bigsur.txt
```

(upgrade and/or) re-install packages

```shell
pip3 install --upgrade --force-reinstall  --user -r packages3.bigsur.txt
pip3 install --ignore-installed           --user -r packages3.bigsur.txt
```

### Ubuntu

Since we are using `--user` should not need to preface with `sudo`

In a newly sourced shell (to get the proper environment)

```shell
pip3 install --user --requirement packages3.ubuntu20.04.txt
```

may get an error if not using an updated shell session about `~/.local/bin` not being in PATH. that should be a transient error.

#### pyenv

works for zsh or bash

```
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
```


### Raspbian buster

Since we are using `--user` should not need to preface with `sudo`

```shell
pip3 install --user --requirement packages3.raspbian.buster.txt
```

### Ubuntu 20.10 groovy on x86-64

```shell
pip3 install --user --requirement packages3.ubuntu20.10.txt
```

### Ubuntu 20.10 groovy on Pi 4

```shell
pip3 install --user --requirement packages3.ubuntu20.10.raspi.txt
```


#### `pyenv`

Via https://github.com/pyenv/pyenv/wiki/Common-build-problems

```
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
```

now clone over

```
python --version
# > Python 3.6.7
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git ~/.pyenv/plugins/pyenv-virtualenvwrapper
# will need to relogin - so pyenv gets sourced into environment
pyenv install 3.7.3
pyenv global 3.7.3
python --version
# > Python 3.7.3
```
