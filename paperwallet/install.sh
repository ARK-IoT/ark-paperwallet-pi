#!/bin/bash

echo
echo
echo "3.1415926535897932384626433832795028841971693993751058209"
echo "    _____         __            __________               "
echo "   /  _  \_______|  | __        \______   \ _______  ___ "
echo "  /  /_\  \_  __ \  |/ /  ______ |    |  _//  _ \  \/  / "
echo " /    |    \  | \/    <  /_____/ |    |   (  <_> >    <  "
echo " \____|__  /__|  |__|_ \         |______  /\____/__/\_ \ "
echo "         \/           \/                \/            \/ "
echo "749445923078164062862089986280348253421170679821480865132"
echo " _____                        _ _ _       _  _       _   "
echo "|  _  | ___  ___  ___  ___   | | | | ___ | || | ___ | |_ "
echo "|   __|| .'|| . || -_||  _|  | | | || .'|| || || -_||  _|"
echo "|__|   |__,||  _||___||_|    |_____||__,||_||_||___||_|  "
echo "            |_|                                          "
echo "823066470938446095505822317253594081284811174502841027019"
echo
echo "Website: https://ark.io | https://github.com/Ark-IoT"
echo "	Ark: Paper Wallet Version: 0.9.0"
echo
echo "385211055596446229489549303819644288109756659334461284756"
echo
echo

# Import PaperWallet conf
CURRENT_CONF=paperwallet/conf/paperwallet.conf
scriptfile="$(readlink -f $0)"
CURRENT_DIR="$(dirname ${scriptfile})"

# Must be root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" #1>&2
    exit 0
fi

# Update system
sudo apt-get update

# Checks if PaperWallet files are correctly placed relative to the install.sh script
if [[ -f  "$CURRENT_DIR"/$CURRENT_CONF ]]; then
	. $CURRENT_CONF 2> /dev/null
else
	echo "PaperWallet config is not in its normal directory."
	echo "Expecting it in \"$CURRENT_DIR/$CURRENT_DIR\"."
	exit 0
fi

# Begin setting up paperwallet's home dir
if [[ ! -d /opt ]]; then
	mkdir -p /opt
fi

# If paperwallet already exists, remove it
if [[ -d /opt/paperwallet ]]; then
	rm -rf /opt/paperwallet &> /dev/null
fi

# Copies paperwallet files to working directories
cp -rv "$CURRENT_DIR"/paperwallet /opt &> /dev/null
echo "Finished copying files to /opt/paperwallet..."

if ! grep "$NET.$IP_SHORT paperwallet.lan$" /etc/hosts > /dev/null; then 
	echo "\"$NET.$IP_SHORT paperwallet.lan\" found in /etc/hosts"
else
	echo "Adding $NET.$IP_SHORT paperwallet.lan to /etc/hosts"
	echo "$NET.$IP_SHORT paperwallet.lan">>/etc/hosts
fi

if ! grep "$NET.$IP_SHORT paperwallet$" /etc/hosts > /dev/null ; then 
	echo "\"$NET.$IP_SHORT paperwallet\" found in /etc/hosts"
else
	echo "Adding $NET.$IP_SHORT paperwallet to /etc/hosts"
	echo "$NET.$IP_SHORT paperwallet">>/etc/hosts
fi

ln -s /opt/paperwallet/init.d/paperwallet /etc/init.d/paperwallet

# Install dependencies
apt-get install -y hostapd lighttpd dnsmasq

# PaperWallet auto-configuration
/opt/paperwallet/bin/install_paperwallet.sh /opt/paperwallet/conf/paperwallet.conf part2

# Configure and start ArkBox.service
echo "stopping hostapd, dnsmasq, and lighttpd.."
sudo pkill hostapd
sudo pkill dnsmasq
sudo pkill lighttpd
echo "pkill'd"
echo
echo "enabling arkbox"
sudo systemctl enable arkbox
echo

# Configure ArkBox for start at boot
sudo update-rc.d -f arkbox defaults

# Make SD-Card Read-Only
# more info: https://learn.adafruit.com/read-only-raspberry-pi/
#	FIXME: AP & SSH will work; Redirect & HTML will not
#sudo bash arkbox/bin/read-only-fs.sh

echo
echo
echo "	####################################"
echo "	#  ArkBox has been installed  #"
echo "	####################################"
echo
echo
echo
echo "	     Please 'sudo reboot' now."
echo
echo

exit 0
