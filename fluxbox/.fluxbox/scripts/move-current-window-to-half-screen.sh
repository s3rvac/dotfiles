#!/usr/bin/env bash
#
# Author: Petr Zemek <s3rvac@petrzemek.net>
#
# Moves the currently active window to the "left" or "right" ($1) part of the
# screen.
#

# Maximize the window so we can measure the dimensions of the current screen.
wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
sleep 0.1

# Take window's measurements.
WIN_GEOMETRY=$(xdotool getactivewindow getwindowgeometry)
WIN_W=$(grep 'Geometry' <<< "$WIN_GEOMETRY" | sed 's/  Geometry: \(.*\)x.*/\1/')
WIN_H=$(grep 'Geometry' <<< "$WIN_GEOMETRY" | sed 's/  Geometry: .*x\(.*\)/\1/')
WIN_X=$(grep 'Position' <<< "$WIN_GEOMETRY" | sed 's/  Position: \(.*\),.* (screen: .*)/\1/')
WIN_Y=$(grep 'Position' <<< "$WIN_GEOMETRY" | sed 's/  Position: .*,\(.*\) (screen: .*)/\1/')

# Compute the new size and position.
WIN_Y=0
if [ "$1" = "left" ]; then
	WIN_W=$((WIN_W / 2))
elif [ "$1" = "right" ]; then
	WIN_W=$((WIN_W / 2))
	WIN_X=$((WIN_X + WIN_W))
else
	echo "error: not enough arguments or unsupported argument $1" >&2
	exit 1
fi

# Finally, resize the window according to the computed size and position.
wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
wmctrl -r :ACTIVE: -e "0,$WIN_X,$WIN_Y,$WIN_W,$WIN_H"
