# zerotier_moon_ztncui_docker

- [中文](./README.md)
- [ENGLISH](./README_EN.md)

- [Github](https://github.com/niliovo/zerotier)
- [Docker Hub](https://hub.docker.com/r/niliaerith/zerotier)

# 本项目基于下列项目，将 zerotier，zerotier-moon，ztncui中文版 集成到一个docker镜像

- [zerotier](https://www.zerotier.com/)
- [docker-zerotier-moon](https://github.com/rwv/docker-zerotier-moon)
- [ztncui-aio](https://github.com/key-networks/ztncui-aio)
- [ztncui-zh](https://github.com/ly88321/ztncui-zh)

## Docker-Cli使用指南

```bash
docker run -itd --name zerotier --hostname zerotier --net host --restart always --cap-add ALL --device /dev/net/tun:/dev/net/tun -v /your_path/zerotier/zerotier-one:/var/lib/zerotier-one -v /your_path/zerotier/etc:/opt/key-networks/ztncui/etc -e TZ=Asia/Shanghai -e IPV4=0.0.0.0 -e IPV6=::1 -e ZTNCUI_ADMIN=admin -e ZTNCUI_PASSWD=password -e HTTP_ALL_INTERFACES=yes -e HTTP_PORT=9994 niliaerith/zerotier:latest
```


## Docker Compose使用指南

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

## 变量

> 必须变量
- `cap_add:` 
- - `- NET_ADMIN`或`- ALL` 选择其中一个，让zerotier获取网络管理权

> 可选变量
- `cap_add:`
- - `- SYS_ADMIN`与`NET_BIND_SERVICE` 可有可无
- `devices:`
- - `- /dev/net/tun:/dev/net/tun` 启用tun模块
- `volumes:`
- - `- /your_path/zerotier/zerotier-one:/var/lib/zerotier-one` 为映射 `zerotier` 目录，`moon` 信息储存在这里
- - `- /your_path/zerotier/etc:/opt/key-networks/ztncui/etc` 为映射 `ztncui` 目录， 用户名和密码信息储存在这里
- `environment:`
- - `- TZ=Asia/Shanghai` 是时区选项，默认为 `UTC`时间
- - `MOON_PORT=9993` 是 `zerotier moon` 占用端口，默认为 `9993`
- - `- IPV4=0.0.0.0` 是 `ipv4` 地址, 默认为 `0.0.0.0`
- - `- IPV6=::1` 是 `ipv6` 地址, 默认为 `::1`
- - `- ZTNCUI_ADMIN=admin` 是管理员名称,默认为 `admin`
- - `- ZTNCUI_PASSWD=password` 是管理员密码,默认为 `password`
- - `- HTTP_ALL_INTERFACES=yes` 为是否启用绑定到所有网络,默认为 `yes`
- - `- HTTP_PORT=9994` 是 `ztncui` 管理界面端口

## 支持平台

- amd64

# 感谢

- [GitHub](https://github.com/)
- [Docker Hub](https://hub.docker.com/)
- [zerotier](https://www.zerotier.com/)
- [docker-zerotier-moon](https://github.com/rwv/docker-zerotier-moon)
- [ztncui-aio](https://github.com/key-networks/ztncui-aio)
- [ztncui-zh](https://github.com/ly88321/ztncui-zh)
- [Github文件加速](https://tool.mintimate.cn/gh/)

# 捐赠

![支付宝](./donation/alipay.JPG)

![微信](./donation/wechatpay.JPG)