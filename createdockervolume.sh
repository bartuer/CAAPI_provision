#!/bin/bash
docker volume create -d  azurefile -o share=code --name=codevol
docker volume create -d  azurefile -o share=data --name=datavol