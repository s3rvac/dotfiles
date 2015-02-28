#!/bin/sh
#
# Author: Petr Zemek <s3rvac@gmail.com>
#
# Switches focus to the given screen.
#
# TODO The current (silly) implementation assumes that there are two screens, 0
#      and 1, and that the first screen has 1920 pixels.
#

# Should be either 0 or 1.
SCREEN="$1"

if [ "$SCREEN" = "0" ]; then
	xdotool mousemove 1600 10 click 1
else
	xdotool mousemove 1950 10 click 1
fi
