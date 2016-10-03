# CAAPI_provsion

Provision files for Azure data science virtual machine. 

### Azure CLI tool and authentication setup

```shell
azure login
```
### Create VM
Edit parameters.json before provision the template, fill all null
parameters before execute below command, it will take about 3 minutes
to successfully create the VM.

```shell
./deploy.sh
```
Make sure ssh public key already on your machine:
```shell
ls ~/.ssh/id_rsa.pub
```
If there is no such key file, you need generate ssh key pair like:
```shell
ssh-keygen
```
Do not edit sshkey.parameters.json file, all null parameters should be
fill automatically when execute below command, it will take about 1 minutes.
```shell
./sshkey.sh
```
Configure ssh to remember machine IP/name
```shell
node ssh_config >> ~/.ssh/config
cat ~/.ssh/config
```
Now you can connect to your machine use public key
```
ssh $machine_name
```
### Provision
Below step should be done on VM.

#### Vagrant
For RMP system:
```shell
curl -o- https://raw.githubusercontent.com/bartuer/CAAPI_provision/master/vagrant.yum.sh | bash
```
For APT system:
```shell
curl -o- https://raw.githubusercontent.com/bartuer/CAAPI_provision/master/vagrant.apt.sh | bash
```

#### Emacs
On  CentOS/RedHat RPM package system:
```shell
curl -o- https://raw.githubusercontent.com/bartuer/dot-emacs/master/install/linux_yum.sh | bash
```

On Ubuntu/Debian APT package system:
```shell
curl -o- https://raw.githubusercontent.com/bartuer/dot-emacs/master/install/linux_apt.sh | bash
```