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


create_temp_graph () {

	rrdtool graph ${WEBSITEPATH}/emerson_${3}/rrdb/graphs/${4}/${1}/${4}_1hour.png \
		--start -1h \
		--end ${GRAPHEND} \
		--title "1 Hour Log" \
		--vertical-label "Temperature ºC" \
		--width 600 \
		--height 200 \
		DEF:${4}=${WEBSITEPATH}/emerson_${3}/rrdb/${1}_${2}_${3}.rrd:${1}_${4}_${3}:AVERAGE \
		LINE2:${4}#FF0000 \
                HRULE:27#660066 \
                HRULE:24#00FF00 \
                HRULE:23#BDBDB3 \
                HRULE:22#BDBDB3 \
                HRULE:21#BDBDB3 \
                AREA:${4}#FF0000:"${1} ${2}"


		
	rrdtool graph ${WEBSITEPATH}/emerson_${3}/rrdb/graphs/${4}/${1}/${4}_12hour.png \
		--start -12h \
		--end ${GRAPHEND} \
		--title "12 Hour Log" \
		--vertical-label "Temperature ºC" \
		--width 600 \
		--height 200 \
		DEF:${4}=${WEBSITEPATH}/emerson_${3}/rrdb/${1}_${2}_${3}.rrd:${1}_${4}_${3}:AVERAGE \
		LINE2:${4}#FF0000 \
                HRULE:27#660066 \
                HRULE:24#00FF00 \
                HRULE:23#BDBDB3 \
                HRULE:22#BDBDB3 \
                HRULE:21#BDBDB3 \
                AREA:${4}#FF0000:"${1} ${2}"


	rrdtool graph ${WEBSITEPATH}/emerson_${3}/rrdb/graphs/${4}/${1}/${4}_1day.png \
		--start -1d \
		--end ${GRAPHEND} \
		--title "24 Hour Log" \
		--vertical-label "Temperature ºC" \
		--width 600 \
		--height 200 \
		DEF:${4}=${WEBSITEPATH}/emerson_${3}/rrdb/${1}_${2}_${3}.rrd:${1}_${4}_${3}:AVERAGE \
		LINE2:${4}#FF0000 \
                HRULE:27#660066 \
                HRULE:24#00FF00 \
                HRULE:23#BDBDB3 \
                HRULE:22#BDBDB3 \
                HRULE:21#BDBDB3 \
                AREA:${4}#FF0000:"${1} ${2}"


	rrdtool graph ${WEBSITEPATH}/emerson_${3}/rrdb/graphs/${4}/${1}/${4}_1week.png \
		--start -1w \
		--end ${GRAPHEND} \
		--title "1 Week Log" \
		--vertical-label "Temperature ºC" \
		--width 600 \
		--height 200 \
		DEF:${4}=${WEBSITEPATH}/emerson_${3}/rrdb/${1}_${2}_${3}.rrd:${1}_${4}_${3}:AVERAGE \
		LINE2:${4}#FF0000 \
                HRULE:27#660066 \
                HRULE:24#00FF00 \
                HRULE:23#BDBDB3 \
                HRULE:22#BDBDB3 \
                HRULE:21#BDBDB3 \
                AREA:${4}#FF0000:"${1} ${2}"


	rrdtool graph ${WEBSITEPATH}/emerson_${3}/rrdb/graphs/${4}/${1}/${4}_4week.png \
		--start -4w \
		--end ${GRAPHEND} \
		--title "1 Month Log" \
		--vertical-label "Temperature ºC" \
		--width 600 \
		--height 200 \
		DEF:${4}=${WEBSITEPATH}/emerson_${3}/rrdb/${1}_${2}_${3}.rrd:${1}_${4}_${3}:AVERAGE \
		LINE2:${4}#FF0000 \
                HRULE:27#660066 \
                HRULE:24#00FF00 \
                HRULE:23#BDBDB3 \
                HRULE:22#BDBDB3 \
                HRULE:21#BDBDB3 \
                AREA:${4}#FF0000:"${1} ${2}"


	rrdtool graph ${WEBSITEPATH}/emerson_${3}/rrdb/graphs/${4}/${1}/${4}_8week.png \
		--start -8w \
		--end ${GRAPHEND} \
		--title "2 Month Log" \
		--vertical-label "Temperature ºC" \
		--width 600 \
		--height 200 \
		DEF:${4}=${WEBSITEPATH}/emerson_${3}/rrdb/${1}_${2}_${3}.rrd:${1}_${4}_${3}:AVERAGE \
		LINE2:${4}#FF0000 \
                HRULE:27#660066 \
                HRULE:24#00FF00 \
                HRULE:23#BDBDB3 \
                HRULE:22#BDBDB3 \
                HRULE:21#BDBDB3 \
                AREA:${4}#FF0000:"${1} ${2}"


	rrdtool graph ${WEBSITEPATH}/emerson_${3}/rrdb/graphs/${4}/${1}/${4}_24week.png \
		--start -24w \
		--end ${GRAPHEND} \
		--title "6 Month Log" \
		--vertical-label "Temperature ºC" \
		--width 600 \
		--height 200 \
		DEF:${4}=${WEBSITEPATH}/emerson_${3}/rrdb/${1}_${2}_${3}.rrd:${1}_${4}_${3}:AVERAGE \
		LINE2:${4}#FF0000 \
                HRULE:27#660066 \
                HRULE:24#00FF00 \
                HRULE:23#BDBDB3 \
                HRULE:22#BDBDB3 \
                HRULE:21#BDBDB3 \
                AREA:${4}#FF0000:"${1} ${2}"


	rrdtool graph ${WEBSITEPATH}/emerson_${3}/rrdb/graphs/${4}/${1}/${4}_1year.png \
		--start -1y \
		--end ${GRAPHEND} \
		--title "1 Year Log" \
		--vertical-label "Temperature ºC" \
		--width 600 \
		--height 200 \
		DEF:${4}=${WEBSITEPATH}/emerson_${3}/rrdb/${1}_${2}_${3}.rrd:${1}_${4}_${3}:AVERAGE \
		LINE2:${4}#FF0000 \
                HRULE:27#660066 \
                HRULE:24#00FF00 \
                HRULE:23#BDBDB3 \
                HRULE:22#BDBDB3 \
                HRULE:21#BDBDB3 \
                AREA:${4}#FF0000:"${1} ${2}"
}


