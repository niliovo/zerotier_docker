#!/bin/bash

export PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin

zt_dir="/var/lib/zerotier-one"

MOON_PORT=${MOON_PORT:-9993}
IPV4=${IPV4:-0.0.0.0}
IPV6=${IPV6:-::1}

ZTNCUI_ADMIN=${ZTNCUI_ADMIN:-admin}  
ZTNCUI_PASSWD=${ZTNCUI_PASSWD:-password}   # Used for argon2g
HTTP_ALL_INTERFACES=${HTTP_ALL_INTERFACES:-yes}
HTTP_PORT=${HTTP_PORT:-9994}

echo "启动Zerotier moon"

stableEndpointsForSed=""
if [ -z ${IPV4+x} ]; then
  if [ -z ${IPV6+x} ]; then
    echo "请设置IPV4或IPV6地址"
    exit 0
  else
    stableEndpointsForSed="\"$IPV6\/$MOON_PORT\""
  fi
else
  if [ -z ${IPV6+x} ]; then
    stableEndpointsForSed="\"$IPV4\/$MOON_PORT\""
  else # ipv6 address is set
    stableEndpointsForSed="\"$IPV4\/$MOON_PORT\",\"$IPV6\/$MOON_PORT\""
  fi
fi

stableEndpointsForSed="$(echo "${stableEndpointsForSed}" | tr -d '[:space:]')"
echo "stableEndpoints: $stableEndpointsForSed"

if [ -d "$zt_dir/moons.d" ]; then
  moon_id=$(cat $zt_dir/identity.public | cut -d ':' -f1)
  echo -e "你的 ZeroTier moon id 是\033[0;31m$moon_id\033[0m, 你可以使用此命令添加 moon \033[0;31m\"zerotier-cli orbit $moon_id $moon_id\"\033[0m"
  /usr/sbin/zerotier-one &
else
  nohup /usr/sbin/zerotier-one >/dev/null 2>&1 &
  while [ ! -f $zt_dir/identity.secret ]; do
    sleep 1
  done
  /usr/sbin/zerotier-idtool initmoon $zt_dir/identity.public >>$zt_dir/moon.json
  sed -i 's/"stableEndpoints": \[\]/"stableEndpoints": ['$stableEndpointsForSed']/g' $zt_dir/moon.json
  /usr/sbin/zerotier-idtool genmoon $zt_dir/moon.json >/dev/null
  mkdir $zt_dir/moons.d
  mv *.moon $zt_dir/moons.d/
  pkill zerotier-one
  moon_id=$(cat $zt_dir/moon.json | grep \"id\" | cut -d '"' -f4)
  echo -e "你的 ZeroTier moon id 是 \033[0;31m$moon_id\033[0m, 你可以使用此命令添加 moon \033[0;31m\"zerotier-cli orbit $moon_id $moon_id\"\033[0m"
  exec /usr/sbin/zerotier-one &
fi

echo "启动ztncui"

ztncui_dir=/opt/key-networks/ztncui

cd $ztncui_dir

if [ -z $IPV4 ]; then
    echo "设置你的IP地址以继续(如果不，则自动检测)"
    MYEXTADDR=$(curl --connect-timeout 5 ip.sb)
    if [ -z $MYEXTADDR ]; then
        MYINTADDR=$(ifconfig eth0 | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
        IPV4=${MYINTADDR}
    else
        IPV4=${MYEXTADDR}
    fi
    echo "你的IP是 ${IPV4}"
fi

while [ ! -f /var/lib/zerotier-one/authtoken.secret ]; do
    echo "Zerotier 的身份验证令牌没找到... 等待zerotier启动"
    sleep 2
done
chown zerotier-one:zerotier-one /var/lib/zerotier-one/authtoken.secret
chmod 640 /var/lib/zerotier-one/authtoken.secret

cd $ztncui_dir

echo "MYADDR=$IPV4" >> $ztncui_dir/.env
echo "HTTP_PORT=$HTTP_PORT" >> $ztncui_dir/.env
if [ ! -z $HTTP_ALL_INTERFACES ]; then
  echo "HTTP_ALL_INTERFACES=$HTTP_ALL_INTERFACES" >> $ztncui_dir/.env
fi

echo "ZTNCUI 环境配置: "
cat $ztncui_dir/.env

mkdir -p $ztncui_dir/etc/storage
mkdir -p $ztncui_dir/etc/myfs

if [ ! -f $ztncui_dir/etc/passwd ]; then
    echo "默认密码文件不存在... 正在生成..."
    cd $ztncui_dir/etc
    /usr/local/bin/argon2g
    cd ../
fi

ZTNCUI_ADMIN_OLD="$(cat $ztncui_dir/etc/passwd | sed 's/^.*name\"\:\"//g' | sed 's/\","pass_set.*$//g')"
if [ "$ZTNCUI_ADMIN" != "$ZTNCUI_ADMIN_OLD" ];then
  sed -i "s#$ZTNCUI_ADMIN_OLD#$ZTNCUI_ADMIN#g" $ztncui_dir/etc/passwd
  echo "修改用户名成功"
fi

chown -R zerotier-one:zerotier-one $ztncui_dir
chmod 0755 $ztncui_dir/ztncui

unset ZTNCUI_PASSWD
gosu zerotier-one:zerotier-one $ztncui_dir/ztncui
