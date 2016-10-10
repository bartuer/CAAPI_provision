#!/bin/bash
echo "download docker AFS driver"
cd /tmp
curl -L http://bartuer.cloudapp.net/azurefile-dockervolumedriver -O
chmod +x azurefile-dockervolumedriver
sudo cp azurefile-dockervolumedriver /usr/bin/azurefile-dockervolumedriver
sudo chmod +x /usr/bin/azurefile-dockervolumedriver
echo "configure docker AFS driver"
sudo mkdir -p /etc/default/azurefile-dockervolumedriver
sudo curl https://raw.githubusercontent.com/Azure/azurefile-dockervolumedriver/master/contrib/init/systemd/azurefile-dockervolumedriver.default -o /etc/default/azurefile-dockervolumedriver/azurefile-dockervolumedriver.default
sudo chmod g+w /etc/default/azurefile-dockervolumedriver/azurefile-dockervolumedriver.default
sudo curl https://raw.githubusercontent.com/bartuer/CAAPI_provision/master/azurefile-dockervolumedriver.service -o /usr/lib/systemd/system/azurefile-dockervolumedriver.service
sudo ln -fs /usr/lib/systemd/system/azurefile-dockervolumedriver.service /etc/systemd/system/multi-user.target.wants/azurefile-dockervolumedriver.service
