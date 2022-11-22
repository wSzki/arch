#!/bin/sh

echo 2048 > /sys/class/rtc/rtc0/max_user_freq
echo 2048 > /proc/sys/dev/hpet/max-user-freq
sysctl vm.swappiness=10
sysctl fs.inotify.max_user_watches=600000
