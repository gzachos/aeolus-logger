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


create_stylesheet_file () {
	
        echo -e "html {\n\ttext-align: center;\n\tbackground-color: #C2C2C2;\n\tmargin-top: 5px;\n\tmargin-left: 5px;\n\tmargin-right: 5px;\n}\n\n\n#head {\n\tmargin-left: 40px;\n\tmargin-right: 40px;\n}\n\n\n#contact {\n\ttext-align: left;\n\tpadding: 15px;\n}\n\n\n#emersons {\n\ttext-align: center;\n}\n\n\np {\n\ttext-align: justify;\n\ttext-justify: inter-word;\n\tmargin-left: 40px;\n\tmargin-right: 40px;\n}\n\n\nh2,h3,h4,h5 {\n\ttext-align: center;\n}\n\n\nbody {\n\ttext-align: center;\n\tvertical-align: auto;\n\tborder: 2px solid;\n\twidth: 910px;\n\t margin: auto;\n}\n\n\ntable, th, td {\n\tmargin-left: auto;\n\tmargin-right: auto;\n\tborder: 1px solid black;\n\ttext-align: center;\n}\n\n\nimg.banner {\n\tmargin-left: 40px;\n\tmargin-right: 40px;\n}\n" > ${WEBSITEPATH}/css/emerson_logger.css
}


main () {
	WEBSITEPATH="/var/www/html"
        create_stylesheet_file
}


main
