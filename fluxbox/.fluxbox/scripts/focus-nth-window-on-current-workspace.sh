#!/bin/sh
#
# Author: Petr Zemek <s3rvac@petrzemek.net>
#
# Focuses (activates) the Nth window (where N is the first argument) on the
# current workspace.

N=$1
if [ -z "$N" ]; then
	echo "Usage: $0 N" >&2
	exit 1
fi

# Get the number of the current workspace (identified by '*' in the output of
# wmctrl).
current_workspace=$(wmctrl -d | awk '{ if ($2 == "*") print $1}')

# Get the ID of the Nth window on the current workspace. This is based on an
# assumption that the order of windows in a workspace is the same as the order
# from wmctrl (i.e. windows are ordered by the time they were created).
nth_window_id=$(
	wmctrl -l |\
	awk -v workspace="$current_workspace" "{ if (\$2 == workspace) print \$1}" |\
	sed -n "${N}p"
)
if [ -z "$nth_window_id" ]; then
	echo "error: window number $N not found" >&2
	exit 1
fi

# Focus/activate the window.
wmctrl -i -R "$nth_window_id"
