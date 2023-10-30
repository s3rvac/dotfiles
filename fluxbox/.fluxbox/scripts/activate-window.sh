#!/bin/sh
#
# Author: Petr Zemek <s3rvac@petrzemek.net>
#
# Activates a window of the given application ($1) on the current desktop. If
# there is no such window, it runs the application.
#

APPLICATION="$1"
DESKTOP=$(xdotool get_desktop)
WINDOW=$(xdotool search --desktop "$DESKTOP" --class "$APPLICATION" | head -n1)
if [ ! -z "$WINDOW" ]; then
	# The window exists, so activate it.
	xdotool windowactivate "$WINDOW"
else
	# The window does not exist, so run the application.
	$APPLICATION
fi
