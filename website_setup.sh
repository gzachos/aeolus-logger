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
	./generate_website_structure.sh
	((EC += $?))
	./generate_website_photos.sh
	((EC += $?))
	./generate_css_file.sh
	((EC += $?))
	./generate_main_page.sh
	((EC += $?))
	./generate_rrdatabases.sh
	((EC += $?))
	./generate_graph_report_main_page.sh
	((EC += $?))
	./generate_graph_report_pages.sh
	((EC += $?))
#	./ntp_update.sh
#	((EC += $?))
	cp -f ./generate_input_data.sh ${WEBSITEPATH}/scripts
	((EC += $?))
	cp -f ./generate_measurement_report.sh ${WEBSITEPATH}/scripts
	((EC += $?))
	cp -f ./generate_rrd_graphs.sh ${WEBSITEPATH}/scripts
	((EC += $?))
	cp -f ./generate_rss_feed.sh ${WEBSITEPATH}/scripts
	((EC += $?))
	cp -f ./generate_status_report.sh ${WEBSITEPATH}/scripts
	((EC += $?))
	cp -f ./ntp_update.sh ${WEBSITEPATH}/scripts
	((EC += $?))
	cp -f ./update_data.sh ${WEBSITEPATH}/scripts
	((EC += $?))
	cp -f ./generate_css_file.sh ${WEBSITEPATH}/setup_scripts
	((EC += $?))
	cp -f ./generate_graph_report_main_page.sh ${WEBSITEPATH}/setup_scripts
	((EC += $?))
	cp -f ./generate_graph_report_pages.sh ${WEBSITEPATH}/setup_scripts
	((EC += $?))
	cp -f ./generate_main_page.sh ${WEBSITEPATH}/setup_scripts
	((EC += $?))
	cp -f ./generate_rrdatabases.sh ${WEBSITEPATH}/setup_scripts
	((EC += $?))
	cp -f ./generate_website_photos.sh ${WEBSITEPATH}/setup_scripts
	((EC += $?))
	cp -f ./generate_website_structure.sh ${WEBSITEPATH}/setup_scripts
	((EC += $?))
	chmod -R 755 ${WEBSITEPATH}
	((EC += $?))
}


# Configures logrotate for the /var/log/aeolus directory
conf_logrotate () {
	local EC=0
	echo -e "/var/log/aeolus/*.log\n{\n\trotate 30\n\tdaily\n\tmissingok\n\tnotifempty\n\tcreate\n\tcompress\n}" > /etc/logrotate.d/aeolus
	((EC += $?))
	logrotate /etc/logrotate.d/aeolus
	((EC += $?))
	if [ "${EC}" -eq "0" ]
	then
		echo "[ $(date -R) ] logrotate was successfully configured for /var/log/aeolus/ directory" >> ${GLB_LOGFILE}
	else
		echo "[ $(date -R) ] logrotate was NOT successfully configured for /var/log/aeolus/ directory [FAIL]" >> ${GLB_LOGFILE}
	fi
}


# Checks is ${WEBSITEPATH} holds a valid directory and if it does, calls the function used to setup the website.
# On the opposite case, feedback is given to user and script execution terminates with an exit code of '1'.
main () {
	WEBSITEPATH="/var/www/html"
        GLB_LOGFILE="/var/log/aeolus/aeolus.log"
        ERR_LOGFILE="/var/log/aeolus/error.log"
        STD_LOGFILE="/var/log/aeolus/stdout.log"
	EC=0
	mkdir /var/log/aeolus
	if [ ! -d "/var/log/aeolus" ]
	then
		echo "[ $(date -R) ] \"/var/log/aeolus\": Invalid directory! \"website_setup.sh\" will now exit! [FAIL]" >> ${GLB_LOGFILE}
		exit 1
	fi
	conf_logrotate
	if [ ! -d "${WEBSITEPATH}" ]
	then
		echo "[ $(date -R) ] \"${WEBSITEPATH}\": Invalid directory! \"website_setup.sh\" will now exit!	[FAIL]" >> ${GLB_LOGFILE}
		exit 2
	fi
	create_website 2>> ${ERR_LOGFILE} 1>> ${STD_LOGFILE}
	if [ "${EC}" -ne "0" ]
	then
		echo -e "\nWebsite setup has finished!\nScript exited with errors!\nCheck:\t1) ${GLB_LOGFILE} \n\t2) ${ERR_LOGFILE} and\n\t3) ${STD_LOGFILE} \nfor more information!\n\n"
		echo "[ $(date -R) ] Website setup has finished with errors [FAIL]" >> ${GLB_LOGFILE}
	else
		echo -e "\nWebsite setup has finished!\nCheck:\t${GLB_LOGFILE} \nfor more information!\n\n"
		echo "[ $(date -R) ] Website setup has finished successfully" >> ${GLB_LOGFILE}
	fi
}


# Calling main.
main
