#!/usr/bin/env bash
#
# Author: Petr Zemek <s3rvac@petrzemek.net>
#
# Starts Chromium.
#

# When using multiple monitors, Chromium tends to open on a secondary one
# instead of on the primary one. Depending on the current setup, open Chromium
# at the primary monitor.

# Cache the results of xrandr in a file as xrandr calls can be rather slow.
XRANDR_PRIMARY_OUTPUT_FILE="/tmp/xrandr-primary-output.txt"
if [ ! -f "$XRANDR_PRIMARY_OUTPUT_FILE" ]; then
	echo "Determining the primary output from xrandr..."
	xrandr -q | grep 'connected primary' > "$XRANDR_PRIMARY_OUTPUT_FILE"
fi
XRANDR_PRIMARY_OUTPUT=$(cat "$XRANDR_PRIMARY_OUTPUT_FILE")

# An example of $XRANDR_PRIMARY_OUTPUT:
#
#     DP-0 connected primary 2560x1440+1920+0 (normal left inverted right x axis y axis) 597mm x 336mm
#
PRIMARY_WIDTH=$(sed   -E "s/.* connected primary ([0-9]+)x([0-9]+)\+([0-9]+)\+([0-9]+).*/\\1/" <<< "$XRANDR_PRIMARY_OUTPUT")
PRIMARY_HEIGHT=$(sed  -E "s/.* connected primary ([0-9]+)x([0-9]+)\+([0-9]+)\+([0-9]+).*/\\2/" <<< "$XRANDR_PRIMARY_OUTPUT")
PRIMARY_START_X=$(sed -E "s/.* connected primary ([0-9]+)x([0-9]+)\+([0-9]+)\+([0-9]+).*/\\3/" <<< "$XRANDR_PRIMARY_OUTPUT")
PRIMARY_START_Y=$(sed -E "s/.* connected primary ([0-9]+)x([0-9]+)\+([0-9]+)\+([0-9]+).*/\\4/" <<< "$XRANDR_PRIMARY_OUTPUT")

chromium "--window-position=${PRIMARY_START_X},${PRIMARY_START_Y}" "--window-size=${PRIMARY_WIDTH}x${PRIMARY_HEIGHT}"
