# Preparing Azure VM

sudo apt-get update; sudo apt-get install -y python build-essential git wget make
sudo apt-get update; sudo apt-get -y install gcc gfortran
sudo apt-get update;

wget http://us.download.nvidia.com/tesla/410.79/nvidia-diag-driver-local-repo-ubuntu1804-410.79_1.0-1_amd64.deb;


sudo dpkg -i nvidia-diag-driver-local-repo-ubuntu1804-410.79_1.0-1_amd64.deb;

sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub;


sudo apt-get update; sudo apt-get -y install cuda-drivers;
sudo apt-get install cuda;
sudo reboot
