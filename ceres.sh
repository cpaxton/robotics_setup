# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "############################"
echo "# ceres-solver with manual 16.04 workarounds"
echo "############################"
echo ""
echo "assumes cmake is installed"
echo ""
echo "ceres-solver.org"
echo ""

# google-glog + gflags
sudo apt-get install libgoogle-glog-dev
# BLAS & LAPACK
sudo apt-get install libatlas-base-dev
# Eigen3
sudo apt-get install libeigen3-dev
# SuiteSparse and CXSparse (optional)
# - If you want to build Ceres as a *static* library (the default)
#   you can use the SuiteSparse package in the main Ubuntu package
#   repository:
sudo apt-get install -y libsuitesparse-dev
# - However, if you want to build Ceres as a *shared* library, you must
#   add the following PPA:
sudo add-apt-repository ppa:bzindovic/suitesparse-bugfix-1319687
sudo apt-get update
sudo apt-get install -y libsuitesparse-dev

cd ~/src

if [ ! -d ~/src/ceres-solver ]
then
    git clone https://ceres-solver.googlesource.com/ceres-solver
fi

cd ceres-solver

if [ ! -d build ]
then
    mkdir build
fi

cd build
cmake ..
make -j16 && sudo make install

# Uncomment below and comment above for ubuntu 16.04

echo "Ubuntu 16.04 bugs:"
echo "https://bugs.launchpad.net/ubuntu/+source/ceres-solver/+bug/1596296"
echo "https://bugs.launchpad.net/ubuntu/+source/ceres-solver/+bug/1595692"
echo "INCLUDES HACK TO GET AROUND missing package files IN UBUNTU 16.04"

#sudo apt install libceres-dev
# sudo cp -a ceres/Ceres /usr/share
# sudo cp -a ceres/include/internal/config.h /usr/include/ceres/internal

cd $DIR
