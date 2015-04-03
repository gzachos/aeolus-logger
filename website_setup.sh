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


create_website () {
	./generate_website_structure.sh >> /dev/null 2>&1
	./generate_website_photos.sh >> /dev/null 2>&1
	./generate_css_file.sh >> /dev/null 2>&1
	./generate_main_page.sh >> /dev/null 2>&1
	./generate_rrdatabases.sh >> /dev/null 2>&1
	cp -rf ./generate_status_report.sh ${WEBSITEPATH}/scripts
	cp -rf ./generate_rrd_graphs.sh ${WEBSITEPATH}/scripts
	cp -rf ./generate_measurement_report.sh ${WEBSITEPATH}/scripts
	cp -rf ./generate_input_data.sh ${WEBSITEPATH}/scripts
	cp -rf ./update_data.sh ${WEBSITEPATH}/scripts
	cp -rf ./generate_css_file.sh ${WEBSITEPATH}/setup_scripts
	cp -rf ./generate_main_page.sh ${WEBSITEPATH}/setup_scripts
	cp -rf ./generate_rrdatabases.sh ${WEBSITEPATH}/setup_scripts
	cp -rf ./generate_website_photos.sh ${WEBSITEPATH}/setup_scripts
	cp -rf ./generate_website_structure.sh ${WEBSITEPATH}/setup_scripts
}


main () {
	WEBSITEPATH="/var/www/html/"
        create_website
}


main
