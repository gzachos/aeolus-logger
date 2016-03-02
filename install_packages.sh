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


# Installs the packages needed for the Aeolus Logger software to run.
main () {
	WEBSITEPATH="/var/www/html"
        GLB_LOGFILE="/var/log/aeolus/aeolus.log"
        ERR_LOGFILE="/var/log/aeolus/error.log"
        STD_LOGFILE="/var/log/aeolus/stdout.log"
	EC=0

	# Needed
	apt-get install -y rrdtool 2>> ${ERR_LOGFILE} 1>> ${STD_LOGFILE}
	((EC += ${?}))
	# Suggested
	apt-get install -y ntp 2>> ${ERR_LOGFILE} 1>> ${STD_LOGFILE}
	# Optional
	apt-get install -y vim 2>> ${ERR_LOGFILE} 1>> ${STD_LOGFILE}

	if [ "${EC}" -ne "0" ]
	then
		echo "[ $(date -R) ] Package installation was NOT successful [FAIL]" >> ${GLB_LOGFILE}
		exit 1
	else
		echo "[ $(date -R) ] Package installation was successful" >> ${GLB_LOGFILE}
	fi
}


# Calling main.
main
