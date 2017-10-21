#!/usr/bin/env python3
#
# Sets keyboard backlight (increase/decrease).
#
# Based on https://wiki.archlinux.org/index.php/Keyboard_backlight
#
# Requires the python-dbus package.
#

import dbus
import sys


def set_beyboard_backlight(delta):
    bus = dbus.SystemBus()
    kbd_backlight_proxy = bus.get_object(
        'org.freedesktop.UPower',
        '/org/freedesktop/UPower/KbdBacklight'
    )
    kbd_backlight = dbus.Interface(
        kbd_backlight_proxy,
        'org.freedesktop.UPower.KbdBacklight'
    )

    current = kbd_backlight.GetBrightness()
    maximum = kbd_backlight.GetMaxBrightness()
    new = max(0, current + delta)

    if 0 <= new <= maximum:
        current = new
        kbd_backlight.SetBrightness(current)

    # Return the current backlight level in percentages.
    return 100 * current / maximum


def main():
    if len(sys.argv) == 2 and sys.argv[1] in ('+', '-'):
        delta = 1 if sys.argv[1] == '+' else -1
        current_level = set_beyboard_backlight(delta)
        print('{}%'.format(int(current_level)))
    else:
        sys.exit('usage: {} +/-'.format(sys.argv[0]))


if __name__ == '__main__':
    main()
