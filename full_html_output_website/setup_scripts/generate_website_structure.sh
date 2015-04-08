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


create_website_structure () {
	cd ${WEBSITEPATH}
        mkdir css photos emerson_3 emerson_4 scripts setup_scripts
	cd emerson_3
	mkdir -p data/temp data/hum
	mkdir -p rrdb/graphs/temp/curr rrdb/graphs/hum/curr
#	mkdir -p rrdb/graphs/temp/unit rrdb/graphs/hum/unit
#	mkdir -p rrdb/graphs/temp/sys rrdb/graphs/hum/sys
	cd ../emerson_4
	mkdir -p data/temp data/hum
	mkdir -p rrdb/graphs/temp/curr rrdb/graphs/hum/curr
#	mkdir -p rrdb/graphs/temp/unit rrdb/graphs/hum/unit
#	mkdir -p rrdb/graphs/temp/sys rrdb/graphs/hum/sys
}


main () {
	WEBSITEPATH="/var/www/html"
        create_website_structure
}


main
