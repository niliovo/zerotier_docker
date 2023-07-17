#!/bin/bash

m_d=/zerotier

echo "deb http://mirrors.ustc.edu.cn/debian bookworm main contrib non-free non-free-firmware
deb-src http://mirrors.ustc.edu.cn/debian bookworm main contrib non-free non-free-firmware
deb http://mirrors.ustc.edu.cn/debian bookworm-updates main contrib non-free non-free-firmware
deb-src http://mirrors.ustc.edu.cn/debian bookworm-updates main contrib non-free non-free-firmware
deb http://mirrors.ustc.edu.cn/debian bookworm-proposed-updates main contrib non-free non-free-firmware
deb-src http://mirrors.ustc.edu.cn/debian bookworm-proposed-updates main contrib non-free non-free-firmware
deb http://mirrors.ustc.edu.cn/debian-security bookworm-security main contrib
deb http://mirrors.ustc.edu.cn/debian-security bookworm-security main contrib" > /etc/apt/sources.list

echo "Types: deb
URIs: http://mirrors.ustc.edu.cn/debian
Suites: bookworm bookworm-updates
Components: main
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

Types: deb
URIs: http://mirrors.ustc.edu.cn/debian-security
Suites: bookworm-security
Components: main
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg" > /etc/apt/sources.list.d/debian.sources

apt-get update

apt-get install gosu apt-utils libssl3 procps sudo ca-certificates gnupg curl wget -y

#wget 'https://githubusercontent.niliovo.top/zerotier/ZeroTierOne/master/doc/contact%40zerotier.com.gpg' | gpg --import

wget 'https://raw.githubusercontent.com/zerotier/ZeroTierOne/master/doc/contact%40zerotier.com.gpg' | gpg --import

#curl -s https://install.zerotier.com | sudo bash

curl https://install.zerotier.com/ | sed 's,download.zerotier.com/,mirrors.sustech.edu.cn/zerotier/,g' | sudo bash

#v=$(wget -qO- -t1 -T2 "https://githubapi.niliovo.top/repos/ly88321/ztncui-zh/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g')

v=$(wget -qO- -t1 -T2 "https://api.github.com/repos/ly88321/ztncui-zh/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g')

z_v=$v\_amd64.deb

#curl -O https://githubdl.niliovo.top/https://github.com/ly88321/ztncui-zh/releases/download/$v/$z_v

curl -O https://github.com/ly88321/ztncui-zh/releases/download/$v/$z_v

dpkg -x $z_v $m_d/tmp

mkdir -p /opt/key-networks/ztncui/etc /opt/key-networks/ztncui/node_modules/argon2/build/Release/

cp tmp/opt/key-networks/ztncui/ztncui /opt/key-networks/ztncui/

cp tmp/opt/key-networks/ztncui/etc/default.passwd /opt/key-networks/ztncui/etc/

cp tmp/opt/key-networks/ztncui/node_modules/argon2/build/Release/argon2.node /opt/key-networks/ztncui/node_modules/argon2/build/Release/

rm -rf tmp $z_v

apt-get remove ca-certificates gnupg curl wget -y

apt-get autoremove -y

apt-get clean -y

rm -rf /var/lib/apt/lists/*
