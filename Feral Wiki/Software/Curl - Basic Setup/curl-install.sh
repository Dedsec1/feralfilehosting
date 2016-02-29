#! /bin/bash
########################
####Define Variables####
########################
echo "Setting up Curl."
mkdir -p ~/bin && bash
wget -qO ~/curl.tar.gz http://curl.haxx.se/download/curl-7.41.0.tar.gz
tar xf ~/curl.tar.gz && cd ~/curl-7.41.0
./configure --prefix=$HOME
make && make install
cd && rm -rf curl{-7.41.0,.tar.gz}
echo "Curl Setup Complete Checking Version"
curl -V
#
