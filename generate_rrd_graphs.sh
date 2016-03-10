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


# Creates temperature graphs.
# (Parameters: 	$1 -> {curr, unit, sys}, 
#		$2 -> {temperature, humidity}, 
#		$3 -> Emerson unit No.,
#		$4 -> {temp, hum},
#		$5 -> {Current, Unit, System})
create_temp_graph () {
	EC=0
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
                AREA:${4}#FF0000:"${5} ${2}"
	((EC += $?))

		
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
                AREA:${4}#FF0000:"${5} ${2}"
	((EC += $?))


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
                AREA:${4}#FF0000:"${5} ${2}"
	((EC += $?))


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
                AREA:${4}#FF0000:"${5} ${2}"
	((EC += $?))


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
                AREA:${4}#FF0000:"${5} ${2}"
	((EC += $?))


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
                AREA:${4}#FF0000:"${5} ${2}"
	((EC += $?))


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
                AREA:${4}#FF0000:"${5} ${2}"
	((EC += $?))


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
                AREA:${4}#FF0000:"${5} ${2}"
	((EC += $?))
	
	if [ "${EC}" -eq "0" ]
	then
		echo "[ $(date -R) ] Temperature (${1}) graphs of Emerson unit #${3} were successfully created"  >> ${GLB_LOGFILE}
	else
		echo "[ $(date -R) ] Temperature (${1}) graph(s) of Emerson unit #${3} were NOT successfully created [FAIL]"  >> ${GLB_LOGFILE}
	fi
	((GEC += EC))
}


