#!/usr/bin/bash
#
# Init script to set the HDMI output as the primary display
#
# My desktop does not seem to know the primary display, so things like the
# system tray don't show up as expected. This command will set the primary
# display and resolve this issue.
#
# Copy this script to /etc/rc.d/init.d/
#

xrandr --output HDMI-2 --primary
