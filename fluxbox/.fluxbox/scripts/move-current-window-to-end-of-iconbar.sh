#!/bin/sh
#
# Author: Petr Zemek <s3rvac@petrzemek.net>
#
# Moves the currently active window to the end of Fluxbox's iconbar (the part
# of taskbar containing opened windows). The primary use of this script is to
# move windows in the iconbar via a keybord shortcut as this is something that
# Fluxbox unfortunatelly does not support out of the box.
#
# Based on https://bgstack15.wordpress.com/2019/09/05/rearrange-windows-on-iconbar-in-fluxbox/
#

xdotool getactivewindow windowunmap windowmap
