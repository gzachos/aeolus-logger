#!/bin/bash

#+-----------------------------------------------------------------------+
#|              Copyright (C) 2015-2016 George Z. Zachos                 |
#+-----------------------------------------------------------------------+
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
# Contact Information:
# Name: George Z. Zachos
# Email: gzzachos <at> gmail.com


# Downloads and saves each website photo inside photos/ directory.
# If the exit code of all three 'wget' commands differs from '0' (zero),
# they are executed again, until photos are downloaded successfully,
# or 50 attemps to download them have taken place. 
retrieve_photos () {
	while [ "${ATTEMPTS}" -le "20" ]
	do
	        EC=0
		wget https://raw.githubusercontent.com/gzachos/aeolus-logger/master/images/website_photos/cse-uoi.ico --timeout=5 --trie=5 -O ${WEBSITEPATH}/photos/cse-uoi.ico
		((EC += $?))
		wget https://raw.githubusercontent.com/gzachos/aeolus-logger/master/images/website_photos/cse_banner_logo.jpg --timeout=5 --tries=5 -O ${WEBSITEPATH}/photos/cse_banner_logo.jpg
		((EC += $?))
		wget https://raw.githubusercontent.com/gzachos/aeolus-logger/master/images/website_photos/uoi-cse.png --timeout=5 --tries=5 -O ${WEBSITEPATH}/photos/uoi-cse.png
		((EC += $?))
		if [ "${EC}" -eq "0" ]
		then
			break
		fi
		((ATTEMPTS += 1))
	done
}


# Calls the function that retrieves the photos used in logger's website.
main () {
	WEBSITEPATH="/var/www/html"
	GLB_LOGFILE="/var/log/aeolus/aeolus.log"
        ERR_LOGFILE="/var/log/aeolus/error.log"         # not used
        STD_LOGFILE="/var/log/aeolus/stdout.log"        # not used
	EC=0
	ATTEMPTS=0
	retrieve_photos
        if [ "${EC}" -eq "0" ]
        then
                echo "[ $(date -R) ] Website photos were successfully fetched" >> ${GLB_LOGFILE}
        else
                echo "[ $(date -R) ] Website photos were NOT successfully fetched [FAIL]" >> ${GLB_LOGFILE}
        fi
}


# Calling main.
main
