echo "Stopping PaperWallet..."
sudo /etc/init.d/paperwallet stop
echo "Removing PaperWallet daemon..."
sudo update-rc.d paperwallet remove 
sudo rm -v /etc/init.d/paperwallet
echo "Removing PaperWallet folder..."
sudo rm -rf -v /opt/paperwallet