Build emacs from source for WSLg support
========================================

What I had to do on Windows 11 (build 22000.x). Based on

-	https://emacsredux.com/blog/2021/12/19/using-emacs-on-windows-11-with-wsl2/
-	https://batsov.com/articles/2021/12/19/building-emacs-from-source-with-pgtk/

cmd.exe (admin)
---------------

```
wsl --update
wsl --shutdown
```

WSL
---

```console
$ cat /proc/version

# Native JSON
$ sudo apt install libjansson4 libjansson-dev

# Native Complilation
$ sudo apt install libgccjit0 libgccjit-10-dev gcc-10 g++-10

$ git clone git://git.sv.gnu.org/emacs.git

$ sudo apt install build-essential libgtk-3-dev libgnutls28-dev libtiff5-dev libgif-dev libjpeg-dev libpng-dev libxpm-dev libncurses-dev texinfo
$ cd emacs

$ sudo apt install autoconf

$ ./autogen.sh
$ export CC=/usr/bin/gcc-10 CXX=/usr/bin/gcc-10
$ ./configure --with-native-compilation --with-json --with-pgtk

$ make -j13
$ sudo make install
```
