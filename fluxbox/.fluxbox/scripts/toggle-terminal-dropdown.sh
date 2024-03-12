#!/usr/bin/env bash
#
# Author: Petr Zemek <s3rvac@petrzemek.net>
#
# Toggles a terminal dropdown.
#
# This is similar to Yakuake (https://apps.kde.org/en/yakuake/), but the script
# uses tdrop (https://github.com/noctuid/tdrop) to support arbitrary terminal emulator,
# not just Yakuake (KDE Konsole UI).
#

# The empty width (-w) and height (-h) is used to prevent tdrop from
# altering the window size.
tdrop -a -r -w '' -h '' alacritty --title 'Alacritty - Yakuake'
