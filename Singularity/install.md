

## 2.6.1 on Ubuntu 16/18

sudo apt-get update -y
sudo apt-get install -y python dh-autoreconf build-essential libarchive-dev git wget

mkdir -p ~/Software
cd ~/Software
git clone https://github.com/sylabs/singularity.git
cd singularity
git fetch --all
git tag -l
git checkout 2.6.1
./autogen.sh
./configure --prefix=/usr/local --sysconfdir=/etc
make
sudo make install
