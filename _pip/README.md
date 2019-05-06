**List of packages to install via `pip`, the python packaging tool.**

    ├── packages2.txt        python2 packages list
    └── packages3.txt        python3 packages list

---

To create the packages list do :

```
pip2 list --format=columns | sed '/Package/,/---------/d' | \
    cut -d " " -f 1 > packages2.txt
pip3 list --format=columns | sed '/Package/,/---------/d' | \
    cut -d " " -f 1 > packages3.txt
```

To install :

    pip2 install -r packages2.txt
    pip3 install -r packages3.txt



### ubuntu special

Since we are using `--user` should not need to preface with `sudo`

```shell
pip2 install --user --requirement packages2.ubuntu18.04.server.txt
pip3 install --user --requirement packages3.ubuntu18.04.server.txt
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git ~/.pyenv/plugins/pyenv-virtualenvwrapper
```
