# taas
Terraria as a (systemd) service
## How to use
Download and execute `install.sh`
```sh
  wget "https://raw.githubusercontent.com/loglob/taas/master/install.sh" -v -O taas.sh
  ./taas.sh # custom install directory here
  rm taas.sh
```
By specifying a directory as first argument, it will install to that directory rather than the default _/srv/terraria_.
