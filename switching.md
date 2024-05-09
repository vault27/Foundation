# Switching

## Tecgnologies

- VLANs
- STP
- RSTP
- MSTP
- VTP
- DTP
- CDP
- LLDP
- LAG
- MC-LAG
- LACP
- Etherchannel - port channel
- Power over Ethernet

## Switch upgrade

**Preparation**

- On-site person + console cable + wired keyboard with Break key
- Notify on-site people
- Notify servers people, if servers are connected
- Local password
- vPC and STP peculiarities
- Disable monitoring system
- Verify that image is on both nodes of the stack.
    - "flash:" means the flash directory of the MASTER switch.
    - "flash1:" means the flash directory of switch 1 of the stack.
    - "flash1:" does NOT necessarily mean it's the flash memory of the master switch.

```
Show flash1:
Show flash2:
```

- Upload image

  ```
  copy /verify ftp://ftpuser:pass@1.1.1.1/IOS/c3560cx-universalk9-mz.152-7.E9.bin flash:
  ```
- Veriify MD5 hash

```
verify /md5 flash:c3750e-universalk9-mz.152-4.E10.bin
```

- Enable SSH log to file

**Backup**

```
copy run start
ter len 0
sh run
```

**Hardware Pre-checks**

```
show environment all
show interfaces status err-disabled
show interfaces status | i connected
show power inline
show inventory
show module
show switch - shows members of a stak + who is Master
show redundancy
```

**Software Pre-checks**

```
show logging
show ver - verify version on all switches in the stack
```

**L2 Pre-checks**

```
show mac add dynamic
show int trunk
show spanning-tree summary
show spanning-tree root
show cdp nei
```

**L3 Pre-checks**

General

```
show ip arp
show ip route
```

OSPF

```
show ip ospf neighbor
show ip ospf database
show ip ospf interface
```

BGP

```
show ip bgp vpnv4 all summary
```

VRF

```
show ip route vrf 1
show ip route vrf 2
```

**Upgrade**

If show boot shows bin file, then it is old catalyst

For new Catalyst
```
install add file flash:cat9k_iosxe.17.09.04a.SPA.bin activate commit prompt-level none
```

For old ones

```
no boot system
boot system flash:c3560cx-universalk9-mz.152-7.E9.bin
exit
copy run start
reload
```

For old one Stack - update all switches in a stack

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

**Post-upgrade**

- Pre-checks
- If Stack: check that member switches are upgraded as well, enter on Master switch:

```
session #switch_number
Enter username and pass - local only???
show boot
```

- Access-points
- Cameras
- Security locks
- Unmute monitoring system

## Hardware

- Show inventory - chassis, modules, SFP, power, fans
- Show module - modules, SFPs, status, supervisors
- Show redundancy - spuervisor modules HA


## Native VLAN

- The native VLAN should match on both trunk ports, or traffic can change VLANs unintentionally
- A native VLAN is a port-specific configuration and is changed with the interface command switchport trunk native vlan vlan-id
- All switch control plane traffic (DTP, VTP and CDP frames and also BPDU’s) is advertised using VLAN 1. The Cisco security hardening guidelines recommend changing the native VLAN to something other than VLAN 1. More specifically, it should be set to a VLAN that is not used at all (that is, has no hosts attached to it). Somebody may add port in VLAN 1 and forget about it

  
## Interface configuration

```
SW1(config)#vlan 101
SW1(config-vlan)#name VOIP
SW1(config-vlan)#exit

 interface TenGigabitEthernet7/0/40
 description USR_Voice/Data
 switchport access vlan 836
 switchport mode access
 switchport nonegotiate - On switches that support both ISL and 802.1Q trunking, DTP can be used to negotiate the appropriate trunking encapsulation. When negotiation is configured, ISL is always preferred, with 802.1Q being negotiated only if either side of the trunk does not support ISL
 switchport voice vlan 20 -  trunk between our switch and IP phone, port on the IP phone that connects to the computer is an access port, all traffic from the computer to the switch untagged, traffic from the IP phone itself will be tagged, Phone will learn through CDP which VLANs it should use
 no logging event link-status
 no mdix auto
 spanning-tree portfast
 spanning-tree bpduguard enable
```

## Power over Ethernet

- Shows which ports consumes Watts
- Shows which ports have Access POints and Phones and Cameras...
  
```
switch#show power inline 

Available:10260.0(w)  Used:126.4(w)  Remaining:10133.6(w)

Interface Admin  Oper       Power   Device              Class Max
                            (Watts)                            
--------- ------ ---------- ------- ------------------- ----- ----
Gi1/0/1   auto   off        0.0     n/a                 n/a   60.0 
Gi1/0/2   auto   off        0.0     n/a                 n/a   60.0 
Gi1/0/3   auto   off        0.0     n/a                 n/a   60.0
Te1/0/35  auto   on         3.6     IP Phone 7841       1     60.0
```

