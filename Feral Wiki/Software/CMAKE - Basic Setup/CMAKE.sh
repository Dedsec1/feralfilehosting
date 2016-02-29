#! /bin/bash
########################
####Define Variables####
########################
echo "Setting up CMAKE."
mkdir -p ~/bin && bash
wget -qO ~/cmake.tar.gz http://www.cmake.org/files/v3.2/cmake-3.2.2-Linux-x86_64.tar.gz
tar xf ~/cmake.tar.gz --strip-components=1 -C ~/
echo "Testing Cmake install"
cmake --version
##
