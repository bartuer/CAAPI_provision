#!/bin/bash
sudo cat /etc/sysconfig/selinux | sed -e 's+SELINUX=enforcing+SELINUX=disabled+' > /tmp/selinux
sudo cp /tmp/selinux /etc/sysconfig/selinux
sudo reboot
