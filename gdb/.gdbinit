#------------------------------------------------------------------------------
# File:   $HOME/.gdbinit
# Author: Petr Zemek <s3rvac@gmail.com>
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Settings.
#------------------------------------------------------------------------------

# Disable confirmation requests (e.g. "Quit anyway? (y or n)").
set confirm off

# Disable informational messages.
set verbose off

# Save the history.
set history filename ~/.gdb_history
set history save

# TUI: Display the source and assembly window by default.
layout split

# TUI: Switch focus to the command window so that arrow keys work as expected
# (history up/down and movement on the command line instead of movement in the
# source-code window).
focus cmd

#------------------------------------------------------------------------------
# Aliases.
#------------------------------------------------------------------------------

# Refreshes the screen (e.g. after the output from the debugged program has
# cluttered the screen).
alias -a rf = refresh

# Disables/enables TUI.
alias -a dt = tui disable
alias -a et = tui enable
