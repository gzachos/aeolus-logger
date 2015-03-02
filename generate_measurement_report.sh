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


################################
#            WEBSITE           #
################################

function append_head () {
	echo -e "<!DOCTYPE html>\n<html>\n\t<!-- HEAD SECTION (includes the two lines above) -->\n\t<head>\n\t\t<title>Emerson Measurement Report</title>\n\t\t<meta charset=\"utf-8\">\n\t\t<link rel=\"icon\" href=\"../photos/cse-uoi.ico\" type=\"image/x-icon\"/>\n\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/emerson_logger.css\">\n\t</head>" > measurement_report_$1.html
}

function append_body_stable_0 () {
	if [ $1 -eq 3 ]
	then
		OTHER_EMERSON=4
	else
		OTHER_EMERSON=3
	fi
	echo -e "\n\t<!-- FIRST STABLE PART OF BODY SECTION -->\n\t<body>\n\t\t<img height=90px align=\"left\" src=\"../photos/uoi-cse.png\">\n\t\t<img id=\"head\" height=90px align=\"right\" src=\"../photos/cse_banner_logo.jpg\">\n\t\t<br><br><br><br><br>\n\t\t<h5><a href=\"../emerson_main_page.html\">Main Page</a> | <a href=\"./status_report_$1.html\">Emerson #$1 Status Report</a> | <a href=\"./measurement_report_$1.html\">Emerson #$1 Measurement Report</a> | <a href=\"../emerson_$OTHER_EMERSON/status_report_$OTHER_EMERSON.html\">Emerson #${OTHER_EMERSON}</a></h5><br>\n\t\t<h2><u>Emerson #$1 Measurement Report</u></h2><br>" >> measurement_report_$1.html
}

function append_table_stable_0 () {
	echo -e "\n\t\t<!-- FIRST STABLE PART OF TABLE SECTION -->\n\t\t<!-- MAIN CONTENT -->\n\t\t<table style=\"width:80%\">\n\t\t\t<tr>\n\t\t\t\t<th>Date / Time</th>\n\t\t\t\t<th>Temp Unit</th>\n\t\t\t\t<th>Temp Sys</th>\n\t\t\t\t<th>Hum Unit</th>\n\t\t\t\t<th>Hum Sys</th>\n\t\t\t</tr>" >> measurement_report_$1.html
}

function append_table_stable_1 () {
	echo -e "\n\t\t<!-- LAST STABLE PART OF TABLE SECTION -->\n\t\t</table>\n\t\t<!-- END OF MAIN CONTENT -->\n\t\t" >> measurement_report_$1.html
}

function append_body_stable_1 () {
	echo -e "\t\t<!-- LAST STABLE PART OF BODY SECTION -->\n\t\t<br>\n\t\t<h4><i>A project by ~gzachos</i></h4>\n\t\t<h4>&copy; Systems Support Group 2015. All rights reserved.</h4>\n\t\t<h4>Computer Science and Engineering Department - University of Ioannina</h4>\n\t</body>\n</html>" >> measurement_report_$1.html
}


