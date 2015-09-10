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


# Appends the <head> section to the output .html file.
# (Parameter: $1 -> Emerson unit No.)
append_head () {
	echo -e "<!DOCTYPE html>\n<html>\n\t<!-- HEAD SECTION (includes the two lines above) -->\n\t<head>\n\t\t<title>Emerson #${1} Status Report</title>\n\t\t<meta charset=\"utf-8\">\n\t\t<link rel=\"icon\" href=\"../photos/cse-uoi.ico\" type=\"image/x-icon\"/>\n\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/emerson_logger.css\">\n\t</head>" > ${WEBSITEPATH}/emerson_${1}/status_report.html
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
	echo -e "\n\t<!-- FIRST STABLE PART OF BODY SECTION -->\n\t<body>\n\t\t<img height=90 alt=\"uoi-cse.png\" src=\"../photos/uoi-cse.png\">\n\t\t<img class=\"banner\" height=90 alt=\"cse_banner_logo.jpg\" src=\"../photos/cse_banner_logo.jpg\">\n\t\t<br><br>\n\t\t<h4><a href=\"../emerson_main_page.html\">Main Page</a> &nbsp;|&nbsp; <a href=\"./status_report.html\">Emerson #${1} Status Report</a> &nbsp;|&nbsp; <a href=\"./measurement_report.html\">Emerson #${1} Measurement Report</a><br> <a href=\"./graph_report.html\">Emerson #${1} Graph Report</a>  &nbsp;|&nbsp; <a href=\"../emerson_${OTHER_EMERSON}/status_report.html\">Emerson #${OTHER_EMERSON}</a></h4><br>\n\t\t<h2><u>Emerson #${1} Status Report</u></h2><br>" >> ${WEBSITEPATH}/emerson_${1}/status_report.html
}


# Appends the first stable part of the <table> section to the output .html file.
# (Parameter: $1 -> Emerson unit No.)
append_table_stable_0 () {
	echo -e "\n\t\t<!-- FIRST STABLE PART OF TABLE SECTION -->\n\t\t<!-- MAIN CONTENT -->\n\t\t<table style=\"width:80%\">\n\t\t\t<tr>\n\t\t\t\t<th>Label</th>\n\t\t\t\t<th>Value</th>\n\t\t\t\t<th>Unit</th>\n\t\t\t</tr>" >> ${WEBSITEPATH}/emerson_${1}/status_report.html
}


