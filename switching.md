# Switching

## Main features

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

## Native VLAN

- The native VLAN should match on both trunk ports, or traffic can change VLANs unintentionally
- A native VLAN is a port-specific configuration and is changed with the interface command switchport trunk native vlan vlan-id
- All switch control plane traffic (DTP, VTP and CDP frames and also BPDU’s) is advertised using VLAN 1. The Cisco security hardening guidelines recommend changing the native VLAN to something other than VLAN 1. More specifically, it should be set to a VLAN that is not used at all (that is, has no hosts attached to it). Somebody may add port in VLAN 1 and forget about it

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
