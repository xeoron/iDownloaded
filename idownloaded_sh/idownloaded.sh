#!/bin/bash
# File: idownloaded.sh | Mac-Download-List
# Author: Jason Campisi
# Date: 3/3/2013
# License: GPL 2 or higher
# Version: 0.1

for arg in "$@"
do
	case $arg in
    -h|--help)
        echo "Usage: idownloaded.sh <options>"
        echo "-l --list the files that have been downloaded"
	echo "-lr --list-sort lists the files that have been downloaded in a general-numeric sorted order"
        echo "-d --delete the download file list"
        echo "-v --version"
        echo "-h --help"
        exit 0
        ;;
    -l|--list)
        echo "Downloaded file list:"
    	sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent'
        ;;
    -lr|--list-sort)
	echo "Downloaded sorted file list:"
        sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent' | sort -g
        ;; 
    -d|--delete)
        echo "Deleting system list of downloaded files..."
    	sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'
        ;;
    -v|--version)
        echo "iDownloaded.sh\nVersion: 0.1"
        echo "System requirements: Mac OSX.5 Leopard or higher"
    	;;
    esac
done
exit 0

