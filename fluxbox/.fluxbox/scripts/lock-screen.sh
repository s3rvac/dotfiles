#!/bin/sh
#
# Author: Petr Zemek <s3rvac@petrzemek.net>
#
# Locks the screen.
#

# Turn off the screen.
sleep 0.3; xset dpms force off

# Lock the screen.
#
# XSECURELOCK_NO_COMPOSITE=1 is there to fix compatibility issues of xsecurelock
# with the xcompmgr compositor ("INCOMPATIBLE COMPOSITOR, PLEASE FIX!").
# https://github.com/google/xsecurelock?tab=readme-ov-file#known-compatibility-issues
XSECURELOCK_SAVER=saver_blank XSECURELOCK_AUTH=auth_pam_x11 XSECURELOCK_NO_COMPOSITE=1 xsecurelock
