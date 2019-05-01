#!/bin/sh

# Open project directory in iterm
if [ -n "$XcodeProjectPath" ]; then
  open -a iTerm "$XcodeProjectPath"/..
else
  open -a iTerm "$XcodeWorkspacePath"/..
fi
