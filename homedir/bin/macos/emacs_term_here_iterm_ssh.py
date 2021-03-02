#!/usr/bin/env python3

# To install:
# brew install python3
# pip3 install --user iterm2
# pip3 install --user pyobjc
# chmod +x iterm_command.py

# import string
import sys

# 2019-May-21: Requires iTerm that has the Python API enabled (beta (v3.3+))

import iterm2
import AppKit

bundle = "com.googlecode.iterm2"
if not AppKit.NSRunningApplication.runningApplicationsWithBundleIdentifier_(bundle):
    AppKit.NSWorkspace.sharedWorkspace().launchApplication_("iTerm")


async def main(connection):
    """Main routine."""
    app = await iterm2.async_get_app(connection)
    await app.async_activate()

    # This will run 'ssh' on macOS with the arguments supplied
    my_cmd = "/usr/bin/ssh " + " ".join(sys.argv[1:])
    # print(my_cmd)
    await iterm2.Window.async_create(connection, command=my_cmd)


iterm2.run_until_complete(main, True)
