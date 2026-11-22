#!/bin/env bash
#
# Volume control.
#
# Requirements:
#   - pactl (from PulseAudio)
#   - osd_cat (from xosd-bin)
#
# How the OSD works:
#   Starting osd_cat on every invocation is slow and, during rapid updates,
#   leads to overlapping text. Instead, a single long-lived osd_cat process is
#   shared by all invocations:
#   - osd_cat reads lines from a FIFO ($osd_fifo). It runs with --lines=1 and
#     without --wait, so each new line immediately replaces the previous one,
#     and the OSD disappears --delay seconds after the last line. The FIFO is
#     opened read-write (<>) so that osd_cat never gets EOF when a writer
#     closes it.
#   - Each invocation writes its status line to the FIFO and records the time
#     of the update in $osd_stamp. If osd_cat is not running (checked via
#     $osd_pidfile), the invocation starts it first.
#   - A background watchdog stops osd_cat after $osd_idle_timeout seconds
#     without an update and removes the FIFO, pid file, and stamp. The next
#     invocation recreates them and starts osd_cat again.
#   - $osd_lockfile (flock) serializes starting osd_cat, updating the stamp,
#     writing to the FIFO, and the watchdog's decision to stop osd_cat. This
#     prevents duplicate processes and lost or stale lines.
#

# Paths for the long-lived OSD process (see start_osd()).
runtime_dir=${XDG_RUNTIME_DIR:-/tmp}
osd_fifo=$runtime_dir/volume-control-osd.fifo
osd_pidfile=$runtime_dir/volume-control-osd.pid
osd_lockfile=$runtime_dir/volume-control-osd.lock
# Holds the time (in epoch seconds) of the last volume update.
osd_stamp=$runtime_dir/volume-control-osd.stamp
# Stop the OSD process after this many seconds without a volume update.
osd_idle_timeout=5

osd_is_running() {
	local pid
	read -r pid 2>/dev/null < "$osd_pidfile" || return 1
	[[ -r /proc/$pid/comm && $(< "/proc/$pid/comm") == osd_cat ]]
}

# Stops the OSD process (pid $1) once it has been idle for $osd_idle_timeout
# seconds and removes its temporary files. Runs in the background and exits
# when the OSD process is gone.
osd_watchdog() {
	local pid=$1 last
	while kill -0 "$pid" 2>/dev/null; do
		read -r last < "$osd_stamp"
		if (( EPOCHSECONDS - last >= osd_idle_timeout )); then
			# Re-check under the lock so that we do not kill the OSD process
			# between an invocation's update and its write to the FIFO.
			{
				flock 9
				read -r last < "$osd_stamp"
				if (( EPOCHSECONDS - last >= osd_idle_timeout )); then
					kill "$pid"
					# The lock file stays: removing a file that other
					# invocations may be waiting to lock would let two of
					# them hold "the" lock at once.
					rm -f "$osd_fifo" "$osd_pidfile" "$osd_stamp"
					return
				fi
			} 9> "$osd_lockfile"
		else
			sleep $(( osd_idle_timeout - (EPOCHSECONDS - last) ))
		fi
	done
}

# Starts a single osd_cat that reads lines from a FIFO. With --lines=1 and no
# --wait, every new line immediately replaces the previous one, and the OSD
# disappears --delay seconds after the last line. A watchdog stops it when it
# is no longer needed.
start_osd() {
	[[ -p $osd_fifo ]] || { rm -f "$osd_fifo"; mkfifo -m 600 "$osd_fifo"; }
	# Opening the FIFO read-write (<>) keeps osd_cat from getting EOF when a
	# writer closes it. Close the lock fd (9) so that osd_cat and the watchdog
	# do not hold the lock.
	osd_cat --lines=1 --delay=1 --align=right --pos=bottom --offset=60 \
		--color=green --font='-*-helvetica-bold-*-*-*-34-*-*-*-*-*-*-*' \
		<> "$osd_fifo" >/dev/null 2>&1 9>&- &
	local pid=$!
	echo "$pid" > "$osd_pidfile"
	osd_watchdog "$pid" >/dev/null 2>&1 9>&- &
}

show_volume_status() {
	local status="$1"
	echo "Volume: $status"

	# The lock serializes starting the OSD process, updating the stamp, and
	# the watchdog's decision to stop it.
	exec 9> "$osd_lockfile"
	flock 9
	echo "$EPOCHSECONDS" > "$osd_stamp"
	osd_is_running || start_osd
	# Opening the FIFO read-write never blocks. Short writes are atomic.
	printf '%s\n' "$status" 1<> "$osd_fifo"
	exec 9>&-
}

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