function append_variable_section () {
        ARRAY_LEN=${#DATES_TIMES_U_ARRAY[@]}
        STRING="\n\t\t\t<!-- VARIABLE PART OF TABLE SECTION -->\n"
        INDEX=0
        while [ "$INDEX" -lt "$((ARRAY_LEN-1))" ]
        do
                STRING="$STRING\t\t\t<tr>\n\t\t\t\t<td>${DATES_TIMES_U_ARRAY[$INDEX]}</td>\n\t\t\t\t<td>${VALUES_U_ARRAY[$INDEX]}</td>\n\t\t\t\t<td>${VALUES_S_ARRAY[$INDEX]}</td>\n\t\t\t\t<td>${VALUES_HU_ARRAY[$INDEX]}</td>\n\t\t\t\t<td>${VALUES_HS_ARRAY[$INDEX]}</td>\n\t\t\t</tr>\n"
                INDEX=$((INDEX+1))
        done
        STRING="$STRING\t\t\t<tr>\n\t\t\t\t<td>${DATES_TIMES_U_ARRAY[$INDEX]}</td>\n\t\t\t\t<td>${VALUES_U_ARRAY[$INDEX]}</td>\n\t\t\t\t<td>${VALUES_S_ARRAY[$INDEX]}</td>\n\t\t\t\t<td>${VALUES_HU_ARRAY[$INDEX]}</td>\n\t\t\t\t<td>${VALUES_HS_ARRAY[$INDEX]}</td>\n\t\t\t</tr>\n"
        echo -e "$STRING" >> measurement_report_$1.html
}


################################
#          TEMPERATURE         #
################################

function init_temp_unit_time () {
	DATES_TIMES_U=$(grep -i time ./temp/temp_unit | tr -d "</time>" | tr -d "\r")
	INDEX=0
	for x in $DATES_TIMES_U
	do
        	DATES_TIMES_U_ARRAY[$INDEX]=$(echo $x | tr "T" " ")
        	INDEX=$((INDEX+1))
	done
}


function init_temp_sys_time () {
	DATES_TIMES_S=$(grep -i time ./temp/temp_sys | tr -d "</time>" | tr -d "\r")
	INDEX=0
	for x in $DATES_TIMES_S
	do
        	DATES_TIMES_S_ARRAY[$INDEX]=$(echo $x | tr "T" " ")
        	INDEX=$((INDEX+1))
	done
}


function init_temp_unit_value () {
        VALUES_U=$(grep -i value ./temp/temp_unit | tr -d "</value>" | tr -d "\r")
        INDEX=0
        for x in $VALUES_U
        do
                VALUES_U_ARRAY[$INDEX]=${x}
                INDEX=$((INDEX+1))
        done
}


function init_temp_sys_value () {
        VALUES_S=$(grep -i value ./temp/temp_sys | tr -d "</value>" | tr -d "\r")
        INDEX=0
        for x in $VALUES_S
        do
                VALUES_S_ARRAY[$INDEX]=${x}
                INDEX=$((INDEX+1))
        done
}


######################################
#             HUMIDITY               #
######################################

function init_hum_unit_time () {
	DATES_TIMES_HU=$(grep -i time ./hum/hum_unit | tr -d "</time>" | tr -d "\r")
	INDEX=0
	for x in $DATES_TIMES_HU
	do
        	DATES_TIMES_HU_ARRAY[$INDEX]=$(echo $x | tr "T" " ")
        	INDEX=$((INDEX+1))
	done
}


function init_hum_sys_time () {
	DATES_TIMES_HS=$(grep -i time ./hum/hum_sys | tr -d "</time>" | tr -d "\r")
	INDEX=0
	for x in $DATES_TIMES_HS
	do
        	DATES_TIMES_HS_ARRAY[$INDEX]=$(echo $x | tr "T" " ")
        	INDEX=$((INDEX+1))
	done

}


function init_hum_unit_value () {
        VALUES_HU=$(grep -i value ./hum/hum_unit | tr -d "</value>" | tr -d "\r")
        INDEX=0
        for x in $VALUES_HU
        do
                VALUES_HU_ARRAY[$INDEX]=${x}
                INDEX=$((INDEX+1))
        done
}


function init_hum_sys_value () {
        VALUES_HS=$(grep -i value ./hum/hum_sys | tr -d "</value>" | tr -d "\r")
        INDEX=0
        for x in $VALUES_HS
        do
                VALUES_HS_ARRAY[$INDEX]=${x}
                INDEX=$((INDEX+1))
        done
}

################################
#        PRINTING DATA         #
################################


function print_data () {
	ARRAY_LEN=${#DATES_TIMES_U_ARRAY[@]}
#       echo $ARRAY_LEN
	INDEX=0
	while [ $INDEX -lt $ARRAY_LEN ]
	do
		echo "INDEX= $INDEX"
		echo "${DATES_TIMES_U_ARRAY[$INDEX]}"
		echo "Unit Tem: ${VALUES_U_ARRAY[$INDEX]}"
		#echo "${DATES_TIMES_S_ARRAY[$INDEX]}"
		echo "Sys  Tem: ${VALUES_S_ARRAY[$INDEX]}"
		#echo "${DATES_TIMES_HU_ARRAY[$INDEX]}"
		echo "Unit Hum: ${VALUES_HU_ARRAY[$INDEX]}"
		#echo "${DATES_TIMES_HS_ARRAY[$INDEX]}"
		echo -e "Sys  Hum: ${VALUES_HS_ARRAY[$INDEX]}\n"
		INDEX=$((INDEX+1))
	done
}


################################
#       FUNCTION CALLING       #
################################

function init_temp_unit () {
	init_temp_unit_time
	init_temp_unit_value
}


function init_temp_sys () {
	init_temp_sys_time
	init_temp_sys_value
}


function init_hum_unit () {
	init_hum_unit_time
	init_hum_unit_value
}


function init_hum_sys () {
	init_hum_sys_time
	init_hum_sys_value
}

function create_measurement_report() {
	append_head $1
	append_body_stable_0 $1
	append_table_stable_0 $1
	append_variable_section $1
	append_table_stable_1 $1
	append_body_stable_1 $1
}

function main () {
	init_temp_unit
	init_temp_sys
	init_hum_unit
	init_hum_sys
#       print_data
	create_measurement_report $1
}

main $1
