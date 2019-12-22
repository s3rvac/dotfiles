#!/bin/sh
#
# Author: Petr Zemek <s3rvac@gmail.com>
#
# Switches focus between screens ("left" or "right", depending on $1).
#
# We do this by moving mouse cursor to the new screen, getting a window that's
# under the cursor, and focusing this window.
#
# Notes:
# - The current naive implementation assumes that windows on all screens are
#   maximized, which suffices for me.
# - Do not try to return the mouse cursor to its original position - focus
#   switching then does not work!
#

# Take current window's measurements.
WIN_GEOMETRY=$(xdotool getactivewindow getwindowgeometry)
WIN_W=$(grep 'Geometry' <<< "$WIN_GEOMETRY" | sed 's/  Geometry: \(.*\)x.*/\1/')
WIN_H=$(grep 'Geometry' <<< "$WIN_GEOMETRY" | sed 's/  Geometry: .*x\(.*\)/\1/')
WIN_X=$(grep 'Position' <<< "$WIN_GEOMETRY" | sed 's/  Position: \(.*\),.* (screen: .*)/\1/')
WIN_Y=$(grep 'Position' <<< "$WIN_GEOMETRY" | sed 's/  Position: .*,\(.*\) (screen: .*)/\1/')

if [ "$1" = "left" ]; then
	MOUSE_X=$((WIN_X - 10))
	MOUSE_Y=100
elif [ "$1" = "right" ]; then
	MOUSE_X=$((WIN_X + WIN_W + 10))
	MOUSE_Y=100
else
	echo "error: not enough arguments or unsupported argument $1" >&2
	exit 1
fi

# Move the mouse cursor to the target position, get the window under the
# cursor, and activate the window.
xdotool mousemove "$MOUSE_X" "$MOUSE_Y"
WIN="$(xdotool getmouselocation --shell 2> /dev/null | grep 'WINDOW' | sed 's".*=\(.*\)"\1"')"
xdotool windowactivate "$WIN"
