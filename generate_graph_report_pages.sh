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
# (Parameters: 	$1 -> Emerson unit No.,
#		$2 -> {curr, unit, sys},
#		$3 -> {temp, hum},
#		$4 -> {Current, System, Humidity},
#		$5 -> {Temperature, Humidity},
#		$6 -> {temperature, humidity})
append_head () {
        echo -e "<!DOCTYPE html>\n<html>\n\t<!-- HEAD SECTION (includes the two lines above) -->\n\t<head>\n\t\t<title>Emerson #${1} ${5} Graph</title>\n\t\t<meta charset=\"UTF-8\">\n\t\t<link rel=\"icon\" href=\"../../../photos/cse-uoi.ico\" type=\"image/x-icon\"/>\n\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"../../../css/emerson_logger.css\">\n\t</head>\n" > ${TMP_FILE}
}


# Appends the <body> section to the output .html file
# (Parameters: 	$1 -> Emerson unit No.,
#		$2 -> {curr, unit, sys},
#		$3 -> {temp, hum},
#		$4 -> {Current, System, Humidity},
#		$5 -> {Temperature, Humidity},
#		$6 -> {temperature, humidity})
append_body () {
	if [ "${1}" -eq "3" ]
	then
		OTHER_EMERSON=4
	else
		OTHER_EMERSON=3
	fi
	echo -e "\t<!-- BODY SECTION (includes \"</html>\" line) -->\n\t<body>\n\t\t<img alt=\"aeolus-banner.png\" src=\"../../../photos/aeolus-banner.png\">\n\t\t<br><br>\n\t\t<h4><a href=\"../../../main_page.html\">Main Page</a> &nbsp;|&nbsp; <a href=\"../../../emerson_3/status_report.html\">Emerson Unit #3</a> &nbsp;|&nbsp;  <a href=\"../../../emerson_4/status_report.html\">Emerson Unit #4</a> &nbsp;|&nbsp; <a href=\"../../../emerson_${OTHER_EMERSON}/graph_report.html\">Emerson Unit #${OTHER_EMERSON} Graph Report</a></h4><br>\n\t\t<h2><u>Emerson #${1} ${4} ${5} Graphs</u></h2>\n\t\t<br>\n\t\t<img alt=\"\" src=\"../graphs/${3}/${2}/${3}_1hour.png\">\n\t\t<img alt=\"\" src=\"../graphs/${3}/${2}/${3}_12hour.png\">\n\t\t<img alt=\"\" src=\"../graphs/${3}/${2}/${3}_1day.png\">\n\t\t<img alt=\"\" src=\"../graphs/${3}/${2}/${3}_1week.png\">\n\t\t<img alt=\"\" src=\"../graphs/${3}/${2}/${3}_4week.png\">\n\t\t<img alt=\"\" src=\"../graphs/${3}/${2}/${3}_24week.png\">\n\t\t<img alt=\"\" src=\"../graphs/${3}/${2}/${3}_1year.png\">\n\t\t\n\t\t<br><br><br><br><br>\n\t\t<h4><i>A project by ~gzachos</i></h4>\n\t\t<h4>&copy; George Z. Zachos 2015-2016. All rights reserved.</h4>\n\t\t<h4>Department of Computer Science &amp; Engineering, University of Ioannina</h4>\n\t</body>\n</html>" >> ${TMP_FILE}
}


# Appends the <head> and <body> sections of a page to the corresponding file.
# (Parameters: 	$1 -> Emerson unit No.,
#		$2 -> {curr, unit, sys},
#		$3 -> {temp, hum},
#		$4 -> {Current, System, Humidity},
#		$5 -> {Temperature, Humidity},
#		$6 -> {temperature, humidity})
create_page () {
        TMP_FILE=$(mktemp /tmp/aeolus.XXXXXX)
        DST_FILE=${WEBSITEPATH}/emerson_${1}/rrdb/graph_reports/${2}_${6}_graph_report.html
        EC=0
	append_head ${1} ${2} ${3} ${4} ${5} ${6}
        ((EC += $?))
	append_body ${1} ${2} ${3} ${4} ${5} ${6}
        ((EC += $?))
        if [ "${EC}" -eq "0" ]
        then
                cp -f ${TMP_FILE} ${DST_FILE}
                if [ "$?" -eq "0" ] && [ -e "${DST_FILE}" ] && [ -s "${DST_FILE}" ]
                then
                        echo "[ $(date -R) ] Graph report page \"${2}_${6}_graph_report.html\" of Emerson unit #${1} was successfully created" >> ${GLB_LOGFILE}
                else
                        echo "[ $(date -R) ] Graph report page \"${2}_${6}_graph_report.html\" of Emerson unit #${1} was NOT successfully created [FAIL]" >> ${GLB_LOGFILE}
                fi
        fi
        rm ${TMP_FILE}
}


# Creates the pages for graph reports of each Emerson unit.
# (Parameter: $1 -> Emerson unit No.)
create_graph_report_pages () {
	create_page ${1} curr temp Current Temperature temperature
	create_page ${1} curr hum Current Humidity humidity
#	create_page ${1} unit temp Unit Temperature temperature
#	create_page ${1} sys temp System Temperature temperature
#	create_page ${1} unit hum Unit Humidity humidity
#	create_page ${1} sys hum System Humidity humidity
}


# Calls the function that creates graph report pages for an Emerson unit.
main () {
	WEBSITEPATH="/var/www/html"
        GLB_LOGFILE="/var/log/aeolus/aeolus.log"
        ERR_LOGFILE="/var/log/aeolus/error.log"         # not used
        STD_LOGFILE="/var/log/aeolus/stdout.log"        # not used
	create_graph_report_pages 3
	create_graph_report_pages 4
}


# Calling main.
main
