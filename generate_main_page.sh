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


function append_head () {
        echo -e "<!DOCTYPE html>\n<html>\n\t<!-- HEAD SECTION (includes the two lines above) -->\n\t<head>\n\t\t<title>Emerson Logger</title>\n\t\t<meta charset=\"utf-8\">\n\t\t<link rel=\"icon\" href=\"./photos/cse-uoi.ico\" type=\"image/x-icon\"/>\n\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"./css/emerson_logger.css\">\n\t</head>\n" > /var/www/html/emerson_main_page.html
}

function append_body () {
        echo -e "\t<!-- BODY SECTION (includes \"</html>\" line) -->\n\t<body align=\"center\">\n\t\t<img height=90px align=\"left\" src=\"./photos/uoi-cse.png\">\n\t\t<img id=\"head\" height=90px align=\"right\" src=\"./photos/cse_banner_logo.jpg\">\n\t\t<br><br><br><br><br>\n\t\t<h4><a href=\"./emerson_3/status_report_3.html\">Emerson Unit #3</a> | <a href=\"./emerson_4/status_report_4.html\">Emerson Unit #4</a> | <a href=\"http://support.cs.uoi.gr/\" target=\"_blank\">Systems Support Group</a></h4><br>\n\t\t<h2><u>Emerson Logger Main Page</u></h2>\n\t\t<h3><u>About</u></h3>\n\t\t<p>\n\t\t\tThe <strong>\"Emerson Logger\"</strong> project is about a server that will be used to monitor the environmental conditions of the cluster room inside the building of <a href=\"http://cs.uoi.gr/\" target=\"_blank\">Computer Science and Engineering Department</a> - <a href=\"http://uoi.gr/\" target=\"_blank\">University of Ioannina</a>. The <strong>temperature</strong> and <strong>humidity</strong> values are supplied by the two Emerson cooling units inside the cluster room. Moreover, the project is about monitoring the <strong>status</strong> of the two Emerson units and <strong>alarming</strong> the faculty if any <strong>abnormal</strong> conditions are observed.\n\t\t</p>\n\t\t<br>\n\t\t<h3><u>Emerson Units</u></h3>\n\t\t<p id=\"emersons\">\n\t\t\tVisit one of the links below to see a detailed report of an Emerson unit.<br>\n\t\t\t<h4><a href=\"./emerson_3/status_report_3.html\" target=\"_blank\">Emerson Unit #3</a>&nbsp;-&nbsp;<a href=\"./emerson_4/status_report_4.html\" target=\"_blank\">Emerson Unit #4</a></h4>\n\t\t</p>\n\t\t<br>\n\t\t<h3><u>More Details</u></h3>\n\t\t<p>\n\t\t\tThe two emersons provide <i>XML</i> files containing the related data for reporting their <i>status</i> and <i>environmental conditions</i>. Each unit provides: a <u>24 hour log</u> of the 1) <strong>unit temperature</strong>, 2) <strong>unit humidity</strong>, 3) <strong>system temperature</strong>, 4) <strong>system humidity</strong> and 5) a <strong>current status report</strong>. Each measurement is taken every <i>6 minutes</i>. That equals to 10 measurements per hour, which sums up to a log of 240 measurements. The XML files of Emerson unit #3 are provided 22 minutes after the actual measurement, while the XML files of the #4 unit are provided 18 minutes after the actual measurement.\n\t\t</p>\n\t\t<br>\n\t\t<h3><u>Contact</u></h3>\n\t\t<p>\n\t\t\t<table>\n\t\t\t\t<tr>\n\t\t\t\t\t<td id=\"contact\">\n\t\t\t\t\t\t<strong>Name: </strong>George Zachos<br>\n\t\t\t\t\t\t<strong>Email: </strong>gzachos&#60;at&#62;cs.uoi.gr<br>\n\t\t\t\t\t\t<strong>Webpage: </strong><a href=\"http://cs.uoi.gr/~gzachos\" target=\"_blank\">cs.uoi.gr/~gzachos</a><br>\n\t\t\t\t\t</td>\n\t\t\t\t</tr>\n\t\t\t</table>\n\t\t</p>\n\t\t<br>\n\t\t<h4><i>A project by ~gzachos</i></h4>\n\t\t<h4>&copy; Systems Support Group 2015. All rights reserved.</h4>\n\t\t<h4>Computer Science and Engineering Department - University of Ioannina</h4>\n\t</body>\n</html>" >> /var/www/html/emerson_main_page.html
}

function main () {
        append_head
        append_body
}

main
