#!/bin/sh
#
# Author: Petr Zemek <s3rvac@petrzemek.net>
#
# Sets up automatic screen locking. Requires xautolock.
#

INACTIVITY_MINS=30

xautolock -time "$INACTIVITY_MINS" -locker xsecurelock -nowlocker xsecurelock -detectsleep
