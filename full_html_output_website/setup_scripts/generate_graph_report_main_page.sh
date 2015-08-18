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


# The output .html file of this script for an Emerson unit, e.g. #3, will be saved as 'graph_report_3.html'

# Appends the <head> section to the output .html file
# (Parameter: Emerson unit No.)
append_head () {

        echo -e "<!DOCTYPE html>\n<html>\n\t<!-- HEAD SECTION (includes the two lines above) -->\n\t<head>\n\t\t<title>Emerson Logger</title>\n\t\t<meta charset=\"utf-8\">\n\t\t<link rel=\"icon\" href=\"../photos/cse-uoi.ico\" type=\"image/x-icon\"/>\n\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/emerson_logger.css\">\n\t</head>\n" > ${WEBSITEPATH}/emerson_${1}/graph_report_${1}.html
}


# Appends the <body> section to the output .html file
# (Parameter: Emerson unit No.)
append_body () {

	if [ ${1} -eq 3 ]
	then
		OTHER_EMERSON=4
	else
		OTHER_EMERSON=3
	fi
	echo -e "\t<!-- BODY SECTION (includes \"</html>\" line) -->\n\t<body>\n\t\t<img height=90 alt=\"uoi-cse.png\" src=\"../photos/uoi-cse.png\">\n\t\t<img class=\"banner\" height=90 alt=\"cse_banner_logo.jpg\" src=\"../photos/cse_banner_logo.jpg\">\n\t\t<br><br>\n\t\t<h4><a href=\"../emerson_main_page.html\">Main Page</a> &nbsp;|&nbsp; <a href=\"../emerson_3/status_report_3.html\">Emerson Unit #3</a> &nbsp;|&nbsp;  <a href=\"../emerson_4/status_report_4.html\">Emerson Unit #4</a> &nbsp;|&nbsp; <a href=\"../emerson_${OTHER_EMERSON}/graph_report_${OTHER_EMERSON}.html\">Emerson Unit #${OTHER_EMERSON} Graph Report</a></h4><br>\n\t\t<h2><u>Emerson #${1} Graph Report</u></h2>\n\t\t<br>\n\t\t<strong>\n\t\t<h3><i>Measurements taken in <u>1 minute</u> intervals</i></h3>\n\t\t<a href=\"./rrdb/graph_reports/curr_temperature_graph_report_${1}.html\" target=\"_blank\">1. Current Temperature Report</a><br><br>\n\t\t<a href=\"./rrdb/graph_reports/curr_humidity_graph_report_${1}.html\" target=\"_blank\">2. Current Humidity Report</a><br><br>\n\t\t<!-- <h3><i>Measurements taken in <u>6 minute</u> intervals</i></h3>\n\t\t<a href=\"./rrdb/graph_reports/unit_temperature_graph_report_${1}.html\" target=\"_blank\">1. Unit Temperature Report</a><br><br>\n\t\t<a href=\"./rrdb/graph_reports/sys_temperature_graph_report_${1}.html\" target=\"_blank\">2. System Temperature Report</a><br><br>\n\t\t<a href=\"./rrdb/graph_reports/unit_humidity_graph_report_${1}.html\" target=\"_blank\">3. Unit Humidity Report</a><br><br>\n\t\t<a href=\"./rrdb/graph_reports/graph_report/sys_humidity_graph_report_${1}.html\" target=\"_blank\">4. System Humidity Report</a> --><br><br>\n\t\t</strong>\n\t\t<br>\n\t\t<br>\n\t\t<h4><i>A project by ~gzachos</i></h4>\n\t\t<h4>&copy; Systems Support Group 2015. All rights reserved.</h4>\n\t\t<h4>Computer Science and Engineering Department - University of Ioannina</h4>\n\t</body>\n</html>" >> ${WEBSITEPATH}/emerson_${1}/graph_report_${1}.html
}


# Calls all functions that append data to the output .html file
# (Parameter: Emerson unit No.)
create_graph_report_main_page () {
	append_head ${1}
	append_body ${1}
}


# Creates the graph report main .html file
main () {
	WEBSITEPATH="/var/www/html"
	create_graph_report_main_page 3
	create_graph_report_main_page 4
}


# Calling main
main