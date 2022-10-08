#!/bin/bash

# Example notifier script -- lowers screen brightness, then waits to be killed
# and restores previous brightness on exit.

## CONFIGURATION ##############################################################

# Brightness will be lowered to this value.
min_brightness=0

# If your video driver works with xbacklight, set -time and -steps for fading
# to $min_brightness here. Setting steps to 1 disables fading.
fade_time=200
fade_steps=20

# If you have a driver without RandR backlight property (e.g. radeon), set this
# to use the sysfs interface and create a .conf file in /etc/tmpfiles.d/
# containing the following line to make the sysfs file writable for group
# "users":
#
#     m /sys/class/backlight/intel_backlight/brightness 0664 root users - -
#

sysfs_path=/sys/class/backlight/intel_backlight/brightness

# Time to sleep (in seconds) between increments when using sysfs. If unset or
# empty, fading is disabled.
fade_step_time=0.05

###############################################################################

get_brightness() {
	xbacklight -get
}

set_brightness() {
xbacklight -steps 1 -set $1
}

fade_brightness() {
	echo "$steps"
        xbacklight -time 3000 -steps 100 -set 0.2
}

trap 'exit 0' TERM INT
trap "set_brightness $(get_brightness); kill %%" EXIT
fade_brightness $min_brightness
sleep 2147483647 &
wait
