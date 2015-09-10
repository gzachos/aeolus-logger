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


# Creates the website (directory) structure, CSS file, main page, Round Robin DBs,
# graph report HTML pages and downloads the photos used in logger's website.
create_website () {
	./generate_website_structure.sh >> /dev/null 2>&1
	./generate_website_photos.sh >> /dev/null 2>&1
	./generate_css_file.sh >> /dev/null 2>&1
	./generate_main_page.sh >> /dev/null 2>&1
	./generate_rrdatabases.sh >> /dev/null 2>&1
	./generate_graph_report_main_page.sh >> /dev/null 2>&1
	./generate_graph_report_pages.sh >> /dev/null 2>&1
	./generate_rrd_graphs.sh ${WEBSITEPATH}/scripts >> /dev/null 2>&1
	./ntp_update.sh >> /dev/null 2>&1
	cp -f ./generate_input_data.sh ${WEBSITEPATH}/scripts
	cp -f ./generate_measurement_report.sh ${WEBSITEPATH}/scripts
	cp -f ./generate_rrd_graphs.sh ${WEBSITEPATH}/scripts
	cp -f ./generate_rss_feed.sh ${WEBSITEPATH}/scripts
	cp -f ./generate_status_report.sh ${WEBSITEPATH}/scripts
	cp -f ./ntp_update.sh ${WEBSITEPATH}/scripts
	cp -f ./update_data.sh ${WEBSITEPATH}/scripts
	cp -f ./generate_css_file.sh ${WEBSITEPATH}/setup_scripts
	cp -f ./generate_graph_report_main_page.sh ${WEBSITEPATH}/setup_scripts
	cp -f ./generate_graph_report_pages.sh ${WEBSITEPATH}/setup_scripts
	cp -f ./generate_main_page.sh ${WEBSITEPATH}/setup_scripts
	cp -f ./generate_rrdatabases.sh ${WEBSITEPATH}/setup_scripts
	cp -f ./generate_website_photos.sh ${WEBSITEPATH}/setup_scripts
	cp -f ./generate_website_structure.sh ${WEBSITEPATH}/setup_scripts
}


# Checks is ${WEBSITEPATH} holds a valid directory and if it does, calls the function used to setup the website.
# On the opposite case, feedback is given to user and script execution terminates with an exit code of '1'.
main () {
	WEBSITEPATH="/var/www/html"
	if [ ! -d "${WEBSITEPATH}" ]
	then
		echo -e "\"${WEBSITEPATH}\": Invalid directory!\n\nScript will now exit!\n"
		exit 1
	fi
	create_website
}


# Calling main.
main
