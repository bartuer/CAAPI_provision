#!/bin/bash

azure vm list >/dev/null 2>&1 || {
    echo "Should not run on machine without azure CLI actived, not run it on VM";
    exit 1;
}

node get_azure_token.js | ssh $1 'cat - > /etc/default/azurefile-dockervolumedriver/azurefile-dockervolumedriver.default'
curl -o- https://raw.githubusercontent.com/bartuer/CAAPI_provision/master/createdockervolume.sh | ssh $1 'bash -s'