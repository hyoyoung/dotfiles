### autostart scripts when some devices added
  * make a user systemd service to '/usr/lib/udev/rules.d'
    - https://askubuntu.com/questions/1228950/script-run-by-udev-rule-fails

### autostart scripts when wake up
  * use a system service
    - https://unix.stackexchange.com/questions/152039/how-to-run-a-user-script-after-systemd-wakeup
  
### xorg tearing free conf
  * use dri3
    - https://askubuntu.com/questions/1234026/screen-tearing-on-ubuntu-xorg-20-04-with-intel-graphics

### debian variants korean key settings
  * edit /etc/default/keyboard
    * XKBOPTIONS="ctrl:nocaps,korean:ralt_hangul"
  * then run, 'sudo dpkg-reconfigure -phigh console-setup'

### model enable
  * mmcli -L
  * mmcli -m 0 -d
  * echo "at@nvm:fix_cat_fcclock.fcclock_mode=0" > /dev/ttyACM0
  * mmcli -m 0 -e
