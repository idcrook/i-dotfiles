install recent golang
=====================

Ubuntu
------

See `../_dpkg/install_packages.ubuntu20.04.txt` for Ubuntu 20.04 LTS

https://github.com/golang/go/wiki/Ubuntu

On 18.04 LTS or 19.10 Ubuntu, as of April 2020, it is golang 1.14

```
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt update
sudo apt install golang-go
```

Raspberry Pi OS
---------------

See https://golang.org/dl/ for latest version. There are currently ARMv6 and ARMv8 (64-bit) ARM versions

```console
$ cd ~/Downloads/
$ wget https://golang.org/dl/go1.16.3.linux-armv6l.tar.gz
$ sha256sum go1.16.3.linux-armv6l.tar.gz
$ test -d /usr/local/go && sudo rm -rf /usr/local/go 
$ sudo tar -C /usr/local -xzf go1.16.3.linux-armv6l.tar.gz
```

The above commands will install into `/usr/local/go/bin`

macOS
-----

golang is installed via Homebrew.

Some utilities that can be installed from source
================================================

`ccat` - Colorizing `cat`
-------------------------

```shell
go get -u github.com/jingweno/ccat
```

`mdfmt` - markdownfmt replacement
---------------------------------

`mdfmt` needs to use a modules, needs a special build flow

```shell
go get -d -v github.com/moorereason/mdfmt
# cd ~/go/src/github.com/moorereason/mdfmt
GO111MODULE=on  go get github.com/gohugoio/hugo@v0.49.2
GO111MODULE=on  go get -v github.com/moorereason/mdfmt
```

### `mdfmt` needed a modified build flow

```
go get -u github.com/moorereason/mdfmt

# github.com/moorereason/mdfmt
./main.go:64:15: undefined: parser.ReadFrom
```
