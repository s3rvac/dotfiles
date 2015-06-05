#!/bin/bash
#
# Author: Petr Zemek <s3rvac@gmail.com>
#
# Starts konsole with the given program ($@) and ensures that it remains opened
# even when the program finishes.
#
# Example: start-konsole-with.sh mc
#

# Based on http://superuser.com/q/682850/241177
RC_FILE=$(mktemp)
cat ~/.bashrc > "$RC_FILE"
echo "$@" >> "$RC_FILE"
konsole --nofork -e /bin/bash --rcfile "$RC_FILE"
rm -f "$RC_FILE"
