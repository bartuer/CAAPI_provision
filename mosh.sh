#!/bin/bash
sudo yum install mosh.x86_64 -y
sudo systemctl enable mosh
sudo systemctl start mosh