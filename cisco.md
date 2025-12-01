# Cisco

## Stacks

### Catalyst 2960-S stacks, also referred to as Cisco FlexStacks

- Up to 4
- Connected through their stack ports
- One of the switches controls the operation of the stack and is called the stack master
- A switch stack is different from a switch cluster
- The master is the single point of stack-wide management.
- System-level (global) features that apply to all members
- Interface-level features for each member
- One of the factors is the stack member priority value. The switch with the highest stack-member priority-value becomes the master
- The master contains the saved and running configuration files for the stack
- You manage the stack through a single IP address
- 

## IOS version naming

- Different platforms ultimately run different Cisco IOS versions 
- There are three sets of numbers that give us information about any version of Cisco IOS
- Train, throttle, rebuild
- Train - major version number
- Train examples: 12.2M, 12.4T, 15.0M, 15.1T
- Different trains for different platforms
    - ISR Routers G1/G2 (1800, 2800, 3800, 1900, 2900, 3900, etc) - 12.2M, 12.4M, 12.4T, 15.0M, 15.1T
    - Catalyst 6500 - Supervisor 32, Supervisor 720, Supervisor VS-720 - 12.2(18)SX, 12.2(33)SX
    -  7600 Router 12.2(33)SR, 15.0S
- Cisco IOS Throttle is roughly a minor version number where some new features and bug fixes can have been added
- Throttle consists of train + number in parenthesis: 12.4(20)T
- Cisco IOS Rebuilds typically consist of bug fixes. The addition of new features to a rebuild is generally avoided but it does happen sometimes. With rebuilds it can be confidently stated that one version of Cisco IOS is more recent than another. For example, 12.4(24)T7 is newer than 12.4(24)T5
- 15.0(1)M8 has been rebuilt 8 times
- M - mainline - recomended
- T - technology line - new features, not very stable
- 15X (special or early deployment), 15S (7600), 15Y (Sup-2T-10GE – Catalyst 6500), 15SG (Sup-CS-S2T – Catalyst 6500), and 15SE (2960, 3560, 3650, and 3750 platforms)

## Nexus

vPC / Fabric Path / OTV / LISP / FEX  

The Nexus platform is modular. Each feature has its own processes, independent of other features.  

CAM - Content-addressable memory 

- Compares input search data against a table of stored data, and returns the address of matching data
- Also known as associative memory or associative storage
- Frequently used in networking devices where it speeds up forwarding information base and routing table operations
- In random-access memory (RAM) the user supplies a memory address and the RAM returns the data word stored at that address
- CAM is designed such that the user supplies a data word and the CAM searches its entire memory to see if that data word is stored anywhere in it. If the data word is found, the CAM returns a list of one or more storage addresses where the word was found. Thus, a CAM is the hardware embodiment of what in software terms would be called an associative array
- CAM is much faster than RAM in data search applications
- The additional circuitry increases the physical size and manufacturing cost of the CAM chip
- Binary CAM is the simplest type of CAM and uses data search words consisting entirely of 1s and 0s
- Ternary CAM (TCAM) allows a third matching state of X or don't care for one or more bits in the stored word, thus adding flexibility to the search
- For example, a stored word of "10XX0" in a ternary CAM will match any of the four search words "10000", "10010", "10100", or "10110"
- This additional state is typically implemented by adding a mask bit ("care" or "don't care" bit) to every memory cell
- Binary CAM is ususally used in switches, to look up MAC table
- Ternary CAMs are often used in network routers, where each address has two parts: the network prefix, which can vary in size depending on the subnet configuration, and the host address, which occupies the remaining bits
- The addresses are stored using don't care for the host part of the address, so looking up the destination address in the CAM immediately retrieves the correct routing entry; both the masking and comparison are done by the CAM hardware

TCAM in Nexus

- To use a non-default feature for Nexus 9000 Series switches, one must manually carve out TCAM space for the features. By default, all TCAM space is allocated

## Switch commands

