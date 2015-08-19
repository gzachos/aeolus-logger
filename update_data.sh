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


# Updates status and measurement report pages for an Emerson unit.
updt_data () {
	${WEBSITEPATH}/scripts/generate_status_report.sh ${1} >> /dev/null 2>&1
	${WEBSITEPATH}/scripts/generate_measurement_report.sh ${1} >> /dev/null 2>&1
}


# Retrieves input data, updates status and measurement report pages and generates graphs. 
main () {
	WEBSITEPATH="/var/www/html"
	${WEBSITEPATH}/scripts/generate_input_data.sh >> /dev/null 2>&1
	updt_data 3
	updt_data 4
	${WEBSITEPATH}/scripts/generate_rrd_graphs.sh >> /dev/null 2>&1	
}


# Calling main.
main
