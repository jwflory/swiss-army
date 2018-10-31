#!/bin/sh -e

# screenshot!
gnome-screenshot -f /tmp/screen_locked.png

# Blur it
convert /tmp/screen_locked.png -blur 0x6 /tmp/screen_locked.png

# Lock screen with blurred image
i3lock -i /tmp/screen_locked.png

# Turn the screen off after a delay.
sleep 120; pgrep i3lock && xset dpms force off