## SPAN

- Can be oversubscribed
- Configurable
- Cisco private

## Mirror port - TAP?

- Full physical copy, no oversubscription


## LAG

Concepts
- Implementation may follow vendor-independent standards such as Link Aggregation Control Protocol (LACP) for Ethernet, defined in IEEE 802.1AX or the previous IEEE 802.3ad, but also proprietary protocols
- Sending all frames associated with a particular session across the same link. Common implementations use L2 or L3 hashes (i.e. based on the MAC or the IP addresses), ensuring that the same flow is always sent via the same physical link, or we will face Ethernet reordening - this will increase load on TCP
- However, this may not provide even distribution across the links in the trunk when only a single or very few pairs of hosts communicate with each other, i.e. when the hashes provide too little variation. It effectively limits the client bandwidth in aggregate.[18] In the extreme, one link is fully loaded while the others are completely idle and aggregate bandwidth is limited to this single member's maximum bandwidth. For this reason, an even load balancing and full utilization of all trunked links is almost never reached in real-life implementations

- 802.3ad earlier, now 802.1AX
How many links each tech?
- Why even number?
- Load balance methods ?
- M-LAG vs MC-LAG? STandard?
- What LACP negotiates?
- 

## MC-LAG

- Is a type of link aggregation group (LAG) iwth using different appliances
- Its implementation varies by vendor; notably, the protocol existing between the chassis is proprietary
- The IEEE 802.1AX-2008 industry standard for link aggregation does not mention MC-LAG, but does not preclude it
- Cisco Catalyst 6500	Multichassis Etherchannel (MEC) - Virtual Switching System (VSS)
- Cisco Catalyst 3750 (and similar)	Cross-Stack EtherChannel
- Cisco Catalyst 9000	StackWise Virtual
- Cisco Nexus	Virtual PortChannel (vPC), where a PortChannel is a regular LAG
- Cisco IOS XR	mLACP (Multichassis Link Aggregation Control Protocol)
- Juniper	MC-LAG

## Port Channel

Port-channels provide three important benefits:
- Redundancy. If one of the member interfaces fails, traffic is redirected over the remaining links.
- Bandwidth. Increase in transmission capacity due to bundling multiple interfaces together. All interfaces are active transmission channels.
- Spanning Tree. Port-channels are seen as a single interface by Spanning-Tree protocols

### Concepts

- "EtherChannel" or "Link Aggregation" is the particular technology that allows you to bundle several links between two devices and use them simultaneously as a single interface. The "Port-channel" is the name of this virtual interface in IOS
- Port-Channel=Etherchannel=Link Aggregation
- It may be Layer 2 or Layer 3
- You can use static port channels, with no associated aggregation protocol, for a simplified configuration
- For more flexibility, you can use the Link Aggregation Control Protocol (LACP)
- Up to 32 physical links
- Nexus does not support Port Aggregation Protocol (PAgP) for port channels
- Each port can be in only one port channel
- The same speed and duplex mode
- Layer 2 port channels in either access or trunk mode
- You can configure a Layer 3 port channel with a static MAC address. If you do not configure this value, the Layer 3 port channel uses the router MAC of the first channel member to come up
- Port-channel load balancing uses MAC addresses, IP addresses, or Layer 4 port numbers to select the link
- The default load-balancing mode for Layer 3 interfaces is the source and destination IP L4 ports, and the default load-balancing mode for non-IP traffic is the source and destination MAC address
- The default method for Layer 2 packets is src-dst-mac
- Symmetric hashing is supported
- LACP allows you to configure up to 16 interfaces into a port channel
- Active mode - LACP is enabled and actively negotiate
- Passive mode - LACP is enabled and waits for negotiation
- On mode - no LACP - static configuration
- Mode is configured on each physical interface

### Configuration

Nexus
```
interface Vlan2
  no shutdown
  ip address 192.168.1.2/24

interface port-channel1
  switchport access vlan 2

interface Ethernet1/1
  switchport access vlan 2
  channel-group 1 mode active - means LACP is enabled in active mode

interface Ethernet1/2
  switchport access vlan 2
  channel-group 1 mode active

#Configure load balance
switch(config)# port-channel load-balance
```

### Verification

**Show port-channel overview on Catalyst. Status, Layer-2 or Layer-3, protocol LACP or PAGP**

