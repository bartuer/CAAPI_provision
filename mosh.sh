#!/bin/bash
sudo yum install mosh.x86_64 -y
sudo iptables -I INPUT 1 -p udp --dport 60000:61000 -j ACCEPT