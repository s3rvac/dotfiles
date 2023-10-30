#!/bin/sh
#
# Author: Petr Zemek <s3rvac@petrzemek.net>
#
# Clears all notifications sent by notify-send.
#

for window_id in $(xdotool search --class xfce4-notifyd); do
	xdotool windowkill "$window_id"
done
