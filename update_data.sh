#!/bin/bash

function updt_data () {
	/var/www/html/scripts/generate_status_report.sh $1
	/var/www/html/scripts/generate_measurement_report.sh $1
}

function main () {
	/var/www/html/scripts/generate_input_data.sh >> /dev/null 2&>1
	updt_data 3
	updt_data 4
}

main
