#!/bin/sh

#  Matthias Strubel (c) 2016  - GPL3
#	adapted by sleepdeficit (simon@sleepdev.sh) 2017
# Script for manipulating firewall rules during start and stop of PaperWallet

PAPERWALLET_CONFIG="/opt/paperwallet/conf/paperwallet.conf"
FIREWALL_CONFIG="/opt/paperwallet/conf/firewall.conf"

run=""

help_text(){

  echo "Script for setting up Firewall rules on PaperWallet. (IPv4 only)"
  echo "
Usage:

  -s   	: Start, add IPtables rules
  -k    : Stop , remove IPtables rules

  -c    : different PaperWallet config location
  -f    : different PaperWallet firewall config location
"
  exit 1
}

while getopts "skc:f:" opt ; do
	case $opt in
		s)  run="start"  ;;
		k)  run="end"    ;;
		c)  PAPERWALLET_CONFIG="$OPTARG" ;;
		f)  FIREWALL_CONFIG="$OPTARG" ;;
		h)  help_text  ;;
		\?)
			echo "Invalid option: -$OPTARG"
			help_text
			;;
	esac
done

if test -z "$run" ; then
	echo "ERROR: You need to select -s (start) or -k (stop) "
	help_text
fi
if test -z "$PAPERWALLET_CONFIG" || test -z "$FIREWALL_CONFIG" ; then
	echo "ERROR: one of the config paths is empty, while it should not"
	help_text
fi

 . "$PAPERWALLET_CONFIG"  || exit 6
 . "$FIREWALL_CONFIG"   || exit 5

if [ "$run" = "start" ] ; then
	IPT_FLAG="-A"
else
	IPT_FLAG="-D"
fi

if [ "$FIREWALL_FETCH_DNS" = "yes" ] ; then
	 iptables -t nat $IPT_FLAG PREROUTING -i "$DNSMASQ_INTERFACE" -d 0/0 \
		-p tcp --dport 53 -j DNAT --to-destination "${IP}:53"
	 iptables -t nat $IPT_FLAG PREROUTING -i "$DNSMASQ_INTERFACE" -d 0/0 \
		-p udp --dport 53 -j DNAT --to-destination "${IP}:53"
fi

if [ "$FIREWALL_FETCH_HTTP" = "yes" ] ; then
	iptables -t nat $IPT_FLAG PREROUTING -i "$DNSMASQ_INTERFACE"  -d 0/0 \
		-p tcp --dport 80 -j DNAT --to-destination "${IP}:80"
fi
