#!/bin/sh
#
# Author: Petr Zemek <s3rvac@petrzemek.net>
#
# Toggles Thunderbird:
# - When it is not running, it starts it.
# - When it is running and it is minimized, it brings it to the foreground.
# - When it is running on the foreground, it is minized.
#

THUNDERBIRD_PID=$(pidof thunderbird)
if [ -z "$THUNDERBIRD_PID" ]; then
	# Thunderbird is not running -> start it.
	thunderbird &
	exit 0
fi

ACTIVE_WINDOW=$(xdotool getwindowfocus)
THUNDERBIRD_WINDOW=$(xdotool search --name "Mozilla Thunderbird")
if [ "$ACTIVE_WINDOW" != "$THUNDERBIRD_WINDOW" ]; then
	# Thunderbird is minimized -> bring it to the foreground.
	thunderbird -mail
	exit 0
fi

# Minimize it.
xdotool windowunmap "$THUNDERBIRD_WINDOW"
exit 0
