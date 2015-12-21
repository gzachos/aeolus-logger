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


################################
#            WEBSITE           #
################################

# Appends <head> section to the output .html file.
# (Parameter: $1 -> Emerson unit No.)
append_head () {
	echo -e "<!DOCTYPE html>\n<html>\n\t<!-- HEAD SECTION (includes the two lines above) -->\n\t<head>\n\t\t<title>Emerson Measurement Report</title>\n\t\t<meta charset=\"utf-8\">\n\t\t<link rel=\"icon\" href=\"../photos/cse-uoi.ico\" type=\"image/x-icon\"/>\n\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/emerson_logger.css\">\n\t</head>" > ${TMP_FILE}
}


# Appends the first stable part of the <body> section to the output .html file.
# (Parameter: $1 -> Emerson unit No.)
append_body_stable_0 () {
	if [ "${1}" -eq "3" ]
	then
		OTHER_EMERSON=4
	else
		OTHER_EMERSON=3
	fi
	echo -e "\n\t<!-- FIRST STABLE PART OF BODY SECTION -->\n\t<body>\n\t\t<img height=90 alt=\"uoi-cse-png\" src=\"../photos/uoi-cse.png\">\n\t\t<img class=\"banner\" height=90 alt=\"cse_banner_logo.jpg\" src=\"../photos/cse_banner_logo.jpg\">\n\t\t<br><br>\n\t\t<h4><a href=\"../emerson_main_page.html\">Main Page</a> &nbsp;|&nbsp; <a href=\"./status_report.html\">Emerson #${1} Status Report</a> &nbsp;|&nbsp; <a href=\"./measurement_report.html\">Emerson #${1} Measurement Report</a><br> <a href=\"./graph_report.html\">Emerson #${1} Graph Report</a>  &nbsp;|&nbsp; <a href=\"../emerson_${OTHER_EMERSON}/status_report.html\">Emerson #${OTHER_EMERSON}</a></h4><br>\n\t\t<h2><u>Emerson #${1} Measurement Report</u></h2><br>" >> ${TMP_FILE}
}


# Appends the first stable part of the <table> section to the output .html file.
# (Parameter: $1 -> Emerson unit No.)
append_table_stable_0 () {
	echo -e "\n\t\t<!-- FIRST STABLE PART OF TABLE SECTION -->\n\t\t<!-- MAIN CONTENT -->\n\t\t<table style=\"width:80%\">\n\t\t\t<tr>\n\t\t\t\t<th>Date / Time</th>\n\t\t\t\t<th>Temp Unit</th>\n\t\t\t\t<th>Temp Sys</th>\n\t\t\t\t<th>Hum Unit</th>\n\t\t\t\t<th>Hum Sys</th>\n\t\t\t</tr>" >> ${TMP_FILE}
}


# Appends the second stable part of the <table> section to the output .html file.
# (Parameter: $1 -> Emerson unit No.)
append_table_stable_1 () {
	echo -e "\n\t\t<!-- LAST STABLE PART OF TABLE SECTION -->\n\t\t</table>\n\t\t<!-- END OF MAIN CONTENT -->\n\t\t" >> ${TMP_FILE}
}


# Appends the second stable part of the <body> section to the output .html file.
# (Parameter: $1 -> Emerson unit No.)
append_body_stable_1 () {
	echo -e "\t\t<!-- LAST STABLE PART OF BODY SECTION -->\n\t\t<br>\n\t\t<h4><i>A project by ~gzachos</i></h4>\n\t\t<h4>&copy; Systems Support Group 2015. All rights reserved.</h4>\n\t\t<h4>Computer Science and Engineering Department - University of Ioannina</h4>\n\t</body>\n</html>" >> ${TMP_FILE}
}


