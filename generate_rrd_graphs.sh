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

# Creates a specific comparative temperature graph.
# (Parameters: 	$1 -> Emerson unit No.
#		$2 -> {curr, unit, sys},
#		$3 -> {1h, 12h, 24h, 1w, 4w, 24w, 1y},
#		$4 -> {1 Hour Log, 12 Hour Log, 24 Hour Log, 1 Week Log, 1 Month Log, 6 Month Log, 1 Year Log})
rrdgraph_temp_comp () {
	rrdtool graph ${WEBSITEPATH}/emerson_${1}/rrdb/graphs/temp/${2}_dual/temp_${3}.png \
		--start -${3} \
		--end ${GRAPHEND} \
		--title "${4}" \
		--vertical-label "Temperature ºC" \
		--width 600 \
		--height 200 \
		--color GRID#C2C2D6 \
		--color MGRID#E2E2E6 \
		--grid-dash 1:1 \
		--dynamic-labels \
		--font TITLE:10 \
		--font UNIT:9 \
		--font LEGEND:8 \
		--font AXIS:8 \
		--font WATERMARK:8 \
		--watermark "Aeolus Logger v2.1  //  ${WTM_DATE}  //  George Z. Zachos" \
		DEF:temp_3=${WEBSITEPATH}/emerson_3/rrdb/${2}_temperature_3.rrd:${2}_temp_3:AVERAGE \
		DEF:temp_4=${WEBSITEPATH}/emerson_4/rrdb/${2}_temperature_4.rrd:${2}_temp_4:AVERAGE \
		AREA:temp_3#FF0000AA:"Emerson #3 (return air temperature)" \
		AREA:temp_4#0000FFAA:"Emerson #4 (return air temperature)" \
		LINE${5}:temp_3#FF0000 \
		LINE${5}:temp_4#0000FF
	((EC += $?))
}

# Creates all temperature graphs of an Emerson unit.
# (Parameters: 	$1 -> Emerson unit No.,
#		$2 -> {curr, unit, sys})
create_temp_graphs_comp () {
	EC=0
	rrdgraph_temp_comp ${1} ${2} 1h  "1 Hour Log"  1
	rrdgraph_temp_comp ${1} ${2} 12h "12 Hour Log" 1
	rrdgraph_temp_comp ${1} ${2} 24h "24 Hour Log" 1
	rrdgraph_temp_comp ${1} ${2} 1w  "1 Week Log"  1
	rrdgraph_temp_comp ${1} ${2} 4w  "1 Month Log" 1
	rrdgraph_temp_comp ${1} ${2} 24w "6 Month Log" 1
	rrdgraph_temp_comp ${1} ${2} 1y  "1 Year Log"  1

	if [ "${EC}" -eq "0" ]
	then
		echo "[ $(date -R) ] Temperature (${2}-comparative) graphs of Emerson unit #${1} were successfully created"  >> ${GLB_LOGFILE}
	else
		echo "[ $(date -R) ] Temperature (${2}-comparative) graph(s) of Emerson unit #${1} were NOT successfully created [FAIL]"  >> ${GLB_LOGFILE}
	fi
	((GEC += EC))
}

# Creates a specific temperature graph.
# (Parameters: 	$1 -> Emerson unit No.
#		$2 -> {curr, unit, sys},
#		$3 -> {1h, 12h, 24h, 1w, 4w, 24w, 1y},
#		$4 -> {1 Hour Log, 12 Hour Log, 24 Hour Log, 1 Week Log, 1 Month Log, 6 Month Log, 1 Year Log})
rrdgraph_temp () {
	if [ "${1}" -eq "3" ]
	then
		SETPOINT=23
	else
		SETPOINT=21
	fi
	rrdtool graph ${WEBSITEPATH}/emerson_${1}/rrdb/graphs/temp/${2}/temp_${3}.png \
		--start -${3} \
		--end ${GRAPHEND} \
		--title "${4}" \
		--vertical-label "Temperature ºC" \
		--width 600 \
		--height 200 \
		--color GRID#C2C2D6 \
		--color MGRID#E2E2E6 \
		--grid-dash 1:3 \
		--dynamic-labels \
		--font TITLE:10 \
		--font UNIT:9 \
		--font LEGEND:8 \
		--font AXIS:8 \
		--font WATERMARK:8 \
		--watermark "Aeolus Logger v2.1  //  ${WTM_DATE}  //  George Z. Zachos" \
		DEF:temp=${WEBSITEPATH}/emerson_${1}/rrdb/${2}_temperature_${1}.rrd:${2}_temp_${1}:AVERAGE \
                AREA:temp#FF0000DD:"Emerson #${1} (return air temperature)" \
		LINE${5}:${SETPOINT}#000000:"Emerson #${1} (return air temperature setpoint)"
	((EC += $?))
}


