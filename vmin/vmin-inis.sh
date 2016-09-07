#!/bin/bash
# This interactive script will create the directories required for php5.6 and php7.0
# in the virtual host directories.  It is interactive so that you can choose to 
# create the directories only in your virtual hosts
#
# Thanks to Dan Zappone for this script!
# Original script is made by Dan Zappone from 23systems and can be found here:
# https://www.23systems.net/2016/01/installing-php-5-6-x-7-0-x-ubuntu-14-04-virtualmin-5-0gpl-using-ppa/
#
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

for DIR in /home/*/
do
    DIR=${DIR%*/}
    DIR=${DIR##*/}
    echo
    echo "Top level directory for this operation locate at /home/$DIR"
    echo
    if ask "Create /home/$DIR/etc/{php5.6}{php7}{php7.0}, copy default php.ini, and set correct permissions for those directories?" Y; then
        mkdir /home/$DIR/etc/php5.6
        mkdir /home/$DIR/etc/php7
        mkdir /home/$DIR/etc/php7.0
        cp /etc/php/5.6/cgi/php.ini /home/$DIR/etc/php5.6/
        cp /etc/php/7.0/cgi/php.ini /home/$DIR/etc/php7/
        cp /etc/php/7.0/cgi/php.ini /home/$DIR/etc/php7.0/
        chown -R $DIR.$DIR /home/$DIR/etc
        echo
        echo "PHP ini files set"
        echo
        for DIR2 in /home/$DIR/domains/*/
            do
                DIR2=${DIR2%*/}
                DIR2=${DIR2##*/}
                echo
                echo "Subdomains directories for this operation locates in /home/$DIR"
                if ask "Create /home/$DIR/domains/$DIR2/etc/{php5.6}{php7}{php7.0} copy default php.ini, and set correct permissions for those directories?" Y; then
                    mkdir /home/$DIR/domains/$DIR2/etc/php5.6
                    mkdir /home/$DIR/domains/$DIR2/etc/php7
                    mkdir /home/$DIR/domains/$DIR2/etc/php7.0
                    cp /etc/php/5.6/cgi/php.ini /home/$DIR/domains/$DIR2/etc/php5.6/
                    cp /etc/php/7.0/cgi/php.ini /home/$DIR/domains/$DIR2/etc/php7/
                    cp /etc/php/7.0/cgi/php.ini /home/$DIR/domains/$DIR2/etc/php7.0/
                    chown -R $DIR.$DIR /home/$DIR/domains/$DIR2/etc
                    echo
                    echo "PHP ini files set"
                    echo
                else
                    echo
                    echo "Skipped /home/$DIR/domains/$DIR2/etc/{php5.6}{php7}{php7.0}"
                    echo
                fi
            done
    else
        echo
        echo "Skipped /home/$DIR/etc/{php5.6}{php7}{php7.0}"
        echo  
    fi
    echo
    echo "Process complete... exiting"
    echo
done
