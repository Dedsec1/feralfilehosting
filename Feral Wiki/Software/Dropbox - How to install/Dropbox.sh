#!/bin/bash
#
############################
##### Basic Info Start #####
############################
#
# Script Author: randomessence
#
# Script Contributors: 
#
# License: This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License. https://creativecommons.org/licenses/by-sa/4.0/
#
# Bash Command for easy reference:
#
# wget -qO ~/install.couchpotato http://git.io/3_iozg && bash ~/install.couchpotato
#
############################
###### Basic Info End ######
############################
#
############################
#### Script Notes Start ####
############################
#
## See readme.md
#
############################
##### Script Notes End #####
############################
#
############################
## Version History Starts ##
############################
#
if [[ ! -z "$1" && "$1" = 'changelog' ]]
then
    echo
    #
    # put your version changes in the single quotes and then uncomment the line.
    #
    #echo 'v0.1.0 - My changes go here'
    #echo 'v0.0.9 - My changes go here'
    #echo 'v0.0.8 - My changes go here'
    #echo 'v0.0.7 - My changes go here'
    #echo 'v0.0.6 - My changes go here'
    #echo 'v0.0.5 - My changes go here'
    echo 'v1.0.9 - small fixes and some tweaks'
    echo 'v1.0.8 - bug fixes to option 3. Settings port and proxypass port were different. Visual tweaks.'
    echo 'v1.0.7 - Added option to just install the proxypass. Updated template and minor tweaks.'
    echo 'v1.0.6 - Updated templated'
    #
    echo
    exit
fi
#
############################
### Version History Ends ###
############################
#
############################
###### Variable Start ######
############################
#
# Script Version number is set here.
scriptversion="1.0.9"
#
# Script name goes here. Please prefix with install.
scriptname="install.couchpotato"
#
# Author name goes here.
scriptauthor="randomessence"
#
# Contributor's names go here.
contributors="None credited"
#
# Set the http://git.io/ shortened URL for the raw github URL here:
gitiourl="http://git.io/3_iozg"
#
# Don't edit: This is the bash command shown when using the info option.
gitiocommand="wget -qO ~/$scriptname $gitiourl && bash ~/$scriptname"
#
# This is the raw github url of the script to use with the built in updater.
scripturl="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/CouchPotato%20-%20An%20automatic%20NZB%20and%20torrent%20downloader%20for%20Films/scripts/install.couchpotato.sh"
#
# This will generate a 20 character random passsword for use with your applications.
apppass="$(< /dev/urandom tr -dc '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' | head -c20; echo;)"
# This will generate a random port for the script between the range 10001 to 32001 to use with applications. You can ignore this unless needed.
appport="$(shuf -i 10001-32001 -n 1)"
#
# This wil take the previously generated port and test it to make sure it is not in use, generating it again until it has selected an open port.
while [[ "$(netstat -ln | grep ':'"$appport"'' | grep -c 'LISTEN')" -eq "1" ]]; do appport="$(shuf -i 10001-32001 -n 1)"; done
#
# Script user's http www URL in the format http://username.server.feralhosting.com/
host1http="http://$(whoami).$(hostname -f)/"
# Script user's https www URL in the format https://username.server.feralhosting.com/
host1https="https://$(whoami).$(hostname -f)/"
# Script user's http www url in the format https://server.feralhosting.com/username/
host2http="http://$(hostname -f)/$(whoami)/"
# Script user's https www url in the format https://server.feralhosting.com/username/
host2https="https://$(hostname -f)/$(whoami)/"
#
# feralwww - sets the full path to the default public_html directory if it exists.
[[ -d ~/www/"$(whoami)"."$(hostname -f)"/public_html ]] && feralwww="$HOME/www/$(whoami).$(hostname -f)/public_html/"
# rtorrentdata - sets the full path to the rtorrent data directory if it exists.
[[ -d ~/private/rtorrent/data ]] && rtorrentdata="$HOME/private/rtorrent/data"
# deluge - sets the full path to the deluge data directory if it exists.
[[ -d ~/private/deluge/data ]] && delugedata="$HOME/private/deluge/data"
# transmission - sets the full path to the transmission data directory if it exists.
[[ -d ~/private/transmission/data ]] && transmissiondata="$HOME/private/transmission/data"
#
# Bug reporting varaibles.
makeissue=".makeissue $scriptname A description of the issue"
ticketurl="https://www.feralhosting.com/manager/tickets/new"
gitissue="https://github.com/feralhosting/feralfilehosting/issues/new"
#
############################
## Custom Variables Start ##
############################
#
giturl="https://github.com/RuudBurger/CouchPotatoServer.git"
#
[[ -f ~/.couchpotato/settings.conf ]] && proxyport="$(grep -oE -m 1 'port = [0-9]{4,5}' ~/.couchpotato/settings.conf | sed -rn 's/^port = (.*)/\1/p')"
#
############################
### Custom Variables End ###
############################
#
# Disables the built in script updater permanently by setting this variable to 0.
updaterenabled="0"
#
############################
####### Variable End #######
############################
#
############################
###### Function Start ######
############################
#
showMenu () 
{
        echo "1) Install Program"
        echo "2) Update Program"
        echo "3) Install the Apache or Nginx proxypass"
        echo "4) Quit the Script"
        echo
}
#
############################
####### Function End #######
############################
#
############################
#### Script Help Starts ####
############################
#
if [[ ! -z "$1" && "$1" = 'help' ]]
then
    echo
    echo -e "\033[32m""Script help and usage instructions:""\e[0m"
    echo
    #
    #####################################
    ##### Custom Help Info Starts #####
    ###################################
    #
    echo -e "Put your help instructions or script guidance here"
    #
    ###################################
    ###### Custom Help Info Ends ######
    ###################################
    #
    echo
    exit
