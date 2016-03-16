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


# Appends the <head> section to the output .html file
# (Parameter: $1 -> Emerson unit No.)
append_head () {
        echo -e "<!DOCTYPE html>\n<html class=\"graph\">\n\t<!-- HEAD SECTION (includes the two lines above) -->\n\t<head>\n\t\t<title>Emerson #${1} Graph Report</title>\n\t\t<meta charset=\"UTF-8\">\n\t\t<link rel=\"icon\" href=\"../photos/cse-uoi.ico\" type=\"image/x-icon\"/>\n\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/emerson_logger.css\">\n\t</head>\n" > ${TMP_FILE}
}


# Appends the <body> section to the output .html file
# (Parameter: $1 -> Emerson unit No.)
append_body () {
	if [ "${1}" -eq "3" ]
	then
		OTHER_EMERSON=4
	else
		OTHER_EMERSON=3
	fi
	echo -e "\t<!-- BODY SECTION (includes \"</html>\" line) -->\n\t<body>\n\t\t<img alt=\"aeolus-banner.png\" src=\"../photos/aeolus-banner.png\">\n\t\t<br><br>\n\t\t<h4><a href=\"../main_page.html\">Main Page</a> &nbsp;|&nbsp; <a href=\"../emerson_3/status_report.html\">Emerson Unit #3</a> &nbsp;|&nbsp;  <a href=\"../emerson_4/status_report.html\">Emerson Unit #4</a> &nbsp;|&nbsp; <a href=\"../emerson_${OTHER_EMERSON}/graph_report.html\">Emerson Unit #${OTHER_EMERSON} Graph Report</a></h4><br>\n\t\t<h2><u>Emerson #${1} Graph Report</u></h2>\n\t\t<br>\n\t\t<h3><strong><i>Measurements taken in <u>1 minute</u> intervals</i></strong></h3>\n\t\t<strong>\n\t\t\t<a href=\"./rrdb/graph_reports/curr_temperature_graph_report.html\" target=\"_blank\">1. Return Air Temperature Report</a><br><br>\n\t\t\t<a href=\"./rrdb/graph_reports/curr_humidity_graph_report.html\" target=\"_blank\">2. Return Air Humidity Report</a><br><br>\n\t\t\t<a href=\"./rrdb/graph_reports/curr_dual_temperature_graph_report.html\" target=\"_blank\">3. Comparative Return Air Temperature Report</a><br><br>\n\t\t</strong>\n\t\t<!-- <h3><strong><i>Measurements taken in <u>6 minute</u> intervals</i></strong></h3>\n\t\t<strong>\n\t\t\t<a href=\"./rrdb/graph_reports/unit_temperature_graph_report.html\" target=\"_blank\">1. Unit Temperature Report</a><br><br>\n\t\t\t<a href=\"./rrdb/graph_reports/sys_temperature_graph_report.html\" target=\"_blank\">2. System Temperature Report</a><br><br>\n\t\t\t<a href=\"./rrdb/graph_reports/unit_humidity_graph_report.html\" target=\"_blank\">3. Unit Humidity Report</a><br><br>\n\t\t\t<a href=\"./rrdb/graph_reports/graph_report/sys_humidity_graph_report.html\" target=\"_blank\">4. System Humidity Report</a>\n\t\t</strong> -->\n\t\t<br><br><br><br><br>\n\t\t<h4><i>A project by ~gzachos</i></h4>\n\t\t<h4>&copy; George Z. Zachos 2015-2016. All rights reserved.</h4>\n\t\t<h4>Department of Computer Science &amp; Engineering, University of Ioannina</h4>\n\t</body>\n</html>" >> ${TMP_FILE}
}


# Calls all functions that append data to the output .html file.
# (Parameter: $1 -> Emerson unit No.)
create_graph_report_main_page () {
        TMP_FILE=$(mktemp /tmp/aeolus.XXXXXX)
        DST_FILE=${WEBSITEPATH}/emerson_${1}/graph_report.html
        EC=0
	append_head ${1}
	((EC += $?))
	append_body ${1}
	((EC += $?))
        if [ "${EC}" -eq "0" ]
        then
                cp -f ${TMP_FILE} ${DST_FILE}
                if [ "$?" -eq "0" ] && [ -e "${DST_FILE}" ] && [ -s "${DST_FILE}" ]
                then
                        echo "[ $(date -R) ] Graph report main page of Emerson unit #${1} was successfully created" >> ${GLB_LOGFILE}
                else
                        echo "[ $(date -R) ] Graph report main page of Emerson unit #${1} was NOT successfully created [FAIL]" >> ${GLB_LOGFILE}
                fi
        fi
	rm ${TMP_FILE}
}


# Calls the function that creates the graph report main .html file.
main () {
	WEBSITEPATH="/var/www/html"
        GLB_LOGFILE="/var/log/aeolus/aeolus.log"
        ERR_LOGFILE="/var/log/aeolus/error.log"         # not used
        STD_LOGFILE="/var/log/aeolus/stdout.log"        # not used
	create_graph_report_main_page 3
	create_graph_report_main_page 4
}


# Calling main.
main
