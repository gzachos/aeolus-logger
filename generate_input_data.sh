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
# Name: George Zachos
# Email: gzzachos_at_gmail.com


retrieve_data () {
	if [ ${ATTEMPTS} -eq 19 ]
	then	
		return
	fi
	wget http://192.168.254.${1}/index.html -O ${WEBSITEPATH}/emerson_${2}/data/main.txt
	wget http://192.168.254.${1}/tmp/1102.xml -O ${WEBSITEPATH}/emerson_${2}/data/temp/temp_unit.txt
	wget http://192.168.254.${1}/tmp/1103.xml -O ${WEBSITEPATH}/emerson_${2}/data/hum/hum_unit.txt
	wget http://192.168.254.${1}/tmp/1104.xml -O ${WEBSITEPATH}/emerson_${2}/data/temp/temp_sys.txt
	wget http://192.168.254.${1}/tmp/1105.xml -O ${WEBSITEPATH}/emerson_${2}/data/hum/hum_sys.txt
	wget http://192.168.254.${1}/tmp/statusreport.xml -O ${WEBSITEPATH}/emerson_${2}/data/event_log.txt
	MAIN_CONTENT=$(cat ${WEBSITEPATH}/emerson_${2}/data/main.txt)
	if [ -z "${MAIN_CONTENT}" ]
	then
		ATTEMPTS=$((ATTEMPTS+1))
		retrieve_data ${1} ${2}
	fi
}


main () {
	WEBSITEPATH="/var/www/html"
	ATTEMPTS=0
	retrieve_data 1 4
	retrieve_data 2 3
}


main
