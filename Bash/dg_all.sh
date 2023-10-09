#!/bin/bash
## F5 Data Group Update Script
## Description: provides options to add IPs and delete IPs to Datagroup
## Version: 1.0
## Requires: bash, curl, jq
##
## Syntax:
##      To Add IPs:
##      Command:    dg_all.sh add <datagroup> <IP>
##      Examples:   dg_all.sh add MY_DATAGROUP 1.1.1.1                  
##
##      
##      To Delete IPs:
##      Command:    dg_all.sh del <datagroup> <IP>
##      Examples:   dg_all.sh del MY_DATAGROUP 1.1.1.1
##                  
##

## IP addresses
BIGIP_Msk="10.2.23.2"
BIGIP_Spb="10.2.23.4"

## Login
LOGIN='api:test'

display_usage () {
    echo "Data group Update Script on all BIG-IPs"
    echo ""
    echo "   To add IP to a data group:"
    echo "   dg_all.sh add <datagroup> <IP>"
    echo ""
    echo "   To remove IP from a data group:"
    echo "   dg_all.sh del <datagroup> <IP>"
	echo "   IP with subnetwork mask mandatory, when delete: 1.1.1.1/32"
    echo ""
    exit 1
}

add_ips () {

## Form data structure with new IP
newdg="{\"name\":\"$2\"}"

##------------------Moscow--------------------

## Get current list of IPs in Moscow
dg_Msk=`curl -sku ${LOGIN} -H 'Content-Type: application/json' -X GET "https://${BIGIP_Msk}/mgmt/tm/ltm/data-group/internal/$1" | jq .records --compact-output |sed 's/\[//g' | sed 's/\]//g'`

## Update data group in Moscow
payload_Msk="{\"records\":[${dg_Msk},${newdg}]}"
curl -i -sku ${LOGIN} -H 'Content-Type: application/json' -X PATCH "https://${BIGIP_Msk}/mgmt/tm/ltm/data-group/internal/$1" -d ${payload_Msk} > result.tmp
if grep -q "HTTP/1.1 200 OK" result.tmp; then
		echo "MSK: IP address has been added successfully"
	else
    echo "MSK: IP address has NOT been added!!!!"
	fi	

##	Sync cluster in Moscow
curl -i -sku ${LOGIN} -H 'Content-Type: application/json' -X POST "https://${BIGIP_Msk}/mgmt/tm/cm" -d '{"command":"run","utilCmdArgs":"config-sync to-group Cluster"}' > result.tmp
	if grep -q "HTTP/1.1 200 OK" result.tmp; then
		echo "MSK: Cluster has been synced successfully"
	else
    echo "MSK: Cluster has NOT been synced!!!!"
	fi	

##------------------Saint-Petersburg-------------

## Get current list of IPs in Spb
dg_Spb=`curl -sku ${LOGIN} -H 'Content-Type: application/json' -X GET "https://${BIGIP_Spb}/mgmt/tm/ltm/data-group/internal/$1" |jq .records --compact-output |sed 's/\[//g' | sed 's/\]//g'`

## Update data group in Spb
payload_Spb="{\"records\":[${dg_Spb},${newdg}]}"
curl -i -sku ${LOGIN} -H 'Content-Type: application/json' -X PATCH "https://${BIGIP_Spb}/mgmt/tm/ltm/data-group/internal/$1" -d ${payload_Spb} > result.tmp
if grep -q "HTTP/1.1 200 OK" result.tmp; then
		echo "SPB: IP address has been added successfully"
	else
    echo "SPB: IP address has NOT been added!!!!"
	fi	

##	Sync cluster in Spb
curl -i -sku ${LOGIN} -H 'Content-Type: application/json' -X POST "https://${BIGIP_Spb}/mgmt/tm/cm" -d '{"command":"run","utilCmdArgs":"config-sync to-group Novosibirsk"}' > result.tmp
	if grep -q "HTTP/1.1 200 OK" result.tmp; then
		echo "SPB: Cluster has been synced successfully"
	else
    echo "SPB: Cluster has NOT been synced!!!!"
	fi	
	rm -f result.tmp
}

del_ips () {

## Form data structure with new IP address
newdg="{\"name\":\"$2\",\"data\":\"\"}"

##---------------------Moscow----------------------------

## Get current list of IPs in Moscow
dg_Msk=`curl -sku ${LOGIN} -H 'Content-Type: application/json' -X GET "https://${BIGIP_Msk}/mgmt/tm/ltm/data-group/internal/$1" |jq .records --compact-output |sed 's/\[//g' | sed 's/\]//g'`

## Update address list in Moscow
modips_msk=`printf '%s\n' "${dg_Msk//$newdg/}"`
payload_Msk="{\"records\":[${modips_msk}]}"
payload_Msk=`echo ${payload_Msk} |sed "s/\[,/\[/;s/,\]/\]/;s/,,/,/"`
curl -i -sku ${LOGIN} -H 'Content-Type: application/json' -X PATCH "https://${BIGIP_Msk}/mgmt/tm/ltm/data-group/internal/$1" -d ${payload_Msk} > result.tmp
if grep -q "HTTP/1.1 200 OK" result.tmp; then
		echo "MSK: IP address has been successfully deleted"
	else
    echo "MSK: IP address has NOT been deleted!!!!"
	fi
## Sync cluster in Moscow
curl -i -sku ${LOGIN} -H 'Content-Type: application/json' -X POST "https://${BIGIP_Msk}/mgmt/tm/cm" -d '{"command":"run","utilCmdArgs":"config-sync to-group Cluster"}' > result.tmp
	if grep -q "HTTP/1.1 200 OK" result.tmp; then
		echo "MSK: Cluster has been successfully synced"
	else
    echo "MSK: Cluster has not been synced!!!!"
	fi	
##----------------------------SPB----------------------------

## Get current list of IPs in Spb
dg_Spb=`curl -sku ${LOGIN} -H 'Content-Type: application/json' -X GET "https://${BIGIP_Spb}/mgmt/tm/ltm/data-group/internal/$1" |jq .records --compact-output |sed 's/\[//g' | sed 's/\]//g'`

## Update address list in Spb
modips_spb=`printf '%s\n' "${dg_Spb//$newdg/}"`
payload_Spb="{\"records\":[${modips_spb}]}"
payload_Spb=`echo ${payload_Spb} |sed "s/\[,/\[/;s/,\]/\]/;s/,,/,/"`
curl -i -sku ${LOGIN} -H 'Content-Type: application/json' -X PATCH "https://${BIGIP_Spb}/mgmt/tm/ltm/data-group/internal/$1" -d ${payload_Spb} > result.tmp
if grep -q "HTTP/1.1 200 OK" result.tmp; then
		echo "SPB: IP address has been successfully deleted"
	else
    echo "SPB: IP address has NOT been deleted!!!!"
	fi

## Sync cluster in SPB
curl -i -sku ${LOGIN} -H 'Content-Type: application/json' -X POST "https://${BIGIP_Spb}/mgmt/tm/cm" -d '{"command":"run","utilCmdArgs":"config-sync to-group Novosibirsk"}' > result.tmp
	if grep -q "HTTP/1.1 200 OK" result.tmp; then
		echo "SPB: Cluster has been successfully synced"
	else
    echo "SPB: Cluster has not been synced!!!!"
	fi		


rm -f result.tmp

}

## Test for command inputs
if [[ "$1" == "add" ]]
then
    add_ips $2 $3
elif [[ "$1" == "del" ]]
then
    del_ips $2 $3
else
    display_usage
fi
exit 1
