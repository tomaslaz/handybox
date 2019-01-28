
## Installing OpenMPI 3.1.3  (Ubuntu 16/18)

sudo apt-get update -y
sudo apt-get install -y gcc g++ gfortran

mkdir -p ~/Software
cd ~/Software

wget https://download.open-mpi.org/release/open-mpi/v3.1/openmpi-3.1.3.tar.bz2
tar -xvf openmpi-3.1.3.tar.bz2
cd openmpi-3.1.3
./configure --prefix=/usr/local
make -j
sudo make -j install

### Adding environment variables to ~/.bashrc

export PATH="/usr/local/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/lib/:$LD_LIBRARY_PATH"
source .bashrc

### TEST
mkdir -p test
cd test
wget https://raw.githubusercontent.com/open-mpi/ompi/master/examples/ring_c.c
mpicc -o ring_c ring_c.c
mpirun -np 2 ring_c
