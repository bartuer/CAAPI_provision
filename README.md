# CAAPI_provision

Provision files for Azure data science virtual machine. 

### Azure CLI tool and authentication setup

```shell
azure login
```
### Create Azure Data Science VM
Edit parameters.json before provision the template, fill all null 
parameters (total 5) before execute below command, it will take about 3 minutes
to successfully create the VM. And never check in parameters.json,
because you are check in credential data.

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
Configure ssh to remember machine IP/machine name, it will install NodeJS.
```shell
curl -o- https://raw.githubusercontent.com/bartuer/CAAPI_provision/master/ssh_config.sh | bash
```

Now you can connect to your machine use RSA public key
```
ssh $machine_name
```
### Provision
Below step should be done on VM.

#### Disable SELinux
Otherwise local folder sync between docker and host would have
permission problem.

Check SELinux running or not:
```shell
id -Z
```

VM will reboot after issue below command, after booting, SELinux should be
disabled. Reboot may take 1~2 minutes.
```shell
curl -o- https://raw.githubusercontent.com/bartuer/CAAPI_provision/master/disable_selinux.sh | bash
```

#### Install Docker

At end, a docker daemon will run as service.

```shell
curl -o- https://raw.githubusercontent.com/bartuer/CAAPI_provision/master/docker.sh | bash
```

Login again
```shell
exit
ssh $machine_name
docker run --rm hello-world
```
A hello world docker container will show up, that means docker install success.

#### Install Vagrant

For RMP system:

```shell
curl -o- https://raw.githubusercontent.com/bartuer/CAAPI_provision/master/vagrant.yum.sh | bash
```

#### Base Image, with ssh setup and host volume mounted 

Check out https://github.com/bartuer/CAAPI_files/blob/master/README.md
for volume mount details.

```shell
curl -o- https://raw.githubusercontent.com/bartuer/CAAPI_files/master/base/create.sh | bash
```

Access base docker instance.
```shell
cd /ml/vms/base && vagrant ssh
```

After ssh into docker container, Change to root to avoid incompatible
uid permission problem.

```shell
sudo su -
cd /ml/local
touch file_rw && chmod g+w file_rw
echo " Hello " > file_rw
```

On Host
```shell
cat /ml/local/file_rw
echo "" > /ml/local/file_rw
```

#### Mount Azure File Storage to docker container

Install driver for Azure File Storage docker volume.
```shell
curl -o- https://raw.githubusercontent.com/bartuer/CAAPI_provision/master/azurefile.sh | bash
```

Execute below command on local machine, not VM. $machine_name is host
field of output when configure ssh public key, check it at
~/.ssh/config.

```shell
./storagetoken.sh $machine_name
```

Now 2 Azure File Storage docker volume are created, datavol and
codevol.

#### Tensor Flow Image

```shell
curl -o- https://raw.githubusercontent.com/bartuer/CAAPI_files/master/tensorflow/create.sh | bash
```

Access tensor flow docker instance.

```shell
cd /ml/vms/tensorflow && vagrant ssh
```

#### Torch Image

```shell
curl -o- https://raw.githubusercontent.com/bartuer/CAAPI_files/master/torch/create.sh | bash
```
Access torch docker instance.

```shell
cd /ml/vms/torch && vagrant ssh
```

#### Emacs
CentOS/RedHat RPM package system:
```shell
curl -o- https://raw.githubusercontent.com/bartuer/dot-emacs/master/install/linux_yum.sh | bash
```

Ubuntu/Debian APT package system:
```shell
curl -o- https://raw.githubusercontent.com/bartuer/dot-emacs/master/install/linux_apt.sh | bash
```
