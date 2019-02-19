## Resource groups

### Create resource group

```
az group create --name multiplegpusrg --location "UK South"
```

### List all resource groups

```
az group list
```

## Storage

```
az storage account create -n multiplegpusstorage -g multiplegpusrg --location "UK South" --sku Standard_LRS
```

## VM

### Create VM

Creating a VM in south uk comprising two K80 gpus

```
az vm create \
  --resource-group multiplegpusrg \
  --name multigpu \
  --image UbuntuLTS \
	--size Standard_NC12 \
  --admin-username tomaslaz \
	--generate-ssh-keys
```

### Open port 22 for ssh

az vm open-port --port 22 --resource-group multiplegpusrg --name multigpu

### Adding ssh key (did not work)

```
az vm user update \
  --resource-group multiplegpusrg \
  --name multigpu \
  --username tomaslaz \
  --ssh-key-value ~/.ssh/turing_imac.pub
```

# Preparing Azure VM

## Installing docker

```
sudo apt-get update
```

```
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
```

```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

```
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
```

```
sudo apt-get update; sudo apt-get install -y docker-ce
```

```
sudo docker run hello-world
```

## Installing NVidia drivers

```
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
```

```
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub;
```

```
sudo dpkg -i cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
```

```
sudo apt-get update
```

```
sudo apt-get install -y cuda
```

```
sudo reboot
```

Verifying CUDA installation
```
cat /proc/driver/nvidia/version
```

## Installing Nvidia docker and Nvidia docker plugin

```
wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb
```

```
sudo dpkg -i /tmp/nvidia-docker*.deb && rm /tmp/nvidia-docker*.deb
```

Let's test
```
nvidia-docker run --rm nvidia/cuda nvidia-smi
```






sudo apt-get update; sudo apt-get install -y python build-essential git wget make
sudo apt-get update; sudo apt-get -y install gcc gfortran
sudo apt-get update;

wget http://us.download.nvidia.com/tesla/410.79/nvidia-diag-driver-local-repo-ubuntu1804-410.79_1.0-1_amd64.deb;


sudo dpkg -i nvidia-diag-driver-local-repo-ubuntu1804-410.79_1.0-1_amd64.deb;

sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub;


sudo apt-get update; sudo apt-get -y install cuda-drivers;
sudo apt-get install cuda;
sudo reboot
