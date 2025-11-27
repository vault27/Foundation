# Checkpoint

## Security Gateway Blades

- Firewall
- Application control and URL filtering
- Data Loss Prevention
- IPS
- Antivirus
- Threat Emulation
- Threat Extraction
- AntiBot
- HTTPS Inspection
- Smartevent
- Identity Awarness
- VSX - ?
- ClusterXL
- L2 - ?
- IPSec VPN - ?
- Sandbalst Agent - ?
- Mobile Access
- AntiSpam and Email Security
- Content Awarness
- QoS
- Monitoring

## Security Management Server Software Blades

- Network Policy Management — to create and manage SG security policies
- Endpoint Policy Management — to create and manage Endpoint Security Policies
- Logging & Status – central logging and log consolidation functionality
- Workflow — Change Management Cycle functionality with ability to audit and approve certain policy management operations
- User Directory — User management and integration with external authentication solutions
- Provisioning — Centralized maintenance tool
- Compliance — Automated compliance tool for security and best practices audits
- SmartEvent — Log correlation and Security Events management tool

## Concepts 

- R80 layers
- Access policy can work in inline mode for layers or in ordered mode
- If acceleration is on, fw monitor sees only syn
- Before connecting smart console we configure via https: interfaces, routes, time, installation type, sic phrase
- cpconfig
- Multi domain manager contains management servers inside itself
- PLus we can install separate logging servers
- Multi domain server can be management or logging
- Management multi-domain server contains inside Domain Management Servers
- Logging multi-domain server contains Domain Log servers
- ClusterXL provides a method for high traffic volumes to be intelligently spread across multiple gateways
- SecureXL provides acceleration for multiple, intensive security operations by offloading the handling of those operations and acting as a director to distribute the traffic to remaining cores
- CoreXL distributes IPS inspection to run in parallel on multi-core processor systems
- Smart update - keep OS, patches, licenses current
- Central license is better than local one

Ports

- TCP 256 Manager > Gateway
- TCP 257 Gateway > Log server
- Client authentication daemon listens:
- 259 - telnet
- 900 - http
- Check Point uses a proprietary protocol to test if VPN tunnels are active, and supports any site-to-site VPN configuration. Tunnel testing requires two Security Gateways, and uses UDP port 18234. Check Point tunnel testing protocol does not support 3rd party Security Gateways
- SmartUpdate to User center - 443
- R80 Smart Console to manager:
- 19009
- 18190
- 18264

Rule processing order

- Anti-spoofing checks
- First Implicit Rules
- Explicit Rules (except for the final rule)
- Before Last Implicit Rules
- Last Explicit Rule (should be cleanup rule)
- Last Implicit Rules
- Network Address Translation

Rule types:

- management - configure who can connect to firewall
- stealth - deny all direct connections to firewall
- internal - if we want to permit everything from 1 particular user
- cleanup - deny everything, used for logging of denied traffic
- many implied rules

History

- First product - Firewall 1
- Than VPN-1
- Devised stateful inspection

SMART architecture
Security management architecture
Console, Management and gateway

Policy is stored on management server and pushed to all gateways
For good performance it is recomended to use Auto NAT instead of Manual

Application awareness

Operating systems:

- IPSO - based on BSD, deprecated
- SecurePlatform - SPLAT - based on Redhat
- GAiA - since 2012, the latest one

SmartEvent requires

- Correlation Unit
- Server
- Client

Versions of firewall itself:

- R61
- R62
- R65
- R70
- R71
- R75
- R76
- R77
- R80

Checkpoint calls stateful inspection - INSPECT engine
Logs to third party can be provided via LEA - Log Export Api



## CLI

Service:

```
create tcp_service tcp_8081
modify services tcp_8081 port 8081
```

```
create udp_service udp_8082
modify services udp_8082 port 8082
```

Group:

```
create network_object_group host-group
add element network_objects host-group '' network_objects:host-100
```

Host:

```
create host_plain host-10
modify network_objects host-10 ipaddr 192.0.2.10
```

Net:

```
create network net-internal
modify network_objects net-internal ipaddr 192.0.2.0
modify network_objects net-internal netmask 255.255.255.0
```

## Mass add networks to database

```
#! /bin/bash

rm add_net

mask2cdr ()
{
   # Assumes there's no "255." after a non-255 byte in the mask
   local x=${1##*255.}
   set -- 0^^^128^192^224^240^248^252^254^ $(( (${#1} - ${#x})*2 )) ${x%%.*}
   x=${1%%$3*}
   echo $(( $2 + (${#x}/4) ))
}

while read line
do

echo $line
ip=`echo $line | cut -d ' ' -f 1`
netmask=`echo $line | cut -d ' ' -f 2`
net=$(mask2cdr $netmask)

echo "create network net_"$ip"_$net" >> add_net
echo "modify network_objects net_"$ip"_$net ipaddr $ip" >> add_net
echo "modify network_objects net_"$ip"_$net netmask $netmask" >> add_net

done < nets
echo "update_all" >> add_net
echo "savedb" >> add_net
cat add_net
```

