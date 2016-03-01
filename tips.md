### ssh
 * open background ssh tunneling
```sh
$ ssh -fND 8080 target.server
```

### chrome
 * scale 2x and using tunneling server
```sh
$ chromium-browser --force-device-scale-factor=2 --proxy-server=socks://localhost:8080
```
