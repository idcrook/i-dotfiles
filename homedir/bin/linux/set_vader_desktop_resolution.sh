#!/bin/sh -x

# DP-0 solo port in second row
# DP-2 single port between HDMI and top of card
nvidia-settings --assign CurrentMetaMode="HDMI-0: nvidia-auto-select +2560+0 {ViewPortIn=2560x1440, ViewPortOut=2560x1440+0+0}, DP-2: nvidia-auto-select +0+0 {ViewPortIn=2560x1440, ViewPortOut=3840x2160+0+0}"

# for some reason the X server does this instead, offsetting the viewport for the second screen (screen on  the right):
# Setting mode "HDMI-0: nvidia-auto-select @2560x1440 +3840+0 {ViewPortIn=2560x1440, ViewPortOut=2560x1440+0+0}, DP-0: nvidia-auto-select @2560x1440 +0+0 {ViewPortIn=2560x1440, ViewPortOut=3840x2160+0+0}"
# the +3840 is a problem
