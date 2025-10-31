#!/bin/sh
#
# Author: Petr Zemek <s3rvac@petrzemek.net>
#
# Volume control.
#
# Requirements:
#   - pactl (from PulseAudio)
#   - osd_cat (from xosd-bin)
#

get_current_volume() {
	pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+%' | head -n1 | sed 's/%//'
}

get_mute_unmute_status() {
	pactl get-sink-mute @DEFAULT_SINK@ | grep -Po 'yes|no' | sed 's/yes/Muted/' | sed 's/no/Unmuted/'
}

show_volume_status() {
	status="${1}"
	echo "Volume: $status"

	# Kill any existing osd_cat instances to avoid overlapping messages.
	pkill osd_cat
	echo "${status}" | osd_cat --delay=1 --age=0 --align=right --pos=bottom --offset=-80 --color=green --font=-*-helvetica-bold-*-*-*-34-*-*-*-*-*-*-* &
}

if [ "$1" = "up" ]; then
	if [ "$(get_current_volume)" -le 95 ]; then
		pactl set-sink-volume @DEFAULT_SINK@ +5%
	else
		pactl set-sink-volume @DEFAULT_SINK@ 100%
	fi
	show_volume_status "$(get_current_volume)%"
elif [ "$1" = "down" ]; then
	if [ "$(get_current_volume)" -ge 5 ]; then
		pactl set-sink-volume @DEFAULT_SINK@ -5%
	else
		pactl set-sink-volume @DEFAULT_SINK@ 0%
	fi
	show_volume_status "$(get_current_volume)%"
elif [ "$1" = "toggle" ]; then
	pactl set-sink-mute @DEFAULT_SINK@ toggle
	show_volume_status "$(get_mute_unmute_status)"
elif [ "$1" = "status" ]; then
	show_volume_status "$(get_current_volume)%"
else
	echo "Usage: $0 {up|down|toggle|status}" >&2
	exit 1
fi
