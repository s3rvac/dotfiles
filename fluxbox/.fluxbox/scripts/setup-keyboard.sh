#!/bin/sh
#
# Author: Petr Zemek <s3rvac@petrzemek.net>
#
# Sets up the keyboard.
#

# Repeat delay and rate.
xset r rate 200 40

# Layouts.
setxkbmap -model pc104 -layout us,cz -variant ,qwerty

# Use Alt+Shift to toggle between layouts.
setxkbmap -option grp:alt_shift_toggle

# Turn Caps Lock into a second Escape.
setxkbmap -option caps:escape

# Start a keyboard layout switcher.
# (It will automatically run in background.)
qxkb
