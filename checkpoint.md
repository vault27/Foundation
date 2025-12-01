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

**NAT order**

- Manual - pre automatic NAT
- Automatic static NAT
- Automatic Hide NAT
- Post automatic/Manual NAT

SRC NAT is done on server side
DST NAT is done on client side

When we create Hide NAT it works only when source from inside is trying to connect to destination outside, not vice versa.
When we create automatic static nat it works in both directions.

**Authentication in firewall rules**

- User authentication - can be configured only for HTTP, FTP, HTTPS, rlogin, Telnet. Very intrusive, is not applied first in rule base
- Session authentication - requires agent, does not fit for HTTP because HTTP creates many sessions.
- Client authentication - per IP address, after auth rules are allowed for this IP

**Daemons**

- cprid - upgrade operations - listen on Gateway for connections from Management server
- cpd (Checkpoint Daemon) - core process: SIC functionality(port18xxx), licenses operations, listen on Gateway for connections from Management server, transfer messages between processes, policy installation, pull the application monitoring status from the GW/Management using Smart Event
- pdp and pep - Identity awareness
- confd - provides access to GAIA configuration database
- fwm (Firewall management) - available on all managament servers: if smartdashboard login fails, gui client communication, database manipulation, policy compilation, management HA sync
- fwd - allows other processes to forward logs to external log server, responsible for other security processes, responsible for full sync in ClusterXL, responsible for kernel tables info across cluster memebers
- fw kernel - responsible for delta sync in Cluster XL
- cpwd - checkpoint watchdog
- fwssd - child process of fwd, maintain SMS, maintain security servers
- cplmd - starts when Smartview tracker starts
- vpnd - authenticates IPSec vpn users
- cvpnd - SSL VPN
- snd - secure network distributor - process incoming traffic and distributes among kernel instances
- gated - manages dynamic routing protocols
- fw gen - compiles $FWDIR/conf/*.W files into machine language

**Configuration files**

- $FWDIR/conf/fwauthd.conf - security server configuration
- $FWDIR/conf/fwauth.NDB - user definition
- $FWDIR/conf/vpn_route.conf - VPN routing
- ike.elg - log file about negotiation encryption
- vpnd.elg - verbose info about vpn failures
- $RTDIR/distrib and $RTDIR/events_db - all system events
- $RTDIR/Database/conf/my.cnf - Smart Reporter database settings in Linux
- %RTDIR%\Database\conf\my.ini - in Windows

## VPN AD CA certificate

- Gateway options > IPSec VPN > Import certificate
- Gateway options > VPN Clients > Authentication > certificate
- Gateway options > VPN Clients > gateway authenticates with certificate....
- Gateway options > Mobile Access > Authentication > certificcate
- Manage > OPsec > New CA
- Manage > Opsec >  new LDAP account unit
- Create LDAP group mandatory
- configure OCSP

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

```bash
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

```bash

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

## Script add ranges

```bash
#! /bin/bash
rm add_range

while read line
do
echo $line
name=`echo $line | cut -d";" -f 1`
ip1=`echo $line | cut -d";" -f 2`
ip2=`echo $line | cut -d";" -f 3`
comment=`echo $line | cut -d";" -f 4`

echo "create address_range $name" >> add_range
echo "modify network_objects $name ipaddr_first $ip1" >> add_range
echo "modify network_objects $name ipaddr_last $ip2" >> add_range

if [ -n "$comment" ]
then
echo "modify network_objects $name comments $comment" >> add_range
fi

done < ranges.csv

echo "update_all" >> add_range
echo "savedb" >> add_range
```

## Script add nets

```bash
#! /bin/bash

cdr2mask (){
  # Number of args to shift, 255..255, first non-255 byte, zeroes
  set -- $(( 5 - ($1 / 8) )) 255 255 255 255 $(( (255 << (8 - ($1 % 8))) & 255 )) 0 0 0
  [ $1 -gt 1 ] && shift $1 || shift
  echo ${1-0}.${2-0}.${3-0}.${4-0}
}

rm add_net
rm nets2

cat nets.txt | sed 's=/=;=g' > nets2

while read line
do

echo $line
name=`echo $line | cut -d ';' -f 1`
ip=`echo $line | cut -d ';' -f 2`
netmask=`echo $line | cut -d ';' -f 3`
netmask2=$(cdr2mask $netmask)
comment=`echo $line | cut -d ';' -f 4`

echo "create network $name" >> add_net
echo "modify network_objects $name ipaddr $ip" >> add_net
echo "modify network_objects $name netmask $netmask2" >> add_net

if [ -n "$comment" ]
then
echo "modify network_objects $name comments $comment" >> add_net
fi

done < nets2

echo "update_all" >> add_net
echo "savedb" >> add_net
```

## Script add hosts

Make sure that there are no spaces, no objects start with a number, no dublicates and end of line is in Linux format

```bash
#! /bin/bash
rm add_ip
while read line
do
echo $line
name=`echo $line | cut -d";" -f 1`
ip=`echo $line | cut -d";" -f 2`
comment=`echo $line | cut -d";" -f 3`

echo "create host_plain $name" >> add_ip
echo "modify network_objects $name ipaddr $ip" >> add_ip
if [ -n "$comment" ]
then
echo "modify network_objects $name comments $comment" >> add_ip
fi

done < hosts

echo "update_all" >> add_ip
echo "savedb" >> add_ip
```

And then

`dbedit -globallock -f add_ip`

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

## R75, R55

FW monitor on R55

```
fw monitor -e "accept dst=10.63.8.60;"
```

Manage managers on R75 cli

```
mdsstat
mdsstop hsia.dms
mdsstart hsia.dms
```

Kill the process

```
mdsstop_customer hsia.dms fyi
```

and then make sure the process is dead

```
mdsstat
```

## Troubleshooting

- `cphaprob stat`  > with more clusterxl informations
- `fwaccel ranges`  > show's anti spoofing ranges
- `fw ctl multik utilize`  > shows the CoreXL queue utilization for each CoreXL FW instance
- `fw ctl multik print_heavy_conn` > shows the table with heavy connections
- `cpinfo -y all` - Show all hotfixes installed
- `fwaccel stat` - Check if SecureXL is enabled - This command also shows if Drop Templates are enabled. Drop templates accelerate drops with Secure XL. If you have many drops, it may help.
- `$CPDIR/log/cpwd.elg` - cpd daemon does not work, 18191 port does not listen, policy cannot be pushed
- During the tracert Checkpoint replies with interface address of Cluster, not from the address of 1 particular fw
- `fw ctl zdebug + drop | grep 1.1.1.1` - See all dropped connections and more importantly the reason (e.g. anti-spoofing, IPS , FW rule)
- `cpstat fw` - Quickly see stats of number of connections (accepted,denied,logged) with a breakdown
- Capture traffic

```
fw monitor | grep 1.1.1.1
fw monitor -e 'accept host(75.154.130.239) and host(100.70.184.5);
fw monitor -e 'accept host(100.66.100.16) and udpport(69);'
fw monitor -e "accept;" -o capture.pcap
tcpdump -s 0 -nn -w capture.pcap -i bond2.340 host 192.168.180.19 and port 443
```

- `cpview; show sysenv all; show asset` -  hardware
- `fw ctl chain` - Shows inbound and outbound chains
- `cpwd_admin list; cpwd_admin stop -name FWM` - Control watch dog and processes
- `vpn crl_zap` - Erase all CRLs
- `fw accel off` - Turn off SecureXL
- `fw ctl pstat` - Gather statistics about the connections
- `fw tab -t connections -s` - Show amount of connections
- Hold table issues: Issue description: traffic is silently dropped, and fw ctl zdebug + drop shows the following: `dropped by fw_filter_chain Reason: chain hold failed;`
- `fw tab -t hold_table -s` - Show state of hold table
- `fw ctl get int fwhold_limit` - Show hold table limit
- To solve this issue we need to increase hold limit, install policy, and optimize policy: all access role rules to the bottom

## Smart event + logging

You can deploy SmartEvent in these ways:
- As part of the SmartEvent – A renewable one year license is included with the SmartEvent
package
- As a dedicated server – You can purchase a perpetual license for a SmartEvent Server

Three modes in Smarttracker:
- Log
- Active
- Audit - super detail

Many predefined quieries + you can create custom
Logs are stored: /$FWDIR/log
Smartlog searches all logs, tracker only fw.log
By default firewall does not store logs by itself, it sends them to management server, but we can configure it manually
Email alerts, SNMP traps
We can block people right from SmartTracker
We also have Smartlog and Smart reporter to deal with many log files simultaneously 
Smarttracker watches only on current log file
Active mode in Smarttracker overloads system

See where firewall sends logs, on firewall itself: `netstat -an | grep 257`

Search logs in multidomain

```
mdsenv mobility.dls
mcd log

fw log -ftnlp | grep <ip>
fw monitor -e 'accept host(172.23.96.71);'
```

Syslog

- Earlier OPSEC and LEA were used.
- Now Log Exporter is primarly used. It is integrated into system since R80.10.
- Filtering based on fields is supported but only from certain versions in 80.20 and 80.30.

## VPN

Steps:

- Enable on Gateway
- ID DOmain
- Create community
- Add rules

Community members - firewalls themselves
Domains -  local networks behind firewalls
VPN site = domain + member

vpn tu - toll on firewall itself to manage VPNs
Domain based takes precedence over route based
Communities may be star or full mesh.

Remote access
- Which addresses will clients get - `Gateway options > VPN clients > Office mode > manual Using pool`
- When using Office Mode, a special IKE mode called config mode is inserted between phase 1 and phase 2 of IKE. During config mode, the client requests an IP from the Security Gateway. Several other parameters are also configurable this way, such as a DNS server IP address, and a WINS server IP address
- A remote user with SecuRemote only is not supported in Office Mode
- IPSec is used with NAT-T: ESP is encapsulated into UDP port 4500
- UDP 4500 and TCP 443 are always used for RA VPN

MEP
- MEP gateways are not restricted to geography
- They can be managed by different management servers
- VPN client selects the secondary gateway
- MEP VPNs use proproetary Probing Protocol (PP) to send special UDP RDP packets to port 259

Troubleshooting

```
vpn debug on > check $FWDIR/log/ike.elg, vpnd.elg
```

Verify that all tunnels are established
```
vpn tunnelutil
```

Verify that configured properly - `vpn shell show interface detailed <VTI name>`

Wire mode
- Allows traffic to pass without any inspection from trusted sources to trusted sources. Based on routed VPN.
- Enabed on Gateway or on Comminity

## Sandblast

- Обязательная лицензия NGTX
- Ставится на шлюз или на саму песочницу если она работает одна без шлюза Чекпоинта
- Threat Extraction - присылает пользователю пдфку вместо файла или просто пустой файл - без задержек - это же поддерживается в агенте
- Агент все отправляет в облако
- Агент постоянно собирает кучу информации локально, если срабатывает триггер, то агент сгенерит мега отчет о том откуда что и как пришло, для логов нужен 1 гиг
- Краковременные бекапы - 1 гб, для защиты от шифровальщиков, сразу после запуска шифровальщика агент определяет это, восстанавливает файлы из бэкапа, и блочит шифровальщика и создает отчет для расследования
- Самый полный агент - это Checkpoint Endpoint Security - в него все входит включая сандбласт агент
- Threat Emulation - запуск в виртуалке - 4 минуты примерно
- Для агета управлялка обязательня

Useful CLI

Show images status
```
tecli show downloads images
```

Disable persistancy mode before clearing queue, or all files will be back!!!
```
tecli ad per set enable 1
tecli ad per show
```

Show files in cache
```
tecli cache sha1 c92bb9e83cc1ec1f6614c060fb819f34670629b9
```

Remove file from cache
```
tecli cache remove sha1 c92bb9e83cc1ec1f6614c060fb819f34670629b9
```

Show file emulation queue
```
tecli show emulator queue
```

Find file in queue
```
tecli show emulator queue | grep sha1_of_this_file
```

Show file status in a queue
```
tecli s e e | grep filename
```

Show queue status
```
tecli s e e | grep "Pending emulating" -A 2
```

Remove file from cache
```
tecli cache remove sha1 _sh1_of_file
```

Cache by default is 7 days
Configure cache
```
tecli ca ttl
```

Show engine version
```
tecli ad en ve
```

Kill process
```
fw kill ted
```

On gateway check if file is still emulated based on part of its SHA-1
```
tecli s r q | grep -i c92bb9E83
```

### Sandblast Agent

Sandblast agent content:

- Threat Emuation
- Threat Extraction
- Anti Exploit - браузеры флеш адоб ридер офис
- Zero fishing  - защита в браузере от кражи учеток, плагин
- Форензика - для расследования, все логируется
- Anti Ransomware - против шифровальщиков
- Behaviral guard - сравниваются деревья и блокируется на основе анализа без песочницы, чтобы работала нужно днлиться форензикой
- Antibot
- Firewall + application control + compliance - implicitly included, explicitly in Cpmplete bundle
- Possible Anti-malware - Kaspersky, then it is called NExt Gen Antivirus
 
License types:

- Anti ransomware
- Sandblast agent
- Next gen antivirus
- Complete

For pilot we need 

1. Management server
2. AD server
3. Couple of VMs with agents
4. Take snapshot of al VMs at one time
5. Acess to VMs via RDP without buffer or VMware client
6. Do not integrate with local Sandblast device

Good for TLS 1.3 and GOST as no need decryption

Anti bot modes:
1. Detect and alert
2. Hold and prevent
Antibot on agent does support inspection of encrypted traffic, or works only with http and IPs

Antifishing starts analyzing a page only after you click on input field
openphish.com
Smartendpoint console program
Gui dbedit is often used
Agent does not support proxy at all

## Optimization

- Firewall policy: Rules with access roles in the very bottom
- Firewall policy: top hit hit rules in the top
- HTTPS policy: rules with categories in the very bottom, as minimum rules as possible
- HTTPS policy: access roles rules can damage whole policy, use with care
- Delete log files base on percentage, not megabytes
- Smartevent correlation unit should be on a log server
- Sandblast policy should contain only threatemulation blade
- Threat prevention rules should be minimum

## Threat prevention

- Threat prevention policy uses multi match approach, where traffic is matched against all rules in all layers
- You can use layers for different protection scopes
- Different admins can work with difeerent layers
- We can use speicific layer for specific blade

Threat Prevention Layers enforcement is calculated by the following:

- Each layer has a first-match logic. Once a match is found, processing is done at the other layers.
- Unlike Access Control, there is no requirement for clean-up rule. So if there is no match on a layer, assumption is that no threat prevention inspection is needed.
- In case there are multiple threat prevention layers, and a match was found in several layers, the strictest option matters. So if you chose to prevent a protection for a subnet in the first layer but detect that protection in another layer, it will be in prevent

Search for emulated cab files from microsoft.com in Logs in R80.10

```
blade:"Threat Emulation" AND file_name:*.cab AND *microsoft.com*
```

Troubleshooting:

Collect logs `$FWDIR/log/cpm.elg*`
`$FWDIR/log/install_policy.elg*`

If it's IPS update failure, run debug

```
fw debug fwm on TDERROR_ALL_ALL=5
```

Run update, disable debug

```
fw debug fwm off
```
## Capsule

- Capsule WorkSpace - is a mobile security container that creates an isolated corporate workspace on personal devices, making it simple to secure corporate data and assets both inside and outside the corporate network.
- Capsule Docs - is a secure mobile document management system that follows your documents wherever they go, making sure you have complete control over who is accessing sensitive data and what they can do with it.
Encryption, authentication, authorization, sharing.
- Capsule CLoud - offers real-time protections by directing all traffic from laptops through a secure tunnel to the cloud where corporate policies are enforced. A single policy can be applied for both on premise and off premise laptops that is centrally managed through SmartConsole or remotely through an intuitive web user interface for pure cloud deployments
- IPS
- Application Control
- URL Filtering
- Antivirus
- Anti-Bot
- Threat Emulation
- VPN (IPsec)

## Secure XL

- Performance pack uses SecureXL technology to accelerate traffic
- Implemented in software
- Drop Template - Feature that accelerates the speed, at which a connection is dropped by matching a new connection to a set of attributes. When a new connection matches the Drop Template, subsequent connections are dropped without performing a rule match and therefore are accelerated. Currently, Drop Template acceleration is performed only on connections with the same destination port.
- Accelerated path - Packet flow when the packet is completely handled by the SecureXL device. It is processed and forwarded to the network.
- Firewall path / Slow path (F2F) - Packet flow when the SecureXL device is unable to process the packet (refer to sk32578 - SecureXL Mechanism). The packet is passed on to the CoreXL layer and then to one of the Core FW instances for full processing. This path also processes all packets when SecureXL is disabled.

Allocate network interface to core

```
sim affinity
```

Show status

```
fwaccel stat
```

## Inspection points

- 1st - i – Pre-inbound - rule/inspection is applied at this point
- 2nd - I – Post-inbound - after being permitted by the rule/inspections
- 3rd - o – Pre-outbound - route look up has been performed to determine the egress interface
- 4th - O – Post-outbound - after egressing the correct firewall interface based on route lookup

The vast majority of firewall security operations (and possible drops) happen on the inbound/client side of the firewall kernel between "i" and "I" such as:

- Inbound Anti-spoofing
- Geo Policy
- HTTPS/VPN decryption
- Connections state table lookups
- Access Control policy layer evaluation
- Destination IP NAT
- Threat Prevention policy layer evaluation

Between "I" and "o" the Gaia IP driver performs routing.

Between "o" and "O" on the outbound/server side of the firewall kernel, the following types of operations occur:

- Outbound Anti-spoofing
- HTTPS/VPN encryption
- Source IP NAT

## NAT

- It is possible to configure 2 NAT ruls wich match a connection, but only when using Automatic NAT (bidirectional NAT)

## BGP

- Restrict sending routes to peer from which we got these routes and redistribute one directly connected network
- Allow all other routes to be exported and imported

```
set routemap FILTER_LAN_OUT id 1 on
set routemap FILTER_LAN_OUT id 1 restrict
set routemap FILTER_LAN_OUT id 1 match nexthop 172.31.41.73 on
set routemap FILTER_LAN_OUT id 2 on
set routemap FILTER_LAN_OUT id 2 allow
set routemap FILTER_LAN_OUT id 2 match interface bond3.342 on
set routemap FILTER_LAN_OUT id 2 match protocol direct
set routemap FILTER_LAN_OUT id 3 on
set routemap FILTER_LAN_OUT id 3 allow


set bgp external remote-as 64900 on
set bgp external remote-as 64900 peer 172.31.41.73 on
set bgp external remote-as 64900 peer 172.31.41.73 holdtime 15
set bgp external remote-as 64900 peer 172.31.41.73 keepalive 5
set bgp external remote-as 64900 peer 172.31.41.73 graceful-restart on
set bgp external remote-as 64900 peer 172.31.41.73 export-routemap "FILTER_LAN_OUT" preference 2 on
set bgp external remote-as 64900 peer 172.31.41.73 import-routemap "allow" preference 1 on
```

## Core XL

- CoreXL is a Check Point technology that allows firewall and IPS security code to run on multiple processors/cores concurrently
- The CoreXL layer accelerates traffic that cannot be handled by the SecureXL device or traffic that requires deep packet inspection
- CoreXL is able to provide near linear scalability of performance, based on the number of processing cores on a single machine 
- This increase in performance is achieved without requiring any changes to management or network topology
- In a CoreXL gateway, the firewall kernel is replicated so that each replicated copy (instance) runs on a processing core. These instances handle traffic concurrently, and each instance is a complete and independent inspection kernel
- CoreXL improves performance with almost linear scalability in the following scenarios:
    - Much of the traffic can not be accelerated by SecureXL
    - Many IPS features enabled, which disable SecureXL functionality
    - Large rulebase
    - NAT rules
- The CoreXL software architecture includes the Secure Network Distributor (SND). The SND is responsible for:
    - Processing incoming traffic from the network interfaces
    - Securely accelerating authorized packets (if SecureXL is running)
    - Distributing non-accelerated packets or Medium Path packets among CoreXL FW kernel instances - this functionality is also referred to as dispatcher
- The dispatcher is executed when a packet should be forwarded to a CoreXL FW instance (in Slow path and Medium path - see sk98737 for details) and is in charge of selecting the CoreXL FW instance that will inspects the packet
- In R77.20 and lower versions, traffic distribution between CoreXL FW instances is statically based on Source IP addresses, Destination IP addresses, and the IP 'Protocol' type. Therefore, there are possible scenarios where one or more CoreXL FW instances would handle more connections, or perform more processing on the packets forwarded to them, than the other CoreXL FW instances.
- This may lead to a situation, where the load is not balanced across the CPU cores, on which the CoreXL FW instances are running
- To help mitigate the above issue, CoreXL Dynamic Dispatcher feature was introduced in R77.30 Security Gateway.
- The new dynamic assignment mechanism is based on the utilization of CPU cores, on which the CoreXL FW instances are running
- R77.30 - To check the current mode on Security Gateway: `[Expert@HostName]# fw ctl multik get_mode`
- Enable: `[Expert@HostName]# fw ctl multik set_mode 9`
- In R80 is enabled by default
- Show: `[Expert@R80.10:0]# fw ctl multik dynamic_dispatching get_mode`
- Current mode is On
- Enable: `[Expert@HostName]# fw ctl multik dynamic_dispatching on`
- Change number of firewall instances: cpconfig, reboot required
- CoreXL will not improve performance in the following scenarios:
    - SecureXL accelerates much of the traffic
    - Traffic mostly consists of VPN
    - Traffic mostly consists of VoIP
- Affinity - Association of a particular network interface / FW kernel instance / daemon with a CPU core (either 'Automatic' (default), or 'Manual')
- Note: The default CoreXL interface affinity setting for all interfaces is 'Automatic' when SecureXL is installed and enable
- You can configure the number of firewall kernel instances (fw_worker) on a on a multi-core Check Point gateway via 'cpconfig'
- Show status and connection table for each core:`fw ctl multik stat`
- When configuring the CoreXL in 'cpconfig' menu, the configuration is saved in the /etc/fw.boot/boot.conf file
- Number of CoreXL FW instances must be identical on all members of the cluster because the state synchronization between members is performed per CoreXL FW instance
- Traffic is processed by the CoreXL FW instances only when the traffic is not accelerated by SecureXL
- VPN and VoIP are not load balanced with CoreXL and always handled by the same FW instance.
- Multi-queue lets you configure more than one traffic queue for each network interface. This means more than one CPU can be used for acceleration

## Policies

- A policy package is a collection of different types of policies.

- A policy package can have one or more of these policy types:
- Access Control - consists of these types of rules:
    - Firewall
    - NAT
    - Application & URL Filtering
    - Content Awareness
- QoS - Quality of Service rules for bandwidth management
- Desktop Security - the Firewall policy for endpoint computers that have the Endpoint Security VPN remote access client installed as a standalone client.
- Threat Prevention - consists of:
    - IPS - IPS protections continually updated by IPS Services
    - Anti-Bot - Detects bot-infected machines, prevents bot damage by blocking bot commands and Control            (C&C) communications
    - Anti-Virus - Includes heuristic analysis, stops viruses, worms, and other malware at the gateway
    - Threat Emulation - Detects zero-day and advanced polymorphic attacks by opening suspicious files in a         sandbox
    - Threat Extraction - Extracts potentially malicious content from e-mail attachments before they enter the         corporate network
- You can organize the Access Control rules in more manageable subsets of rules using Ordered Layers and Inline Layers
- An Inline Layer is a sub-policy which is independent of the rest of the Rule Base - it is like Section, but there are Sections themselves as well
- Ordered layers are just processed one bby one and can be used in different policy packages. Layers may be for Access control and may be for Threat Prevention

## Cluster XL

- Load sharing can be multicast or unicast. If it is unicast then pivot member gets all packets and then sends them to the other members. Pivot is choosen automatically buy ClusterXL
- Multicast - router sends packets to all members via multicast, only one member processes it, others drop it, not all routers can support it
- IPv6 is not supported in load sharing
- During Failover cluster sends gratuitous ARP request to inform everyone about new MAC address
- Cluster XL uses virtual IP and physical IP for every gateway
- ClusterXL uses Cluster Control Protocol (CCP) to sync connections, UDP 8116
- High availability does not require additional licenses
- Load sharing requires Acceleration and Clustering Blade
- ClusterXL requires good clock synchronisation via NTP
- We should use a separate cabel for sync
- We can use WAN for sync as well
- We can also use VLAN for sync
- Initially there is a Full sync - fwd daemon, encrypted TCP connection
- Then only changes via Delta sync are made, it is handled by Security Gateway kernel, using UDP multicast and broadcast on port 8116
- It is generally a good practice to disable syncronisation for protocols whose connections live for a short time, such as HTTP, DNS, for instance
- 6 devices maximum
- Sync network may include only switches and hubs, 100 ms max, 5% loss max
- FWD daemon uses port 256 for initial full sync
- Check cluster status + who is active: `cphaprob state`
- Verify failover: `clusterxl_admin down/clusterxl_admin up`
- Verify failover type 2: `cphaprob -d STOP -s problem -t 0 register; cphaprob -d STOP unregister`
- Change CCP type: `cphaconf set_ccp broadcast; cphaconf set_ccp multicast`
- If several clusters in the same subnet we need to change global ID: `cphaconf cluster_id set vaule`
- Debug: `cphaconf debug_data`, /var/log/messages

ClusterXL member requirements

- same OS
- Same Checkpoint version
- Same policy
- SecureXL status - SecureXL on all members has to be either enabled, or disabled
- Number of CoreXL FW instances - number of instances on all members must be identical
- Advanced Dynamic Routing - on all members has to be either enabled, or disabled

The default critical devices are:

- The cluster interfaces on the cluster members
- Synchronization — full synchronization completed successfully
- Filter — the Security Policy, and whether it is loaded
- cphad — which follows the ClusterXL process called cphamcset
- fwd — the Security Gateway daemon

Check synchronisation

- fw ctl pstat
- cphaprob -i list

Disable sync on one cluster: `fw ctl setsync off`

Check interfaces: `cphaprob -a if`

**VRRP**

- Management server cannot be on VRRP member
- VRRP and ClusterXL cannot be on the same host
- VRRP supprts 255 virtual routers
- VRRP router might participate in more than one VRID

Configuring VRRP

- In WebGUI
- Priority - the higher - the better
- Priority delta - where priority goes after failure

## API

There are four ways to communicate use the management APIs:

1. Typing API commands from a dialog inside the SmartConsole GUI application
2. Typing API commands using the "mgmt_cli" executable (available in both Windows, Linux/Gaia flavors)
3. Typing API commands using Gaia's secure shell (clish)
4. Sending API commands over an https connection using web-services

```
api status
api restart
```

```
mgmt_cli add host name host1 ip-address 192.0.2.100
```

## Kernel, module, chain, table

- Inbound and outbound directions consist of modules and modules from chains.
- Show all active chains: `[Expert@HostName]# fw ctl chain`
- When troubleshooting and trying to understand which chain is causing a problem on the Security Gateway, use the following command: `[Expert@HostName]# fw monitor -e "accept;" -p all`
- The '-p all' flag will show all the chains, through which the traffic passed
- To see all active modules on the Security Gateway, run: `[Expert@HostName]# fw ctl debug -m`

**Kernel tables**

- The kernel writes all of its actions to relevant tables. Every kernel table has an assigned name and assigned kernel ID, and it holds specific information
- The forwarding, handling and decisions will be done based on informatin that is stored in different kernel tables
- To view the kernel tables, run: `[Expert@HostName]# fw tab`
- To view a certain table, run: `[Expert@HostName]# fw tab -t <Table_Name | Table_ID>`
- To view all entries (unlimited number) in the table: `[Expert@HostName]# fw tab -t <Table_Name | Table_ID> -u`
- To delete all entries from a certain kernel table (all involved connections will be immediately lost and disconnected): `[Expert@HostName]# fw tab -t <Table_Name | Table_ID> -x -y`
- Important Note: This operation deletes all information from the table. Do NOT use this command in production environment, as it might cause a traffic outage.
- To delete specific entry: `[Expert@HostName]# fw tab -t <Table_Name | Table_ID> -x -e <Entry_ID | Tuple>`
- Display a summary about entries in certain table: `[Expert@HostName]# fw tab -t <Table_Name | Table_ID> -s`
- Display a summary about entries in all tables: `[Expert@HostName]# fw tab -s`

## Identity Awareness

- AD query security event logs using WMI over DCE-RPC (port 135 and then dynamic)
- Captive portal - browser - Kerberos is also supported
- Agents - Endpoint or Terminal Services
- VPN
- Steps: Enable Feature(this is a separate blade) > Create Access Roles > Use them in rules
- Support Non English names - Set the SupportUnicode attribute in AU object
- Captive portal Logs: /opt/CPNacPortal/logs
- PDP - The process on the Security Gateway responsible for collecting and sharing identities
- Turn PDP logging on: `pdp tracker on`
- Show AD groups and all other info for the user: `pdp monitor user Ivanov`

In expert mode:

```
pdp monitor client_type portal
pdp monitor ip 10.1.1.1 
pdp monitor user petrov
pdp control revoke_ip 10.1.1.1
```

Check connectivity with LDAP server 

```
[Expert@MSK-TK1-CP23500-1:0]# $FWDIR/bin/test_ad_connectivity -d test.ru -i 192.168.32.30 -u srv.Checkpoint -D "CN=srv.Checkpoint,OU=Service Accounts,OU=Admins,DC=test,DC=ru" -a -v -o my_test.txt
```

## Sizing

- If customer needs 1Gb VPN performance, search for a device with 2 Gbit performance 🙂
- Relative speeds of algorithms for IPsec and SSL - sk73980
- Best Practices - VPN Performance - sk105119

## Backup and restore

There are 3 main types: Snapshot/revert, backup/restore, upgarde_export

- DB version - 50 Mb - Policy and objects - Dashboard - CLI(dbver) - HTTPS NO
- Backup - 500 Mb - Gaia config and CP database - Dashboard NO - show/add/set backup - HTTPS YES
- Image/Snapshot - 5000 Mb - Partition including CP database - Dashboard NO - show/add/set/ snapshot - HTTPS YES
- Upgrade_export and upgrade_import - does not include route tables, it is used when upgrading Security Mangement server, it stores all objects database and the /conf directories
- Policy Package management

Schedule recomendations

- Snapshot - before major changes
- Backup - every couple of months
- upgrade_export - migrate tool is used now instead - every month?
- `add backup-scheduled name testb local`
- `set backup-scheduled name testb recurrence daily time 01:00`

## Transaction

- The utility commits all operations to the management database together when the transaction ends.
- If the transaction fails, the utility discards all its commands

```
gaia> start transaction

gaia [Xact]> set interface Mgmt ipv4-address 172.30.1.1 mask-length 24
gaia [Xact]> set static-route default nexthop gateway address 172.30.1.254 on
gaia [Xact]> commit
```