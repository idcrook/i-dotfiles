Some utilities that can be installed from source
================================================

```shell
go get -u github.com/jingweno/ccat
```

`mdfmt` needs a special build flow
----------------------------------

mdfmt needs to use a modules

```
go get -u github.com/moorereason/mdfmt

# github.com/moorereason/mdfmt
./main.go:64:15: undefined: parser.ReadFrom
```

```shell
go get -d -v github.com/moorereason/mdfmt
cd ~/go/src/github.com/moorereason/mdfmt
GO111MODULE=on  go get github.com/gohugoio/hugo@v0.49.2
GO111MODULE=on  go get -v github.com/moorereason/mdfmt
```

### markdownfmt -> mdfmt

Switched from `markdownfmt` to `mdfmt` (see above) since `mdfmt` allows front matter in the markdown files

```shell
go get -u github.com/shurcooL/markdownfmt
```
