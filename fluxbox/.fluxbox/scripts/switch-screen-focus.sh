#!/bin/sh
#
# Author: Petr Zemek <s3rvac@gmail.com>
#
# Switches focus to the given screen.
#
# We do this by moving mouse cursor to the given screen, getting a window
# that's under the cursor, and focusing this window.
#
# Note: Do not try to return the mouse cursor to its original position - focus
#       switching then does not work!
#
# TODO The current (silly) implementation assumes that there are two screens, 0
#      and 1, and that the first screen has 1920 pixels.
#

# Should be either 0 or 1.
SCREEN="$1"

# Compute the position where we should move the mouse to switch focus.
if [ "$SCREEN" = "0" ]; then
	SCREEN_MOUSE_X_POS="1600"
else
	SCREEN_MOUSE_X_POS="1950"
fi
SCREEN_MOUSE_Y_POS="100"

# Move the mouse to the target position and set focus to the window under it.
xdotool mousemove "$SCREEN_MOUSE_X_POS" "$SCREEN_MOUSE_Y_POS"
WINDOW="$(xdotool getmouselocation --shell 2> /dev/null | grep 'WINDOW' | sed 's".*=\(.*\)"\1"')"
xdotool windowfocus "$WINDOW"
