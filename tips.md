### ssh
 * open background ssh tunneling
  : ssh -fND 8080 target.server

### chrome
 * scale 2x and using tunneling server
  : chromium-browser --force-device-scale-factor=2 --proxy-server=socks://localhost:8080
