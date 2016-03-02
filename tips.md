### ssh
 * open background ssh tunneling
```sh
$ ssh -fND 8080 target.server
```
 
 * ssh port forwarding to localhost
```sh
$ ssh -fNL 8080:localhost:8080 your_account@remote_host.com
```

### chrome
 * scale 2x and using tunneling server
```sh
$ chromium-browser --force-device-scale-factor=2 --proxy-server=socks://localhost:8080
```