**Show all MAC addresses on the switch**
CAM table (Content Addressable Memory table) - also known as the MAC address table
```
switch#show mac address-table 
          Mac Address Table
-------------------------------------------
 
Vlan    Mac Address       Type        Ports
----    -----------       --------    -----
All    0100.0ccc.cccc    STATIC      CPU
All    0100.0ccc.cccd    STATIC      CPU
All    0180.c200.0000    STATIC      CPU
All    0180.c200.0001    STATIC      CPU
All    0180.c200.0002    STATIC      CPU
All    0180.c200.0003    STATIC      CPU
All    0180.c200.0004    STATIC      CPU
All    0180.c200.0005    STATIC      CPU
All    0180.c200.0006    STATIC      CPU
All    0180.c200.0007    STATIC      CPU
All    0180.c200.0008    STATIC      CPU
All    0180.c200.0009    STATIC      CPU
All    0180.c200.000a    STATIC      CPU
All    0180.c200.000b    STATIC      CPU
All    0180.c200.000c    STATIC      CPU
All    0180.c200.000d    STATIC      CPU
All    0180.c200.000e    STATIC      CPU
All    0180.c200.000f    STATIC      CPU
All    0180.c200.0010    STATIC      CPU
All    0180.c200.0021    STATIC      CPU
All    ffff.ffff.ffff    STATIC      CPU
  20    0000.0c07.ac14    DYNAMIC     Te1/1/8
  20    34f8.e769.f756    STATIC      Vl20 
  20    4488.165b.db3f    DYNAMIC     Te1/1/8
  20    4488.165b.e21f    DYNAMIC     Te1/1/8
  20    cc90.70a1.0399    DYNAMIC     Te1/1/8
111    0000.0c07.ac6f    DYNAMIC     Te1/1/8
111    083a.8858.80f3    DYNAMIC     Te1/1/8
111    34bd.c8c7.c7f8    DYNAMIC     Te1/1/8
111    4488.165b.db3f    DYNAMIC     Te1/1/8
111    4488.165b.e21f    DYNAMIC     Te1/1/8
111    5405.db73.dc08    STATIC      Tw1/0/17 
111    5405.dbce.279b    STATIC      Tw1/0/1 
111    8c8c.aa3d.38ea    DYNAMIC     Te1/1/8
111    a029.1992.b989    DYNAMIC     Te1/1/8
111    a0ce.c8ef.49ba    DYNAMIC     Drop
has context menu
```
**Show all MAC addresses on a port**

```
cisco9300#sh mac address-table interface gigabitEthernet1/0/22
          Mac Address Table
-------------------------------------------

Vlan    Mac Address       Type        Ports
----    -----------       --------    -----
 423    0892.04b5.fb46    DYNAMIC     Gi1/0/22
Total Mac Addresses for this criterion: 1
```

Possible types of MAC

- Dynamic
- Static

Possible Ports values

- CPU - mac-address is assigned by CPU and is an internal allocation for some internal process. Every switch has a pool of mac-addreses for internal allocation for its processes.For example, for STP process, VTP process, switch assings the internal mac-addresses
- Port number
- Drop - port drops traffic due to security violations, for example if port security is configured, or 802.1X

**Show 802.1X port status**

```
Device# show dot1x interface fastethernet7/1 details

Dot1x Info for FastEthernet7/1
-----------------------------------
PAE                       = AUTHENTICATOR
PortControl               = AUTO
ControlDirection          = Both 
HostMode                  = SINGLE_HOST
ReAuthentication          = Disabled
QuietPeriod               = 60
ServerTimeout             = 30
SuppTimeout               = 30
ReAuthPeriod              = 3600 (Locally configured)
ReAuthMax                 = 2
MaxReq                    = 2
TxPeriod                  = 30
RateLimitPeriod           = 0
Dot1x Authenticator Client List
-------------------------------
Supplicant                = 1000.0000.2e00
        Auth SM State     = AUTHENTICATED
        Auth BEND SM Stat = IDLE
Port Status               = AUTHORIZED
          
Authentication Method     = Dot1x
Authorized By             = Authentication Server
Vlan Policy               = N/A
```
**Show all ARPs**

```
cisco9300#show ip arp            
Protocol  Address          Age (min)  Hardware Addr   Type   Interface
Internet  10.0.3.1              211   6c41.0ead.2bc4  ARPA   Vlan19
Internet  10.0.3.165              -   4ce1.75e8.31c4  ARPA   Vlan19
```

**Show all interfaces in a VLAN**
`sh vlan id 901`

## Interfaces

Show all ports status

```
cisco9300#show ip int br
Interface              IP-Address      OK? Method Status                Protocol
Vlan836                10.2.136.110    YES manual up                    up      
GigabitEthernet0/0     unassigned      YES NVRAM  down                  down
```

Show brief status of the interface

```
cisco9300#show int gi1/0/22 status

Port         Name               Status       Vlan       Duplex  Speed Type
Gi1/0/22     d.bandaletov_NAC   connected    423        a-full a-1000 10/100/1000BaseTX
```

Show description of all interfaces to understand what goes where

