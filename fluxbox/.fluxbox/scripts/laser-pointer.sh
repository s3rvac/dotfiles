#!/bin/sh
#
# Author: Petr Zemek <s3rvac@petrzemek.net>
#
# Toggles a laser pointer effect on the mouse cursor (useful for
# presentations).
#
# Requirements:
#   - https://github.com/naclomi/xlaserpointer
#

if pgrep -x xlaserpointer > /dev/null; then
	killall xlaserpointer
else
	xlaserpointer --size 10 --trail 10
fi
