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


create_emerson_dir_structure () {
	mkdir -p emerson_${1}/data/temp 
	mkdir -p emerson_${1}/data/hum
	mkdir -p emerson_${1}/rrdb/graph_reports 
	mkdir -p emerson_${1}/rrdb/graphs/temp/curr 
	mkdir -p emerson_${1}/rrdb/graphs/temp/curr_dual
	mkdir -p emerson_${1}/rrdb/graphs/hum/curr 
	mkdir -p emerson_${1}/rrdb/graphs/hum/curr_dual
#	mkdir -p emerson_${1}/rrdb/graphs/temp/unit 
#	mkdir -p emerson_${1}/rrdb/graphs/temp/unit_dual
#	mkdir -p emerson_${1}/rrdb/graphs/temp/sys
#	mkdir -p emerson_${1}/rrdb/graphs/temp/sys_dual
#	mkdir -p emerson_${1}/rrdb/graphs/hum/unit 
#	mkdir -p emerson_${1}/rrdb/graphs/hum/unit_dual 
#	mkdir -p emerson_${1}/rrdb/graphs/hum/sys
#	mkdir -p emerson_${1}/rrdb/graphs/hum/sys_dual
}


create_website_structure () {
	cd ${WEBSITEPATH}
        mkdir css photos emerson_3 emerson_4 scripts setup_scripts
	create_emerson_dir_structure 3
	create_emerson_dir_structure 4
}


main () {
	WEBSITEPATH="/var/www/html"
        create_website_structure
}


main
