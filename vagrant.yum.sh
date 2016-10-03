sudo mkdir -p /var/cache/yum/x86_64/7/vagrant/
sudo cd /var/cache/yum/x86_64/7/vagrant/
sudo curl -O https://releases.hashicorp.com/vagrant/1.8.6/vagrant_1.8.6_x86_64.rpm
sudo yum install vagrant_1.8.6_x86_64.rpm -y