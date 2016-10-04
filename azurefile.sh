#!/bin/bash
cd /tmp
curl -L https://github.com/Azure/azurefile-dockervolumedriver/releases/download/latest/azurefile-dockervolumedriver -O
chmod +x azurefile-dockervolumedriver
sudo cp azurefile-dockervolumedriver /usr/bin/azurefile-dockervolumedriver
sudo chmod +x /usr/bin/azurefile-dockervolumedriver
sudo mkdir -p /etc/default/azurefile-dockervolumedriver
sudo curl https://raw.githubusercontent.com/Azure/azurefile-dockervolumedriver/master/contrib/init/systemd/azurefile-dockervolumedriver.default -o /etc/default/azurefile-dockervolumedriver/azurefile-dockervolumedriver.default
sudo chmod g+w /etc/default/azurefile-dockervolumedriver/azurefile-dockervolumedriver.default
sudo curl https://raw.githubusercontent.com/bartuer/CAAPI_provision/master/dockervolumedriver.service -o /usr/lib/systemd/system/azurefile-dockervolumedriver.service
sudo ln -s /usr/lib/systemd/system/azurefile-dockervolumedriver.service /etc/systemd/system/multi-user.target.wants/azurefile-dockervolumedriver.service
sudo systemctl daemon-reload
sudo systemctl enable azurefile-dockervolumedriver
sudo systemctl start azurefile-dockervolumedriver
echo "DONT forget change storage credential, run storagetoken.sh on local machine (NOT VM)"