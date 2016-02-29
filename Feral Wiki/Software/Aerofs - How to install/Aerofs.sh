#! /bin/bash
########################
####Define Variables####
########################
echo "Before Installing Aerofs Please go to https://aerofs.com/ and create an account."
wget -qO ~/aerofs.tgz https://dsy5cjk52fz4a.cloudfront.net/aerofs-installer-0.8.91.tgz
tar xf ~/aerofs.tgz
echo "Configuring Aerofs: This will start the set-up process in screen."
screen -S aerofs ~/aerofs/aerofs-cli
echo "Starting up Aerofs"
screen -dmS aerofs ~/aerofs/aerofs-cli &
##
##
