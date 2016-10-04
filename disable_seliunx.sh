#!/bin/bash
sudo cat /etc/sysconfig/selinux | sed -e 's+SELINUX=enforcing+SELINUX=disabled+' > /etc/sysconfig/selinux
sudo reboot
