#!/bin/bash
sudo su -
cat /etc/sysconfig/selinux | sed -e 's+SELINUX=enforcing+SELINUX=disabled+' > /etc/sysconfig/selinux
reboot