fi
#
############################
##### Script Help Ends #####
############################
#
############################
#### Script Info Starts ####
############################
#
# Use this to show a user script information when they use the info option with the script.
if [[ ! -z "$1" && "$1" = 'info' ]]
then
    echo
    echo -e "\033[32m""Script Details:""\e[0m"
    echo
    echo "Script version: $scriptversion"
    echo
    echo "Script Author: $scriptauthor"
    echo
    echo "Script Contributors: $contributors"
    echo
    echo -e "\033[32m""Script options:""\e[0m"
    echo
    echo -e "\033[36mhelp\e[0m = See the help section for this script."
    echo
    echo -e "Example usage: \033[36m$scriptname help\e[0m"
    echo
    echo -e "\033[36mchangelog\e[0m = See the version history and change log of this script."
    echo
    echo -e "Example usage: \033[36m$scriptname changelog\e[0m"
    echo
    echo -e "\033[36minfo\e[0m = Show the script information and usage instructions."
    echo
    echo -e "Example usage: \033[36m$scriptname info\e[0m"
    echo
    echo -e "\033[31mImportant note:\e[0m Options \033[36mqr\e[0m and \033[36mnu\e[0m are interchangeable and usable together."
    echo
    echo -e "For example: \033[36m$scriptname qr nu\e[0m or \033[36m$scriptname nu qr\e[0m will both work"
    echo
    echo -e "\033[36mqr\e[0m = Quick Run - use this to bypass the default update prompts and run the main script directly."
    echo
    echo -e "Example usage: \033[36m$scriptname qr\e[0m"
    echo
    echo -e "\033[36mnu\e[0m = No Update - disable the built in updater. Useful for testing new features or debugging."
    echo
    echo -e "Example usage: \033[36m$scriptname nu\e[0m"
    echo
    echo -e "\033[32mBash Commands:\e[0m"
    echo
    echo -e "\033[36m""$gitiocommand""\e[0m"
    echo
    echo -e "\033[36m""~/bin/$scriptname""\e[0m"
    echo
    echo -e "\033[36m""$scriptname""\e[0m"
    echo
    echo -e "\033[32m""Bug Reporting:""\e[0m"
    echo
    echo -e "These are the recommended ways to report bugs for scripts in the FAQs:"
    echo
    echo -e "1: In IRC you can use wikibot to create a github issue by using this command format:"
    echo
    echo -e "\033[36m""$makeissue""\e[0m"
    echo
    echo -e "2: You could open a ticket describing the problem with details of which script and what the problem is."
    echo
    echo -e "\033[36m""$ticketurl""\e[0m"
    echo
    echo -e "3: You can create an issue directly on github using your github account."
    echo
    echo -e "\033[36m""$gitissue""\e[0m"
    echo
    echo -e "\033[33m""All bug reports are welcomed and very much appreciated, as they benefit all users.""\033[32m"
    #
    echo
    exit
