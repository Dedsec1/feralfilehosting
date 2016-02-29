#! /bin/bash
########################
####Define Variables####
########################
echo "Setting Up Dropbox."
mkdir -p ~/bin && bash
wget -qO ~/dropbox.tar.gz "http://www.dropbox.com/download/?plat=lnx.x86_64" && tar -xzf dropbox.tar.gz
wget -qO ~/bin/dropbox.py "http://www.dropbox.com/download?dl=packages/dropbox.py" && chmod 700 ~/bin/dropbox.py
source ~/.bashrc && source ~/.profile
rm -f ~/dropbox.tar.gz
echo "Setting up linking your Drobox Account"
HOME=$HOME/ ~/.dropbox-dist/dropboxd
sleep 10
HOME=$HOME/ ~/.dropbox-dist/dropboxd &
##
