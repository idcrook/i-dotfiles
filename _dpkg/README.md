**List of packages to install via `dpkg`, the package manager for Debian (and Ubuntu) distributions.**

    └── install_packages.txt        Packages list

---

To reproduce packages that were at one time manually installed using `apt/apt-get` do :

```shell
( (  zcat $(ls -tr /var/log/apt/history.log*.gz ) ; \
     cat /var/log/apt/history.log ) | \
   egrep '^(Start-Date:|Commandline:)' | \
   grep -v aptdaemon ; ) | \
 egrep '^Commandline:.*install|^\[INSTALL\]' | \
 sed 's#Commandline: ##' | \
 awk '/INSTALL/ { print $2 }; !/INSTALL/ { print $0 }; ' 1> \
install_packages.txt
```

Inspect the file `install_packages.txt` to see the commands to replicate.