fi
#
############################
##### Script Info Ends #####
############################
#
############################
#### Self Updater Start ####
############################
#
# Checks for the positional parameters $1 and $2 to be reset if the script is updated.
[[ ! -z "$1" && "$1" != 'qr' ]] || [[ ! -z "$2" && "$2" != 'qr' ]] && echo -en "$1\n$2" > ~/.passparams
# Quick Run option part 1: If qr is used it will create this file. Then if the script also updates, which would reset the option, it will then find this file and set it back.
[[ ! -z "$1" && "$1" = 'qr' ]] || [[ ! -z "$2" && "$2" = 'qr' ]] && echo -n '' > ~/.quickrun
#
# No Update option: This disables the updater features if the script option "nu" was used when running the script.
if [[ ! -z "$1" && "$1" = 'nu' ]] || [[ ! -z "$2" && "$2" = 'nu' ]]
then
    echo
    echo "The Updater has been temporarily disabled"
    echo
    scriptversion="$scriptversion-nu"
else
    #
    # Check to see if the variable "updaterenabled" is set to 1. If it is set to 0 the script will bypass the built in updater regardless of the options used.
    if [[ "$updaterenabled" -eq "1" ]]
    then
        [[ ! -d ~/bin ]] && mkdir -p ~/bin
        [[ ! -f ~/bin/"$scriptname" ]] && wget -qO ~/bin/"$scriptname" "$scripturl"
        #
        wget -qO ~/.000"$scriptname" "$scripturl"
        #
        if [[ "$(sha256sum ~/.000"$scriptname" | awk '{print $1}')" != "$(sha256sum ~/bin/"$scriptname" | awk '{print $1}')" ]]
        then
            echo -e "#!/bin/bash\nwget -qO ~/bin/$scriptname $scripturl\ncd && rm -f $scriptname{.sh,}\nbash ~/bin/$scriptname\nexit" > ~/.111"$scriptname"
            bash ~/.111"$scriptname"
            exit
        else
            if [[ -z "$(pgrep -fu "$(whoami)" "bash $HOME/bin/$scriptname")" && "$(pgrep -fu "$(whoami)" "bash $HOME/bin/$scriptname")" -ne "$$" ]]
            then
                echo -e "#!/bin/bash\ncd && rm -f $scriptname{.sh,}\nbash ~/bin/$scriptname\nexit" > ~/.222"$scriptname"
                bash ~/.222"$scriptname"
                exit
            fi
        fi
        cd && rm -f .{000,111,222}"$scriptname"
        chmod -f 700 ~/bin/"$scriptname"
        echo
    else
        echo
        echo "The Updater has been disabled"
        echo
        scriptversion="$scriptversion-DEV"
    fi
fi
#
# Quick Run option part 2: If quick run was set and the updater section completes this will enable quick run again then remove the file.
[[ -f ~/.quickrun ]] && updatestatus="y"; rm -f ~/.quickrun
#
# resets the positional parameters $1 and $2 post update.
[[ -f ~/.passparams ]] && set "$1" "$(sed -n '1p' ~/.passparams)" && set "$2" "$(sed -n '2p' ~/.passparams)"; rm -f ~/.passparams
#
############################
##### Self Updater End #####
############################
#
############################
## Positional Param Start ##
############################
#
if [[ ! -z "$1" && "$1" = "example" ]]
then
    echo
    #
    # Edit below this line
    #
    echo "Add your custom positional parameters in this section."
    #
    if [[ -n "$2" ]]
    then
        echo "You used $scriptname $1 $2 when calling this example"
    fi
    #
    # Edit above this line
    #
    echo
    exit
fi
#
############################
### Positional Param End ###
############################
#
############################
#### Core Script Starts ####
############################
#
if [[ "$updatestatus" = "y" ]]
then
    :
else
    echo -e "Hello $(whoami), you have the latest version of the" "\033[36m""$scriptname""\e[0m" "script. This script version is:" "\033[31m""$scriptversion""\e[0m"
    echo
    read -ep "The script has been updated, enter [y] to continue or [q] to exit: " -i "y" updatestatus
    echo
