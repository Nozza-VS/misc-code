#!/bin/bash 

######
# This script adds WEB checks from a file to a zabbix host by inputting the urls directly into the database."
#
# Original author: Walter Heck - Tribily - <walter@tribily.com>
#
# Version history
# v0.1: 2011-11-13: 
# 	* First version
# v0.2: 2011-11-20:
#	* Added proper error handling
#	* Added input parameters instead of defined variables for safety  
#	* Added usage and logging functions. Removed logging to file, just redirect STDOUT if you want the output
#	* Improved Logging
#
# License: GPL v3:
#
#    Copyright (C) 2011 Walter Heck
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

PROGNAME=$(basename $0)

##### Helper functions

function usage
{
echo "This script adds WEB checks from a file to a zabbix host by inputting the urls directly into the database."
echo "USE WITH CARE!!"
echo ""
echo "usage: ${PROGNAME}"
echo ""
echo "MySQL connection options:"
echo "-u | --dbuser	mysql username to connect to zabbix database (Required)"
echo "-p | --dbpass	mysql password to connect to zabbix database (Required)"
echo "-H | --dbhost	hostname of the mysql server (Default: localhost)"
echo "-D | --dbname	databasename of the zabbix mysql database (Default: zabbix)"
echo ""
echo "Webcheck options:"
echo "-t | --timeout	timeout in seconds before a http request times out (Default: 15)"
echo "-d | --delay	number of seconds between two WEB checks (Default: 60)"
echo "-i | --history	number of days to keep all values (Default: 90)"
echo "-t | --trends	number of days to keep trends (Default: 360)"
echo ""
echo "-o | --hostid	the zabbix hostid of the host these WEB checks will be added to (Required)"
echo "-A | --appname	zabbix application the WEB checks will be added to (Required)"
echo "-a | --agent    user agent the WEB check will be done as (Default: 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)')"
echo ""
echo "-f | --urlfile	file with urls to monitor. One url per line (Required)"
echo ""
echo "Help:"
echo "-h | --help		this message"
}

function error_exit
{

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
# 	Example call of the error_exit function.  Note the inclusion
# 	of the LINENO environment variable.  It contains the current
# 	line number.
#
#	error_exit "$LINENO: An error has occurred."
#
#	----------------------------------------------------------------
	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	exit 1
}

function log
{
	echo "${PROGNAME}: $1"
}

##### Parameter processing

# These are the host and hostgroup that all web checks will be added to
HOSTID=
APPLNAME=
USERAGENT='Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)'
HOSTFILE=
# timeout in seconds before a http request times out
TIMEOUT=15
# number of seconds between two checks
DELAY=60
# number of days to keep all values
HISTORY=90
# number of days to keep trends
TRENDS=360

MYSQLUSER=
MYSQLPASS=
MYSQLHOST=localhost
MYSQLDB=zabbix

while [ "$1" != "" ]; do
    case $1 in
        -u | --dbuser )         shift
                                MYSQLUSER=$1
                                ;;
        -p | --dbpass )    		shift
        						MYSQLPASS=$1
                                ;;
        -H | --dbhost )    		shift
        						MYSQLHOST=$1
                                ;;
        -D | --dbname )    		shift
        						MYSQLDB=$1
                                ;;
        -t | --timeout )    	shift
        						TIMEOUT=$1
                                ;;
        -d | --delay )    		shift
        						DELAY=$1
                                ;;
        -i | --history )    	shift
        						HISTORY=$1
                                ;;
        -t | --trends )    		shift
        						TRENDS=$1
                                ;;
        -o | --hostid )    		shift
        						HOSTID=$1
                                ;;
    	-f | --urlfile )    	shift
        						HOSTFILE=$1
                                ;;
        -a | --agent )    		shift
        						USERAGENT=$1
                                ;;
        -A | --appname )    	shift
        						APPLNAME=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

if [ -z "$MYSQLUSER" ]
then
	error_exit "$LINENO: Required parameter not found: -u | --dbuser. See -h | --help for more information"
fi

if [ -z "$MYSQLPASS" ]
then
	error_exit "$LINENO: Required parameter not found: -p | --dbpass. See -h | --help for more information"
fi

if [ -z "$HOSTID" ]
then
	error_exit "$LINENO: Required parameter not found: -o | --hostid. See -h | --help for more information"
fi

if [ -z "$HOSTFILE" ]
then
	error_exit "$LINENO: Required parameter not found: -f | --urlfile. See -h | --help for more information"
fi

