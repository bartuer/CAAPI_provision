#!/bin/bash
sudo systemctl daemon-reload
sudo systemctl enable azurefile-dockervolumedriver
sudo systemctl start azurefile-dockervolumedriver
docker volume create -d  azurefile -o share=code --name=codevol
docker volume create -d  azurefile -o share=data --name=datavol