fi
#
if [[ "$updatestatus" =~ ^[Yy]$ ]]
then
#
############################
#### User Script Starts ####
############################
#
    while [ 1 ]
    do
        showMenu
        read -e CHOICE
        echo
        case "$CHOICE" in
            "1")
                    mkdir -p ~/bin && bash
                    wget -qO ~/dropbox.tar.gz "http://www.dropbox.com/download/?plat=lnx.x86_64" && tar -xzf dropbox.tar.gz
                    wget -qO ~/bin/dropbox.py "http://www.dropbox.com/download?dl=packages/dropbox.py" && chmod 700 ~/bin/dropbox.py
                    source ~/.bashrc && source ~/.profile
                    rm -f ~/dropbox.tar.gz
                    echo "Downloading and configuring some files..."
                    echo
                    .dropbox-dist/dropboxd &
                ;;
            "2")    
                if [[ -d ~/.couchpotato ]]
                then
                    if [[ -f ~/.couchpotato/couchpotato.pid ]]
                    then
                        kill "$(cat ~/.couchpotato/couchpotato.pid)"
                        while [[ -f ~/.couchpotato/couchpotato.pid  ]]; do printf '\rI need to wait for Couchpotato to shut down. '; done
                        echo -e '\n'
                    fi
                    cd ~/.couchpotato
                    git pull origin
                    echo
                    python ~/.couchpotato/CouchPotato.py --config_file="$HOME/.couchpotato/settings.conf" --daemon
                    echo "Visit this URL to use Couchpotato:"
                    echo
                    echo -e "\033[32m""${host2https}couchpotato/""\e[0m"
                    echo
                    sleep 10
                    if [[ -f ~/.couchpotato/couchpotato.pid ]] 
                    then
                        echo -e "Couchpotato is running at the PID:$(cat ~/.couchpotato/couchpotato.pid)"
                        echo
                    else
                        python ~/.couchpotato/CouchPotato.py --config_file="$HOME/.couchpotato/settings.conf"  --daemon
                        echo
                        echo -e "Couchpotato is running at the PID:$(cat ~/.couchpotato/couchpotato.pid)"
                        echo
                    fi
                else
                    echo 'Couchpotato is not installed to ~/.couchpotato'
                    echo
                fi
                ;;
            "3")
                # Check for the existence of the ~/.nginx/conf.d/000-default-server.d directory so as to echo a relevant statement.
                if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                then
                    echo "Installing the Apache and Nginx proxypass."
                    echo
                else
                    echo "Installing the Apache proxypass."
                    echo
                fi
                # KIll the couchpotato process via the PID file if it is present.
                if [[ -f ~/.couchpotato/couchpotato.pid ]]
                then
                    kill "$(cat ~/.couchpotato/couchpotato.pid)"
                    while [[ -f ~/.couchpotato/couchpotato.pid  ]]; do printf '\rI need to wait for Couchpotato to shut down. '; done
                    echo -e '\n'
                fi
                # proxypass starts - Install the Apache and ning proxypasses.
                mkdir -p ~/.apache2/conf.d
                echo -en 'Include /etc/apache2/mods-available/proxy.load\nInclude /etc/apache2/mods-available/proxy_http.load\nInclude /etc/apache2/mods-available/headers.load\n\nProxyRequests Off\nProxyPreserveHost On\nProxyVia On\n\nProxyPass /couchpotato http://10.0.0.1:'"$proxyport"'/${USER}/couchpotato\nProxyPassReverse /couchpotato http://10.0.0.1:'"$appport"'/${USER}/couchpotato' > ~/.apache2/conf.d/couchpototo.conf
                /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
                # The nginx specific section - depends on the existence of the required directories.
                if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                then
                    echo -en 'location ^~ /couchpotato {\nproxy_set_header X-Real-IP $remote_addr;\nproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\nproxy_set_header Host $http_x_host;\nproxy_set_header X-NginX-Proxy true;\n\nrewrite /(.*) /'$(whoami)'/$1 break;\nproxy_pass http://10.0.0.1:'"$proxyport"'/;\nproxy_redirect off;\n}' >  ~/.nginx/conf.d/000-default-server.d/couchpotato.conf
                    /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
                fi
                # proxypass ends
                #
                # Start couchpotato again
                python ~/.couchpotato/CouchPotato.py --config_file="$HOME/.couchpotato/settings.conf" --daemon
                echo "Visit this URL to use Couchpotato:"
                echo
                echo -e "\033[32m""${host2https}couchpotato/""\e[0m"
                echo
                sleep 10
                if [[ -f ~/.couchpotato/couchpotato.pid ]] 
                then
                    echo -e "Couchpotato is running at the PID:$(cat ~/.couchpotato/couchpotato.pid)"
                    echo
                else
                    python ~/.couchpotato/CouchPotato.py --config_file="$HOME/.couchpotato/settings.conf"  --daemon
                    echo
                    echo -e "Couchpotato is running at the PID:$(cat ~/.couchpotato/couchpotato.pid)"
                    echo
                fi
                ;;
            "4")
                echo "You chose to quit the script."
                echo
                exit
                ;;
        esac
    done
#
############################
##### User Script End  #####
############################
#
else
    echo -e "You chose to exit after updating the scripts."
    echo
    cd && bash
    exit
fi
#
############################
##### Core Script Ends #####
############################
#
