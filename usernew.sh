#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ifconfig.me/ip);
echo "Checking VPS"

echo -e "${green}Permission Accepted...${NC}"

clear
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/v2ray/domain)
else
domain=$IP
fi
echo -e "Name : SSH , WebSocket, Openvpn"
echo -e "===============================" | lolcat
read -p "Username : " Login
read -p "Password : " Pass
read -p "Expired (hari): " masaaktif

IP=$(wget -qO- ifconfig.me/ip);
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
wsnonssl="$(cat ~/log-install.txt | grep -w "Websocket NON SSL" | cut -d: -f2|sed 's/ //g')"
sleep 1
echo Ping Host
echo Cek Hak Akses...
sleep 0.5
echo Permission Accepted
clear
sleep 0.5
echo Membuat Akun: $Login
sleep 0.5
echo Setting Password: $Pass
sleep 0.5
clear
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "Name : SSH , WebSocket, Openvpn"
echo -e "===============================" | lolcat
echo -e "Username       : $Login "
echo -e "Password       : $Pass"
echo -e "Expired On     : $exp"
echo -e "===============================" | lolcat
echo -e "ISP            : $ISP"
echo -e "Domain         : $domain"
echo -e "Host           : $IP"
echo -e "OpenSSH        : 22"
echo -e "DropBear       : 44, 69, 77"
echo -e "SSL/TLS        :$ssl"
echo -e "Port Suid      :$sqd"
echo -e "Port WS SSL    : 443"
echo -e "Port WS DB     : $wsnonssl"
echo -e "Port WS OS     : 2082"
echo -e "Port WS OVPN   : 2086"
echo -e "Badvpn         : 7100-7300"
echo -e "===============================" | lolcat
echo -e "OpenVPN        : TCP $ovpn http://$IP:81/client-tcp-1194.ovpn"
echo -e "OpenVPN        : UDP $ovpn2 http://$IP:81/client-udp-2200.ovpn"
echo -e "OpenVPN        : SSL 442 http://$IP:81/client-tcp-ssl.ovpn"
echo -e "===============================" | lolcat
echo -e "PAYLOAD WS     :"
echo -e "GET / HTTP/1.1[crlf]Host: $domain[crlf]Upgrade: websocket[crlf][crlf]"
echo -e "===============================" | lolcat
echo -e "PAYLOAD WS SSL :"
echo -e "GET wss://bug.com/ HTTP/1.1[crlf]Host: $domain[crlf]Upgrade: websocket[crlf][crlf]"
echo -e "===============================" | lolcat
echo -e "Script By SSH SEDANG NETWORK"