create_hum_graph () {

	rrdtool graph ${WEBSITEPATH}/emerson_${3}/rrdb/graphs/${4}/${1}/${4}_1hour.png \
		--start -1h \
		--end ${GRAPHEND} \
		--title "1 Hour Log" \
		--vertical-label "Humidity %rH" \
		--width 600 \
		--height 200 \
		DEF:${4}=${WEBSITEPATH}/emerson_${3}/rrdb/${1}_${2}_${3}.rrd:${1}_${4}_${3}:AVERAGE \
		LINE2:${4}#FF0000 \
		HRULE:50#BDBDB3 \
                HRULE:49#BDBDB3 \
                HRULE:48#BDBDB3 \
                HRULE:47#BDBDB3 \
                HRULE:46#BDBDB3 \
                HRULE:45#BDBDB3 \
                HRULE:44#BDBDB3 \
                HRULE:43#BDBDB3 \
                HRULE:42#BDBDB3 \
                HRULE:41#BDBDB3 \
                HRULE:40#BDBDB3 \
                HRULE:39#BDBDB3 \
                HRULE:38#BDBDB3 \
                HRULE:37#BDBDB3 \
                HRULE:36#BDBDB3 \
                HRULE:35#BDBDB3 \
                HRULE:34#BDBDB3 \
                HRULE:33#BDBDB3 \
                HRULE:32#BDBDB3 \
                HRULE:31#BDBDB3 \
                HRULE:30#BDBDB3 \
                AREA:${4}#FF0000:"${1} ${2}"


		
	rrdtool graph ${WEBSITEPATH}/emerson_${3}/rrdb/graphs/${4}/${1}/${4}_12hour.png \
		--start -12h \
		--end ${GRAPHEND} \
		--title "12 Hour Log" \
		--vertical-label "Humidity %rH" \
		--width 600 \
		--height 200 \
		DEF:${4}=${WEBSITEPATH}/emerson_${3}/rrdb/${1}_${2}_${3}.rrd:${1}_${4}_${3}:AVERAGE \
		LINE2:${4}#FF0000 \
		HRULE:50#BDBDB3 \
                HRULE:49#BDBDB3 \
                HRULE:48#BDBDB3 \
                HRULE:47#BDBDB3 \
                HRULE:46#BDBDB3 \
                HRULE:45#BDBDB3 \
                HRULE:44#BDBDB3 \
                HRULE:43#BDBDB3 \
                HRULE:42#BDBDB3 \
                HRULE:41#BDBDB3 \
                HRULE:40#BDBDB3 \
                HRULE:39#BDBDB3 \
                HRULE:38#BDBDB3 \
                HRULE:37#BDBDB3 \
                HRULE:36#BDBDB3 \
                HRULE:35#BDBDB3 \
                HRULE:34#BDBDB3 \
                HRULE:33#BDBDB3 \
                HRULE:32#BDBDB3 \
                HRULE:31#BDBDB3 \
                HRULE:30#BDBDB3 \
                AREA:${4}#FF0000:"${1} ${2}"


	rrdtool graph ${WEBSITEPATH}/emerson_${3}/rrdb/graphs/${4}/${1}/${4}_1day.png \
		--start -1d \
		--end ${GRAPHEND} \
		--title "24 Hour Log" \
		--vertical-label "Humidity %rH" \
		--width 600 \
		--height 200 \
		DEF:${4}=${WEBSITEPATH}/emerson_${3}/rrdb/${1}_${2}_${3}.rrd:${1}_${4}_${3}:AVERAGE \
		LINE2:${4}#FF0000 \
		HRULE:50#BDBDB3 \
                HRULE:49#BDBDB3 \
                HRULE:48#BDBDB3 \
                HRULE:47#BDBDB3 \
                HRULE:46#BDBDB3 \
                HRULE:45#BDBDB3 \
                HRULE:44#BDBDB3 \
                HRULE:43#BDBDB3 \
                HRULE:42#BDBDB3 \
                HRULE:41#BDBDB3 \
                HRULE:40#BDBDB3 \
                HRULE:39#BDBDB3 \
                HRULE:38#BDBDB3 \
                HRULE:37#BDBDB3 \
                HRULE:36#BDBDB3 \
                HRULE:35#BDBDB3 \
                HRULE:34#BDBDB3 \
                HRULE:33#BDBDB3 \
                HRULE:32#BDBDB3 \
                HRULE:31#BDBDB3 \
                HRULE:30#BDBDB3 \
                AREA:${4}#FF0000:"${1} ${2}"


	rrdtool graph ${WEBSITEPATH}/emerson_${3}/rrdb/graphs/${4}/${1}/${4}_1week.png \
		--start -1w \
		--end ${GRAPHEND} \
		--title "1 Week Log" \
		--vertical-label "Humidity %rH" \
		--width 600 \
		--height 200 \
		DEF:${4}=${WEBSITEPATH}/emerson_${3}/rrdb/${1}_${2}_${3}.rrd:${1}_${4}_${3}:AVERAGE \
		LINE2:${4}#FF0000 \
		HRULE:50#BDBDB3 \
                HRULE:49#BDBDB3 \
                HRULE:48#BDBDB3 \
                HRULE:47#BDBDB3 \
                HRULE:46#BDBDB3 \
                HRULE:45#BDBDB3 \
                HRULE:44#BDBDB3 \
                HRULE:43#BDBDB3 \
                HRULE:42#BDBDB3 \
                HRULE:41#BDBDB3 \
                HRULE:40#BDBDB3 \
                HRULE:39#BDBDB3 \
                HRULE:38#BDBDB3 \
                HRULE:37#BDBDB3 \
                HRULE:36#BDBDB3 \
                HRULE:35#BDBDB3 \
                HRULE:34#BDBDB3 \
                HRULE:33#BDBDB3 \
                HRULE:32#BDBDB3 \
                HRULE:31#BDBDB3 \
                HRULE:30#BDBDB3 \
                AREA:${4}#FF0000:"${1} ${2}"


	rrdtool graph ${WEBSITEPATH}/emerson_${3}/rrdb/graphs/${4}/${1}/${4}_4week.png \
		--start -4w \
		--end ${GRAPHEND} \
		--title "1 Month Log" \
		--vertical-label "Humidity %rH" \
		--width 600 \
		--height 200 \
		DEF:${4}=${WEBSITEPATH}/emerson_${3}/rrdb/${1}_${2}_${3}.rrd:${1}_${4}_${3}:AVERAGE \
		LINE2:${4}#FF0000 \
		HRULE:50#BDBDB3 \
                HRULE:49#BDBDB3 \
                HRULE:48#BDBDB3 \
                HRULE:47#BDBDB3 \
                HRULE:46#BDBDB3 \
                HRULE:45#BDBDB3 \
                HRULE:44#BDBDB3 \
                HRULE:43#BDBDB3 \
                HRULE:42#BDBDB3 \
                HRULE:41#BDBDB3 \
                HRULE:40#BDBDB3 \
                HRULE:39#BDBDB3 \
                HRULE:38#BDBDB3 \
                HRULE:37#BDBDB3 \
                HRULE:36#BDBDB3 \
                HRULE:35#BDBDB3 \
                HRULE:34#BDBDB3 \
                HRULE:33#BDBDB3 \
                HRULE:32#BDBDB3 \
                HRULE:31#BDBDB3 \
                HRULE:30#BDBDB3 \
                AREA:${4}#FF0000:"${1} ${2}"


	rrdtool graph ${WEBSITEPATH}/emerson_${3}/rrdb/graphs/${4}/${1}/${4}_8week.png \
		--start -8w \
		--end ${GRAPHEND} \
		--title "2 Month Log" \
		--vertical-label "Humidity %rH" \
		--width 600 \
		--height 200 \
		DEF:${4}=${WEBSITEPATH}/emerson_${3}/rrdb/${1}_${2}_${3}.rrd:${1}_${4}_${3}:AVERAGE \
		LINE2:${4}#FF0000 \
		HRULE:50#BDBDB3 \
                HRULE:49#BDBDB3 \
                HRULE:48#BDBDB3 \
                HRULE:47#BDBDB3 \
                HRULE:46#BDBDB3 \
                HRULE:45#BDBDB3 \
                HRULE:44#BDBDB3 \
                HRULE:43#BDBDB3 \
                HRULE:42#BDBDB3 \
                HRULE:41#BDBDB3 \
                HRULE:40#BDBDB3 \
                HRULE:39#BDBDB3 \
                HRULE:38#BDBDB3 \
                HRULE:37#BDBDB3 \
                HRULE:36#BDBDB3 \
                HRULE:35#BDBDB3 \
                HRULE:34#BDBDB3 \
                HRULE:33#BDBDB3 \
                HRULE:32#BDBDB3 \
                HRULE:31#BDBDB3 \
                HRULE:30#BDBDB3 \
                AREA:${4}#FF0000:"${1} ${2}"


	rrdtool graph ${WEBSITEPATH}/emerson_${3}/rrdb/graphs/${4}/${1}/${4}_24week.png \
		--start -24w \
		--end ${GRAPHEND} \
		--title "6 Month Log" \
		--vertical-label "Humidity %rH" \
		--width 600 \
		--height 200 \
		DEF:${4}=${WEBSITEPATH}/emerson_${3}/rrdb/${1}_${2}_${3}.rrd:${1}_${4}_${3}:AVERAGE \
		LINE2:${4}#FF0000 \
		HRULE:50#BDBDB3 \
                HRULE:49#BDBDB3 \
                HRULE:48#BDBDB3 \
                HRULE:47#BDBDB3 \
                HRULE:46#BDBDB3 \
                HRULE:45#BDBDB3 \
                HRULE:44#BDBDB3 \
                HRULE:43#BDBDB3 \
                HRULE:42#BDBDB3 \
                HRULE:41#BDBDB3 \
                HRULE:40#BDBDB3 \
                HRULE:39#BDBDB3 \
                HRULE:38#BDBDB3 \
                HRULE:37#BDBDB3 \
                HRULE:36#BDBDB3 \
                HRULE:35#BDBDB3 \
                HRULE:34#BDBDB3 \
                HRULE:33#BDBDB3 \
                HRULE:32#BDBDB3 \
                HRULE:31#BDBDB3 \
                HRULE:30#BDBDB3 \
                AREA:${4}#FF0000:"${1} ${2}"


	rrdtool graph ${WEBSITEPATH}/emerson_${3}/rrdb/graphs/${4}/${1}/${4}_1year.png \
		--start -1y \
		--end ${GRAPHEND} \
		--title "1 Year Log" \
		--vertical-label "Humidity %rH" \
		--width 600 \
		--height 200 \
		DEF:${4}=${WEBSITEPATH}/emerson_${3}/rrdb/${1}_${2}_${3}.rrd:${1}_${4}_${3}:AVERAGE \
		LINE2:${4}#FF0000 \
		HRULE:50#BDBDB3 \
                HRULE:49#BDBDB3 \
                HRULE:48#BDBDB3 \
                HRULE:47#BDBDB3 \
                HRULE:46#BDBDB3 \
                HRULE:45#BDBDB3 \
                HRULE:44#BDBDB3 \
                HRULE:43#BDBDB3 \
                HRULE:42#BDBDB3 \
                HRULE:41#BDBDB3 \
                HRULE:40#BDBDB3 \
                HRULE:39#BDBDB3 \
                HRULE:38#BDBDB3 \
                HRULE:37#BDBDB3 \
                HRULE:36#BDBDB3 \
                HRULE:35#BDBDB3 \
                HRULE:34#BDBDB3 \
                HRULE:33#BDBDB3 \
                HRULE:32#BDBDB3 \
                HRULE:31#BDBDB3 \
                HRULE:30#BDBDB3 \
                AREA:${4}#FF0000:"${1} ${2}"
}


create_emerson_graph () {
	create_temp_graph curr temperature ${1} temp
	create_hum_graph curr humidity ${1} hum
#	create_temp_graph unit temperature ${1} temp
#	create_hum_graph unit humidity ${1} hum
#	create_temp_graph sys temperature ${1} temp
#	create_hum_graph sys humidity ${1} hum
}


main () {
	WEBSITEPATH="/var/www/html"
	DATESTAMP=$(date +%s)
	GRAPHEND=$((DATESTAMP-60))
	create_emerson_graph 3
	create_emerson_graph 4
}


main
