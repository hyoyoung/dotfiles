#!/bin/bash

# awake from sleep, use '/usr/lib/systemd/system-sleep' dir to put a script

sleep 10
xmodmap ~/.Xmodmap
for id in $(/usr/bin/xinput list | /bin/grep "USB Mouse\|Bluetooth.* Mouse" | /bin/grep -o id=[0-9]* | /bin/grep -o [0-9]*);
do
  echo "Inverted Mouse id is $id";
  xinput set-button-map $id 3 2 1;
done
