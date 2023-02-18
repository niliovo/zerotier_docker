# zerotier_moon_ztncui_docker

- [中文](./README.md)
- [ENGLISH](./README_EN.md)

- [Github](https://github.com/niliovo/zerotier)
- [Docker Hub](https://hub.docker.com/r/niliaerith/zerotier)

# This project is based on below projects，Integrate zerotier, zerotier-moon, ztncui Chinese version into a docker image

- [zerotier](https://www.zerotier.com/)
- [docker-zerotier-moon](https://github.com/rwv/docker-zerotier-moon)
- [ztncui-aio](https://github.com/key-networks/ztncui-aio)
- [ztncui-zh](https://github.com/ly88321/ztncui-zh)

## Docker-Cli Usage Guide

```bash
docker run -itd --name zerotier --hostname zerotier --net host --restart always --cap-add ALL --device /dev/net/tun:/dev/net/tun -v /your_path/zerotier/zerotier-one:/var/lib/zerotier-one -v /your_path/zerotier/etc:/opt/key-networks/ztncui/etc -e TZ=Asia/Shanghai -e IPV4=0.0.0.0 -e IPV6=::1 -e ZTNCUI_ADMIN=admin -e ZTNCUI_PASSWD=password -e HTTP_ALL_INTERFACES=yes -e HTTP_PORT=9994 niliaerith/zerotier:latest
```


## Docker Compose Usage Guide

```compose.yml
  zerotier:
    image: niliaerith/zerotier:latest
    container_name: zerotier
    hostname: zerotier
    restart: zerotier
    network_mode: host
    restart: always
    cap_add:
    #  - ALL
      - NET_ADMIN
    #  - SYS_ADMIN
    #  - NET_BIND_SERVICE
    devices:
      - /dev/net/tun:/dev/net/tun
    volumes:
      - /your_path/zerotier/zerotier-one:/var/lib/zerotier-one
      - /your_path/zerotier/etc:/opt/key-networks/ztncui/etc
    environment:
      - TZ=Asia/Shanghai
      - MOON_PORT=9993
      - IPV4=0.0.0.0
      - IPV6=::1
      - ZTNCUI_ADMIN=admin
      - ZTNCUI_PASSWD=password
      - HTTP_ALL_INTERFACES=yes
      - HTTP_PORT=9994
```

## Variable

> Necessary Variable
- `cap_add:` 
- - `- NET_ADMIN` OR `- ALL` select one and let zerotier get network management rights

> Optional Variable
- `cap_add:`
- - `- SYS_ADMIN` and `NET_BIND_SERVICE` are Dispensable
- `devices:`
- - `- /dev/net/tun:/dev/net/tun` Enabling the tun module
- `volumes:`
- - `- /your_path/zerotier/zerotier-one:/var/lib/zerotier-one` is the map for `zerotier` directory where 'moon' information is stored
- - `- /your_path/zerotier/etc:/opt/key-networks/ztncui/etc` is the map for `ztncui` directory, the user name and password information is stored in here
- `environment:`
- - `- TZ=Asia/Shanghai` ss a time zone option. The default time is `UTC`
- - `MOON_PORT=9993` `zerotier moon` occupies the port, default is `9993`
- - `- IPV4=0.0.0.0` is `ipv4` address, The default is `0.0.0.0`
- - `- IPV6=::1` is `ipv6` address, The default is `::1`
- - `- ZTNCUI_ADMIN=admin` is Administrator name. The default value is `admin`
- - `- ZTNCUI_PASSWD=password` is Administrator password. The default value is `password`
- - `- HTTP_ALL_INTERFACES=yes` Indicates whether to enable binding to all networks. The default is `yes`
- - `- HTTP_PORT=9994` is `ztncui` Management interface port

## Support platform

- amd64

# Thanks

- [GitHub](https://github.com/)
- [Docker Hub](https://hub.docker.com/)
- [zerotier](https://www.zerotier.com/)
- [docker-zerotier-moon](https://github.com/rwv/docker-zerotier-moon)
- [ztncui-aio](https://github.com/key-networks/ztncui-aio)
- [ztncui-zh](https://github.com/ly88321/ztncui-zh)
- [Github file acceleration](https://tool.mintimate.cn/gh/)
- [USTC open source software mirror](https://mirrors.ustc.edu.cn/)
