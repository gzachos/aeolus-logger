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


create_rrdb () {

	rrdtool create 	${WEBSITEPATH}/emerson_${3}/rrdb/${1}_${2}_${3}.rrd \
	--start 1428044400 \
	--step 60 \
	DS:${1}_${4}_${3}:GAUGE:120:U:U \
	RRA:AVERAGE:0.5:1:31556926	# 365 day log (1 graph value every 1 DB update)
}


create_emerson_rrdb () {
        create_rrdb curr temperature ${1} temp
        create_rrdb curr humidity ${1} hum
#       create_rrdb unit temperature ${1} temp
#       create_rrdb unit humidity ${1} hum
#       create_rrdb sys temperature ${1} temp
#       create_rrdb sys humidity ${1} hum
}


main () {
	WEBSITEPATH="/var/www/html"
        create_emerson_rrdb 3
        create_emerson_rrdb 4
}


main