```
show etherchannel summary 
Flags:  D - down        P - bundled in port-channel
        I - stand-alone s - suspended
        H - Hot-standby (LACP only)
        R - Layer3      S - Layer2
        U - in use      f - failed to allocate aggregator

        M - not in use, minimum links not met
        u - unsuitable for bundling
        w - waiting to be aggregated
        d - default port

        A - formed by Auto LAG


Number of channel-groups in use: 11
Number of aggregators:           11

Group  Port-channel  Protocol    Ports
------+-------------+-----------+-----------------------------------------------
10     Po10(SU)        LACP        Hu1/0/50(P)     Hu1/0/52(P)     
20     Po20(SU)        LACP        Twe1/0/1(D)     Twe1/0/13(P)    
22     Po22(SD)        LACP        Twe1/0/2(D)     
24     Po24(SU)        LACP        Twe1/0/3(P)     Twe1/0/15(P)    
26     Po26(SU)        LACP        Twe1/0/4(P)     Twe1/0/16(P)    
28     Po28(SU)        LACP        Twe1/0/5(P)     Twe1/0/17(P)    
30     Po30(SU)        LACP        Twe1/0/6(P)     Twe1/0/18(P)    
32     Po32(SU)        LACP        Twe1/0/7(P)     Twe1/0/19(P)    
34     Po34(SU)        LACP        Twe1/0/8(P)     Twe1/0/20(P)    
40     Po40(SU)        LACP        Twe1/0/11(P)    Twe1/0/23(P)    
41     Po41(SU)        LACP        Twe1/0/12(P)    Twe1/0/24(P)    
```

**Show all trunk ports**

Management donain, spanning tre...

```
switch#show int trunk

Port           Mode             Encapsulation  Status        Native vlan  
Te2/0/46       on               802.1q         trunking      888
Te3/0/1        on               802.1q         trunking      1
Te4/0/1        on               802.1q         trunking      1
Te6/0/45       on               802.1q         trunking      888
Te6/0/46       on               802.1q         trunking      888

Port           Vlans allowed on trunk
Te2/0/46       844,888
Te3/0/1        1,10,20,30,50,610-611,836,844-845,888,1000
Te4/0/1        1,10,20,30,50,610-611,836,844-845,888,1000
Te6/0/45       844,888
Te6/0/46       844,888

Port           Vlans allowed and active in management domain
Te2/0/46       844,888
Te3/0/1        1,10,20,30,50,610-611,836,844-845,888,1000
Te4/0/1        1,10,20,30,50,610-611,836,844-845,888,1000
Te6/0/45       844,888
Te6/0/46       844,888

Port           Vlans in spanning tree forwarding state and not pruned
Te2/0/46       844,888
Te3/0/1        1,10,20,30,50,610-611,836,844-845,888,1000
Te4/0/1        none
Te6/0/45       844,888
Te6/0/46       844,888
```

## ESI

- Works above VxLAN EVPN
- Host may be connected to more than 2 switches - multiple home active/active

## vPC

- Virtual port channel - feature on Nexus switches which provides the ability to configure a Port-Channel across multiple switches
- We create vPC domain on switch, then we create port-channel interfaces with one port inside and configure vpc domain number in them, access or trunk we configure in port-channel interfaces as well
- Provides active-active dual homed host connection
- Also known as Multichassis EtherChannel (MEC)
- The same as MLAG, MCLAG
- The same models and soft
- The same as VSS on Catalyst, but more reliable
- Two switches maximum the same as in MLAG
- BUM traffic is replicated via peer link
- Configs on both switches should be consistent
- 16 links and even more
- LACP is used - not optimal load balance algorithm is used - it is better to use 5 tuple - MACs, Ports, Protocol

### Components

- Peer link - LAG - no traffic - CFS Cisco protocol - sync vPC config + MAC table + ARP table - 2 High speed links are used - 40/100 Gbits - can be connected via switch
- Peer keep alive link - maybe virtual - used only for heartbeat - recomended to use physical in separate VRF - mgmt0 interface can be used - every second - UDP 3200 - SVI interface and loopback are not recomended - IPs are used - can be connected via switch
- vPC domain - all about 2 switches - has a number - it influences virtual MAC
- Peer - praimary and secondary role according to priority - configured manually or 32000+MAC - manual is recomended. Operational status - primary or secondary, it can be different from role - transfers VLANs, CFS messages, BUM. VLANS on vPC should be allowed on this link
- Member port - vPC port
- vPC - supports static and LACP - L2 only - trunk or access - configured as regular port channel - hust specify vPC number in it
- Orphan port - host is connected only to one switch - all orphan devices are recomended to connect to primary node - if peer link fails - they will be accesible - orphan ports are used when host does not support LAG
- Peer switch - feature - when it is enabled - both nodes reply to BPDU, not only primary - from STP point of view it is one logical box - very useful when we have back to back connection between 2 vPC
- Peer gateway - feature - when it is enabled  - one vPC peer to locally route packets destined to the MAC address of the other vPC peer such that packets destined to the remote vPC peer do not need to egress the vPC Peer-Link in order to be routed - so secondary routes packets intended to primary
- ARP/ND - synchronise - by default ARP tables are not synced - to avoid small traffic black holing

