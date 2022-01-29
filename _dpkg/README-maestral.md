# Install and Setup `maestral`

work-ilike Dropbox client

- https://maestral.app/docs/installation
- https://github.com/samschott/maestral

## installing manually on WSL2/Win11

```shell
pip3 install --user --upgrade maestral[gui]
# ERROR: launchpadlib 1.10.13 requires testresources, which is not installed.

maestral_qt  # ... missing lib dependencies

# qt.qpa.plugin: Could not load the Qt platform plugin "xcb" in "" even though it was found.
export QT_DEBUG_PLUGINS=1

# "Cannot load library /home/dpc/.dotfiles/shell/.local/lib/python3.8/site-packages/PyQt5/Qt5/plugins/platforms/libqxcb.so: (libxcb-xkb.so.1: cannot open shared object file: No such file or directory)"
sudo apt-get install --reinstall libxcb-xinerama0

# "Cannot load library /home/dpc/.dotfiles/shell/.local/lib/python3.8/site-packages/PyQt5/Qt5/plugins/platforms/libqxcb.so: (libxkbcommon-x11.so.0: cannot open shared object file: No such file or directory)"
sudo apt install libxkbcommon-x11-0

maestral_qt  # ... link to dropbox via token obtained in browser login
```