# Creates all temperature graphs of an Emerson unit.
# (Parameters: 	$1 -> Emerson unit No.,
#		$2 -> {curr, unit, sys})
create_temp_graphs () {
	EC=0
	rrdgraph_temp ${1} ${2} 1h  "1 Hour Log"  2
	rrdgraph_temp ${1} ${2} 12h "12 Hour Log" 2
	rrdgraph_temp ${1} ${2} 24h "24 Hour Log" 2
	rrdgraph_temp ${1} ${2} 1w  "1 Week Log"  1
	rrdgraph_temp ${1} ${2} 4w  "1 Month Log" 1
	rrdgraph_temp ${1} ${2} 24w "6 Month Log" 1
	rrdgraph_temp ${1} ${2} 1y  "1 Year Log"  1

	if [ "${EC}" -eq "0" ]
	then
		echo "[ $(date -R) ] Temperature (${2}) graphs of Emerson unit #${1} were successfully created"  >> ${GLB_LOGFILE}
	else
		echo "[ $(date -R) ] Temperature (${2}) graph(s) of Emerson unit #${1} were NOT successfully created [FAIL]"  >> ${GLB_LOGFILE}
	fi
	((GEC += EC))
}


# Creates a specific humidity graph.
# (Parameters: 	$1 -> Emerson unit No.
#		$2 -> {curr, unit, sys},
#		$3 -> {1h, 12h, 24h, 1w, 4w, 24w, 1y},
#		$4 -> {1 Hour Log, 12 Hour Log, 24 Hour Log, 1 Week Log, 1 Month Log, 6 Month Log, 1 Year Log})
rrdgraph_hum () {
	EC=0
	rrdtool graph ${WEBSITEPATH}/emerson_${1}/rrdb/graphs/hum/${2}/hum_${3}.png \
		--start -${3} \
		--end ${GRAPHEND} \
		--title "${4}" \
		--vertical-label "Humidity %rH" \
		--width 600 \
		--height 200 \
		--color GRID#A3A3B2 \
		--color MGRID#B3B3C2 \
		--grid-dash 1:1 \
		--dynamic-labels \
		--font TITLE:10 \
		--font UNIT:9 \
		--font LEGEND:8 \
		--font AXIS:8 \
		--font WATERMARK:8 \
		--watermark "Aeolus Logger v2.1  //  ${WTM_DATE}  //  George Z. Zachos" \
		DEF:hum=${WEBSITEPATH}/emerson_${1}/rrdb/${2}_humidity_${1}.rrd:${2}_hum_${1}:AVERAGE \
                AREA:hum#0000FFDD:"Emerson #${1} (return air humidity)"
	((EC += $?))
}


# Creates all humidity graphs of an Emerson unit.
# (Parameters: 	$1 -> Emerson unit No.,
#		$2 -> {curr, unit, sys})
create_hum_graphs () {
	EC=0
	rrdgraph_hum ${1} ${2} 1h  "1 Hour Log"
	rrdgraph_hum ${1} ${2} 12h "12 Hour Log"
	rrdgraph_hum ${1} ${2} 24h "24 Hour Log"
	rrdgraph_hum ${1} ${2} 1w  "1 Week Log"
	rrdgraph_hum ${1} ${2} 4w  "1 Month Log"
	rrdgraph_hum ${1} ${2} 24w "6 Month Log"
	rrdgraph_hum ${1} ${2} 1y  "1 Year Log"

	if [ "${EC}" -eq "0" ]
	then
		echo "[ $(date -R) ] Humidity (${2}) graphs of Emerson unit #${1} were successfully created"  >> ${GLB_LOGFILE}
	else
		echo "[ $(date -R) ] Humidity (${2}) graph(s) of Emerson unit #${1} were NOT successfully created [FAIL]"  >> ${GLB_LOGFILE}
	fi
	((GEC += EC))
}


# Creates the graphs for each Emerson unit.
# (both temperature and humidity)
# (Parameter: $1 -> Emerson unit No.)
create_emerson_graphs () {
	create_temp_graphs ${1} curr
	create_hum_graphs  ${1} curr
	create_temp_graphs_comp ${1} curr
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
	WTM_DATE=$(date -R)
	GRAPHEND=$((DATESTAMP-60))
	GEC=0
	create_emerson_graphs 3
	create_emerson_graphs 4
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
