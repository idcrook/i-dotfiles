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

On Ubuntu (and possibly other platforms, depending on your config), should preface these with `sudo`
