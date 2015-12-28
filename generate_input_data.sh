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
	CURR_STATUS_FILE="${WEBSITEPATH}/emerson_${2}/data/curr_status.txt"
	TEMP_UNIT_FILE="${WEBSITEPATH}/emerson_${2}/data/temp/temp_unit.txt"
	HUM_UNIT_FILE="${WEBSITEPATH}/emerson_${2}/data/hum/hum_unit.txt"
	TEMP_SYS_FILE="${WEBSITEPATH}/emerson_${2}/data/temp/temp_sys.txt"
	HUM_SYS_FILE="${WEBSITEPATH}/emerson_${2}/data/hum/hum_sys.txt"
	EVENT_LOG_FILE="${WEBSITEPATH}/emerson_${2}/data/event_log.txt"
	local EC=0
	FLAG=0
	while [ "${ATTEMPTS}" -le "4" ]
	do
		EC=0
		FLAG=0
		wget http://192.168.254.${1}/index.html --timeout=2 --tries=1 -O ${CURR_STATUS_FILE} >> /dev/null 2>&1
		((EC += $?))
		wget http://192.168.254.${1}/tmp/1102.xml --timeout=2 --tries=1 -O ${TEMP_UNIT_FILE} >> /dev/null 2>&1
		((EC += $?))
		wget http://192.168.254.${1}/tmp/1103.xml --timeout=2 --tries=1 -O ${HUM_UNIT_FILE} >> /dev/null 2>&1
		((EC += $?))
		wget http://192.168.254.${1}/tmp/1104.xml --timeout=2 --tries=1 -O ${TEMP_SYS_FILE} >> /dev/null 2>&1
		((EC += $?))
		wget http://192.168.254.${1}/tmp/1105.xml --timeout=2 --tries=1 -O ${HUM_SYS_FILE} >> /dev/null 2>&1
		((EC += $?))
		wget http://192.168.254.${1}/tmp/statusreport.xml --timeout=2 --tries=1 -O ${EVENT_LOG_FILE} >> /dev/null 2>&1
		((EC += $?))
		if [ "${EC}" -eq "0" ] && [ -s "${CURR_STATUS_FILE}" ] && [ -s "${TEMP_UNIT_FILE}" ] && [ -s "${HUM_UNIT_FILE}" ] && [ -s "${TEMP_SYS_FILE}" ] && [ -s "${HUM_SYS_FILE}" ] && [ -s "${EVENT_LOG_FILE}" ]
		then
			FLAG=2
			LINE_COUNT=$(cat ${CURR_STATUS_FILE} ${TEMP_UNIT_FILE} ${HUM_UNIT_FILE} ${TEMP_SYS_FILE} ${HUM_SYS_FILE} | wc -l)
			if [ "${LINE_COUNT}" -eq "3935" ]
			then
				FLAG=1
				break
			else
				echo "[ $(date -R) ] Input data for Emerson unit #${2} were incompletely retrieved. Attempt: #${ATTEMPTS} [WARN]" >> ${GLB_LOGFILE}
			fi
		fi
		((ATTEMPTS += 1))
	done
	
	if [ "${FLAG}" -eq "0" ]
	then
		echo "[ $(date -R) ] Input data for Emerson unit #${2} were NOT successfully retrieved [FAIL]" >> ${GLB_LOGFILE}
		return 2
	elif [ "${FLAG}" -eq "1" ]
	then
		echo "[ $(date -R) ] Input data for Emerson unit #${2} were successfully retrieved" >> ${GLB_LOGFILE}
		return 0
	else
		echo "[ $(date -R) ] Input data for Emerson unit #${2} were retrieved but some files are corrupt [FAIL]" >> ${GLB_LOGFILE}
		return 3
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
	if [ "${EC}" -ne "0" ]
	then
		echo "[ $(date -R) ] Cannot connect to host with IP: 192.168.254.{1,2} and retrieve input data [FAIL]" >> ${GLB_LOGFILE}
		exit 1
	fi
	retrieve_data 1 4
	((EC += $?))
	retrieve_data 2 3
	((EC += $?))
	if [ "${EC}" -ne "0" ]
	then
		exit 2
	fi
	exit 0
}


# Calling main.
main
