#!/bin/sh
#
# Author: Petr Zemek <s3rvac@gmail.com>
#
# Sets the background of the screen(s).
#

# Find the screen resolution.
# TODO When using dual heads, width is 3360 (or similar), i.e. the sum of the
#      widths of both monitors.
# LINE=`xrandr -q | grep Screen`
# WIDTH=`echo ${LINE} | awk '{ print $8 }'`
# HEIGHT=`echo ${LINE} | awk '{ print $10 }' | awk -F"," '{ print $1 }'`
# RES="${WIDTH}x${HEIGHT}"

# Choose a proper background image depending on the used resolution.
# Note: I assume that the background file exists for the used resolution.
SCREEN0_BG=~/.fluxbox/backgrounds/wallpaper.jpg
SCREEN1_BG=~/.fluxbox/backgrounds/black.png

# Set the background.
feh --image-bg black --bg-max "$SCREEN0_BG" "$SCREEN1_BG"
