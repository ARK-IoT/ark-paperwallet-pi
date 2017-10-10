[Unit]
Description=Ark: Paper Wallet Pi Service

[Service]
Type=idle
RemainAfterExit=yes
ExecStart=/opt/paperwallet/init.d/paperwallet_alt start
ExecStop=/opt/paperwallet/init.d/paperwallet_alt stop
#Restart=/opt/paperwallet/init.d/paperwallet_alt restart
#PIDFile=/var/run/paperwallet.pid

[Install]
WantedBy=multi-user.target
