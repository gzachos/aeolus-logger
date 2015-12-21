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
	ATTEMPTS=0
	while [ "${ATTEMPTS}" -le "4" ]
	do
		EC=0
		wget http://192.168.254.${1}/index.html --timeout=2 --tries=1 -O ${WEBSITEPATH}/emerson_${2}/data/curr_status.txt >> /dev/null 2>&1
		((EC += $?))
		wget http://192.168.254.${1}/tmp/1102.xml --timeout=2 --tries=1 -O ${WEBSITEPATH}/emerson_${2}/data/temp/temp_unit.txt >> /dev/null 2>&1
		((EC += $?))
		wget http://192.168.254.${1}/tmp/1103.xml --timeout=2 --tries=1 -O ${WEBSITEPATH}/emerson_${2}/data/hum/hum_unit.txt >> /dev/null 2>&1
		((EC += $?))
		wget http://192.168.254.${1}/tmp/1104.xml --timeout=2 --tries=1 -O ${WEBSITEPATH}/emerson_${2}/data/temp/temp_sys.txt >> /dev/null 2>&1
		((EC += $?))
		wget http://192.168.254.${1}/tmp/1105.xml --timeout=2 --tries=1 -O ${WEBSITEPATH}/emerson_${2}/data/hum/hum_sys.txt >> /dev/null 2>&1
		((EC += $?))
		wget http://192.168.254.${1}/tmp/statusreport.xml --timeout=2 --tries=1 -O ${WEBSITEPATH}/emerson_${2}/data/event_log.txt >> /dev/null 2>&1
		((EC += $?))
		MAIN_CONTENT=$(cat ${WEBSITEPATH}/emerson_${2}/data/curr_status.txt)
		if [ "${EC}" -eq "0" ] || [ -n "${MAIN_CONTENT}" ]
		then
			break
		fi
		((ATTEMPTS += 1))
	done
	
	if [ "${EC}" -ne "0" ]
	then
		echo "[ $(date -R) ] Input data for Emerson unit #${2} were NOT successfully retrieved [FAIL]" >> ${GLB_LOGFILE}
		return 2
	fi

	if [ -z "${MAIN_CONTENT}" ]
	then
		echo "[ $(date -R) ] Input data for Emerson unit #${2} were successfully retrieved but one or more files are empty [FAIL]" >> ${GLB_LOGFILE}
		return 3
	else
		echo "[ $(date -R) ] Input data for Emerson unit #${2} were successfully retrieved" >> ${GLB_LOGFILE}
		return 0
	fi
}


# Calls the function that retrieves the required data for an Emerson units.
# If retrieval fails, the script exits with an exit code of 1.
main () {
	WEBSITEPATH="/var/www/html"
        GLB_LOGFILE="/var/log/aeolus/aeolus.log"
        ERR_LOGFILE="/var/log/aeolus/error.log"         # not used
        STD_LOGFILE="/var/log/aeolus/stdout.log"        # not used
	EC=0
	ping -c 3 192.168.254.1 >> /dev/null 2>&1
	((EC += $?))
	ping -c 3 192.168.254.2 >> /dev/null 2>&1
	((EC += $?))
	if [ "${EC}" -eq "0" ]
	then
		retrieve_data 1 4
		retrieve_data 2 3
	else
		echo "[ $(date -R) ] Cannot connect to host with IP: 192.168.254.{1,2} and retrieve input data [FAIL]" >> ${GLB_LOGFILE}
		exit 1
	fi
}


# Calling main.
main
