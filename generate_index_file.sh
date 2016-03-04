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


WEBSITEPATH="/var/www/html"
GLB_LOGFILE="/var/log/aeolus/aeolus.log"
ERR_LOGFILE="/var/log/aeolus/error.log"         # not used
STD_LOGFILE="/var/log/aeolus/stdout.log"        # not used
TMP_FILE=$(mktemp /tmp/aeolus.XXXXXX)
DST_FILE=${WEBSITEPATH}/index.html
EC=0

cat > ${TMP_FILE} << __EOF__
<!DOCTYPE html>
<html>
        <head>
                <title>Aeolus Logger v2</title>
                <meta HTTP-EQUIV="REFRESH" content="0; url=/emerson_main_page.html">
        </head>
        <body>
        </body>
</html>
__EOF__
((EC += $?))

if [ "${EC}" -eq "0" ]
then
	cp -f ${TMP_FILE} ${DST_FILE}
	((EC += $?))
	if [ "${EC}" -eq "0" ] && [ -e "${DST_FILE}" ] && [ -s "${DST_FILE}" ]
	then
		echo "[ $(date -R) ] index.html was successfully created" >> ${GLB_LOGFILE}
	else
		echo "[ $(date -R) ] index.html was NOT created" >> ${GLB_LOGFILE}
	fi
fi
rm ${TMP_FILE}

