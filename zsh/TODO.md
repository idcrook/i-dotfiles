zsh TODO
========

Fix emacsclient
---------------

-	adjust aliases and `$EDITOR` to work on macOS

#### RESOLVED

with spaces in $EDITOR envariable value, need to tell `zsh` not to treat as a single command/argument. There are two solutions that work, without creating a script wrapper that contains no spaces (from argument separators) in its value

```shell
$=EDITOR README.md
eval $EDITOR README.md
```

Exact problem was discussed: https://stackoverflow.com/q/8299610/47850
