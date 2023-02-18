# Switching

## M-LAG
- Different a little bit on different vendors

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
```
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
Suspend orphan ports when peer link is down - on every orphan interface
```
Nexus(config-if)# vpc orphan-ports suspend
```

## VSS

## Stackwise