if [ -z "$APPLNAME" ]
then
	error_exit "$LINENO: Required parameter not found: -A | --appname. See -h | --help for more information"
fi

##### Functions

# Executes an sql command, call like so:
#   mysql_cmd "select * from zabbix.items where hostid = ${HOSTID}"
mysql_cmd () {
	if [ -z "$1" ]                           # Is parameter #1 zero length?
	then
		error_exit "-Parameter #1 is zero length in mysql_cmd.-\n"  # Or no parameter passed.
	fi

	# --skip-columna-names for parseable output assumes we don't use select * 
	# 	so you already know which column names are in which order
	# --batch output results in record-per-line tab-delimited way
	#log "mysql -u${MYSQLUSER} -p${MYSQLPASS} -D${MYSQLDB} -h${MYSQLHOST} --batch --skip-column-name -e\"$1\""
	result=`mysql -u${MYSQLUSER} -p${MYSQLPASS} -D${MYSQLDB} -h${MYSQLHOST} --batch --skip-column-name -e"$1"`
	
	
	if [ "$?" = "0" ]; then
		# in bash you cannot return a value so we echo it, the calling function can 
		# 	then just capture that using `` or $()
		echo $result
	else
		error_exit "MySQL command failed: $1 (-u${MYSQLUSER} -p${MYSQLPASS} -D${MYSQLDB} -h${MYSQLHOST})"
	fi
}

zabbix_get_next_id () {
	table="$1"
	field="$2"

	# Get the current id and the next id and compare them. If the difference is 1, use it.
	curr_id=`mysql_cmd "SELECT nextid FROM ids WHERE table_name='${table}' AND field_name='${field}';"`
	next_id=`mysql_cmd "UPDATE ids SET nextid=nextid+1 WHERE nodeid=0 AND table_name='${table}' AND field_name='${field}';SELECT nextid FROM ids WHERE table_name='${table}' AND field_name='${field}';"`
		
	if [ `expr $curr_id - $next_id` -eq -1 ] ;
	then
		echo $next_id
		return 1
	else
		return 0
	fi
}

##### Main

log "== Starting run" 
log "== Starting run" 
log "== Starting run"

# Add an application if it doesn't exist and get it's appid returned
app_id=`mysql_cmd "select applicationid from applications where hostid = '${HOSTID}' and name = '${APPLNAME}'"`
if [ -z "$app_id" ]
then
	app_id=`zabbix_get_next_id 'applications' 'applicationid'`
	mysql_cmd "insert into applications(applicationid, hostid, name) values (${app_id}, ${HOSTID}, '${APPLNAME}')"
fi

