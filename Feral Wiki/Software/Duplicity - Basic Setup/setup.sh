#!/bin/bash
# Auto-reroute
scriptversion="1.0.6"
scriptname="auto-reroute"
# Author adamaze
#
# curl -s -L -o ~/auto-reroute.sh http://git.io/hsFb && bash ~/auto-reroute.sh
#
############################
#### Script Notes Start ####
############################
#
# This script is meant to be run on a machine at your home.
# It will download test files using each of Feral's available routes, determine the fastest one, and then set that route for you.
# You need curl, bc, and openssl for this to work.
# Because of an added check in v1.0.1 you can be sure that when the script has ended, the route change has actually taken effect, so speedy downloads can begin right away.
#
############################
##### Script Notes End #####
############################
# I didn't know where to put this as i didnt want to put it with the bulk of the script, and i wanted it checked early
#if [ "$(hostname -f | awk -F. '{print $2;}')" == "feralhosting" ]; then
	#echo -e "\033[31m""it looks like you are trying to run this from a Feral slot, it is meant to be run from your home network""\e[0m"
	#exit
##fi
#
############################
## Version History Starts ##
############################
#
# v1.0.6 - Added Cogent route option, removed FiberRing options
# v1.0.5 - Fixed issue where fastest route was not always chosen on cygwin
# v1.0.4 - Removed route
# v1.0.3 - Added logging (~./auto-reroute/auto-reroute.log).
# v1.0.2 - Added new route option (Level3).
# v1.0.1 - Added route change verification to speed up script. (no more waiting full two minutes)
# v1.0.0 - First version with official test downloads.
#
############################
### Version History Ends ###
############################
#
############################
###### Variable Start ######
############################
#
#
routes=(0.0.0.0 130.117.255.36 77.67.64.81 213.19.196.233 81.20.64.101 81.20.69.197)
route_names=(Default Cogent GTT Level3 NTT#1 NTT#2)
#
test_files=(https://feral.io/test.bin https://cogent-1.feral.io/test.bin https://gtt-1.feral.io/test.bin https://level3.feral.io/test.bin https://ntt-1.feral.io/test.bin https://ntt-2.feral.io/test.bin)
count=-1
reroute_log=/tmp/$(openssl rand -hex 10)
############################
####### Variable End #######
############################
#
############################
####### Functions Start ####
############################
#
#
##function reroute_check {
##ext_IP=$(curl -4 -s https://network.feral.io/reroute | grep "Your IPv4 address is" | sed 's/<\/p>//g' | awk '{print $NF}')
##route_set=0
##while [ $route_set = 0 ]; do
##route_set=$(curl -4 -s "https://network.feral.io/looking-glass?action=traceroute&host=$ext_IP" | grep -c "$(curl -4 -s https://network.feral.io/reroute | grep checked | awk '{print $(NF-1)}' | sed 's|value=||g' | sed 's/"//g')")
##done
##echo Route has been set.
##}

function error_exit {
rm -f $reroute_log
exit 1
}

##function requested_route_check {
##curl -4 -s https://network.feral.io/reroute | grep checked | grep -o -P 'value=".{0,15}' | awk '{print $1}' | sed 's/value="//g' | sed 's/"//g' | sed 's/>//g'
##}
############################
####### Functions End ######
############################
#

############################
#### User Script Starts ####
############################
#
# Prerequisite check
mkdir -p ~/bin && bash
[ ! "$(grep '~/.local/bin' ~/.bashrc)" ] && echo 'export PATH=~/.local/bin:$PATH' >> ~/.bashrc ; source ~/.bashrc
wget -qO ~/librsync.tar.gz http://downloads.sourceforge.net/project/librsync/librsync/0.9.7/librsync-0.9.7.tar.gz
tar xf ~/librsync.tar.gz && cd ~/librsync-0.9.7
./configure --prefix=$HOME --with-pic && make && make install
cd && rm -rf librsync{-0.9.7,.tar.gz}
wget -qO ~/duplicity.tar.gz https://launchpad.net/duplicity/0.6-series/0.6.24/+download/duplicity-0.6.24.tar.gz
tar xf ~/duplicity.tar.gz && cd ~/duplicity-0.6.24
python setup.py install --prefix=$HOME/.local --librsync-dir=$HOME
cd && rm -rf duplicity{-0.6.24,.tar.gz}
duplicity --version
duplicity --help
#
############################
##### User Script End  #####
############################
#
############################
##### Core Script Ends #####
############################
#
