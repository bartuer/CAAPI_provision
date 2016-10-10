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

azure vm list -g CAAPI >/dev/null 2>&1 || {
    echo "Should not run on machine without azure CLI actived, try"
    echo "azure login --service-principal -u https://cafe.msra.cn/caapi/provision -p pass --tenant 72f988bf-86f1-41af-91ab-2d7cd011db47";
    exit 1;
}

echo "get AFS key"
curl -o- https://raw.githubusercontent.com/bartuer/CAAPI_provision/master/get_azure_token.js |node  > /etc/default/azurefile-dockervolumedriver/azurefile-dockervolumedriver.default

echo "start docker AFS driver"
sudo systemctl daemon-reload
sudo systemctl enable azurefile-dockervolumedriver
sudo systemctl start azurefile-dockervolumedriver
sudo systemctl status azurefile-dockervolumedriver -l

echo "create docker volume"
docker stop `(docker ps -a -q)`
# rm volume in case it mount as wrong local driver
docker volume rm codevol
docker volume rm datavol
docker volume create -d  azurefile -o share=code --name=codevol
docker volume create -d  azurefile -o share=data --name=datavol
docker volume inspect codevol
docker volume inspect datavol

echo "mount AFS to host"
cat /etc/fstab > /tmp/fstab
curl -o- https://raw.githubusercontent.com/bartuer/CAAPI_provision/master/afs_mount.js | node >> /tmp/fstab
cat /tmp/fstab
sudo cp /tmp/fstab /etc/fstab
rm -f /tmp/fstab
rm -f /tmp/afspass
sudo cp /tmp/afspass /
sudo chmod g+w /afspass
sudo mount -a