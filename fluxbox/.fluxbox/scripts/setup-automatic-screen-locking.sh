#!/bin/sh
#
# Sets up automatic screen locking. Requires xautolock.
#

INACTIVITY_MINS=30

xautolock -time "$INACTIVITY_MINS" -locker xsecurelock -nowlocker xsecurelock -detectsleep
