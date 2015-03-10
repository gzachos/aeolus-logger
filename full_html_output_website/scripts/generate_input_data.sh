#!/bin/bash

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