## Add networks from Palo Alto

```
#! /bin/bash

cdr2mask (){
  # Number of args to shift, 255..255, first non-255 byte, zeroes
  set -- $(( 5 - ($1 / 8) )) 255 255 255 255 $(( (255 << (8 - ($1 % 8))) & 255 )) 0 0 0
  [ $1 -gt 1 ] && shift $1 || shift
  echo ${1-0}.${2-0}.${3-0}.${4-0}
}

rm add_net
cat nets | sed 's=/=;=g' > nets2

while read line
do

echo $line
name=`echo $line | cut -d ';' -f 1`
ip=`echo $line | cut -d ';' -f 2`
netmask=`echo $line | cut -d ';' -f 3`
netmask2=$(cdr2mask $netmask)

echo "create network $name" >> add_net
echo "modify network_objects $name ipaddr $ip" >> add_net
echo "modify network_objects $name netmask $netmask2" >> add_net

done < nets2

echo "update_all" >> add_net
echo "savedb" >> add_net

```

## VSX

Benefits

- Reduce Hardware expenses
- Simplify management
- Expand and scale network environment
- Centralized provision of security gateways

Two modes

- Routing
- Bridge - exclude VPN and NAT

Every VS has its own

- Network
- Inspect engine
- Kernel 
- Configuration
- Policy
- SIC
- File handling
- CP registry

Virtual components include:

- Security Gateways
- Routers
- Switches
- Cables

4 types of links:

- warp links - direct connection, created automatically, for example between VS and virtual router. On VS side it has prefix wrp. On virtual switch side it has prefix wrpj. Virtual mac is automatically created.
- Virtual (VLAN) interfaces - used to connect to external switch with tags
- Physical interfaces
- Unnumbered interfaces - The following limitations apply to Unnumbered Interfaces:
	- Unnumbered interfaces must connect to a Virtual Router.
	- You can only "borrow" an individual interface IP address once.
	- In order to use VPN or Hide NAT, the borrowed address must be routable.

Virtual Systems support:

- OSPF
- RIP
- BGP
- PIM

Virtual System Load Sharing (VSLS)

- For example, Active Virtual System 1 runs on VSX Cluster Member A, while Active Virtual System 2 runs on VSX Cluster Member B

Deployment strategies

- Physical Internal Interface for Each Virtual System
- Virtual Systems with Internal VLAN Interfaces
- Internal Virtual Router with Source-Based Routing
- Virtual Systems in Bridge Mode

Concepts

- 64 per virtual system, 128 max  interfaces
- 4096 interfaces per VSX gateway
- Virtual Systems can be managed by  different  Domain Management Servers
- Remote management connects via a Virtual System are not supported
- Non-DMI is irreversible - you cannot change from a non-DMI VSX Gateway to a DMI VSX Gateway
- When you create a Virtual Device, VSX automatically establishes SIC trust using the secure communication channel defined between the Management Server and the VSX Gateway
- The VSX Gateway uses its management interface for Secure Internal Communication between the Management Server and all Virtual Devices.
- Routes are automatically added to virtual systems from adjacent virtual systems
- Virtual switch can have only one interface
- In VS we can change only interface and VLAN
- Two modes of management are available: Direct management  interface and non direct.  vsx_util_reconfigure command is not  available during non direct. 
- Route propagation to adjacent  virtual devices is available for physical interfaces  and is configured in topology section of virtual system
- Bonding groups and management interface must be configured before converting gateway to VSX
- wrpj interfaces represent the Virtual Router/Switch side of the connection
- wrp interfaces represent system side of the connection

You can jump to any virtual device (Gateway, router, switch) with vsenv command using ID:

```
vsenv 2
ifconfig
```

Cluster

- We prepare 2 devices: configure networks and HA interfaces
- No IP addresses on phisical interfaces
- VSX license on each gateway
- Then we configure IP for VSX cluster
- And install policy on cluster - it controls traffic to cluster itself

Deployment process

1. The management server stops its current operations to deploy the Virtual System.
2. The target Virtual System’s object receives an update.
3. The Virtual System sends its configuration changes to the management server.
4. The management server pushes out the Virtual System configuration changes to the physical VSX Gateway (VS0).
5. The target Virtual System (VS1 and above) receives its network configuration script (local.vsall.files).

Disable VSX mode

```
set virtual-system 0
set vsx off
show vsx
```

Maximum amount of concurent connections in VSX

```
vsx_1 (X80): [vs0] root$ vsx stat -v -l

<output removed>
Connections number: 0
Connections peak: 0
Connections limit: 15000 (this is the value configured in the GUI)
```

Reset gateway deleting all virtual sytems

```
reset_gw
```

Virtual switch


We create it, specify physical interfaces to which it is connected, can also specify VLAN.
Delete virtual switch on management server

```
vsx_provisioning_tool -s localhost -u admin -p 123qwe -o remove vd name VS2
```

Virtual System

We create it and assign interfaces to it, and provide IP addresses for them also we may send routes to other virtual systems.
We also configure default route.
We create a separate policy for every virtual system and install it.
Configure dinamic routing:

