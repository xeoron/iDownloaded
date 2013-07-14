#!/bin/bash
# File: idownloaded.sh | Mac-Download-List
# Author: Jason Campisi
# Date: 3/3/2013
# License: GPL 2 or higher
VERSION="0.3"


 function listCount {
   echo "$(sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent' | awk 'NF'| wc -l | sed 's/ //g')"
 }

option=$1  #argument

 if [ -z "$option" ]; then #if option is not set
    option="-h"
 fi

  case $option in
    -h|--help)
        echo "Usage: idownloaded.sh <option>"
        echo "   -l --list the files that have been downloaded"
        echo "   -ls --list-sort display's the downloaded file history in a numerically sorted list"
        echo "   -d --delete the download file list"
        echo "   -f --file-count displays the total sum value of the listed files"
        echo "   -v --version"
        echo "   -h --help"
        ;;
    -l|--list)
        echo "Downloaded file list:"
    	sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent' | awk 'NF'
        ;;
    -ls|--list-sort)
        echo "Numerically sorted downloaded file list:"
        sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent' | awk 'NF' | sort -g
        ;; 
    -f|--file-count)
        echo "Total number of files: $(listCount)" 
        ;; 
    -d|--delete)
        echo "Deleting system list of downloaded files..."
    	sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'
        ;;
    -v|--version)
        echo " iDownloaded.sh v$VERSION"
        echo " System requirements: Mac OSX.5 Leopard or higher"
    	;;
  esac
exit 0

