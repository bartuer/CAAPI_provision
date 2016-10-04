#!/bin/bash
curl -fsSL https://get.docker.com/ | bash
sudo groupadd docker
sudo usermod -aG docker $(whoami)
sudo usermod -aG root $(whoami)
sudo systemctl enable docker.service
sudo systemctl start docker
docker run --rm hello-world
