#!/bin/sh
#
# Volume control.
#
# Requirements:
#   - pactl (from PulseAudio)
#   - osd_cat (from xosd-bin)
#

# Sets the global $vol.
read_volume() {
	local out
	out=$(pactl get-sink-volume @DEFAULT_SINK@)
	[[ $out =~ ([0-9]+)% ]] && vol=${BASH_REMATCH[1]}
}

# Sets the global $mute_status.
read_mute_status() {
	local out
	out=$(pactl get-sink-mute @DEFAULT_SINK@)
	if [[ $out == *yes* ]]; then mute_status=Muted; else mute_status=Unmuted; fi
}

show_volume_status() {
	local status="$1"
	echo "Volume: $status"

	# Kill any existing osd_cat instances to avoid overlapping messages.
	pkill osd_cat
	echo "$status" | osd_cat --delay=1 --age=0 --align=right --pos=bottom --offset=-80 --color=green --font='-*-helvetica-bold-*-*-*-34-*-*-*-*-*-*-*' &
}

case "$1" in
	up|down)
		read_volume
		if [[ $1 == up ]]; then
			new=$(( vol + 5 > 100 ? 100 : vol + 5 ))
		else
			new=$(( vol - 5 < 0 ? 0 : vol - 5 ))
		fi
		pactl set-sink-volume @DEFAULT_SINK@ "${new}%"
		show_volume_status "${new}%"
		;;
	toggle)
		pactl set-sink-mute @DEFAULT_SINK@ toggle
		read_mute_status
		show_volume_status "$mute_status"
		;;
	status)
		read_volume
		show_volume_status "${vol}%"
		;;
	*)
		echo "Usage: $0 {up|down|toggle|status}" >&2
		exit 1
		;;
esac
