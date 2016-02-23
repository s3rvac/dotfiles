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

#------------------------------------------------------------------------------
# Functions.
#------------------------------------------------------------------------------

# Disable TUI.
define dt
	tui disable
end

# Enable TUI.
define et
	tui enable
	# Display the source and assembly window.
	layout split
	# Switch focus to the command window so that arrow keys work as expected
	# (history up/down and movement on the command line instead of movement in
	# the source-code window).
	focus cmd
end

#------------------------------------------------------------------------------
# Aliases.
#------------------------------------------------------------------------------

# Refreshes the screen (e.g. after the output from the debugged program has
# cluttered the screen).
alias -a rf = refresh
