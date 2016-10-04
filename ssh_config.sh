#!/bin/bash

node -v >/dev/null 2>&1 || {
     curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash
     export NVM_DIR="/home/bazhou/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
     nvm install 6.0
     nvm use 6.0
}

node ssh_config >> ~/.ssh/config
cat ~/.ssh/config
