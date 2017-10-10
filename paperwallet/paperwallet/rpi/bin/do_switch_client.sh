#!/bin/sh

# Wrapper script for the steps to enable wifi client

systemctl stop paperwallet
if /opt/paperwallet/rpi/run_client.sh ; then
    echo "Started Wifi client sucessfully!"
    exit 0
else
    echo "Error while starting wifi client, restarting paperwallet"
    systemctl start paperwallet
    exit 1
fi
exit 1
