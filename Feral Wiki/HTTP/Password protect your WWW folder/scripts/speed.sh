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


function error_exit {
rm -f $reroute_log
exit 1
}


############################
####### Functions End ######
############################
#

############################
#### User Script Starts ####
############################
#
# Prerequisite check
command -v curl >/dev/null 2>&1 || { echo >&2 "This script requires curl but it's not installed.  Aborting."; exit 1; }
command -v bc >/dev/null 2>&1 || { echo >&2 "This script requires bc but it's not installed.  Aborting."; exit 1; }
command -v openssl >/dev/null 2>&1 || { echo >&2 "This script requires openssl but it's not installed.  Aborting."; exit 1; }



#
	for i in "${routes[@]}"
	do
		((count++))
		echo "Testing single segment download speed from ${route_names[$count]}..."
		##need sed now because some european versions of curl insert a , in the speed results
		messyspeed=$(echo -n "scale=2; " && curl -4 -s -L ${test_files[$count]} -w "%{speed_download}" -o /dev/null | sed "s/\,/\./g")
		if [ -z "$(echo $messyspeed | awk -F\; '{print $2}'| sed 's/ //g')" ]; then
			echo "There was an issue downloading ${test_files[$count]}"
			speed="0"
		else
			speed=$(echo $messyspeed/1048576*8 | bc | sed 's/$/ Mbit\/s/')	
			if [ "$speed" = "ERROR404:" ]; then
				echo -e "\033[31m""\nThe test file cannot be found at ${test_files[$count]} \n""\e[0m"
				exit
			fi
	               	 echo "$speed ${routes[$count]} ${route_names[$count]}" >> $reroute_log
		fi
	done
	#
	fastestroute=$(sort -gr $reroute_log | head -n 1 | awk '{print $3}')
	fastestspeed=$(sort -gr $reroute_log | head -n 1 | awk '{print $1}')
	fastestroutename=$(sort -gr $reroute_log | head -n 1 | awk '{print $4}')
	#
	fi
	sed -i 's/ /, /g' $reroute_log
	sed -i "s/^/$(date -u), /g" $reroute_log
	cat $reroute_log >> ~/.auto-reroute/auto-reroute.log
	rm $reroute_log
	#
	echo 'All done!'
#
############################
##### User Script End  #####
############################
#
############################
##### Core Script Ends #####
############################
#
