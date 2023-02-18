#!/bin/bash

m_d=/zerotier

echo "deb http://mirrors.ustc.edu.cn/debian/ bullseye main non-free contrib
deb http://mirrors.ustc.edu.cn/debian/ bullseye-updates main non-free contrib
deb http://mirrors.ustc.edu.cn/debian/ bullseye-backports main non-free contrib
deb http://mirrors.ustc.edu.cn/debian-security/ bullseye-security main non-free contrib 
deb-src http://mirrors.ustc.edu.cn/debian/ bullseye main non-free contrib
deb-src http://mirrors.ustc.edu.cn/debian/ bullseye-updates main non-free contrib
deb-src http://mirrors.ustc.edu.cn/debian/ bullseye-backports main non-free contrib
deb-src http://mirrors.ustc.edu.cn/debian-security/ bullseye-security main non-free contrib" > /etc/apt/sources.list

apt-get update -qq

apt-get install gosu apt-utils libssl1.1 procps sudo ca-certificates gnupg curl wget -y

#curl -s 'https://raw.githubusercontent.com/zerotier/ZeroTierOne/master/doc/contact%40zerotier.com.gpg' | gpg --import

curl -s 'https://gh.flyinbug.top/gh/https://raw.githubusercontent.com/zerotier/ZeroTierOne/master/doc/contact%40zerotier.com.gpg' | gpg --import

#curl -s https://install.zerotier.com | sudo bash

curl https://install.zerotier.com/ | sed 's,download.zerotier.com/,mirrors.sustech.edu.cn/zerotier/,g' | sudo bash

rm -rf tmp $z_v

apt-get remove ca-certificates gnupg curl wget -y

apt-get autoremove -y

apt-get clean -y

rm -rf /var/lib/apt/lists/*