#!/bin/bash -
#title          :fixhostperm.sh
#description    :Fixing currect folder owner and permissions
#author         :Kristijan Lukacin
#date           :20140302
#version        :1
#usage          :./fix_it.sh
#notes          :
#bash_version   :4.2.45(1)-release
#============================================================================$
START_TIME=$SECONDS
# CONFIG SECTION
FILE_PERM=664
FOLDER_PERM=775
WHERE_IS_HOME="home"
echo 'Start of fixing'
# END OF CONFIG --- Don't edit below this line ---
MYPWD=$(pwd)
echo 'Current path: ' $MYPWD
echo 'Checking if path in permitted location'
CHECK_PATH=`echo $MYPWD | cut -d'/' -f 2  `

#First we check if we are in home folder in first place
if [ "$WHERE_IS_HOME" == "$CHECK_PATH" ] 
        then
                #Check for home directory, to make this command more secure
                if [ "$MYPWD" == "/$WHERE_IS_HOME" ]
                        then
                                echo 'You must be in home subfolder!'
                                exit 0
                        else #If I'am in subfolder now I need to check if I have owner imput
                                if [ $# -eq 0 ]
                                        then
                                            echo 'You must provide owner for all folders and files in current folder'
                                            exit 0
                                fi
                fi
        else
                echo 'Not in HOME or HOME subfolder'
                exit 0
fi
echo 'Path looks OK'
echo -n 'Changing owner of all files and folder: '
chown $1:$1 .ht* .gi* .id* .e* .c* * -R
echo 'Done'
echo -n 'Changing folders permissions: '
find $MYPWD/ -type d -exec chmod 775 {} \;
echo 'Done'
echo -n 'Changing files permission: '
find $MYPWD/ -type f -exec chmod 664 {} \;
echo 'Done'
echo -n 'Fixing security in .htaccess files for ubuntu with new apache servers: '
sed -i -e s/FollowSymLinks/SymLinksIfOwnerMatch/g $(find $MYPWD -name *htaccess)
echo 'Done'
ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo 'All done in '$ELAPSED_TIME' Sec'
