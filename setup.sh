#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NOCOLOR='\033[0m'
cd ~
echo -e "${GREEN}start cleaning files${NOCOLOR}"
if test -d ~/.proxy-help
then
pname=$(ls ~/.proxy-help| grep sshdd)
current=$(ps -a|grep "${pname}")
if [ ${#current} > 5 ]
then
pkill ${pname}
fi
rm -rf ~/.proxy-help/
fi
echo -e "${GREEN}done${NOCOLOR}"

mkdir .proxy-help
cd .proxy-help
echo -e "${GREEN}start downloading tools${NOCOLOR}"
wget https://github.com/ginuerzh/gost/releases/download/v2.11.1/gost-linux-amd64-2.11.1.gz -q --show-progress
wget https://raw.githubusercontent.com/2BenUniv/net/main/conf.json -q --show-progress
mkdir q
cd q
wget https://raw.githubusercontent.com/2BenUniv/net/main/ineedwifi -q --show-progress
chmod +x ineedwifi
cd ..
echo -e "${GREEN}done"

echo -e "${GREEN}start configuring tools${NOCOLOR}"
s5port=`expr $RANDOM + 30000`
htport=`expr $s5port + 1`
proxyname=sshdd${s5port}
gzip -d gost-linux-amd64-2.11.1.gz
mv gost-linux-amd64-2.11.1 ${proxyname}
chmod +x ${proxyname}
sed -i "s/sport/${s5port}/" conf.json
sed -i "s/hport/${htport}/" conf.json

ppath=$(cat ~/.bashrc | grep proxy-help)
if [ ${#ppath} -lt 5 ]
then
echo 'export PATH="$HOME/.proxy-help/q/:$PATH"' >> ~/.bashrc
source ~/.bashrc
fi

echo -e "${GREEN}done${NOCOLOR}"

echo -e "${GREEN}start proxy${NOCOLOR}"
nohup ./${proxyname} -C conf.json >/dev/null 2>&1 &
sleep 5s

echo -e "${GREEN}testing${NOCOLOR}"
addr=$(curl -s ifconfig.me)
sleep 1s
addr2=$(curl -s ifconfig.me --socks5 127.0.0.1:"${s5port}")
sleep 1s
addr3=$(curl -s ifconfig.me --proxy http://127.0.0.1:"${htport}")
sleep 1s

if [[ $addr = $addr2 && $addr = $addr3 ]]
then
  echo -e "${GREEN}all success${NOCOLOR}"
  echo -e "connection address: ${GREEN}${addr}${NOCOLOR}"
  echo -e "socks5 port: ${GREEN}${s5port}${NOCOLOR}"
  echo -e "http port: ${GREEN}${htport}${NOCOLOR}"
else 
  echo -e "${RED}setup failed, please try again${NOCOLOR}"
fi    


