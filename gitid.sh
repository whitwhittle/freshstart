#!/bin/bash
#
if [ $# -eq 0 ]
then
	echo "No arguments supplied"
	echo "Usage: gitid.sh <user email address>"
	exit 1
fi

echo " git will be configured for email:" $1
echo " git user will be configured for:" $USER

function confirm() {
	while true; do
        read -p "Do you want to proceed? (YES/NO/CANCEL) " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            [Cc]* ) exit;;
            * ) echo "Please answer YES, NO, or CANCEL.";;
        esac
    done
}

if confirm; then
	echo "setting git user email.."
	git config --global user.email $1
	echo "setting git user.."
	git config --global user.name $USER
else
	exit
fi



