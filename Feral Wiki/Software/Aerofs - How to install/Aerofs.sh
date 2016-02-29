#! /bin/bash
########################
####Define Variables####
########################
echo "Before Installing Aerofs Please go to https://aerofs.com/ and create an account."
wget -qO ~/aerofs.tgz https://dsy5cjk52fz4a.cloudfront.net/aerofs-installer-0.8.91.tgz
tar xf ~/aerofs.tgz
echo "Configuring Aerofs: This will start the set-up process in screen.

Enter the email you registered with when prompted.

Enter you password for this account when prompted.

Enter the path you want for you Aerofs folder when prompted. This path will ~/Aerofs by default if you just press enter.

When the set-up is complete press this keyboard sequence to detach from the screen:

Press and hold CTRL and A then press D"
screen -S aerofs ~/aerofs/aerofs-cli
echo "Once you have setup up Aerofs you can start it easily using this command: screen -dmS aerofs ~/aerofs/aerofs-cli &"
##
