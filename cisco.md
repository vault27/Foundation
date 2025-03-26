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

## Routers and switches upgrade

### Part 1 - Reconnaissance

- What is connected to a device: clients, cameras, servers, APs, transit: CDP, port description, diagrams
- Who support connected devices?
- Maitenance window
- Validators - they have to approve before and after
- Will there be service interraption or not?
- Impact allowed: can we do interruption or not
- Find out the rack number
- Find person on site availability - console cable + wired keyboard with Break key
- Person on site requested access

### Part 2 - Change creation

- Notify on-site people
- Notify servers people
- Notify validators: application teams, security guards - send them Bridge link
- Create MOP
- Pass TAB
- Pass SCRUM

### Part 3 - Prepare for change

- Local password
- Local access
- vPC and STP peculiarities
- Routing protocols
- Upload images + MD5
- Wireless controllers - check before upgrade
- Stack or not

### Part 4 - Change

- Disable monitoring system
- Notify about start
- Validators validate before start
- Install + Verify

### Part5 - Post Upgrade

- Pre-checks
- If Stack: check that member switches are upgraded as well
- Access-points
- Cameras
- Security locks
- Servers connections
- Servers validators
- App validators
- Notify about end
- Close change
- Unmute monitoring system
- Add change to monitoring system

### Appendix-A - Images

- Verify that image is on both nodes of the stack.
    - "flash:" means the flash directory of the MASTER switch.
    - "flash1:" means the flash directory of switch 1 of the stack.
    - "flash1:" does NOT necessarily mean it's the flash memory of the master switch.

```
Show flash1:
Show flash2:
```

### Upload image

- For Catalyst via FTP: `copy /verify ftp://ftpuser:pass@1.1.1.1/IOS/c3560cx-universalk9-mz.152-7.E9.bin flash:`
- For Nexus via SFTP: `copy sftp://user.scp@2.2.2.2/Images/nxos64-cs.10.2.6.M.bin bootflash:`
- Veriify MD5 hash `verify /md5 flash:c3750e-universalk9-mz.152-4.E10.bin`
- Verify MD5 on Nexus `show file bootflash:nxos64-cs.10.2.6.M.bin md5sum`
- Upload image to main switch in stack `copy /verify scp://sw.scp:Canyon+paint1@10.2.53.13:c2960x-universalk9-mz.152-7.E11.bin flash:`
- Upload image to second switch in stack `copy flash:c2960x-universalk9-mz.152-7.E11 flash2:`

### MOP

- Enable SSH log to file

**Backup**

```
copy run start
ter len 0
sh run
```

**Hardware Pre-checks**

```
show environment all - fans, ps, alerts, sensors
show interfaces status err-disabled
show interfaces status | i connected
show power inline - power over ethernet ports
show inventory - slots, sfps, power supplies, fans
show module - OS versions on all slots, MAC addresses 
show switch - shows members of a stack + who is Master
show redundancy
show cdp nei
```

**Software Pre-checks**

```
show logging
show ver - verify version on all switches in the stack
```

**L2 Pre-checks - for switches only**

```
show mac add dynamic
show int trunk
show spanning-tree summary
show spanning-tree root
```

**L3 Pre-checks**

General

```
show vrf
show ip protocols
show ip arp
show ip route
show ip route summary

#For VRFs with Interfaces
show ip arp vrf VRF_NAME
show ip route vrf VRF_NAME
show ip route vrf VRF_NAME summary
```

OSPF 

```
show ip ospf neighbor
show ip ospf database
show ip ospf interface
```

BGP

```
show ip bgp all summary
```

**Nexus Pre-checks**

```
show install all impact nxos bootflash:nxos64-cs.10.2.6.M.bin
show feature
show install all status
```

### Upgrade*

Check version one more time

If **show boot** shows bin file, then it is old catalyst

For new Catalyst - the same for Stack
```
install add file flash:cat9k_iosxe.17.09.04a.SPA.bin activate commit prompt-level none
```

For old ones - we keep old one, new one on top, just in case new one will not boot

```
no boot system boot system flash:c2900-universalk9-mz.SPA.157-3.M4a.bin
boot system flash:c2900-universalk9-mz.SPA.157-3.M8.bin
boot system boot system flash:c2900-universalk9-mz.SPA.157-3.M4a.bin
exit
copy run start
reload
```

**For old one Stack - update all switches in a stack**

```
boot system switch all flash:c3750e-universalk9-mz.152-4.E10.bin
```

If switch does not boot with new image, we need to connect with console and load switch with previous image:

```
Enter ROMMODE - CTRl+Break
boot flash:IMAGE_NAME
if flash is not detected, then you can try flash_init
you can do "dir" to see if flash is detected
if it doesn't boot on the new code, it'll automatically go to rommon
```

For Nexus

```
Install all nxos bootflash:nxos64-cs.10.2.6.M.bin
```

**Validation**


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

## IOS VS ASA

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

