#!/bin/bash -x

# Using output from # cvt 2560 1440 60
xrandr --newmode "2560x1440_60.00"  312.25  2560 2752 3024 3488  1440 1443 1448 1493 -hsync +vsync
# the next line may error if mode is already defined
xrandr --verbose --addmode DP-1 "2560x1440_60.00"
xrandr  --output DP-1 --mode "2560x1440_60.00" --left-of HDMI-1

# xrandr --listmonitors
# Monitors: 2
#  0: +*DP-1 2560/600x1440/330+0+0  DP-1
#  1: +HDMI-1 2560/597x1440/336+2560+0  HDMI-1
# xrandr --verbose --listproviders
