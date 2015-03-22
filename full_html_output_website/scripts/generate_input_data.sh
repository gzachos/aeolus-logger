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



function retrieve_data () {
	wget http://192.168.254.$1/index.html -O /var/www/html/emerson_$2/data/main.txt
	wget http://192.168.254.$1/tmp/1102.xml -O /var/www/html/emerson_$2/data/temp/temp_unit.txt
	wget http://192.168.254.$1/tmp/1103.xml -O /var/www/html/emerson_$2/data/hum/hum_unit.txt
	wget http://192.168.254.$1/tmp/1104.xml -O /var/www/html/emerson_$2/data/temp/temp_sys.txt
	wget http://192.168.254.$1/tmp/1105.xml -O /var/www/html/emerson_$2/data/hum/hum_sys.txt
	wget http://192.168.254.$1/tmp/statusreport.xml -O /var/www/html/emerson_$2/data/event_log.txt
}

function main () {
	retrieve_data 1 3
	retrieve_data 2 4
}

main
