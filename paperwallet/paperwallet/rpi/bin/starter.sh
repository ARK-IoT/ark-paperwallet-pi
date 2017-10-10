#!/bin/sh
# Try to setup WiFi and if it succeeds, start the PaperWallet

## Default
WIFI_DEVICE="wlan0"

WIFI_CONFIG_PATH="/boot/wifi_card.conf"

if test -e "${WIFI_CONFIG_PATH}" ; then
    echo "Found wifi card config"
    WIFI_DEVICE=$( head -n 1 "${WIFI_CONFIG_PATH}" | tr -d '\n'  )
fi

if [ "${INTERFACE}" = "${WIFI_DEVICE}" ] ; then
    /bin/sh -c /opt/paperwallet/rpi/bin/wifi_detect.sh && /usr/bin/systemctl start paperwallet
fi
exit 0
