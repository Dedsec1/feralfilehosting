#! /bin/bash
#############################################
####Define Variables####
##############################################
echo "Setting up CMake "
wget -qO ~/cmake.tar.gz http://www.cmake.org/files/v3.2/cmake-3.2.2.tar.gz
tar xf ~/cmake.tar.gz && cd ~/cmake-3.2.2
./configure --prefix=$HOME
make && make install
cd && rm -rf cmake{-3.2.2,.tar.gz}
echo "Testing Cmake install"
cmake --version
##