# Creates humidity graphs.
# (Parameters: 	$1 -> {curr, unit, sys}, 
#		$2 -> {temperature, humidity}, 
#		$3 -> Emerson unit No.,
#		$4 -> {temp, hum},
#		$5 -> {Current, Unit, System})
create_hum_graph () {
	EC=0
	rrdtool graph ${WEBSITEPATH}/emerson_${3}/rrdb/graphs/${4}/${1}/${4}_1hour.png \
		--start -1h \
		--end ${GRAPHEND} \
		--title "1 Hour Log" \
		--vertical-label "Humidity %rH" \
		--width 600 \
		--height 200 \
		DEF:${4}=${WEBSITEPATH}/emerson_${3}/rrdb/${1}_${2}_${3}.rrd:${1}_${4}_${3}:AVERAGE \
		LINE2:${4}#FF0000 \
                HRULE:100#BDBDB3 \
                HRULE:95#BDBDB3 \
                HRULE:90#BDBDB3 \
                HRULE:85#BDBDB3 \
                HRULE:80#BDBDB3 \
                HRULE:75#BDBDB3 \
                HRULE:70#BDBDB3 \
                HRULE:65#BDBDB3 \
                HRULE:60#BDBDB3 \
                HRULE:55#BDBDB3 \
                HRULE:50#BDBDB3 \
                HRULE:45#BDBDB3 \
                HRULE:40#BDBDB3 \
                HRULE:35#BDBDB3 \
                HRULE:30#BDBDB3 \
                AREA:${4}#FF0000:"${5} ${2}"
	((EC += $?))

		
	rrdtool graph ${WEBSITEPATH}/emerson_${3}/rrdb/graphs/${4}/${1}/${4}_12hour.png \
		--start -12h \
		--end ${GRAPHEND} \
		--title "12 Hour Log" \
		--vertical-label "Humidity %rH" \
		--width 600 \
		--height 200 \
		DEF:${4}=${WEBSITEPATH}/emerson_${3}/rrdb/${1}_${2}_${3}.rrd:${1}_${4}_${3}:AVERAGE \
		LINE2:${4}#FF0000 \
                HRULE:100#BDBDB3 \
                HRULE:95#BDBDB3 \
                HRULE:90#BDBDB3 \
                HRULE:85#BDBDB3 \
                HRULE:80#BDBDB3 \
                HRULE:75#BDBDB3 \
                HRULE:70#BDBDB3 \
                HRULE:65#BDBDB3 \
                HRULE:60#BDBDB3 \
                HRULE:55#BDBDB3 \
                HRULE:50#BDBDB3 \
                HRULE:45#BDBDB3 \
                HRULE:40#BDBDB3 \
                HRULE:35#BDBDB3 \
                HRULE:30#BDBDB3 \
                AREA:${4}#FF0000:"${5} ${2}"
	((EC += $?))


	rrdtool graph ${WEBSITEPATH}/emerson_${3}/rrdb/graphs/${4}/${1}/${4}_1day.png \
		--start -1d \
		--end ${GRAPHEND} \
		--title "24 Hour Log" \
		--vertical-label "Humidity %rH" \
		--width 600 \
		--height 200 \
		DEF:${4}=${WEBSITEPATH}/emerson_${3}/rrdb/${1}_${2}_${3}.rrd:${1}_${4}_${3}:AVERAGE \
		LINE2:${4}#FF0000 \
                HRULE:100#BDBDB3 \
                HRULE:95#BDBDB3 \
                HRULE:90#BDBDB3 \
                HRULE:85#BDBDB3 \
                HRULE:80#BDBDB3 \
                HRULE:75#BDBDB3 \
                HRULE:70#BDBDB3 \
                HRULE:65#BDBDB3 \
                HRULE:60#BDBDB3 \
                HRULE:55#BDBDB3 \
                HRULE:50#BDBDB3 \
                HRULE:45#BDBDB3 \
                HRULE:40#BDBDB3 \
                HRULE:35#BDBDB3 \
                HRULE:30#BDBDB3 \
                AREA:${4}#FF0000:"${5} ${2}"
	((EC += $?))


	rrdtool graph ${WEBSITEPATH}/emerson_${3}/rrdb/graphs/${4}/${1}/${4}_1week.png \
		--start -1w \
		--end ${GRAPHEND} \
		--title "1 Week Log" \
		--vertical-label "Humidity %rH" \
		--width 600 \
		--height 200 \
		DEF:${4}=${WEBSITEPATH}/emerson_${3}/rrdb/${1}_${2}_${3}.rrd:${1}_${4}_${3}:AVERAGE \
		LINE2:${4}#FF0000 \
                HRULE:100#BDBDB3 \
                HRULE:95#BDBDB3 \
                HRULE:90#BDBDB3 \
                HRULE:85#BDBDB3 \
                HRULE:80#BDBDB3 \
                HRULE:75#BDBDB3 \
                HRULE:70#BDBDB3 \
                HRULE:65#BDBDB3 \
                HRULE:60#BDBDB3 \
                HRULE:55#BDBDB3 \
                HRULE:50#BDBDB3 \
                HRULE:45#BDBDB3 \
                HRULE:40#BDBDB3 \
                HRULE:35#BDBDB3 \
                HRULE:30#BDBDB3 \
                AREA:${4}#FF0000:"${5} ${2}"
	((EC += $?))


	rrdtool graph ${WEBSITEPATH}/emerson_${3}/rrdb/graphs/${4}/${1}/${4}_4week.png \
		--start -4w \
		--end ${GRAPHEND} \
		--title "1 Month Log" \
		--vertical-label "Humidity %rH" \
		--width 600 \
		--height 200 \
		DEF:${4}=${WEBSITEPATH}/emerson_${3}/rrdb/${1}_${2}_${3}.rrd:${1}_${4}_${3}:AVERAGE \
		LINE2:${4}#FF0000 \
                HRULE:100#BDBDB3 \
                HRULE:95#BDBDB3 \
                HRULE:90#BDBDB3 \
                HRULE:85#BDBDB3 \
                HRULE:80#BDBDB3 \
                HRULE:75#BDBDB3 \
                HRULE:70#BDBDB3 \
                HRULE:65#BDBDB3 \
                HRULE:60#BDBDB3 \
                HRULE:55#BDBDB3 \
                HRULE:50#BDBDB3 \
                HRULE:45#BDBDB3 \
                HRULE:40#BDBDB3 \
                HRULE:35#BDBDB3 \
                HRULE:30#BDBDB3 \
                AREA:${4}#FF0000:"${5} ${2}"
	((EC += $?))


	rrdtool graph ${WEBSITEPATH}/emerson_${3}/rrdb/graphs/${4}/${1}/${4}_8week.png \
		--start -8w \
		--end ${GRAPHEND} \
		--title "2 Month Log" \
		--vertical-label "Humidity %rH" \
		--width 600 \
		--height 200 \
		DEF:${4}=${WEBSITEPATH}/emerson_${3}/rrdb/${1}_${2}_${3}.rrd:${1}_${4}_${3}:AVERAGE \
		LINE2:${4}#FF0000 \
                HRULE:100#BDBDB3 \
                HRULE:95#BDBDB3 \
                HRULE:90#BDBDB3 \
                HRULE:85#BDBDB3 \
                HRULE:80#BDBDB3 \
                HRULE:75#BDBDB3 \
                HRULE:70#BDBDB3 \
                HRULE:65#BDBDB3 \
                HRULE:60#BDBDB3 \
                HRULE:55#BDBDB3 \
                HRULE:50#BDBDB3 \
                HRULE:45#BDBDB3 \
                HRULE:40#BDBDB3 \
                HRULE:35#BDBDB3 \
                HRULE:30#BDBDB3 \
                AREA:${4}#FF0000:"${5} ${2}"
	((EC += $?))


	rrdtool graph ${WEBSITEPATH}/emerson_${3}/rrdb/graphs/${4}/${1}/${4}_24week.png \
		--start -24w \
		--end ${GRAPHEND} \
		--title "6 Month Log" \
		--vertical-label "Humidity %rH" \
		--width 600 \
		--height 200 \
		DEF:${4}=${WEBSITEPATH}/emerson_${3}/rrdb/${1}_${2}_${3}.rrd:${1}_${4}_${3}:AVERAGE \
		LINE2:${4}#FF0000 \
                HRULE:100#BDBDB3 \
                HRULE:95#BDBDB3 \
                HRULE:90#BDBDB3 \
                HRULE:85#BDBDB3 \
                HRULE:80#BDBDB3 \
                HRULE:75#BDBDB3 \
                HRULE:70#BDBDB3 \
                HRULE:65#BDBDB3 \
                HRULE:60#BDBDB3 \
                HRULE:55#BDBDB3 \
                HRULE:50#BDBDB3 \
                HRULE:45#BDBDB3 \
                HRULE:40#BDBDB3 \
                HRULE:35#BDBDB3 \
                HRULE:30#BDBDB3 \
                AREA:${4}#FF0000:"${5} ${2}"
	((EC += $?))


	rrdtool graph ${WEBSITEPATH}/emerson_${3}/rrdb/graphs/${4}/${1}/${4}_1year.png \
		--start -1y \
		--end ${GRAPHEND} \
		--title "1 Year Log" \
		--vertical-label "Humidity %rH" \
		--width 600 \
		--height 200 \
		DEF:${4}=${WEBSITEPATH}/emerson_${3}/rrdb/${1}_${2}_${3}.rrd:${1}_${4}_${3}:AVERAGE \
		LINE2:${4}#FF0000 \
                HRULE:100#BDBDB3 \
                HRULE:95#BDBDB3 \
                HRULE:90#BDBDB3 \
                HRULE:85#BDBDB3 \
                HRULE:80#BDBDB3 \
                HRULE:75#BDBDB3 \
                HRULE:70#BDBDB3 \
                HRULE:65#BDBDB3 \
                HRULE:60#BDBDB3 \
                HRULE:55#BDBDB3 \
                HRULE:50#BDBDB3 \
                HRULE:45#BDBDB3 \
                HRULE:40#BDBDB3 \
                HRULE:35#BDBDB3 \
                HRULE:30#BDBDB3 \
                AREA:${4}#FF0000:"${5} ${2}"
	((EC += $?))
	
	if [ "${EC}" -eq "0" ]
	then
		echo "[ $(date -R) ] Humidity (${1}) graphs of Emerson unit #${3} were successfully created"  >> ${GLB_LOGFILE}
	else
		echo "[ $(date -R) ] Humidity (${1}) graph(s) of Emerson unit #${3} were NOT successfully created [FAIL]"  >> ${GLB_LOGFILE}
	fi
	((GEC += EC))
}


