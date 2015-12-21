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


# Creates the directory structure of an Emerson unit.
# (Parameter: $1 -> Emerson unit No.)
create_emerson_dir_structure () {
	mkdir -p emerson_${1}/data/temp
	((EC += $?))
	mkdir -p emerson_${1}/data/hum
	((EC += $?))
	mkdir -p emerson_${1}/rrdb/graph_reports
	((EC += $?))
	mkdir -p emerson_${1}/rrdb/graphs/temp/curr
	((EC += $?))
	mkdir -p emerson_${1}/rrdb/graphs/temp/curr_dual
	((EC += $?))
	mkdir -p emerson_${1}/rrdb/graphs/hum/curr
	((EC += $?))
	mkdir -p emerson_${1}/rrdb/graphs/hum/curr_dual
	((EC += $?))
#	mkdir -p emerson_${1}/rrdb/graphs/temp/unit
#	((EC += $?))
#	mkdir -p emerson_${1}/rrdb/graphs/temp/unit_dual
#	((EC += $?))
#	mkdir -p emerson_${1}/rrdb/graphs/temp/sys
#	((EC += $?))
#	mkdir -p emerson_${1}/rrdb/graphs/temp/sys_dual
#	((EC += $?))
#	mkdir -p emerson_${1}/rrdb/graphs/hum/unit
#	((EC += $?))
#	mkdir -p emerson_${1}/rrdb/graphs/hum/unit_dual
#	((EC += $?))
#	mkdir -p emerson_${1}/rrdb/graphs/hum/sys
#	((EC += $?))
#	mkdir -p emerson_${1}/rrdb/graphs/hum/sys_dual
#	((EC += $?))
}


# Creates the main directories of the website and calls the function that 
# creates the directory structure for each Emerson unit.
create_website_structure () {
	cd ${WEBSITEPATH}
        mkdir css photos emerson_3 emerson_4 scripts setup_scripts feed
	((EC += $?))
	create_emerson_dir_structure 3
	create_emerson_dir_structure 4
}


# Calls the function that creates the whole website (directory) structure.
main () {
	WEBSITEPATH="/var/www/html"
        GLB_LOGFILE="/var/log/aeolus/aeolus.log"
        ERR_LOGFILE="/var/log/aeolus/error.log"         # not used
        STD_LOGFILE="/var/log/aeolus/stdout.log"        # not used
        EC=0
        create_website_structure
        if [ "${EC}" -eq "0" ]
        then
                echo "[ $(date -R) ] Website directory structure successfully created" >> ${GLB_LOGFILE}
        else
                echo "[ $(date -R) ] Website directory structure was NOT successfully created [FAIL]" >> ${GLB_LOGFILE}
        fi
}


# Calling main.
main
