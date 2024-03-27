#!/bin/sh
#
# Author: Petr Zemek <s3rvac@petrzemek.net>
#
# Sets up the mouse.
#

MOUSE='Logitech G403 Prodigy Gaming Mouse'

# Disable acceleration.
xinput --set-prop "$MOUSE" 'libinput Accel Profile Enabled' 0, 1

# Set sensitivity.
xinput --set-prop "$MOUSE" 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1

# Note: Other settings are set via https://github.com/libratbag/piper.
