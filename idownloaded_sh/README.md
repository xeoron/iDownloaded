iDownloaded.sh (cmdline version):
=====
OS X keeps a record of every filename downloaded and source location (webpages not included). This list is kept outside of your web browser of choice. Deleting your browsing or download history does not purge the system database of this information. 

If you are worried about your privacy, then use this script manually or add it to a cron job so it will be purged regularly.

Usage: 
=====
Format

    idownloaded.sh <options>

Options:
=====
    -h --help           Help
    -v --version        Current program version and requirements
    -l --list           List the history of downloaded files
    -ls --list-sort     Display the downloaded file history in a numerically sorted list
    -f --file-count     displays the total sum value of the listed files
    -d --delete         Delete repository of downloaded files


Install:
=====
Automated command:

    sudo ./install_idownloaded.sh

Requirements:
=====
    Mac OSX.5 or higher
