#!/bin/bash

azure vm list >/dev/null 2>&1 || {
    echo "Should not run on machine without azure CLI actived, not run it on VM";
    exit 1;
}

if [ -z "$1" ]; then
    echo "Specify machine name: ./storagetoken.sh the_machine_name"
    exit 2;
fi

node get_azure_token.js | ssh $1 'cat - > /etc/default/azurefile-dockervolumedriver/azurefile-dockervolumedriver.default'
curl -o- https://raw.githubusercontent.com/bartuer/CAAPI_provision/master/createdockervolume.sh | ssh $1 'bash -s'