# Creates the graphs for each Emerson unit.
# (both temperature and humidity)
# (Parameter: $1 -> Emerson unit No.)
create_emerson_graph () {
	create_temp_graph curr temperature ${1} temp Current
	create_hum_graph curr humidity ${1} hum Current
#	create_temp_graph unit temperature ${1} temp # Unit
#	create_hum_graph unit humidity ${1} hum # Unit
#	create_temp_graph sys temperature ${1} temp # System 
#	create_hum_graph sys humidity ${1} hum # System
}


# Calls the function that creates the graphs for an Emerson unit.
main () {
	WEBSITEPATH="/var/www/html"
        GLB_LOGFILE="/var/log/aeolus/aeolus.log"
        ERR_LOGFILE="/var/log/aeolus/error.log"         # not used
        STD_LOGFILE="/var/log/aeolus/stdout.log"        # not used
	DATESTAMP=$(date +%s)
	GRAPHEND=$((DATESTAMP-60))
	GEC=0
	create_emerson_graph 3
	create_emerson_graph 4
	if [ "${GEC}" -eq "0" ]
        then
                echo "[ $(date -R) ] Graphs were successfully created" >> ${GLB_LOGFILE}
        else
                echo "[ $(date -R) ] Graphs were NOT successfully created [FAIL]" >> ${GLB_LOGFILE}
		exit 1
        fi

}


# Calling main.
main
