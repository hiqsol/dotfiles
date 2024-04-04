#!/bin/sh

xrandr --newmode "2560x1600_30.00"  164.10  2560 2688 2960 3360  1600 1601 1604 1628  -HSync +Vsync
xrandr --addmode HDMI-2 "2560x1600_30.00"

xrandr --output DP-1 --mode 3840x2160 --pos 1600x0 --rotate right --output HDMI-1 --off --output HDMI-2 --primary --mode 2560x1600_30.00 --pos 0x0 --rotate left --output DP-2 --off
