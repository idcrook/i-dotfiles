install recent golang
=====================

Ubuntu
------

See `../_dpkg/install_packages.ubuntu20.04.txt` for Ubuntu 20.04 LTS

See `../_dpkg/install_packages.ubuntu22.04.txt` for Ubuntu 22.04 LTS

https://github.com/golang/go/wiki/Ubuntu

On 18.04 LTS or 19.10 Ubuntu, as of April 2020, it is golang 1.14

```
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt update
sudo apt install golang-go
```

Debian 11 (bullseye)
--------------------

```shell
sudo apt install golang-go
```

Raspberry Pi OS (bookworm)
---------------

version 1.19  as of January 2024

```shell
sudo apt install -y golang-go
```

Raspberry Pi OS (manual)
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
go install github.com/jingweno/ccat@latest
```

`mdfmt` - markdownfmt replacement
---------------------------------

```shell
go install -v github.com/moorereason/mdfmt@latest
```

## `wakatime-cli`

Now a python wrapper: <https://pypi.org/project/wakatime/>


```console
$ pip3 install wakatime
$ pip3 install wakatime --user --break-system-packages
```

Works on Raspberry Pi OS

```
python3 -c "$(wget -q -O - https://raw.githubusercontent.com/wakatime/vim-wakatime/master/scripts/install_cli.py)"
```

<https://github.com/wakatime/wakatime-cli/releases>

<https://wakatime.com/help/creating-plugin#plugin-init:wakatime-cli>

errors about '`replace`' in `go.mod`

```shell
# DOES NOT WORK # go install -v github.com/wakatime/wakatime-cli
# DOES NOT WORK # go install github.com/wakatime/wakatime-cli@latest
```



#### DEPRECATED: `ccat`

```shell
go get -u github.com/jingweno/ccat
```

#### DEPRECATED: `mdfmt` needs to use a modules, needs a special build flow

```shell
go get -d -v github.com/moorereason/mdfmt
# cd ~/go/src/github.com/moorereason/mdfmt
GO111MODULE=on  go get github.com/gohugoio/hugo@v0.49.2
GO111MODULE=on  go get -v github.com/moorereason/mdfmt
```

on go1.17

```
GO111MODULE=on  go get github.com/gohugoio/hugo@v0.49.2
go get: installing executables with 'go get' in module mode is deprecated.
	Use 'go install pkg@version' instead.
	For more information, see https://golang.org/doc/go-get-install-deprecation
	or run 'go help get' or 'go help install'.
```

### `mdfmt` needed a modified build flow

```
go get -u github.com/moorereason/mdfmt

# github.com/moorereason/mdfmt
./main.go:64:15: undefined: parser.ReadFrom
```