```
show int description
```

## ASA

- Global ACL
- Object oriented approach, you can name all objets(nets, hosts, ports), you can create objext groups, for instance many ports.
- Packet tracer
- ASDM
- capture
- show logging
- Advanced Level 5-7 application inspection
- Advanced NAT
- Failover
- modular policy framework
- scp server
- more convenient cli - grep, not necessarily to use do 
- TCP advanced options - ASA allows to control options of TCP flow such as adding or removing 19 option or preventing SYN flood attacks or TCP state by pass, TCP syn cookies
- Deep packet inspection - IOS has it in zone based firewall + ip inspect command
- ASA can inspect protocols on layers 5-7: ftp, dns, http, esmtp
- ASA can filter Botnet traffic
- LDAP authorisation
- ASA does not support DMVPN and GRE
- No Policy Base Routing in ASA
- ASA faster in VPN
- ASA can threat detection
- User based policies (cut through proxy)
- No wild cards!!! on ASA
- No Telnet and SSH client on ASA
- security levels on interfaces on ASA
- default inspection of TCP and UDP on ASA
- On ASA real IP address is used in ACLs not mapped one
- Transparent firewall - when you switch to this mode all configuration is erased, BPDU, multicast, broadcast are not forwarded by default
- Virtual firewall - in multiple mode you can't use VPNs and routing protocols. However this mode is required for active/active failover mode
- 8.2 > 8.3 - NAT commands changed
- All interfaces are named
- Object related approach

**Modular policy framework**

- By default global-class is configured 
- It includes match default-inspection-traffic
- In your own classes you can match ACl, ports UDP and TCP, tunnel group
- Besides classic class we can configure 3 types of classes:
  - inspect - used for layer 5-7 protocol inspection
  - management
  - regex
- Besides classic policy map there is an inspect type of policy map
- You can configure match INSIDE inspect policy map without using class
- ICMP inspection is off by default
- TCP and UDP inspection is ON by default
- Configuration defines set of rules for applying firewall features, such as traffic inspection, QoS etc. to the traffic transiting the firewall
- Traffic inspection we can use for accepting replies, for instance if we add to policy map command inspect icmp, than echo replies will be automatically allowed, but only for existing echos

Enable ICMP inspection

```
policy-map global_policy
        class inspection_default
          inspect icmp
```

Example - configure blocking trace method in HTTP

```
class-map type inspect http match-all http-class
 match request method trace

policy-map type inspect http http-map
 class http-class
  reset log

policy-map global-policy
 class global-class
  inspect http http-map

```

Another practical usage is 

- ftp inspection(Application inspection)
- Connection tweaking
- QOS
- Rate liniting
- Traffic shaping
- Send data to IPS

```
class-map test
 match any
policy-map test_map
class test
  inspect http
service-policy test_map global
```

Things required for BGP starts working:

- Permit TCP option 19
- Configure TCP normalizer to disable TCP ISN randomization

```
show activation-key
show version
dir disk0:/
asdm image disk0:/asdm-645.bin
```

**CLI**

Create VLAN interface

```
interface Ethernet0.1
 vlan 2
 nameif vlan2
 security-level 0
 ip address 172.16.3.1 255.255.255.252
!
```

Save config

```
Write memory
```

Troubleshooting

```
show asp table socket
show run http
show run asdm
```

Capture traffic

```
capture capin interface inside-ipsec match ip host 142.174.132.100  host 96.1.255.176 
show capture
no capture capin
show capture capin
```

**TCP normalization**

- Create a tcp map where we describe what to do
- Then we create a standard class map
- Next, standard policy map, where we add a tcp map to our class map: `set connection advanced-options my_tcp_map`
- Using set connection command we also can configure connection limits, including embryonic ones for anti Dos purposes

## Wildcard masks

