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


# Creates ${DST_FILE}.
function create_rss_index_html () {
	echo -e "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<rss version=\"2.0\">\n\t<channel>\n\t\t<title>Aeolus Logger v2 RSS Feed</title>\n\t\t<link>http://aeolus.cs.uoi.gr</link>\n\t\t<description>Department of Computer Science &#38; Engineering, University of Ioannina</description>\n\t\t<language>en-US</language>\n\t\t<copyright>(c) 2015</copyright>\n\t</channel>\n</rss>" > ${TMP_FILE}
}


# Feeds the RSS feed with updates. If ${DST_FILE} does not exist,
# it is created before feed is updated. Moreover, feed updates
# will not exceed the amount of 24.
# (Parameters: 	$1 -> Emerson unit No.,
#		$2 -> Degrees Celsius,
#		$3 -> {System, Unit})
function feed_updates () {
	FILE_LEN=$(cat ${DST_FILE} | wc -l)
	REMAINING_LINES=$((FILE_LEN-8))
	cat ${DST_FILE} | head -8 > ${TMP_FILE}
	((EC += $?))
        echo -e "\t\t<item>	\
        	\n\t\t\t<title>${2} deg. Celsius @Emerson #${1}</title>	\
        	\n\t\t\t<link>http://aeolus.cs.uoi.gr/emerson_${1}/measurement_report_${1}.html</link>	\
        	\n\t\t\t<description>${3} temperature @Emerson #${1} has reached ${2} degrees Celsius!</description>	\
        	\n\t\t\t<pubDate>${DATE}</pubDate>	\
        	\n\t\t</item>" >> ${TMP_FILE}
	((EC += $?))
	if [ "${FILE_LEN}" -eq "154" ]
	then
		cat ${DST_FILE} | tail -${REMAINING_LINES} | head -138 >> ${TMP_FILE}
		((EC += $?))
		cat ${DST_FILE} | tail -2 >> ${TMP_FILE}
		((EC += $?))
	else
		cat ${DST_FILE} | tail -${REMAINING_LINES} >> ${TMP_FILE}
		((EC += $?))
	fi
}


# Calls the appropriate functions to update RSS feed.
# (Parameters: 	$1 -> Emerson unit No.,
#		$2 -> Degrees Celsius,
#		$3 -> {sys, unit})
function main() {
        WEBSITEPATH="/var/www/html"
        GLB_LOGFILE="/var/log/aeolus/aeolus.log"
        ERR_LOGFILE="/var/log/aeolus/error.log"         # not used
        STD_LOGFILE="/var/log/aeolus/stdout.log"        # not used
        TMP_FILE=$(mktemp /tmp/aeolusrss.XXXXXX)
        DST_FILE=${WEBSITEPATH}/feed/index.html
	EC=0
        DATE=$(date '+%a, %d %b %Y %H:%M:%S %z')
	if [ ! -e "${DST_FILE}" ] || [ ! -s "${DST_FILE}" ]
	then
		create_rss_index_html
		if [ "${?}" -eq "0" ]
		then
			cp -f ${TMP_FILE} ${DST_FILE}
			if [ "${?}" -eq "0" ]
			then
				echo "[ $(date -R) ] RSS feed was successfully created" >> ${GLB_LOGFILE}
			else
				echo "[ $(date -R) ] RSS feed was NOT created [FAIL]" >> ${GLB_LOGFILE}
				rm ${TMP_FILE}
				exit 1
			fi
			rm ${TMP_FILE}
		fi
	fi
	if [ -z "${1}" ] && [ -z "${2}" ] && [ -z "${3}" ]
	then
		exit 0
	fi
        TMP_FILE=$(mktemp /tmp/aeolusrss.XXXXXX)
	if [ "${3}" == "sys" ]
	then
		feed_updates ${1} ${2} System
	else
		feed_updates ${1} ${2} Unit
	fi
	if [ "${EC}" -eq "0" ]
	then
		cp -f ${TMP_FILE} ${DST_FILE}
		if [ "${?}" -eq "0" ]
		then
			echo "[ $(date -R) ] RSS feed was successfully updated" >> ${GLB_LOGFILE}
		else
			echo "[ $(date -R) ] RSS feed was NOT successfully updated [FAIL]" >> ${GLB_LOGFILE}
			rm ${TMP_FILE}
			exit 2
		fi
	fi
	rm ${TMP_FILE}
#       echo "${DATE} ${1} ${2} ${3}" >> /var/www/html/feed/feedlog.txt
}


# Calling main.
# (Parameters: 	$1 -> Emerson unit No.,
#		$2 -> Degrees Celsius,
#		$3 -> {sys, unit})
main ${1} ${2} ${3}
