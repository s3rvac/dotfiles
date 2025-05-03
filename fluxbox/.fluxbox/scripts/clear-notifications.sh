#!/bin/sh
#
# Author: Petr Zemek <s3rvac@petrzemek.net>
#
# Clears all notifications sent by notify-send.
#

for window_id in $(xdotool search --onlyvisible --class xfce4-notifyd); do
   xdotool windowclose "$window_id"
done