- Wildcard - uknown or unpredictable factor - a symbol which represents one or more unspecified characters
- It is a 32 bit binary number
- Inverted subnet mask
- A wild card mask is a matching rule
- Wildcard masks are used in situations where subnet masks may not apply. For example, when two affected hosts fall in different subnets, the use of a wildcard mask will group them together
- For example in access list we can use access-list 1 permit 10.168.1.0 255.0.0.255 - it will match address from different networks: 192.168.1.3 and 10.168.1.4!
- Subnet Masks can only identify sequential IP addresses. Wildcard Masks, however, can identify IP addresses which are not sequential
- Directs the router’s logic bit by bit
- Bit of 0 means the comparison should be done as normal
- Binary 1 means that the bit is a wildcard and can be ignored when comparing the numbers
- All bits which are zero in WC should match in bith comparing numbers!
- To match a range of addresses
- Shows wich octets and bits to consider and which to ignore
- Used in access lists, OSPF network command, EIGRP network command
- Decimal 0: The router must compare this octet as normal.
- Decimal 255: The router ignores this octet, considering it to already match
- 0.0.0.255 - ignore last octet - 10.1.2.0 matches 10.1.2.1
- 0.0.255.255 - ignore last two octets
- 0.255.255.255 - ignore last three octets
- access-list 1 permit 10.1.1.1 - match exactly one address
- access-list 1 deny 10.1.1.0 0.0.0.255 - match everything starting with 10.1.1.
- access-list 1 permit 10.0.0.0 0.255.255.255 - match everything starting from 10
- Convert subnet mask to WC: 255.255.255.255 - 255.255.252.0 = 0. 0. 3.255 - wildcard mask!

## Service commands

```
service nagle
```

The Nagle congestion-control algorithm to improve the performance of their Telnet sessions to and from the router. When using a standard TCP implementation to send keystrokes between machines, TCP tends to send one packet for each keystroke typed. John Nagle's algorithm (RFC 896) helps alleviate the small-packet problem in TCP. In general, it works this way: The first character typed after connection establishment is sent in a single packet, but TCP holds any additional characters typed until the receiver acknowledges the previous packet. The second, larger packet is sent, and additional typed characters are saved until the acknowledgment comes back. The effect is to accumulate characters into larger chunks and pace them out to the network at a rate matching the round-trip time of the given connection. This method is usually good for all TCP-based traffic and helps when connectivity to the router is poor or congested or the router itself is busier than normal. Without service nagle on a Cisco router, each character in a Telnet session is a separate CPU interrupt. Hence, a command such as show tech will force a large number of CPU interrupts, impacting the performance of the router. From a Cisco point of view, the Nagle service not only helps to optimize the Telnet session but also lessens the load on the router

```
Router1(config)# service tcp-keepalives-in
Router1(config)# service tcp-keepalives-out
```

This enables TCP keep-alives for inbound and outbound traffic. This helps to drop the session if one peer is rebooted for example.

## Packet capture

IOS

```
ip access-list extended BGP_FILTER
              permit ip host 10.125.5.17 host 10.125.5.20
              permit ip host 10.125.5.20 host 10.125.5.17
      
monitor capture bgp access-list BGP_FILTER buffer size 100 interface Port-channel2.1197 both
monitor capture bgp start
show monitor capture bgp
monitor capture bgp stop
monitor capture bgp export flash:bgp.pcap
no monitor capture mycapture
```

##  Port security

## Users

- username netadmin privilege 15 secret 5 $1$0Q7y$2h6aQexKrhaOv4/VL5M9w/
- username secopsadmin secret 9 $9$SU3dGhgTOfAaZE$GzcaRuORda/Y/3ZiV5MrNqvL7KctOHphPv1PChc.fQo
- Privilege level 15 gives full administrative access (like enable mode)
- By default, users have privilege level 1 (basic user mode)
- secopsadmin does not specify a privilege level, so it defaults to 1

Password Encryption Types in Cisco

- Type	Syntax	Encryption Algorithm	Security Level
- 0	username admin secret 0 password	Plain text	❌ Weak
- 5	username admin secret 5 <hashed>	MD5	⚠️ Weak (deprecated)
- 7	username admin password 7 <hashed>	Cisco Type 7 (Vigenère cipher)	❌ Very weak (easily reversible)
- 8	username admin secret 8 <hashed>	PBKDF2	✅ Strong
- 9	username admin secret 9 <hashed>	SHA-256	✅✅ Strongest

## AAA

- aaa new-model - Enables AAA (Authentication, Authorization, and Accounting) - Without this, the switch would only use local authentication

### Tacacs
 ```
 aaa group server tacacs+ CORP_ACS
 server-private 10.255.255.3 key 7 001C240436080C57497208160F3E2F0637273C5D791F082730
 ip tacacs source-interface FastEthernet0
 ```

### Authentication

It specifies a named list of methods:
- Which authentication methods to use (e.g., TACACS+, RADIUS, local accounts, or simple line passwords).
- The order in which authentication methods are tried (e.g., try TACACS+ first, then local).
- Whether a username is required or just a password

Commands:
- `aaa authentication login <METHOD-LIST-NAME> <METHOD1> [METHOD2] [METHOD3]`
- aaa authentication login default group CORP_ACS local
- aaa authentication login umicn_line line

