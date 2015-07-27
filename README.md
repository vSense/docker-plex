## What is plex

Plex organizes your video, music, and photo collections and streams them to all of your screens

> [More info](http://plex.tv)

![Plex](https://raw.githubusercontent.com/vSense/docker-plex/master/logo.jpg)

## How to use this images

This is a Dockerfile to set up "Plex Media Server" (https://plex.tv/). It is based on progrium/busybox.

This image contains 2 volumes you can override with host or data containers volumes:
- /library : your media library
- /config : plex configuration files

```
docker run -d -v /your/config/path:/config -v /your/library/path -p 32400:32400 vsense/plex
```

Of course you can mount as many volumes as you want, the base volumes are here to ensure image compatibility.

## How to choose a tag

There is no particular reason you should run anything but latest, we will keep some older version Dockerfile if there are still available on plex.tv.

For exemple:

-   vsense/plex:latest (default)
-   vsense/plex:0.9.12.4.1192-9a47d21 (available version according to repository folders)

## Initial Setup

On the first run if you are not on localhost (eg. remote server) you will get "You do not have permission to access this server" if you connect to the 32400 port.
The solution is to temporary create an SSH Tunnel to the remote host :

`ssh -L 32400:remote_host:32400 root@remote_host`

You can then access http://127.0.0.1:32400/web without issues and proceed with the initial setup and linking to your plex.tv account. After that, the tunnel is no longer necessary.

## Init Script

You can use docker with --always to ensure container restart:

```
docker run --restart=always -d -v /your/config/path:/config -v /your/library/path -p 32400:32400 vsense/plex
```

Or you can use a systemd unit:

```
[Unit]
Description=Plex Media Server
After=docker.service
Requires=docker.service

[Service]
TimeoutStartSec=0
ExecStartPre=-/usr/bin/rm "/srv/configs/plex/Plex Media Server/plexmediaserver.pid"
ExecStartPre=-/usr/bin/docker pull vsense/plex
ExecStart=/usr/bin/docker run --rm --name plex --hostname plex -p 32400:32400 -v /srv/configs/plex:/config -v /srv/seedbox:/library vsense/plex
ExecStop=/usr/bin/docker stop plex
ExecReload=/usr/bin/docker restart plex

[Install]
WantedBy=multi-user.target
```
