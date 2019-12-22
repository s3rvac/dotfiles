#!/bin/sh
#
# Author: Petr Zemek <s3rvac@gmail.com>
#
# Locks the screen.
#

# Turn off the screen.
sleep 0.3; xset dpms force off

# Lock the screen.
XSECURELOCK_SAVER=saver_blank XSECURELOCK_AUTH=auth_pam_x11 xsecurelock
