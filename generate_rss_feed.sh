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


# Creates ${TRGFILE}.
function create_rss_index_html () {
	echo -e "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<rss version=\"2.0\">\n\t<channel>\n\t\t<title>Aeolus Logger RSS Feed</title>\n\t\t<link>http://aeolus.cs.uoi.gr</link>\n\t\t<description>Department of Computer Science &#38; Engineering, University of Ioannina</description>\n\t\t<language>en-US</language>\n\t\t<copyright>(c) 2015</copyright>\n\t</channel>\n</rss>" > ${TRGFILE}
}


# Feeds the RSS feed with updates. If ${TRGFILE} does not exist,
# it is created before feed is updated. Moreover, feed updates
# will not exceed the amount of 24.
# (Parameters: 	$1 -> Emerson unit No.,
#		$2 -> Degrees Celsius,
#		$3 -> {System, Unit})
function feed_updates () {
	FILE_LEN=$(cat ${TRGFILE} | wc -l)
	REMAINING_LINES=$((FILE_LEN-8))
	cat ${TRGFILE} | head -8 > ${TMPFILE}
        echo -e "\t\t<item>" >> ${TMPFILE}
        echo -e "\t\t\t<title>${2} deg. Celsius @Emerson #${1}</title>" >> ${TMPFILE}
        echo -e "\t\t\t<link>http://aeolus.cs.uoi.gr/emerson_${1}/measurement_report_${1}.html</link>" >> ${TMPFILE}
        echo -e "\t\t\t<description>${3} temperature @Emerson #${1} has reached ${2} degrees Celsius!</description>" >> ${TMPFILE}
        echo -e "\t\t\t<pubDate>${DATE}</pubDate>" >> ${TMPFILE}
        echo -e "\t\t</item>" >> ${TMPFILE}
	if [ "${FILE_LEN}" -eq "154" ]
	then
		cat ${TRGFILE} | tail -${REMAINING_LINES} | head -138 >> ${TMPFILE}
		cat ${TRGFILE} | tail -2 >> ${TMPFILE}
	else
		cat ${TRGFILE} | tail -${REMAINING_LINES} >> ${TMPFILE}
	fi
}


# Calls the appropriate functions to update RSS feed.
# (Parameters: 	$1 -> Emerson unit No.,
#		$2 -> Degrees Celsius,
#		$3 -> {sys, unit})
function main() {
        DATE=$(date '+%a, %d %b %Y %H:%M:%S %z')
        TRGFILE="/var/www/html/feed/index.html"
        TMPFILE="/tmp/rssfeed"

	if [ ! -s "${TRGFILE}" ]
	then
		create_rss_index_html
	fi

	if [ "${3}" == "sys" ]
	then
		feed_updates ${1} ${2} System
	else
		feed_updates ${1} ${2} Unit
	fi
	cp -f ${TMPFILE} ${TRGFILE}
#       echo "${DATE} ${1} ${2} ${3}" >> /var/www/html/feed/feedlog.txt
}


# Calling main.
# (Parameters: 	$1 -> Emerson unit No.,
#		$2 -> Degrees Celsius,
#		$3 -> {sys, unit})
main ${1} ${2} ${3}
