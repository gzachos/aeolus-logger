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
append_head () {
	echo -e "<!DOCTYPE html>\n<html>\n\t<!-- HEAD SECTION (includes the two lines above) -->\n\t<head>\n\t\t<title>Aeolus Logger v2</title>\n\t\t<meta charset=\"utf-8\">\n\t\t<link rel=\"icon\" href=\"./photos/cse-uoi.ico\" type=\"image/x-icon\"/>\n\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"./css/emerson_logger.css\">\n\t</head>\n" > ${TMP_FILE}
	((EC += $?))
}


# Appends the the <body> section to the output .html file
append_body () {
	echo -e "\t<!-- BODY SECTION (includes \"</html>\" line) -->\n\t<body>\n\t\t<img height=90 alt=\"uoi-cse.png\" src=\"./photos/uoi-cse.png\">\n\t\t<img class=\"banner\" height=90 alt=\"cse_banner_logo.jpg\" src=\"./photos/cse_banner_logo.jpg\">\n\t\t<br><br>\n\t\t<h4><a href=\"./emerson_3/status_report.html\">Emerson Unit #3</a> &nbsp;|&nbsp;  <a href=\"./emerson_4/status_report.html\">Emerson Unit #4</a> &nbsp;|&nbsp; <a href=\"http://support.cse.uoi.gr/\" target=\"_blank\">Systems Support Group</a><br><br>\n\t\t<a href=\"./emerson_3/graph_report.html\">Emerson #3 Graph Report</a> &nbsp;|&nbsp; <a href=\"./emerson_4/graph_report.html\">Emerson #4 Graph Report</a></h4><br>\n\t\t<h2><u>Aeolus Logger Main Page</u></h2>" >> ${TMP_FILE}
	((EC += $?))

	echo -e "\t\t<h3><u>About</u></h3>\n\t\t<p>\n\t\t\tThe <strong>\"Aeolus Logger\"</strong> project is about the implementation of a logging system and it's integration with Emerson cooling units, so that it can be used to monitor the environmental conditions of the cluster room inside the building of the <a href=\"http://cs.uoi.gr/\" target=\"_blank\">Computer Science and Engineering Department</a>, <a href=\"http://uoi.gr/\" target=\"_blank\">University of Ioannina</a>. The <strong>temperature</strong> and <strong>humidity</strong> values are supplied by the two Emerson cooling units inside the cluster room. Moreover, the server monitors the <strong>status</strong> of those two units and <strong>alarms</strong> the faculty if any <strong>abnormal</strong> conditions are observed.\n\t\t</p>\n\t\t<br>\n\t\t<h3><u>Emerson Units</u></h3>\n\t\t<div id=\"emersons\">\n\t\t\tVisit one of the links below to see a detailed report of an Emerson unit.<br>\n\t\t\t<h4><a href=\"./emerson_3/status_report.html\" target=\"_blank\">Emerson Unit #3</a>&nbsp;-&nbsp;<a href=\"./emerson_4/status_report.html\" target=\"_blank\">Emerson Unit #4</a></h4>\n\t\t</div>\n\t\t<br>" >> ${TMP_FILE}
	((EC += $?))

	echo -e "\t\t<h3><u>Email Alerts</u></h3>\n\t\t<p>\n\t\t\tIf you want to be notified via email when the temperature of an Emerson unit exceeds a specific value, email me and let me know. You will receive at most 1 email per hour, but you can also select the frequency of the alerts.\n\t\t</p>\n\t\t<br>" >> ${TMP_FILE}
	((EC += $?))

	echo -e "\t\t<h3><u>RSS Feed</u></h3>\n\t\t<p>\n\t\t\tIn the following URL, you can find the RSS v2.0 feed of Aeolus Logger which is updated every time temperature exceeds 26 or equals -30 degrees Celsius (Minus 30 degrees is a value that indicates a specific kind of error). The feed will be updated at most once per hour. <a href=\"./feed/\">[Aeolus Logger RSS feed]</a>\n\t\t</p>\n\t\t<br>" >> ${TMP_FILE}
	((EC += $?))

	echo -e "\t\t<h3><u>More Details</u></h3>\n\t\t<p>\n\t\t\tThe two Emerson units provide <i>XML</i> files containing the related data for reporting their <i>status</i> and <i>environmental conditions</i> of the cluster room. Each unit provides: a <u>24 hour log</u> of the 1) <strong>unit temperature</strong>, 2) <strong>unit humidity</strong>, 3) <strong>system temperature</strong> &amp; 4) <strong>system humidity</strong> and a <strong>current status report</strong>. Log files contain the average of the values observed in <u>6 minute</u> intervals. That equals to 10 measurements per hour, which sums up to a log of 240 measurements. The <i>XML</i> files of Emerson unit #3 are provided 22 minutes after the actual measurement, while the <i>XML</i> files of the #4 unit are provided 18 minutes after the actual measurement. For this reason, the values provided by <strong>current status report</strong> and which are updated every <u>1 minute</u>, are monitored and logged in <i>RRD</i> databases, something that increases accuracy by 1200 measurements a day (24 hours).\n\t\t</p>\n\t\t<br>" >> ${TMP_FILE}
	((EC += $?))

        echo -e "\t\t<h3><u>Source Code</u></h3>\n\t\t<p>\n\t\t\tAeolus Logger is entirely written in BASH and the source code can be found in the following Git repository: <a href=\"https://github.com/gzachos/aeolus-logger\">[Aeolus Logger - GitHub Repository]</a>\n\t\t</p>\n\t\t<br>" >> ${TMP_FILE}
        ((EC += $?))


	echo -e "\t\t<h3><u>Contact</u></h3>\n\t\t<table>\n\t\t\t<tr>\n\t\t\t\t<td id=\"contact\">\n\t\t\t\t\t<strong>Name: </strong>George Z. Zachos<br>\n\t\t\t\t\t<strong>Email: </strong>gzachos&#60;at&#62;cse.uoi.gr<br>\n\t\t\t\t\t<strong>Webpage: </strong><a href=\"http://cse.uoi.gr/~gzachos\" target=\"_blank\">cse.uoi.gr/~gzachos</a><br>\n\t\t\t\t</td>\n\t\t\t</tr>\n\t\t</table>\n\t\t<br><br><br>\n\t\t<h4><i>A project by ~gzachos</i></h4>\n\t\t<h4>Computer Systems Support Group</h4>\n\t\t<h4>&copy; George Z. Zachos 2015-2016. All rights reserved.</h4>\n\t\t<h4>Computer Science and Engineering Department - University of Ioannina</h4>\n\t</body>\n</html>" >> ${TMP_FILE}
	((EC += $?))
}


# Calls the functions that append data to the output .html file.
main () {
	WEBSITEPATH="/var/www/html"
	GLB_LOGFILE="/var/log/aeolus/aeolus.log"
        ERR_LOGFILE="/var/log/aeolus/error.log"         # not used
        STD_LOGFILE="/var/log/aeolus/stdout.log"        # not used
        TMP_FILE=$(mktemp /tmp/aeolus.XXXXXX)
        DST_FILE=${WEBSITEPATH}/emerson_main_page.html
	EC=0
        append_head
        append_body
        if [ "${EC}" -eq "0" ]
        then
                cp -f ${TMP_FILE} ${DST_FILE}
		if [ "$?" -eq "0" ] && [ -e "${DST_FILE}" ] && [ -s "${DST_FILE}" ]
		then
	                echo "[ $(date -R) ] Main page was successfully created" >> ${GLB_LOGFILE}
		else
        		echo "[ $(date -R) ] Main page was NOT created [FAIL]" >> ${GLB_LOGFILE}
		fi
        fi
        rm ${TMP_FILE}
}


# Calling main.
main
