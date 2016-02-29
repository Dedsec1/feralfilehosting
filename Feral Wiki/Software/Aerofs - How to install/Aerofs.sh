#! /bin/bash
########################
####Define Variables####
########################
echo "Before Installing Aerofs Please go to https://aerofs.com/ and create an account."
wget -qO ~/aerofs.tgz https://dsy5cjk52fz4a.cloudfront.net/aerofs-installer-0.8.91.tgz
tar xf ~/aerofs.tgz
echo "Configuring Aerofs: This will start the set-up process in screen.
sleep 1
screen -S aerofs ~/aerofs/aerofs-cli
sleep 1
echo "Aerofs Configuration has finished exting setup finished press this keyboard sequence to detach from the screen:
Press and hold CTRL and A then press D to detach." 
sleep 1
echo "starting up Aerofs in screen."
screen -dmS aerofs ~/aerofs/aerofs-cli &
##