# Loop through all sites to be added
while read line; do 
	
	log "== Starting ${line}" 
	
	test_name="Scenario ${line}"
	step_name="Scenario ${line} Step 1"
	
	# create a {httptest}
	# mysql> select * from httptest\G
	# *************************** 1. row ***************************
	#     httptestid: 1
	#           name: blah scenario name
	#  applicationid: 364
	#      lastcheck: 0
	#      nextcheck: 0
	#       curstate: 3
	#        curstep: 0
	# lastfailedstep: 0
	#          delay: 60
	#         status: 0
	#         macros: 
	#          agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)
	#           time: 0.0000
	#          error: 
	# authentication: 0
	#      http_user: 
	#  http_password: 
	# 1 row in set (0.00 sec)
	httptest_id=`zabbix_get_next_id 'httptest' 'httptestid'`
	mysql_cmd "insert into httptest(httptestid, name, applicationid, curstate, delay, status, agent, authentication) values (${httptest_id}, '${test_name}', ${app_id}, 3, 60, 0, '${USERAGENT}', 0)"
	

		# create a {httpstep}
		# mysql> select * from httpstep\G
		# *************************** 1. row ***************************
		#   httpstepid: 1
		#   httptestid: 1
		#         name: scenario step 1
		#           no: 1
		#          url: http://localhost:8888
		#      timeout: 15
		#        posts: 
		#     required: 
		# status_codes: 
		# 1 row in set (0.00 sec)
		httpstep_id=`zabbix_get_next_id 'httpstep' 'httpstepid'`
		mysql_cmd "insert into httpstep(httpstepid, httptestid, name, no, url, timeout, posts, required, status_codes) values (${httpstep_id}, ${httptest_id}, '${step_name}', 1, '${line}', ${TIMEOUT}, '', '', '')"
	
		# create {items} for {httpstep}
		# mysql> select * from items where itemid in (23731,23732,23733)\G
		# 		*************************** 1. row ***************************
		# 		               itemid: 23731
		# 		                 type: 9
		# 		       snmp_community: 
		# 		             snmp_oid: 
		# 		            snmp_port: 161
		# 		               hostid: 10092
		# 		          description: Download speed for step '$2' of scenario '$1'
		# 		                 key_: web.test.in[blah scenario name,scenario step 1,bps]
		# 		                delay: 60
		# 		              history: 30
		# 		               trends: 90
		# 		            lastvalue: NULL
		# 		            lastclock: NULL
		# 		            prevvalue: NULL
		# 		               status: 0
		# 		           value_type: 0
		# 		        trapper_hosts: localhost
		# 		                units: Bps
		# 		           multiplier: 0
		# 		                delta: 0
		# 		         prevorgvalue: NULL
		# 		  snmpv3_securityname: 
		# 		 snmpv3_securitylevel: 0
		# 		snmpv3_authpassphrase: 
		# 		snmpv3_privpassphrase: 
		# 		              formula: 0
		# 		                error: 
		# 		          lastlogsize: 0
		# 		           logtimefmt: 
		# 		           templateid: 0
		# 		           valuemapid: 0
		# 		           delay_flex: 
		# 		               params: 
		# 		          ipmi_sensor: 
		# 		            data_type: 0
		# 		             authtype: 0
		# 		             username: 
		# 		             password: 
		# 		            publickey: 
		# 		           privatekey: 
		# 		                mtime: 0
		# 		*************************** 2. row ***************************
		# 		               itemid: 23732
		# 		                 type: 9
		# 		       snmp_community: 
		# 		             snmp_oid: 
		# 		            snmp_port: 161
		# 		               hostid: 10092
		# 		          description: Response time for step '$2' of scenario '$1'
		# 		                 key_: web.test.time[blah scenario name,scenario step 1,resp]
		# 		                delay: 60
		# 		              history: 30
		# 		               trends: 90
		# 		            lastvalue: NULL
		# 		            lastclock: NULL
		# 		            prevvalue: NULL
		# 		               status: 0
		# 		           value_type: 0
		# 		        trapper_hosts: localhost
		# 		                units: s
		# 		           multiplier: 0
		# 		                delta: 0
		# 		         prevorgvalue: NULL
		# 		  snmpv3_securityname: 
		# 		 snmpv3_securitylevel: 0
		# 		snmpv3_authpassphrase: 
		# 		snmpv3_privpassphrase: 
		# 		              formula: 0
		# 		                error: 
		# 		          lastlogsize: 0
		# 		           logtimefmt: 
		# 		           templateid: 0
		# 		           valuemapid: 0
		# 		           delay_flex: 
		# 		               params: 
		# 		          ipmi_sensor: 
		# 		            data_type: 0
		# 		             authtype: 0
		# 		             username: 
		# 		             password: 
		# 		            publickey: 
		# 		           privatekey: 
		# 		                mtime: 0
		# 		*************************** 3. row ***************************
		# 		               itemid: 23733
		# 		                 type: 9
		# 		       snmp_community: 
		# 		             snmp_oid: 
		# 		            snmp_port: 161
		# 		               hostid: 10092
		# 		          description: Response code for step '$2' of scenario '$1'
		# 		                 key_: web.test.rspcode[blah scenario name,scenario step 1]
		# 		                delay: 60
		# 		              history: 30
		# 		               trends: 90
		# 		            lastvalue: NULL
		# 		            lastclock: NULL
		# 		            prevvalue: NULL
		# 		               status: 0
		# 		           value_type: 3
		# 		        trapper_hosts: localhost
		# 		                units: 
		# 		           multiplier: 0
		# 		                delta: 0
		# 		         prevorgvalue: NULL
		# 		  snmpv3_securityname: 
		# 		 snmpv3_securitylevel: 0
		# 		snmpv3_authpassphrase: 
		# 		snmpv3_privpassphrase: 
		# 		              formula: 0
		# 		                error: 
		# 		          lastlogsize: 0
		# 		           logtimefmt: 
		# 		           templateid: 0
		# 		           valuemapid: 0
		# 		           delay_flex: 
		# 		               params: 
		# 		          ipmi_sensor: 
		# 		            data_type: 0
		# 		             authtype: 0
		# 		             username: 
		# 		             password: 
		# 		            publickey: 
		# 		           privatekey: 
		# 		                mtime: 0
		# 		3 rows in set (0.00 sec)
		# create a {httpstepitem} (connects {httptest} and {items})
		# mysql> select * from httpstepitem\G
		# *************************** 1. row ***************************
		# httpstepitemid: 1
		#     httpstepid: 1
		#         itemid: 23731
		#           type: 2
		# *************************** 2. row ***************************
		# httpstepitemid: 2
		#     httpstepid: 1
		#         itemid: 23732
		#           type: 1
		# *************************** 3. row ***************************
		# httpstepitemid: 3
		#     httpstepid: 1
		#         itemid: 23733
		#           type: 0
		# 3 rows in set (0.00 sec)
		
		# Create 3 items for response time, response code and download speed
		log "Create 3 items for response time, response code and download speed" 
		
		# download speed
		item_id=`zabbix_get_next_id 'items' 'itemid'`
		mysql_cmd "insert into items(itemid, type, hostid, description, key_, delay, history, trends, status, value_type, trapper_hosts, units, multiplier, delta, prevorgvalue, formula, error, lastlogsize, logtimefmt, templateid, valuemapid, delay_flex, params, data_type, mtime) values (${item_id}, 9, ${HOSTID}, 'Download speed for step \'\$2\' of scenario \'\$1\'', 'web.test.in[${test_name},${step_name},bps]', ${DELAY}, ${HISTORY}, ${TRENDS}, 0, 0, 'localhost', 'Bps', 0, 0, NULL, 0, '', 0, '', 0, 0, '', '', 0, 0)"
		httpstepitem_id=`zabbix_get_next_id 'httpstepitem' 'httpstepitemid'`
		mysql_cmd "insert into httpstepitem(httpstepitemid, httpstepid, itemid, type) values (${httpstepitem_id}, ${httpstep_id}, ${item_id}, 2)"
		
		# response time
		item_id=`zabbix_get_next_id 'items' 'itemid'`
		mysql_cmd "insert into items(itemid, type, hostid, description, key_, delay, history, trends, status, value_type, trapper_hosts, units, multiplier, delta, prevorgvalue, formula, error, lastlogsize, logtimefmt, templateid, valuemapid, delay_flex, params, data_type, mtime) values (${item_id}, 9, ${HOSTID}, 'Response time for step \'\$2\' of scenario \'\$1\'', 'web.test.time[${test_name},${step_name},resp]', ${DELAY}, ${HISTORY}, ${TRENDS}, 0, 0, 'localhost', 's', 0, 0, NULL, 0, '', 0, '', 0, 0, '', '', 0, 0)"
		httpstepitem_id=`zabbix_get_next_id 'httpstepitem' 'httpstepitemid'`
		mysql_cmd "insert into httpstepitem(httpstepitemid, httpstepid, itemid, type) values (${httpstepitem_id}, ${httpstep_id}, ${item_id}, 1)"

		# response code
		item_id=`zabbix_get_next_id 'items' 'itemid'`
		mysql_cmd "insert into items(itemid, type, hostid, description, key_, delay, history, trends, status, value_type, trapper_hosts, units, multiplier, delta, prevorgvalue, formula, error, lastlogsize, logtimefmt, templateid, valuemapid, delay_flex, params, data_type, mtime) values (${item_id}, 9, ${HOSTID}, 'Response code for step \'\$2\' of scenario \'\$1\'', 'web.test.rspcode[${test_name},${step_name}]', ${DELAY}, ${HISTORY}, ${TRENDS}, 0, 3, 'localhost', '', 0, 0, NULL, 0, '', 0, '', 0, 0, '', '', 0, 0)"
		httpstepitem_id=`zabbix_get_next_id 'httpstepitem' 'httpstepitemid'`
		mysql_cmd "insert into httpstepitem(httpstepitemid, httpstepid, itemid, type) values (${httpstepitem_id}, ${httpstep_id}, ${item_id}, 0)"
	
	# create {items} for {httptest}
	# mysql> select * from items where itemid in (23734,23735)\G
	# *************************** 1. row ***************************
	#                itemid: 23734
	#                  type: 9
	#        snmp_community: 
	#              snmp_oid: 
	#             snmp_port: 161
	#                hostid: 10092
	#           description: Download speed for scenario '$1'
	#                  key_: web.test.in[blah scenario name,,bps]
	#                 delay: 60
	#               history: 30
	#                trends: 90
	#             lastvalue: NULL
	#             lastclock: NULL
	#             prevvalue: NULL
	#                status: 0
	#            value_type: 0
	#         trapper_hosts: localhost
	#                 units: Bps
	#            multiplier: 0
	#                 delta: 0
	#          prevorgvalue: NULL
	#   snmpv3_securityname: 
	#  snmpv3_securitylevel: 0
	# snmpv3_authpassphrase: 
	# snmpv3_privpassphrase: 
	#               formula: 0
	#                 error: 
	#           lastlogsize: 0
	#            logtimefmt: 
	#            templateid: 0
	#            valuemapid: 0
	#            delay_flex: 
	#                params: 
	#           ipmi_sensor: 
	#             data_type: 0
	#              authtype: 0
	#              username: 
	#              password: 
	#             publickey: 
	#            privatekey: 
	#                 mtime: 0
	# *************************** 2. row ***************************
	#                itemid: 23735
	#                  type: 9
	#        snmp_community: 
	#              snmp_oid: 
	#             snmp_port: 161
	#                hostid: 10092
	#           description: Failed step of scenario '$1'
	#                  key_: web.test.fail[blah scenario name]
	#                 delay: 60
	#               history: 30
	#                trends: 90
	#             lastvalue: NULL
	#             lastclock: NULL
	#             prevvalue: NULL
	#                status: 0
	#            value_type: 3
	#         trapper_hosts: localhost
	#                 units: 
	#            multiplier: 0
	#                 delta: 0
	#          prevorgvalue: NULL
	#   snmpv3_securityname: 
	#  snmpv3_securitylevel: 0
	# snmpv3_authpassphrase: 
	# snmpv3_privpassphrase: 
	#               formula: 0
	#                 error: 
	#           lastlogsize: 0
	#            logtimefmt: 
	#            templateid: 0
	#            valuemapid: 0
	#            delay_flex: 
	#                params: 
	#           ipmi_sensor: 
	#             data_type: 0
	#              authtype: 0
	#              username: 
	#              password: 
	#             publickey: 
	#            privatekey: 
	#                 mtime: 0
	# 2 rows in set (0.00 sec)
	
	# create {httptestitem} (connects {httptest} and {items})
	# mysql> select * from httptestitem\G
	# *************************** 1. row ***************************
	# httptestitemid: 1
	#     httptestid: 1
	#         itemid: 23734
	#           type: 2
	# *************************** 2. row ***************************
	# httptestitemid: 2
	#     httptestid: 1
	#         itemid: 23735
	#           type: 3
	# 2 rows in set (0.00 sec)
	
	# Create 2 items for download speed and fail test of the whole scenario
	log "Create 2 items for download speed and fail test of the whole scenario" 
	
	# download speed
	item_id=`zabbix_get_next_id 'items' 'itemid'`
	mysql_cmd "insert into items(itemid, type, hostid, description, key_, delay, history, trends, status, value_type, trapper_hosts, units, multiplier, delta, prevorgvalue, formula, error, lastlogsize, logtimefmt, templateid, valuemapid, delay_flex, params, data_type, mtime) values (${item_id}, 9, ${HOSTID}, 'Download speed for scenario \'\$1\'', 'web.test.in[${test_name},,bps]', ${DELAY}, ${HISTORY}, ${TRENDS}, 0, 0, 'localhost', 'Bps', 0, 0, NULL, 0, '', 0, '', 0, 0, '', '', 0, 0)"
	httptestitem_id=`zabbix_get_next_id 'httptestitem' 'httptestitemid'`
	mysql_cmd "insert into httptestitem(httptestitemid, httptestid, itemid, type) values (${httptestitem_id}, ${httptest_id}, ${item_id}, 2)"
	
	# fail test
	item_id=`zabbix_get_next_id 'items' 'itemid'`
	mysql_cmd "insert into items(itemid, type, hostid, description, key_, delay, history, trends, status, value_type, trapper_hosts, units, multiplier, delta, prevorgvalue, formula, error, lastlogsize, logtimefmt, templateid, valuemapid, delay_flex, params, data_type, mtime) values (${item_id}, 9, ${HOSTID}, 'Failed step of scenario \'\$1\'', 'web.test.fail[${test_name}]', ${DELAY}, ${HISTORY}, ${TRENDS}, 0, 3, 'localhost', '', 0, 0, NULL, 0, '', 0, '', 0, 0, '', '', 0, 0)"
	httptestitem_id=`zabbix_get_next_id 'httptestitem' 'httptestitemid'`
	mysql_cmd "insert into httptestitem(httptestitemid, httptestid, itemid, type) values (${httptestitem_id}, ${httptest_id}, ${item_id}, 3)"	
	
done < ${HOSTFILE}