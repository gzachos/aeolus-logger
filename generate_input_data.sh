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


# Retrieves the required data files to be processed for an Emerson unit.
# If curr_status.txt is empty, the files are retrieved again,
# until file is not empty or 50 attempts have been made to download them.
# (Parameters: $1 -> IP address part, $2 -> Emerson unit No.) 
retrieve_data () {
	if [ "${ATTEMPTS}" -eq "50" ]
	then	
		return
	fi
	wget http://192.168.254.${1}/index.html -O ${WEBSITEPATH}/emerson_${2}/data/curr_status.txt
	wget http://192.168.254.${1}/tmp/1102.xml -O ${WEBSITEPATH}/emerson_${2}/data/temp/temp_unit.txt
	wget http://192.168.254.${1}/tmp/1103.xml -O ${WEBSITEPATH}/emerson_${2}/data/hum/hum_unit.txt
	wget http://192.168.254.${1}/tmp/1104.xml -O ${WEBSITEPATH}/emerson_${2}/data/temp/temp_sys.txt
	wget http://192.168.254.${1}/tmp/1105.xml -O ${WEBSITEPATH}/emerson_${2}/data/hum/hum_sys.txt
	wget http://192.168.254.${1}/tmp/statusreport.xml -O ${WEBSITEPATH}/emerson_${2}/data/event_log.txt
	MAIN_CONTENT=$(cat ${WEBSITEPATH}/emerson_${2}/data/curr_status.txt)
	if [ -z "${MAIN_CONTENT}" ]
	then
		ATTEMPTS=$((ATTEMPTS+1))
		retrieve_data ${1} ${2}
	fi
}


# Calls the function that retrieves the required data for an Emerson units.
# If retrieval fails, the script exits with an exit code of 1.
main () {
	WEBSITEPATH="/var/www/html"
	ping -c 3 192.168.254.1 >> /dev/null 2>&1
	X1="$?"
	ping -c 3 192.168.254.2 >> /dev/null 2>&1
	X2="$?"
	if [ "$((X1+X2))" -eq "0" ]
	then
		ATTEMPTS=0
		retrieve_data 1 4
		ATTEMPTS=0
		retrieve_data 2 3
	else
		echo -e "\nCannot connect to host with IP: 192.168.254.{1,2}!\n"
		exit 1
	fi
}


# Calling main.
main