### Packet flow

### Infra VLANS - ???

### Consistency checks
Type 1
- Interface parametres - Secondary switch shuts down vPC ports
- Global parametres - Secondary switch suspends affected ports
- STP mode, STP VLAN state, STP global settings, LACP mode, MTU

Type 2
- In case of inconsistency there is no service interaption
- Unpredictible traffic behavior is possible
- VLAN interface (SVI), ACL, QOS, IGMP snooping, HSRP

### vPC failures
- One link from host to vPC fails - it is ok - everything goes via another link
- Peer link fails - secondary switch shuts down all vPC ports - orphan ports are untouched - this is not good - all SVIs are down as well that are connected to vPC VLANs
- Peer link + keep alive fail - peer link first then keep-alive - this will isolate secondary node, if keep-alive is first - then split brain
- Keep-alive fails - nothing happens

### Configuration

Nexus - configs on tboth switches should be identical!!!

```
feature vpc

vpc domain 8
  #Peer switch activation - both nodes reply on BPDU
  peer-switch
  
  #Priority for primary node - the less the better
  role priority 5
  
  #Configuration of peer keep alive link - with separate VRF according to best practice
  peer-keepalive destination 172.16.16.1 source 172.16.16.2 vrf VPC
  
  #Delay of vPC on after reboot
  delay restore 10
  
  #Enable Peer gateway - secondary node may route packets destined for primary node
  peer-gateway
  
  #If router is connected to secondary node, its traffic will pass correctly
  layer3 peer-router
  
  #ARP table sync between nodes
  ip arp synchronize

#LAG for peer link
interface port-channel1
  switchport mode trunk
  spanning-tree port type network- This command explicitly configures the port as a network port
  vpc peer-link

#LAG for end host
interface port-channel101
  switchport access vlan 100
  vpc 8
  
 interface loopback0
  ip address 10.10.2.3/32
  ## Virtual VTEP ID - Anycast VTEP
  ip address 10.10.2.6/32 secondary
  
 #Peer keep alive inteface
 interface Ethernet1/4
  no switchport
  vrf member VPC
  ip address 172.16.16.2/30
  no shutdown

#Special VRF for peer keep alive
vrf context VPC

#Physical interface to end host
interface Ethernet1/2
  switchport access vlan 100
  channel-group 101 mode active
  
 #Physical interface for peer link
 interface Ethernet1/6
  switchport mode trunk
  channel-group 1 mode active
  
#Second physical interface for peer link
interface Ethernet1/5
  switchport mode trunk
  channel-group 1 mode active
```

Suspend orphan ports when peer link is down - on every orphan interface
```
Nexus(config-if)# vpc orphan-ports suspend
```

### Verification

Show all we need about vPC
```
leaf-1# show vpc
Legend:
                (*) - local vPC is down, forwarding via vPC peer-link

vPC domain id                     : 8
Peer status                       : peer adjacency formed ok
vPC keep-alive status             : peer is alive
Configuration consistency status  : success
Per-vlan consistency status       : success
Type-2 consistency status         : success
vPC role                          : primary, operational secondary
Number of vPCs configured         : 1
Peer Gateway                      : Enabled
Dual-active excluded VLANs        : -
Graceful Consistency Check        : Enabled
Auto-recovery status              : Disabled
Delay-restore status              : Timer is off.(timeout = 10s)
Delay-restore SVI status          : Timer is off.(timeout = 10s)
Operational Layer3 Peer-router    : Enabled
Virtual-peerlink mode             : Disabled

vPC Peer-link status
---------------------------------------------------------------------
id    Port   Status Active vlans
--    ----   ------ -------------------------------------------------
1     Po1    up     1,100,200,300


vPC status
----------------------------------------------------------------------------
Id    Port          Status Consistency Reason                Active vlans
--    ------------  ------ ----------- ------                ---------------
8     Po101         up     success     success               100
```

## STP

Port types:
- Network - goes immediately to Blocking state - for connecting switches
- Edge - goes immediately to Forwarding state - for connecting end hosts
- Normal
