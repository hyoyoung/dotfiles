#!/bin/bash

sleep 3
export DISPLAY=:0
xmodmap ~/.Xmodmap
for id in $(/usr/bin/xinput list | /bin/grep "USB Mouse\|Laser Mouse\|Bluetooth.* Mouse" | /bin/grep -o id=[0-9]* | sed 's/^...//');
do
  echo "Inverted Mouse id is $id";
  xinput set-button-map $id 3 2 1;
done