# Creates an array that contains the content of each <Label> element.
# (Parameter: $1 -> Emerson unit No.)
init_labels () {
	# ${LABELS} holds a string that contains all the <Label> elements of the curr_status.txt
	# file, with the tags included (e.g. "<Label>Unit Status</Label>"), each one on a
	# different line. Moreover, the white spaces in the text between the <Label> tags
	# are replaced by underscores "_"
        LABELS=$(grep -i Label ${WEBSITEPATH}/emerson_${1}/data/curr_status.txt | tr " " "_")
        unset LABELS_ARRAY
	# The value of ${INDEX} is initialized to zero '0'
        INDEX=0
	# For every line in ${LABELS}
        for x in ${LABELS}
        do
		# The <Label> tag is deleted and the new string is saved in ${L}
                L=$(echo ${x#<Label>})
		# The </Label> tag is deleted too
                L=$(echo ${L%<*})
		# The underscores "_" are replaced by white spaces
                L=$(echo ${L} | tr "_" " ")
		# The value of ${L} is saved in the ${INDEX}-th element of the ${LABELS_ARRAY}
                LABELS_ARRAY[${INDEX}]=${L}
		# ${INDEX} is incremented by one '1'
                INDEX=$((INDEX+1))
        done
}


# Creates an array that contains the content of each <Value> element.
# (Parameter: $1 -> Emerson unit No.)
init_values () {
        # ${VALUES} holds a string that contains all the <Value> elements of the curr_status.txt
        # file, with the tags included (e.g. "<Value>Warning On</Value>"), each one on a
        # different line. Moreover, the white spaces in the text between the <Value> tags
        # are replaced by underscores "_"
	VALUES=$(grep -i Value ${WEBSITEPATH}/emerson_${1}/data/curr_status.txt | tr " " "_")
        unset VALUES_ARRAY
	# The value of ${INDEX} is initialized to zero '0'
        INDEX=0
	# For every line in ${VALUES}
        for x in ${VALUES}
        do
		# The <Value> tag is deleted (including all of the contents inside '<' and '>')
		# and the new string is saved in ${V}
                V=$(echo ${x#<*>})
		# The </Value> tag is deleted too
                V=$(echo ${V%<*})
		# The underscores "_" are replaced by white spaces
                V=$(echo ${V} | tr "_" " ")
		# The value of ${V} is saved in the ${INDEX}-th element of the ${VALUES_ARRAY}
                VALUES_ARRAY[${INDEX}]=${V}
		# ${INDEX} is incremented by one '1'
                INDEX=$((INDEX+1))
        done
	if [ -n "${VALUES_ARRAY[1]}" ] 
	then
		# Stores the value of "Return Air Temperature" into "curr_temperature_${1}.rrd"
		rrdtool update ${WEBSITEPATH}/emerson_${1}/rrdb/curr_temperature_${1}.rrd ${DATESTAMP}:${VALUES_ARRAY[1]}
		# Stores the value of "Return Air Humidity" into "curr_humidity_${1}.rrd"
		rrdtool update ${WEBSITEPATH}/emerson_${1}/rrdb/curr_humidity_${1}.rrd ${DATESTAMP}:${VALUES_ARRAY[2]}
		FEED_VALUE=$( printf "%.0f" ${VALUES_ARRAY[1]} )
		MINUTES=$(date "+%M")
		if [ "${FEED_VALUE}" -gt "27" ] || [ "${MINUTES}" == "00" ]
		then
			${WEBSITEPATH}/scripts/generate_rss_feed.sh ${1} ${VALUES_ARRAY[1]} unit
		fi
	fi
}


# Creates an array that contains the content of each <Unit> element.
# (Parameter: $1 -> Emerson unit No.)
init_units () {
	# ${UNITS} holds a string that contains all the <Unit> elements of the curr_status.txt
        # file, with the tags included (e.g. "<Unit></Unit>", "<Unit>%rH</Unit>" etc.),
	# each one on a different line. Moreover, the white spaces in the text between
	# the <Unit> tags are replaced by underscores "_"
	UNITS=$(grep -i Unit ${WEBSITEPATH}/emerson_${1}/data/curr_status.txt | grep -v Status | grep -v On | tr " " "_")
        unset UNITS_ARRAY
	# The value of ${INDEX} is initialized to zero '0'
        INDEX=0
	# For every line in ${UNITS}
        for x in ${UNITS}
        do
		# The <Unit> tag is deleted and the new string is saved in ${U}
                U=$(echo ${x#<*>})
		# The </Unit> tag is deleted too
                U=$(echo ${U%<*})
		# The underscores "_" are replaced by white spaces
                U=$(echo ${U} | tr "_" " ")
		# If ${U} is null
                if [ -z "${U}" ]
                then
			# The value " - " is saved in the ${INDEX}-th element of the ${UNITS_ARRAY}
                        UNITS_ARRAY[${INDEX}]=" - "
                else
			# If NOT, the value of ${U} is saved in the ${INDEX}-th element of the ${UNITS_ARRAY}
                        UNITS_ARRAY[${INDEX}]=${U}
                fi
		# ${INDEX} is incremented by one '1'
                INDEX=$((INDEX+1))
        done
}


# Appends the variable part of the <table> section to the output .html file.
# (Parameter: $1 -> Emerson unit No.)
append_variable_section () {
	# ${ARRAY_LEN} holds the length of ${LABELS_ARRAY}
        ARRAY_LEN=${#LABELS_ARRAY[@]}
	# ${STRING} is initialized
        STRING="\n\t\t\t<!-- VARIABLE PART OF TABLE SECTION -->\n"
	# ${INDEX} is initialized to zero '0'
        INDEX=0
	# while ${INDEX} is less than ${ARRAY_LEN} reduced by one '1'
        while [ "${INDEX}" -lt "$((ARRAY_LEN-1))" ]
        do
		# One row (<tr></tr>) of the HTML array is added at a time in ${STRING}
                STRING="${STRING}\t\t\t<tr>\n\t\t\t\t<td>${LABELS_ARRAY[${INDEX}]}</td>\n\t\t\t\t<td>${VALUES_ARRAY[${INDEX}]}</td>\n\t\t\t\t<td>${UNITS_ARRAY[${INDEX}]}</td>\n\t\t\t</tr>\n"
		# ${INDEX} is incremented by one '1'
                INDEX=$((INDEX+1))
        done
	# Adding the final line will not require "\n" at the end, so a different string is added in ${STRING}
        STRING="${STRING}\t\t\t<tr>\n\t\t\t\t<td>${LABELS_ARRAY[${INDEX}]}</td>\n\t\t\t\t<td>${VALUES_ARRAY[${INDEX}]}</td>\n\t\t\t\t<td>${UNITS_ARRAY[${INDEX}]}</td>\n\t\t\t</tr>"
	# Finally, ${STRING} is appended to the output.html
        echo -e "${STRING}" >> ${WEBSITEPATH}/emerson_${1}/status_report.html
}


# Appends the last stable part of the <table> section to the output .html file.
# (Parameter: $1 -> Emerson unit No.)
append_table_stable_1 () {
	echo -e "\n\t\t<!-- LAST STABLE PART OF TABLE SECTION -->\n\t\t</table>\n\t\t<!-- END OF MAIN CONTENT -->\n\t\t" >> ${WEBSITEPATH}/emerson_${1}/status_report.html
}


# Appends the last stable part of the <body> section to the output .html file.
# (Parameter: $1 -> Emerson unit No.)
append_body_stable_1 () {
	echo -e "\t\t<!-- LAST STABLE PART OF BODY SECTION -->\n\t\t<br>\n\t\t<h4><i>A project by ~gzachos</i></h4>\n\t\t<h4>&copy; Systems Support Group 2015. All rights reserved.</h4>\n\t\t<h4>Computer Science and Engineering Department - University of Ioannina</h4>\n\t</body>\n</html>" >> ${WEBSITEPATH}/emerson_${1}/status_report.html
}


# Calls all functions that append data to the output .html file.
# (Parameter: $1 -> Emerson unit No.)
create_status_report () {
	append_head ${1}
	append_body_stable_0 ${1}
	append_table_stable_0 ${1}
	append_variable_section ${1}
	append_table_stable_1 ${1}
	append_body_stable_1 ${1}
}


# Calls the functions that create the status report .html file.
# (Parameter: $1 -> Emerson unit No.)
main () {
        WEBSITEPATH="/var/www/html"
        DATESTAMP=$(date +%s)
        init_labels ${1}
        init_values ${1}
        init_units ${1}
        create_status_report ${1}
}


# Calling main.
# (Parameter: $1 -> Emerson unit No.)
main ${1}
