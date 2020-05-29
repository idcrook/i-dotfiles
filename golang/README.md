install recent golang
=====================

https://github.com/golang/go/wiki/Ubuntu

On 18.04 LTS or 19.10 Ubuntu, as of April 2020, it is golang 1.14

```
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt update
sudo apt install golang-go
```

See `../_dpkg/install_packages.ubuntu20.04.txt` for Ubuntu 20.04 LTS

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
cd ~/go/src/github.com/moorereason/mdfmt
GO111MODULE=on  go get github.com/gohugoio/hugo@v0.49.2
GO111MODULE=on  go get -v github.com/moorereason/mdfmt
```

### markdownfmt (Deprecated)

Switched from `markdownfmt` to `mdfmt` (see above) since `mdfmt` allows front matter in the markdown files

```shell
go get -u github.com/shurcooL/markdownfmt
```

### `mdfmt` needed a modified build flow

```
go get -u github.com/moorereason/mdfmt

# github.com/moorereason/mdfmt
./main.go:64:15: undefined: parser.ReadFrom
```
