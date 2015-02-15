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



function append_head {
	echo -e "<!DOCTYPE html>\n<html>\n\t<head>\n\t\t<title>Emerson Status Report</title>\n\t\t<meta charset=\"utf-8\">\n\t\t<link rel=\"icon\" href=\"./photos/cse-uoi.ico\" type=\"image/x-icon\"/>\n\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"emerson_status_report.css\">\n\t</head>" > status_report_$1.html
}


function append_body_stable_0 {
	echo -e "\t<body>\n\t\t<img height=90px align=\"left\" src=\"./photos/uoi-cse.png\">\n\t\t<img id=\"head\" height=90px align=\"right\" src=\"./photos/cse_banner_logo.jpg\">\n\t\t<br><br><br><br><br>\n\t\t<h5><a href=\".\">Unit Air Temperature</a> | <a href=\".\">System Average Air Temperature</a> | <a href=\".\">Unit Air Humidity</a> | <a href=\".\">System Average Air Humidity</a></h5>\n\t\t<h5><a href=\".\">Main Page</a> | <a href=\".\">Status Report</a></h5><br>\n\t\t<h2><u>Emerson #$1 Status Report</u></h2><br>" >> status_report_$1.html
}


function append_table_stable_0 {
	echo -e "\n\t\t<!-- MAIN CONTENT -->\n\t\t<table style=\"width:80%\">\n\t\t\t<tr>\n\t\t\t\t<th>Label</th>\n\t\t\t\t<th>Value</th>\n\t\t\t\t<th>Unit</th>\n\t\t\t</tr>" >> status_report_$1.html
}


function init_labels {
        LABELS=$(grep -i Label main.txt | tr " " "_")
        unset LABELS_ARRAY
        INDEX=0
        for x in $LABELS
        do
                label=$(echo ${x#<Label>})
                label=$(echo ${label%<*})
                label=$(echo $label | tr "_" " ")
                LABELS_ARRAY[$INDEX]=${label}
                INDEX=$((INDEX+1))
        done
}


function init_values {
        VALUES=$(grep -i Value main.txt | tr " " "_")
        unset VALUES_ARRAY
        INDEX=0
        for x in $VALUES
        do
                value=$(echo ${x#<*>})
                value=$(echo ${value%<*})
                value=$(echo $value | tr "_" " ")
                VALUES_ARRAY[$INDEX]=${value}
                INDEX=$((INDEX+1))
        done
}


function init_units {
        UNITS=$(grep -i Unit main.txt | grep -v Status | tr " " "_")
        unset UNITS_ARRAY
        INDEX=0
        for x in $UNITS
        do
                u=$(echo ${x#<*>})
                u=$(echo ${u%<*})
                u=$(echo $u | tr "_" " ")
                if [ -z "$u" ]
                then
                        UNITS_ARRAY[$INDEX]=" - "
                else
                        UNITS_ARRAY[$INDEX]=${u}
                fi
                INDEX=$((INDEX+1))
        done
}


function append_variable_section {
        ARRAY_LEN=${#LABELS_ARRAY[@]}
        STRING=""
        INDEX=0
        while [ "$INDEX" -lt "$((ARRAY_LEN-1))" ]
        do
                STRING="$STRING\t\t\t<tr>\n\t\t\t\t<td>${LABELS_ARRAY[$INDEX]}</td>\n\t\t\t\t<td>${VALUES_ARRAY[$INDEX]}</td>\n\t\t\t\t<td>${UNITS_ARRAY[$INDEX]}</td>\n\t\t\t</tr>\n"
                INDEX=$((INDEX+1))
        done
        STRING="$STRING\t\t\t<tr>\n\t\t\t\t<td>${LABELS_ARRAY[$INDEX]}</td>\n\t\t\t\t<td>${VALUES_ARRAY[$INDEX]}</td>\n\t\t\t\t<td>${UNITS_ARRAY[$INDEX]}</td>\n\t\t\t</tr>"
        echo -e "$STRING" >> status_report_$1.html
}


function append_table_stable_1 {
	echo -e "\t\t</table>\n\t\t<!-- END OF MAIN CONTENT -->\n\n\t\t" >> status_report_$1.html
}


function append_body_stable_1 {
	echo -e "<br>\n\t\t<h4><i>A project by ~gzachos</i></h4>\n\t\t<h4>&copy; Systems Support Group 2015. All rights reserved.</h4>\n\t\t<h4>Computer Science and Engineering Department - University of Ioannina</h4>\n\t</body>\n</html>" >> status_report_$1.html
}


function create_status_report {
	init_labels
	init_values
	init_units
	append_head $1
	append_body_stable_0 $1
	append_table_stable_0 $1
	append_variable_section $1
	append_table_stable_1 $1
	append_body_stable_1 $1
}

create_status_report $1
