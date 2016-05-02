#!/bin/sh
#
# Author: Petr Zemek <s3rvac@gmail.com>
#
# Sets the background of the screens.
#

# Use a completely black background on both screens.
SCREEN0_BG=~/.fluxbox/backgrounds/black.png
SCREEN1_BG=~/.fluxbox/backgrounds/black.png

feh --image-bg black --bg-max "$SCREEN0_BG" "$SCREEN1_BG"
