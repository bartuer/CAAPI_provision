# CAAPI_provision

Provision files for Azure data science virtual machine. 

### Azure CLI tool and authentication setup

#### Install Azure CLI
[https://azure.microsoft.com/en-us/documentation/articles/xplat-cli-install/](https://azure.microsoft.com/en-us/documentation/articles/xplat-cli-install/)

#### Auth
After Azure CLI installed, unzip CAAPI_azure_login.zip, copy content
in login file, it looks like

```shell
azure login --service-principal -u https://cafe.msra.cn/caapi/provision -p pass --tenant ...
```
### Create Azure Data Science VM
Edit parameters.json before provision the template, fill all null 
parameters (total 5) before execute below command, it will take about 3 minutes
to successfully create the VM. And never check in parameters.json,
because you are check in credential data.

More details about the VM image:
[Microsoft linux data science VM](https://azure.microsoft.com/en-us/marketplace/partners/microsoft-ads/linux-data-science-vm/)

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
```shell
ssh $machine_name
```
BELOW STEP SHOULD BE DONE ON VM.

Mosh can keep you connect to the VM, but it is optional.
```shell
curl -o- https://raw.githubusercontent.com/bartuer/CAAPI_provision/master/mosh.sh | bash
```

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
codevol, we will mount them when create docker image.

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

On Windows and OSX platform, follow docker official instrument:
[https://www.docker.com/products/overview](https://www.docker.com/products/overview)

#### Install Vagrant

```shell
curl -o- https://raw.githubusercontent.com/bartuer/CAAPI_provision/master/vagrant.yum.sh | bash
```

#### Minimal Image, with ssh setup and host volume mounted 

Check out [https://github.com/bartuer/CAAPI_files/blob/master/README.md](https://github.com/bartuer/CAAPI_files/blob/master/README.md)
for volume mount details.

We store docker images both on hub.docker.com and caapi blob storage,
Mapping caapi/minimal:latest to https://caapi.blob.core.windows.net/docker/minimal.latest.tar.gz

Speed up image pull as below, it is same as docker pull but faster when first time download.
```
curl https://caapi.blob.core.windows.net/docker/image/minimal.latest.tar.gz | gunzip | docker load
```
Notice vagrant will create another image based on docker pull/load image version.
```shell
curl -o- https://raw.githubusercontent.com/bartuer/CAAPI_files/master/minimal/create.sh | bash
```

Access minimal docker container.
```shell
cd /ml/vms/minimal && vagrant ssh
```

After ssh into docker container, Change to root to avoid incompatible
uid permission problem.

```shell
cd /ml/local
touch file_rw && chmod g+w file_rw
echo " Hello " > file_rw
```

On Host
```shell
cat /ml/local/file_rw
echo "" > /ml/local/file_rw
```

Try Azure File Storage volume
```shell
cd /ml/storage/code
touch file_rw && chmod g+w file_rw
echo " Hello for docker" > file_rw
```

On local machine, check via file service
```shell
azure storage file download -a caapi857 -k --share code -p /file_rw /tmp 
cat /tmp/file_rw
```

#### Tensor Flow 

```shell
curl -o- https://raw.githubusercontent.com/bartuer/CAAPI_files/master/tensorflow/create.sh | bash
```

Access tensor flow docker instance.

```shell
cd /ml/vms/tensorflow && vagrant ssh
```

#### Torch Container

```shell
curl -o- https://raw.githubusercontent.com/bartuer/CAAPI_files/master/torch/create.sh | bash
```
Access torch docker instance.

```shell
cd /ml/vms/torch && vagrant ssh
```

#### Emacs
If you don't use Emacs as your editor/IDE, ignore this.

CentOS/RedHat RPM package system:
```shell
curl -o- https://raw.githubusercontent.com/bartuer/dot-emacs/master/install/linux_yum.sh | bash
```

Ubuntu/Debian APT package system:
```shell
curl -o- https://raw.githubusercontent.com/bartuer/dot-emacs/master/install/linux_apt.sh | bash
```
Or docker way, on Windows:
```shell
docker pull caapi/emacs:base
docker run --rm -p 2233:22 -v C:/Users:/ml caapi/emacs:base
ssh -p 2233 vagrant@localhost
ec
```