**Common Authentication Methods**

- Method	Description
- group tacacs+	Use TACACS+ server for authentication
- group radius	Use RADIUS server for authentication
- local	Use local usernames/passwords (username <name> secret <password>)
- line	Use the password set under line con 0 or line vty (no username)
- enable	Use the enable password for authentication.
- none	No authentication (not recommended).

### Authorization

- aaa authorization exec default group CORP_ACS if-authenticated 
- aaa authorization commands 15 default group CORP_ACS local 

### Accounting

- aaa accounting exec default start-stop group CORP_ACS
- aaa accounting commands 15 default start-stop group CORP_ACS

## Console configuration

- We mention which list of Auth methods we use
- In this list method line is configured, which means to use password specified in console section
- We mention password if required
- By default we will get priviledge level 1, if only privilege level 15 is not specicified

```
aaa authentication login umicn_line line

line con 0
 session-timeout 15  output
 exec-timeout 15 0
 password 7 141D270D1E526C0E1E2D3E2021120C42
 privilege level 15
 logging synchronous
 login authentication umicn_line

```

## Firepower

- My course book:  https://learningspace.cisco.com/content 
- Threat Grid - local and cloud sandboxing
- Multidomain management in management centre
- Security group tags based filtering in cooperation with ISE
- Remember that, for the allow rules, you are logging connections at the end. The SSH session is not displayed in Connection Events until the session is completed
- FXOS + Firepower Management Center
- Firepower device manager is avalable for some models - Local GUI management

### CLI

Change management IP

```
configure network ipv4 manual 192.168.139.167 255.255.255.0 192.168.139.1
```

Verify management interface

```
show network
```

Add firepower to management server

```
configure manager add XXX.XXX.XXX.XXX my_reg_key
```

Configure network on management center

```
sudo /usr/local/sf/bin/configure-network
```

Show interfaces(except management) config

```
show ip
```

Ping from MANAGMENT interface

```
ping system 192.168.1.1
```

show ntp

```
show ntp
```

show logging

```
show logging
```

show failover

```
show failover
```

switch to secondary (can be done in FMC as well)

```
no failover active
```

Show NAT details

```
show nat detail
```

### HA

Configuration steps

- Who primary
- Failover link
- Stateful link
- Secondary IPs - not mandatory, but desirable

For the Firepower 4100/9300 chassis, all interfaces must be preconfigured in FXOS identically before you enable High Availability. If you change the interfaces after you enable High Availability, make the
interface changes in FXOS on the standby unit, and then make the same changes on the active unit.

- Be in the same firewall mode (routed or transparent)
- Have the same major (first number), minor (second number), and maintenance (third number) software version
- Be in the same domain or group on the Firepower Management Center
- Have the same NTP configuration. See Configure NTP Time Synchronization for Threat Defense, on page 1003
- Be fully deployed on the Firepower Management Center with no uncommitted changes
- Not have DHCP or PPPoE configured in any of their interfaces

The failover link and the optional stateful failover link are dedicated connections between the two units. The same interface on both devices should to be used for failover and stateful failover links

The following information is communicated over the failover link:

- The unit state (active or standby)
- Hello messages (keep-alives)
- Network link status
- MAC address exchange
- Configuration replication and synchronization

Workflow

- The active unit always uses the primary unit's IP addresses and MAC addresses
- When the active unit fails over, the standby unit assumes the IP addresses and MAC addresses of thefailed unit and begins passing traffic
- When the failed unit comes back online, it is now in a standby state and takes over the standby IP addressesand MAC addresses
- Cisco recommends that the bandwidth of the stateful failover link should at least match the bandwidth of thedata interfaces.

### Migration from ASA to FTD

- Allocate separate FMC - trail VM is OK
- Go to root: sudo su -
- Launch migration tool enableMigrationtool.pl
- Copy ASA config to a file
- On FMC go to System > Tools > Import/Export and upload ASA config
- Save resulted configuration to a file after conversion
- On Production FMC go to System > Tools > Import/Export and upload ASA converted config

### Configuration

- Configure health monitoring  centrally from FMC: `System > Health > Policy`
- Hardware alarms, CPU, Interfaces, malware analysus. disks...etc... many things can be monitored, including on FMC itself
- Centrally configure NTP, logging, SNMp, SMTP.... etc `Devices > Platform settings`
- Configure devices individually - Routing, interfaces + Add new Device + Configure HA or Cluster: `Devices > Device Management`
