#! /bin/bash
########################
####Define Variables####
########################
echo "Autodl-irssi and rutorrent plugin - community edition"
mkdir -p ~/.irssi/scripts/autorun ~/.autodl
echo -e "[options]\ngui-server-port = 0\ngui-server-password = PASS" > ~/.autodl/autodl.cfg
wget -O ~/autodl-irssi.zip $(curl -sL http://git.io/vlcND | grep 'browser' | cut -d\" -f4)
unzip -qo ~/autodl-irssi.zip -d ~/.irssi/scripts/
cp -f ~/.irssi/scripts/autodl-irssi.pl ~/.irssi/scripts/autorun/
cd && rm -f autodl-irssi.zip .irssi/scripts/{README*,autodl-irssi.pl,CONTRIBUTING.md}
##
