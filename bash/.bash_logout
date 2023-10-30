#------------------------------------------------------------------------------
# File:   $HOME/.bash_logout
# Author: Petr Zemek <s3rvac@petrzemek.net>
#
# Based on http://www.hermann-uwe.de/files/bash_logout.
#------------------------------------------------------------------------------

# When leaving the console clear the screen to increase privacy. Also clear the
# scroll-back buffer by switching to tty63 and back.
case "$(tty)" in
	/dev/tty[0-9])
		t=$(v=`tty` ; echo ${v##*ty})
		clear
		chvt 63; chvt "$t"
	;;

	/dev/tty[0-9][0-9])
		t=$(v=`tty` ; echo ${v##*ty})
		clear
		chvt 63; chvt "$t"
	;;

	*)
	;;
esac
