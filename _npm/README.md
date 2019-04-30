**List of packages to install via `npm`, the *node.js* packaging tool.**

     └── npm_global_packages.list

---

To create the packages list do :

```shell
#!/bin/bash
# Save to a file npm's global packages
list="$(npm list --global --parseable --depth=0 | sed '1d')"
newlist=""
for i in $list; do
  name="${i##*/}"
  newlist+="$name "
done
echo "$newlist"
echo "$newlist" > npm_global_packages.list
```


To (re)install :

```shell
[sudo] npm install --global $(cat npm_global_packages.list)
```
