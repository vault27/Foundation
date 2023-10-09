#!/bin/bash
## F5 Data Group Update Script
## Description: provides options to add IP, delete IP, and list the IPs in an existing Data Group
## Version: 1.0
## Requires: bash, curl, jq
## 
## Syntax:
##
##		Valid regions: MSK, SPB, SMR, EKB, NSK
##
##      To Add IP:
##      Command:    dg_custom.sh add <datagroup> <IP> <region>
##      Examples:   dg_custom.sh add dg-bypass 1.1.1.0/24 NSK
##                  
##      To List IPs:
##      Command:    dg_custom.sh list <datagroup> <region>
##      Example:    dg_custom.sh list dg-bypass SPB
##
##      To Delete IP:
##      Command:    dg_custom.sh del <datagroup> <IP> <region>
##      Examples:   dg_custom.sh del dg-bypass 1.1.1.1/32 SMR
##                  

##	IP addresses of all BIG-IPs
BIGIP_MSK="10.2.23.2"
BIGIP_SPB="10.2.23.2"
BIGIP_SMR="10.2.23.4"
BIGIP_EKB="10.2.23.4"
BIGIP_NSK="10.2.23.4"

##	Login
LOGIN='api:Test123!'

display_usage () {
    echo "   Data Group Update Script"
    echo ""
	echo "   Valid regions: MSK, SPB, SMR, EKB, NSK"
	echo ""
    echo "   To add IP to a data group:"
    echo "   dg_custom.sh add <datagroup> <IP> <region>"
    echo ""
    echo "   To list IPs in a data group:"
    echo "   dg_custom.sh list <datagroup> <region>"
    echo ""
    echo "   To remove URLs from a datagroup:"
    echo "   script del <category> <URL> <[exact-match|glob-match]> <region>"
    echo ""
    exit 1
}

add_ips () {

## Check IP address
	if [[ "$3" == "SPB" ]]
	then
		BIGIP=$BIGIP_SPB
		Cluster="Cluster"
    elif [[ "$3" == "SMR" ]]
	then
		BIGIP=$BIGIP_SMR
		Cluster=Novosibirsk
	elif [[ "$3" == "MSK" ]]
	then
		BIGIP=$BIGIP_MSK
		Cluster=Cluster
	elif [[ "$3" == "EKB" ]]
	then
		BIGIP=$BIGIP_EKB
		Cluster=Cluster
	elif [[ "$3" == "NSK" ]]
	then
		BIGIP=$BIGIP_NSK
		Cluster=Cluster
	else
		echo "No such region! Valid regions: MSK, SPB, SMR, EKB, NSK"
	fi

## Form data structure with new IP
newdg="{\"name\":\"$2\"}"

## Get current list of IPs
dg=`curl -sku ${LOGIN} -H 'Content-Type: application/json' -X GET "https://${BIGIP}/mgmt/tm/ltm/data-group/internal/$1" | jq .records --compact-output |sed 's/\[//g' | sed 's/\]//g'`

## Update data group
payload="{\"records\":[${dg},${newdg}]}"
curl -i -sku ${LOGIN} -H 'Content-Type: application/json' -X PATCH "https://${BIGIP}/mgmt/tm/ltm/data-group/internal/$1" -d ${payload} > result.tmp
if grep -q "HTTP/1.1 200 OK" result.tmp; then
		echo "IP address has been added successfully"
	else
    echo "IP address has NOT been added!!!!"
	fi	

##	Sync cluster
curl -i -sku ${LOGIN} -H 'Content-Type: application/json' -X POST "https://${BIGIP}/mgmt/tm/cm" -d '{"command":"run","utilCmdArgs":"config-sync to-group '"$Cluster"'"}' > result.tmp
	if grep -q "HTTP/1.1 200 OK" result.tmp; then
		echo "Cluster has been synced successfully"
	else
    echo "Cluster has not been synced!!!!"
	fi	
	rm -f result.tmp
}

del_ips () {

## Check IP address
	if [[ "$3" == "SPB" ]]
	then
		BIGIP=$BIGIP_SPB
		Cluster="Cluster"
    elif [[ "$3" == "SMR" ]]
	then
		BIGIP=$BIGIP_SMR
		Cluster=Novosibirsk
	elif [[ "$3" == "MSK" ]]
	then
		BIGIP=$BIGIP_MSK
		Cluster=Cluster
	elif [[ "$3" == "EKB" ]]
	then
		BIGIP=$BIGIP_EKB
		Cluster=Cluster
	elif [[ "$3" == "NSK" ]]
	then
		BIGIP=$BIGIP_NSK
		Cluster=Cluster
	else
		echo "No such region! Valid regions: MSK, SPB, SMR, EKB, NSK"
	fi

## Form data structure with new IP address
newdg="{\"name\":\"$2\",\"data\":\"\"}"	

	## Get current list of IPs
dg=`curl -sku ${LOGIN} -H 'Content-Type: application/json' -X GET "https://${BIGIP}/mgmt/tm/ltm/data-group/internal/$1" |jq .records --compact-output |sed 's/\[//g' | sed 's/\]//g'`

## Update address list in Moscow
modips=`printf '%s\n' "${dg//$newdg/}"`
payload="{\"records\":[${modips}]}"
payload=`echo ${payload} |sed "s/\[,/\[/;s/,\]/\]/;s/,,/,/"`
curl -i -sku ${LOGIN} -H 'Content-Type: application/json' -X PATCH "https://${BIGIP}/mgmt/tm/ltm/data-group/internal/$1" -d ${payload} > result.tmp
if grep -q "HTTP/1.1 200 OK" result.tmp; then
		echo "IP address has been deleted successfully"
	else
    echo "IP address has NOT been deleted!!!!"
	fi
##	Sync cluster
curl -i -sku ${LOGIN} -H 'Content-Type: application/json' -X POST "https://${BIGIP}/mgmt/tm/cm" -d '{"command":"run","utilCmdArgs":"config-sync to-group '"$Cluster"'"}' > result.tmp
	if grep -q "HTTP/1.1 200 OK" result.tmp; then
		echo "Cluster has been synced successfully"
	else
    echo "Cluster has not been synced!!!!"
	fi	

rm -f result.tmp

}

list_ips () {

## Check IP address
	if [[ "$2" == "SPB" ]]
	then
		BIGIP=$BIGIP_SPB
		Cluster="Cluster"
    elif [[ "$2" == "SMR" ]]
	then
		BIGIP=$BIGIP_SMR
		Cluster=Novosibirsk
	elif [[ "$2" == "MSK" ]]
	then
		BIGIP=$BIGIP_MSK
		Cluster=Cluster
	elif [[ "$2" == "EKB" ]]
	then
		BIGIP=$BIGIP_EKB
		Cluster=Cluster
	elif [[ "$2" == "NSK" ]]
	then
		BIGIP=$BIGIP_NSK
		Cluster=Cluster
	else
		echo "No such region! Valid regions: MSK, SPB, SMR, EKB, NSK"
	fi
curl -sku ${LOGIN} -H 'Content-Type: application/json' -X GET "https://${BIGIP}/mgmt/tm/ltm/data-group/internal/$1" |jq .records | grep name

}

## Test for command inputs
if [[ "$1" == "add" ]]
then
    add_ips $2 $3 $4
elif [[ "$1" == "del" ]]
then
    del_ips $2 $3 $4
elif [[ "$1" == "list" ]]
then
	list_ips $2 $3
else
    display_usage
fi
exit 1
