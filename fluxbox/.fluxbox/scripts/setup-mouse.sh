#!/bin/sh
#
# Author: Petr Zemek <s3rvac@petrzemek.net>
#
# Sets up the mouse.
#

MOUSE='Logitech G403 Prodigy Gaming Mouse'

# Disable acceleration.
xinput --set-prop "$MOUSE" 'libinput Accel Profile Enabled' 0, 1

# Increase sensitivity.
xinput --set-prop "$MOUSE" 'Coordinate Transformation Matrix' 1.600000, 0.000000, 0.000000, 0.000000, 1.600000, 0.000000, 0.000000, 0.000000, 1.000000
