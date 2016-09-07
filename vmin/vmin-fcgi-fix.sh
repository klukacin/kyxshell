#!/bin/bash
# This interactive script will create the directories required for php5.6 and php7.0
# in the virtual host directories.  It is interactive so that you can choose to 
# create the directories only in your virtual hosts
#
# Thanks to Dan Zappone for this script!
# Original script is made by Dan Zappone from 23systems and can be found here:
# https://www.23systems.net/2016/01/installing-php-5-6-x-7-0-x-ubuntu-14-04-virtualmin-5-0gpl-using-ppa/
#

function ask() {
    # http://djm.me/ask - see this link for information about the ask function
    while true; do

        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        read -p "$1 [$prompt] " REPLY </dev/tty

        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi

        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac
    done
}

echo "PLEASE READ"
echo "-----------------------------------------------------------------------------------------"
echo "Virtualmin detects and sets up /home/<vhostdiruser>/fcgi-bin/* however it seems that that"
echo "the configured version is either setup wrong by the php installer or detected wrong by"
echo "Virtualmin.  This script will move the phpX.X files Virtualmin points to to phpX.X.old"
echo "and create cymbolic links for phpX.X to php-cgiX.X instead which seems to work correctly."
echo "-----------------------------------------------------------------------------------------"
echo
if ask "Do you wish to continue?" Y; then
    cd /usr/bin
    mv php5.6 php5.6.old
    mv php7.0 php7.0.old
    ln -s php-cgi5.6 php5.6
    ln -s php-cgi7.0 php7.0
    echo
    echo "Process complete... exiting"
    echo
else
    echo
    echo "Nothing done... exiting"
    echo
fi