# Appends the variable part part of the <table> section to the output .html file.
# (Parameter: $1 -> Emerson unit No.)
append_variable_section () {
        ARRAY_LEN=${#DATES_TIMES_U_ARRAY[@]}
        STRING="\n\t\t\t<!-- VARIABLE PART OF TABLE SECTION -->\n"
        INDEX=0
        while [ "${INDEX}" -lt "$((ARRAY_LEN-1))" ]
        do
                STRING="${STRING}\t\t\t<tr>\n\t\t\t\t<td>${DATES_TIMES_U_ARRAY[${INDEX}]}</td>\n\t\t\t\t<td>${VALUES_U_ARRAY[${INDEX}]}</td>\n\t\t\t\t<td>${VALUES_S_ARRAY[${INDEX}]}</td>\n\t\t\t\t<td>${VALUES_HU_ARRAY[${INDEX}]}</td>\n\t\t\t\t<td>${VALUES_HS_ARRAY[${INDEX}]}</td>\n\t\t\t</tr>\n"
                INDEX=$((INDEX+1))
        done
        STRING="${STRING}\t\t\t<tr>\n\t\t\t\t<td>${DATES_TIMES_U_ARRAY[${INDEX}]}</td>\n\t\t\t\t<td>${VALUES_U_ARRAY[${INDEX}]}</td>\n\t\t\t\t<td>${VALUES_S_ARRAY[${INDEX}]}</td>\n\t\t\t\t<td>${VALUES_HU_ARRAY[${INDEX}]}</td>\n\t\t\t\t<td>${VALUES_HS_ARRAY[${INDEX}]}</td>\n\t\t\t</tr>\n"
        echo -e "${STRING}" >> ${TMP_FILE}
}


################################
#          TEMPERATURE         #
################################


# Initializes the values of DATES_TIMES_U.
init_temp_unit_time () {
	DATES_TIMES_U=$(grep -i time ${WEBSITEPATH}/emerson_${1}/data/temp/temp_unit.txt | tr -d "</time>" | tr -d "\r")
	INDEX=0
	for x in ${DATES_TIMES_U}
	do
        	DATES_TIMES_U_ARRAY[${INDEX}]=$(echo ${x} | tr "T" " ")
        	INDEX=$((INDEX+1))
	done
}


# Initializes the values of DATES_TIMES_S.
init_temp_sys_time () {
	DATES_TIMES_S=$(grep -i time ${WEBSITEPATH}/emerson_${1}/data/temp/temp_sys.txt | tr -d "</time>" | tr -d "\r")
	INDEX=0
	for x in ${DATES_TIMES_S}
	do
        	DATES_TIMES_S_ARRAY[${INDEX}]=$(echo ${x} | tr "T" " ")
        	INDEX=$((INDEX+1))
	done
}


# Initializes the values of VALUES_U.
init_temp_unit_value () {
        VALUES_U=$(grep -i value ${WEBSITEPATH}/emerson_${1}/data/temp/temp_unit.txt | tr -d "</value>" | tr -d "\r")
        INDEX=0
        for x in ${VALUES_U}
        do
		x=$(awk "BEGIN{print ${x}/10}")
                VALUES_U_ARRAY[${INDEX}]=${x}
                INDEX=$((INDEX+1))
        done
	FEED_VALUE=$( printf "%.0f" ${VALUES_U_ARRAY[2]} )
	# if unit temperature is equal to -30 degrees Celsius,
	# there is a problem with the close-control air conditioning system,
	# so the RSS feed is updated every hour.
	# Maybe an email alert should be sent.
	MINUTES=$(date "+%M")
	if [ "${FEED_VALUE}" == "-30" ] && [ "${MINUTES}" -eq "00" ]
	then
		${WEBSITEPATH}/scripts/generate_rss_feed.sh ${1} ${VALUES_U_ARRAY[2]} unit
	fi
}


# Initializes the values of VALUES_S.
init_temp_sys_value () {
        VALUES_S=$(grep -i value ${WEBSITEPATH}/emerson_${1}/data/temp/temp_sys.txt | tr -d "</value>" | tr -d "\r")
        INDEX=0
        for x in ${VALUES_S}
        do
		x=$(awk "BEGIN{print ${x}/10}")
                VALUES_S_ARRAY[${INDEX}]=${x}
                INDEX=$((INDEX+1))
        done
	# System temperature is checked during the execution of generate_status_report.sh
#	FEED_VALUE=$( printf "%.0f" ${VALUES_S_ARRAY[2]} )
#	if [ "${FEED_VALUE}" -gt "26" ]
#	then
#		${WEBSITEPATH}/scripts/generate_rss_feed.sh ${1} ${VALUES_S_ARRAY[2]} sys
#	fi
}


######################################
#             HUMIDITY               #
######################################


# Initializes the values of DATES_TIMES_HU.
init_hum_unit_time () {
	DATES_TIMES_HU=$(grep -i time ${WEBSITEPATH}/emerson_${1}/data/hum/hum_unit.txt | tr -d "</time>" | tr -d "\r")
	INDEX=0
	for x in ${DATES_TIMES_HU}
	do
        	DATES_TIMES_HU_ARRAY[${INDEX}]=$(echo ${x} | tr "T" " ")
        	INDEX=$((INDEX+1))
	done
}


# Initializes the values of DATES_TIMES_HS.
init_hum_sys_time () {
	DATES_TIMES_HS=$(grep -i time ${WEBSITEPATH}/emerson_${1}/data/hum/hum_sys.txt | tr -d "</time>" | tr -d "\r")
	INDEX=0
	for x in ${DATES_TIMES_HS}
	do
        	DATES_TIMES_HS_ARRAY[${INDEX}]=$(echo ${x} | tr "T" " ")
        	INDEX=$((INDEX+1))
	done
}


# Initializes the values of VALUES_HU.
init_hum_unit_value () {
        VALUES_HU=$(grep -i value ${WEBSITEPATH}/emerson_${1}/data/hum/hum_unit.txt | tr -d "</value>" | tr -d "\r")
        INDEX=0
        for x in ${VALUES_HU}
        do
		x=$(awk "BEGIN{print ${x}/10}")
                VALUES_HU_ARRAY[${INDEX}]=${x}
                INDEX=$((INDEX+1))
        done
}


# Initializes the values of VALUES_HS.
init_hum_sys_value () {
        VALUES_HS=$(grep -i value ${WEBSITEPATH}/emerson_${1}/data/hum/hum_sys.txt | tr -d "</value>" | tr -d "\r")
        INDEX=0
        for x in ${VALUES_HS}
        do
		x=$(awk "BEGIN{print ${x}/10}")
                VALUES_HS_ARRAY[${INDEX}]=${x}
                INDEX=$((INDEX+1))
        done
}


################################
#        CHECKING DATA         #
################################


naive_check_data () {
	DT_U_LEN=${#DATES_TIMES_U_ARRAY[@]}
	DT_S_LEN=${#DATES_TIMES_S_ARRAY[@]}
	DT_HU_LEN=${#DATES_TIMES_HU_ARRAY[@]}
	DT_HS_LEN=${#DATES_TIMES_HS_ARRAY[@]}
	VU_LEN=${#VALUES_U_ARRAY[@]}
	VS_LEN=${#VALUES_S_ARRAY[@]}
	VHU_LEN=${#VALUES_HU_ARRAY[@]}
	VHS_LEN=${#VALUES_HS_ARRAY[@]}
	if [ "${DT_U_LEN}" -ne "${DT_S_LEN}" ] || [ "${DT_S_LEN}" -ne "${DT_HU_LEN}" ] || [ "${DT_HU_LEN}" -ne "${DT_HS_LEN}" ] || [ "${DT_HS_LEN}" -ne "${VU_LEN}" ] || [ "${VU_LEN}" -ne "${VS_LEN}" ] || [ "${VS_LEN}" -ne "${VHU_LEN}" ] || [ "${VHU_LEN}" -ne "${VHS_LEN}" ]
	then
		echo "[ $(date -R) ] Arrays created by \"generate_measurement_report.sh\" executed for Emerson unit #${1} are of DIFFERENT size" >> ${GLB_LOGFILE}
                return 1
	fi
	INDEX=0
        while [ "${INDEX}" -lt "$((DT_U_LEN-1))" ]
        do
                if [ -z "${DATES_TIMES_U_ARRAY[${INDEX}]}" ] || [ -z "${VALUES_U_ARRAY[${INDEX}]}" ] ||	[ -z "${VALUES_S_ARRAY[${INDEX}]}" ] ||	[ -z "${VALUES_HU_ARRAY[${INDEX}]}" ] || [ -z "${DATES_TIMES_HS_ARRAY[${INDEX}]}" ]
                then
                        echo "[ $(date -R) ] Arrays created by \"generate_measurement_report.sh\" executed for Emerson unit #${1} have EMPTY elements" >> ${GLB_LOGFILE}
                        return 2
                fi
                INDEX=$((INDEX+1))
        done
}


################################
#        PRINTING DATA         #
################################


# Prints the data held in ${DATES_TIMES_U_ARRAY}, ${VALUES_S_ARRAY},
# ${VALUES_HU_ARRAY} and ${VALUES_HS_ARRAY}.
print_data () {
	ARRAY_LEN=${#DATES_TIMES_U_ARRAY[@]}
#       echo ${ARRAY_LEN}
	INDEX=0
	while [ "${INDEX}" -lt "${ARRAY_LEN}" ]
	do
		echo "INDEX= ${INDEX}"
		echo "${DATES_TIMES_U_ARRAY[${INDEX}]}"
		echo "Unit Tem: ${VALUES_U_ARRAY[${INDEX}]}"
		#echo "${DATES_TIMES_S_ARRAY[${INDEX}]}"
		echo "Sys  Tem: ${VALUES_S_ARRAY[${INDEX}]}"
		#echo "${DATES_TIMES_HU_ARRAY[${INDEX}]}"
		echo "Unit Hum: ${VALUES_HU_ARRAY[${INDEX}]}"
		#echo "${DATES_TIMES_HS_ARRAY[${INDEX}]}"
		echo -e "Sys  Hum: ${VALUES_HS_ARRAY[${INDEX}]}\n"
		INDEX=$((INDEX+1))
	done
}


################################
#       FUNCTION CALLING       #
################################


# Functions: init_temp_unit, init_temp_sys, init_hum_unit and init_hum_sys
# call the functions that initialize data to BASH arrays.


init_temp_unit () {
	init_temp_unit_time ${1}
	init_temp_unit_value ${1}
}


init_temp_sys () {
	init_temp_sys_time ${1}
	init_temp_sys_value ${1}
}


init_hum_unit () {
	init_hum_unit_time ${1}
	init_hum_unit_value ${1}
}


init_hum_sys () {
	init_hum_sys_time ${1}
	init_hum_sys_value ${1}
}


# Calls the functions that append data to the output .html file.
# (Parameter: $1 -> Emerson unit No.)
create_measurement_report () {
	append_head ${1}
	((EC += $?))
	append_body_stable_0 ${1}
	((EC += $?))
	append_table_stable_0 ${1}
	((EC += $?))
	append_variable_section ${1}
	((EC += $?))
	append_table_stable_1 ${1}
	((EC += $?))
	append_body_stable_1 ${1}
	((EC += $?))
}


# Calls all the functions that create the measurement report file for an Emerson unit.
# (Parameter: $1 -> Emerson unit No.)
main () {
	WEBSITEPATH="/var/www/html"
	GLB_LOGFILE="/var/log/aeolus/aeolus.log"
        ERR_LOGFILE="/var/log/aeolus/error.log"         # not used
        STD_LOGFILE="/var/log/aeolus/stdout.log"        # not used
        TMP_FILE=$(mktemp /tmp/aeolus.XXXXXX)
        DST_FILE=${WEBSITEPATH}/emerson_${1}/measurement_report.html
        EC=0
	init_temp_unit ${1}
	init_temp_sys ${1}
	init_hum_unit ${1}
	init_hum_sys ${1}
	naive_check_data
        if [ "$?" -ne "0" ]
        then
                echo "[ $(date -R) ] Measurement report of Emerson unit #${1} was NOT created [FAIL]" >> ${GLB_LOGFILE}
                rm ${TMP_FILE}
                exit 1
        fi
#       print_data
	create_measurement_report ${1}
        if [ "${EC}" -eq "0" ]
        then
                cp -f ${TMP_FILE} ${DST_FILE}
                if [ "$?" -eq "0" ] && [ -e "${DST_FILE}" ] && [ -s "${DST_FILE}" ]
                then
                        echo "[ $(date -R) ] Measurement report of Emerson unit #${1} was successfully created" >> ${GLB_LOGFILE}
                else
                        echo "[ $(date -R) ] Measurement report of Emerson unit #${1} was NOT successfully created [FAIL]" >> ${GLB_LOGFILE}
        		rm ${TMP_FILE}
			exit 2
                fi
        fi
        rm ${TMP_FILE}
}


# Calling main.
# (Parameter: $1 -> Emerson unit No.)
main ${1}