```
set virtual-system <Virtual system ID>
commands to enable dynamic routing
save config
```

In this case it is better to disable automatic topology calculation

## Useful commands

R80.20

```
# cphaprob stat     > with more clusterxl informations
# fwaccel ranges   > show's anti spoofing ranges
# fw ctl multik utilize   > shows the CoreXL queue utilization for each CoreXL FW instance
# # fw ctl multik print_heavy_conn   > shows the table with heavy connections
```

Disable SSH timeout for current session

```
export TMOUT=0
```

Create Backup from CLI

```
add backup scp ip 192.168.181.182 path /CPbackup/ username scp interactive password SCP001
```

Change MAC address

```
dbset interface:eth0:hwaddr 01\:0f\:90\:d7\:4e\:00
dbset :save
```

```
cpstat os
```

Shows inbound and outbound chains

```
fw ctl chain
```

COntrol watch dog and processes

```
cpwd_admin
```

Erase all CRLs

```
vpn crl_zap
```

Turn off SecureXL

```
fw accel off
```

Check if SecureXL is enabled

```
fwaccel stat
```

Show service accounts

```
adlog a service_accounts
```

Set admin shell to bash

```
set user admin shell bash
```

Block source

```
fw sam -J src IP
```

On Manager manage versions:

```
dbver
create new-db-ver comments
print_all
```

switch to new log file

```
fw logswitch 
```

all network configuration

```
/etc/sysconfig/netconf.C - 
```

Unlock user on management server with CLI:

```
fwm lock_admin -u account_name
```

On Manager users:

```
show users
add user philipp uid 555 homedir /home/Bubba
set user philipp newpass abc123
delete user philipp
```

Create local backup

```
add backup local
show backup status
/var/CPbackup/backups
set backup restore local <tab>
```

Check license

```
cplic check identity
cplic print
```

Show interfaces brief

```
fw getifs
```

Show all interfaces configuration

```
show interfaces all
```

Show bonded interfaces

```
show bonding groups
```

show firewall stat:

```
fw stat
```

unload policy directly from firewall

```
fw unloadlocal
```


show configurations

```
show configuration
show configuration interface
show route
```

Show uptime

```
uptime
```

Get policy back to firewall

```
fw fetch localhost
fw fetch 10.1.1.25
fw fetch cio.pr2
```

show static routes

```
show route static
```

save configuration

```
save config
```

Delete route

```
set static-route 206.75.34.158/32 off
```

Delete path

```
set static-route 192.0.2.100 nexthop gateway address 192.0.2.18 off
```

Add static route

```
set static-route 216.7.218.0/24 nexthop gateway address 142.178.52.232 on
```

Lock database

```
clish -c "lock database override" >/dev/null 2>&1
```

Delete SNMP community

```
clish -c "delete snmp community m1bv1ew"
```

Set SNMP community

```
clish -c "set snmp community p0LL1ng4SioP5 read-only"
```

SNMP traps

```
clish -c "delete snmp traps receiver 209.202.66.5"
clish -c "add snmp traps receiver 96.1.255.176 version v2 community public"
```

Unlock database

```
clish -c "unlock database"
```

Show SNMP

```
clish -c "show snmp communities"
clish -c "show snmp traps receivers"
```

Generate SNMP trap

```
clish -c 'set snmp agent off'
clish -c 'set snmp agent on'
```

Show policy based routing

```
show pbr summary
```

Show routes in R75 in Expert mode

```
ip route show
ip rule show
ip route show table "table name"
```

New static route in R75 in expert mode:

```
ip route add 142.174.14.194 via 209.53.137.161 dev eth5.35
ip route add 100.65.253.128/25 via 0.0.0.0 dev bond0.2202
save_ifconfig --save
route --save
```

Restart SNMP service R75

```
NokiaIP690:102> set snmp daemon off
NokiaIP690:103> set snmp daemon on
```

Check SNMP localy R75 IPSO

```
snmpget -v 2c -c DrumStickS localhost .1.3.6.1.2.1.1.5.0
```

Restart SNMP R75.10

```
snmp service disable
snmp service enable
```

Kernel tables

```
fw tab | grep -e "----" | more
or
fw tab -s
```

Connections (sessions) table
The fw tab command shows data from the kernel tables, and lets you change the content of dynamic kernel tables. You cannot change the content of static kernel  tables. 

Show connections stats

```
fw tab -t connections -s
```

Show all connections

```
fw tab -t connections -u -f

-f shows formatted version of table data
-u show unlimited table version
```

Grep

```
fw tab -t connections -f | grep 'IPaddr' | awk '{print "Source:",$9,"Source Port:",$11,"Destination:",$13,"Destination Port:",$15,"Protocol",$17,"Rule Number:",$23;}'
```

or you can use cpview on R77 firewalls

**Interfaces**

Here’s the commands to verify the bonded interfaces, you’ll need to verify they are up as well as the physical interfaces

```
cat /proc/net/bonding/bond0
cphaconf show_bond bond0
```

