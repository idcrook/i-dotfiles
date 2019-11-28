**List of packages to install via `pip`, the python packaging tool.**

```
├── packages2.txt        python2 packages list
└── packages3.txt        python3 packages list
```

---

To create the packages list do :

```
pip2 list --format=columns | sed '/Package/,/---------/d' | \
    cut -d " " -f 1 > packages2.txt
pip3 list --format=columns | sed '/Package/,/---------/d' | \
    cut -d " " -f 1 > packages3.txt
```

To install :

```
# pip2 install -r packages2.txt
pip3 install -r packages3.txt
```

### Ubuntu

Since we are using `--user` should not need to preface with `sudo`

```shell
#pip3 install --user --requirement packages3.ubuntu18.04.server.txt
pip3 install --user --requirement packages3.ubuntu19.10.txt
```

may get an error if not using an updated shell session about `~/.local/bin` not being in PATH. that should be a transient error.

### Raspbian buster

Since we are using `--user` should not need to preface with `sudo`

```shell
# pip2 install --user --requirement packages2.raspbian.buster.txt
pip3 install --user --requirement packages3.raspbian.buster.txt
```

#### `pyenv`

Via https://github.com/pyenv/pyenv/wiki/Common-build-problems

```
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
```

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
```

> Python 3.7.3
