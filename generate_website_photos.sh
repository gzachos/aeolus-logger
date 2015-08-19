#!/bin/bash

#+-----------------------------------------------------------------------+
#|                 Copyright (C) 2015 George Z. Zachos                   |
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
	if [ "${ATTEMPTS}" -eq "50" ]
	then
		return
	fi
	wget https://raw.githubusercontent.com/support-uoi/emerson-logger/master/full_html_output_website/photos/cse-uoi.ico -O ${WEBSITEPATH}/photos/cse-uoi.ico
	E1=$?
	wget https://raw.githubusercontent.com/support-uoi/emerson-logger/master/full_html_output_website/photos/cse_banner_logo.jpg -O ${WEBSITEPATH}/photos/cse_banner_logo.jpg
	E2=$?
	wget https://raw.githubusercontent.com/support-uoi/emerson-logger/master/full_html_output_website/photos/uoi-cse.png -O ${WEBSITEPATH}/photos/uoi-cse.png
	E3=$?
	EC=$((E1 + E2 + E3))
	if [ "${EC}" -ne "0" ]
	then
		ATTEMPTS=$((ATTEMPTS + 1))
		retrieve_photos
	fi
}


# Calls the function that retrieves the photos used in logger's website.
main () {
	WEBSITEPATH="/var/www/html"
	ATTEMPTS=0
	retrieve_photos
}


# Calling main.
main
